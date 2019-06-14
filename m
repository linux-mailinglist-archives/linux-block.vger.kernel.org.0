Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1138045DD6
	for <lists+linux-block@lfdr.de>; Fri, 14 Jun 2019 15:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfFNNP2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 14 Jun 2019 09:15:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:46216 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727918AbfFNNP2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 09:15:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D195EAF7B;
        Fri, 14 Jun 2019 13:15:26 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 23/29] bcache: improve error message in bch_cached_dev_run()
Date:   Fri, 14 Jun 2019 21:13:52 +0800
Message-Id: <20190614131358.2771-24-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190614131358.2771-1-colyli@suse.de>
References: <20190614131358.2771-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds more error message in bch_cached_dev_run() to indicate
the exact reason why an error value is returned. Please notice when
printing out the "is running already" message, pr_info() is used here,
because in this case also -EBUSY is returned, the bcache device can
continue to attach to the cache devince and run, so it won't be an
error level message in kernel message.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 4a6406b53de1..026e2df358c3 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -926,13 +926,18 @@ int bch_cached_dev_run(struct cached_dev *dc)
 		NULL,
 	};
 
-	if (dc->io_disable)
+	if (dc->io_disable) {
+		pr_err("I/O disabled on cached dev %s",
+		       dc->backing_dev_name);
 		return -EIO;
+	}
 
 	if (atomic_xchg(&dc->running, 1)) {
 		kfree(env[1]);
 		kfree(env[2]);
 		kfree(buf);
+		pr_info("cached dev %s is running already",
+		       dc->backing_dev_name);
 		return -EBUSY;
 	}
 
@@ -961,7 +966,7 @@ int bch_cached_dev_run(struct cached_dev *dc)
 	if (sysfs_create_link(&d->kobj, &disk_to_dev(d->disk)->kobj, "dev") ||
 	    sysfs_create_link(&disk_to_dev(d->disk)->kobj,
 			      &d->kobj, "bcache")) {
-		pr_debug("error creating sysfs link");
+		pr_err("Couldn't create bcache dev <-> disk sysfs symlinks");
 		return -ENOMEM;
 	}
 
-- 
2.16.4

