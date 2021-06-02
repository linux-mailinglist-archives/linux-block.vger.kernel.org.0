Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B34D398232
	for <lists+linux-block@lfdr.de>; Wed,  2 Jun 2021 08:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhFBG6P (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Jun 2021 02:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhFBG56 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jun 2021 02:57:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2F1C06175F;
        Tue,  1 Jun 2021 23:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=t0ZfpA7/b1tuSB9Qdmm+6Pkt4GtuM/+pFYP7xY239G0=; b=uyZhEjeEW990KkF+Rai7xjxEUV
        5bWN+uUzqHopzatrtAIE4foiriDdqCyVhGFR6vrU02JeY+SQh7ATWFUZXA3UpyDJcgDYSDLhQXP9V
        RbuXa4k+DVNm7KNjqg4cbdIBM1Va/6aZbjJtQTnqImkNPJ0qKqmBir0MJFXK6gK5PvPfEwCxj1xmD
        dJgu840EtdLj1HHThtV37MaOh3u42wXScgCL7y9GVONAhUdX9SrS6vntka8Pn6bww45YDmPKVYARg
        M/UkenAPSpkgf5JK1kNXiSwoq6fWJ8kR9bHE+sA5X31QgA+XlZSlp6YoKzXnGG50xif3YpnMjuZQG
        qCj5Hh3A==;
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1loKnE-0026TF-Pp; Wed, 02 Jun 2021 06:55:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Tim Waugh <tim@cyberelk.net>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH 27/30] scm_blk: use blk_mq_alloc_disk and blk_cleanup_disk
Date:   Wed,  2 Jun 2021 09:53:42 +0300
Message-Id: <20210602065345.355274-28-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210602065345.355274-1-hch@lst.de>
References: <20210602065345.355274-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use blk_mq_alloc_disk and blk_cleanup_disk to simplify the gendisk and
request_queue allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/block/scm_blk.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index a4f6f2e62b1d..88cba6212ee2 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -462,12 +462,12 @@ int scm_blk_dev_setup(struct scm_blk_dev *bdev, struct scm_device *scmdev)
 	if (ret)
 		goto out;
 
-	rq = blk_mq_init_queue(&bdev->tag_set);
-	if (IS_ERR(rq)) {
-		ret = PTR_ERR(rq);
+	bdev->gendisk = blk_mq_alloc_disk(&bdev->tag_set, scmdev);
+	if (IS_ERR(bdev->gendisk)) {
+		ret = PTR_ERR(bdev->gendisk);
 		goto out_tag;
 	}
-	bdev->rq = rq;
+	rq = bdev->rq = bdev->gendisk->queue;
 	nr_max_blk = min(scmdev->nr_max_block,
 			 (unsigned int) (PAGE_SIZE / sizeof(struct aidaw)));
 
@@ -477,17 +477,11 @@ int scm_blk_dev_setup(struct scm_blk_dev *bdev, struct scm_device *scmdev)
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, rq);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, rq);
 
-	bdev->gendisk = alloc_disk(SCM_NR_PARTS);
-	if (!bdev->gendisk) {
-		ret = -ENOMEM;
-		goto out_queue;
-	}
-	rq->queuedata = scmdev;
 	bdev->gendisk->private_data = scmdev;
 	bdev->gendisk->fops = &scm_blk_devops;
-	bdev->gendisk->queue = rq;
 	bdev->gendisk->major = scm_major;
 	bdev->gendisk->first_minor = devindex * SCM_NR_PARTS;
+	bdev->gendisk->minors = SCM_NR_PARTS;
 
 	len = snprintf(bdev->gendisk->disk_name, DISK_NAME_LEN, "scm");
 	if (devindex > 25) {
@@ -504,8 +498,6 @@ int scm_blk_dev_setup(struct scm_blk_dev *bdev, struct scm_device *scmdev)
 	device_add_disk(&scmdev->dev, bdev->gendisk, NULL);
 	return 0;
 
-out_queue:
-	blk_cleanup_queue(rq);
 out_tag:
 	blk_mq_free_tag_set(&bdev->tag_set);
 out:
@@ -516,9 +508,8 @@ int scm_blk_dev_setup(struct scm_blk_dev *bdev, struct scm_device *scmdev)
 void scm_blk_dev_cleanup(struct scm_blk_dev *bdev)
 {
 	del_gendisk(bdev->gendisk);
-	blk_cleanup_queue(bdev->gendisk->queue);
+	blk_cleanup_disk(bdev->gendisk);
 	blk_mq_free_tag_set(&bdev->tag_set);
-	put_disk(bdev->gendisk);
 }
 
 void scm_blk_set_available(struct scm_blk_dev *bdev)
-- 
2.30.2

