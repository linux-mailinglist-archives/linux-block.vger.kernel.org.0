Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F21F32C888
	for <lists+linux-block@lfdr.de>; Thu,  4 Mar 2021 02:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbhCDAux (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 3 Mar 2021 19:50:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:44472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235354AbhCCRNo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Mar 2021 12:13:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4462AEB3;
        Wed,  3 Mar 2021 17:12:02 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Martin Wilck <mwilck@suse.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] block: Suppress uevent for hidden device when removed
Date:   Wed,  3 Mar 2021 18:12:01 +0100
Message-Id: <20210303171201.8432-1-dwagner@suse.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

register_disk() suppress uevents for devices with the GENHD_FL_HIDDEN
but enables uevents at the end again in order to announce disk after
possible partitions are created.

When the device is removed the uevents are still on and user land sees
'remove' messages for devices which were never 'add'ed to the system.

  KERNEL[95481.571887] remove   /devices/virtual/nvme-fabrics/ctl/nvme5/nvme0c5n1 (block)

Let's suppress the uevents for GENHD_FL_HIDDEN again before calling
device_del() which will write trigger uevents.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 block/genhd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index c55e8f0fced1..ab9ed355bdef 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -731,6 +731,9 @@ void del_gendisk(struct gendisk *disk)
 	if (!sysfs_deprecated)
 		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
 	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
+
+	if (disk->flags & GENHD_FL_HIDDEN)
+		dev_set_uevent_suppress(disk_to_dev(disk), 1);
 	device_del(disk_to_dev(disk));
 }
 EXPORT_SYMBOL(del_gendisk);
-- 
2.30.1

