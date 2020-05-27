Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E9E1E36CD
	for <lists+linux-block@lfdr.de>; Wed, 27 May 2020 06:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgE0EDH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 27 May 2020 00:03:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:57406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgE0EDH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 00:03:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 824A8AE89;
        Wed, 27 May 2020 04:03:08 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH v2 3/5] bcache: fix refcount underflow in bcache_device_free()
Date:   Wed, 27 May 2020 12:01:53 +0800
Message-Id: <20200527040155.43690-4-colyli@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200527040155.43690-1-colyli@suse.de>
References: <20200527040155.43690-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The problematic code piece in bcache_device_free() is,

 785 static void bcache_device_free(struct bcache_device *d)
 786 {
 787     struct gendisk *disk = d->disk;
 [snipped]
 799     if (disk) {
 800             if (disk->flags & GENHD_FL_UP)
 801                     del_gendisk(disk);
 802
 803             if (disk->queue)
 804                     blk_cleanup_queue(disk->queue);
 805
 806             ida_simple_remove(&bcache_device_idx,
 807                               first_minor_to_idx(disk->first_minor));
 808             put_disk(disk);
 809         }
 [snipped]
 816 }

At line 808, put_disk(disk) may encounter kobject refcount of 'disk'
being underflow.

Here is how to reproduce the issue,
- Attche the backing device to a cache device and do random write to
  make the cache being dirty.
- Stop the bcache device while the cache device has dirty data of the
  backing device.
- Only register the backing device back, NOT register cache device.
- The bcache device node /dev/bcache0 won't show up, because backing
  device waits for the cache device shows up for the missing dirty
  data.
- Now echo 1 into /sys/fs/bcache/pendings_cleanup, to stop the pending
  backing device.
- After the pending backing device stopped, use 'dmesg' to check kernel
  message, a use-after-free warning from KASA reported the refcount of
  kobject linked to the 'disk' is underflow.

The dropping refcount at line 808 in the above code piece is added by
add_disk(d->disk) in bch_cached_dev_run(). But in the above condition
the cache device is not registered, bch_cached_dev_run() has no chance
to be called and the refcount is not added. The put_disk() for a non-
added refcount of gendisk kobject triggers a underflow warning.

This patch checks whether GENHD_FL_UP is set in disk->flags, if it is
not set then the bcache device was not added, don't call put_disk()
and the the underflow issue can be avoided.

Signed-off-by: Coly Li <colyli@suse.de>
---
Changelog:
v2: make the code to be more cleaner by suggestion from Jens Axboe.
v1: initial version.

 drivers/md/bcache/super.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 467149f3bcc5..a10a3c78f4ff 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -797,7 +797,9 @@ static void bcache_device_free(struct bcache_device *d)
 		bcache_device_detach(d);
 
 	if (disk) {
-		if (disk->flags & GENHD_FL_UP)
+		bool disk_added = (disk->flags & GENHD_FL_UP) != 0;
+
+		if (disk_added)
 			del_gendisk(disk);
 
 		if (disk->queue)
@@ -805,7 +807,8 @@ static void bcache_device_free(struct bcache_device *d)
 
 		ida_simple_remove(&bcache_device_idx,
 				  first_minor_to_idx(disk->first_minor));
-		put_disk(disk);
+		if (disk_added)
+			put_disk(disk);
 	}
 
 	bioset_exit(&d->bio_split);
-- 
2.25.0

