Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3B657961B
	for <lists+linux-block@lfdr.de>; Tue, 19 Jul 2022 11:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbiGSJTQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 19 Jul 2022 05:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237201AbiGSJSt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jul 2022 05:18:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EE82F035;
        Tue, 19 Jul 2022 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3SG29X18+WGny24KClnD1FQZesqBmQwdTFSU80wN0EU=; b=apy6aex+iuX/E+WgwNNTRs2cYy
        /WvXabqQb5L0QSF2afdgY3wxaJlqKULPMTbmBFfAoeb36WtJEZgGJBx6pZ95qhvJkz4mb96bHBntP
        oYfZbUMf8y9LeLhVk4L5/qPtbaWUSpTvD5BHQf8ExHA6BRCUnDCbjbEtLWEHDm9XaUu9SOyKRdJLd
        GhGIBJ6TykvKoBIz+ikqikTDZjD6k46V8d+nEQk/GDp5El70CJqUaFfmTOUjpBdR6XFCI3znyNZBF
        zyMKkfQ/KIb3V8hqSuNY0IFtfp7sWNQJ/HRrtPLg8Bx3Gw6eP6fktmknOH7VjNTowcEv6wGqEDM1l
        5USkrE0Q==;
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDjNA-007C6D-Bs; Tue, 19 Jul 2022 09:18:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 01/10] md: fix mddev->kobj lifetime
Date:   Tue, 19 Jul 2022 11:18:15 +0200
Message-Id: <20220719091824.1064989-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220719091824.1064989-1-hch@lst.de>
References: <20220719091824.1064989-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Once a kobject is initialized, the containing object should not be
directly freed.  So delay initialization until it is added.  Also
remove the kobject_del call as the last put will remove the kobject as
well.  The explicitly delete isn't needed here, and dropping it will
simplify further fixes.

With this md_free now does not need to check that ->gendisk is non-NULL
as it is always set by the time that kobject_init is called on
mddev->kobj.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/md.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index b64de313838f2..7829045fc7fd9 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -678,7 +678,6 @@ static void md_safemode_timeout(struct timer_list *t);
 
 void mddev_init(struct mddev *mddev)
 {
-	kobject_init(&mddev->kobj, &md_ktype);
 	mutex_init(&mddev->open_mutex);
 	mutex_init(&mddev->reconfig_mutex);
 	mutex_init(&mddev->bitmap_info.mutex);
@@ -5590,10 +5589,9 @@ static void md_free(struct kobject *ko)
 	if (mddev->sysfs_level)
 		sysfs_put(mddev->sysfs_level);
 
-	if (mddev->gendisk) {
-		del_gendisk(mddev->gendisk);
-		blk_cleanup_disk(mddev->gendisk);
-	}
+	del_gendisk(mddev->gendisk);
+	blk_cleanup_disk(mddev->gendisk);
+
 	percpu_ref_exit(&mddev->writes_pending);
 
 	bioset_exit(&mddev->bio_set);
@@ -5617,7 +5615,6 @@ static void mddev_delayed_delete(struct work_struct *ws)
 {
 	struct mddev *mddev = container_of(ws, struct mddev, del_work);
 
-	kobject_del(&mddev->kobj);
 	kobject_put(&mddev->kobj);
 }
 
@@ -5719,6 +5716,7 @@ int md_alloc(dev_t dev, char *name)
 	if (error)
 		goto out_cleanup_disk;
 
+	kobject_init(&mddev->kobj, &md_ktype);
 	error = kobject_add(&mddev->kobj, &disk_to_dev(disk)->kobj, "%s", "md");
 	if (error)
 		goto out_del_gendisk;
-- 
2.30.2

