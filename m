Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC703B14F6
	for <lists+linux-block@lfdr.de>; Wed, 23 Jun 2021 09:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhFWHni (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 23 Jun 2021 03:43:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229918AbhFWHnh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 03:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624434080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jLgM1q9XIe+fyOZ5JdYn24SoYAOcOsG0RAc8jkcv59c=;
        b=NCLgZ6JQRn31bPMsoyv6x5Eav+hYiq8DFf25trrVMhxYqL60qoiLad6HBUV1gHMlSoMs7f
        eJbv/JIcgD2gzfUMhof+tlHXHw2a7ksH+thyo7zwmydUTX6UXgrvff0KJuB9nGdwAKt7LV
        e1Y05zoWvWHT3G1fgQIz2hIlMJzTbeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-7wU6mV6-MhuR3wnCA94pFg-1; Wed, 23 Jun 2021 03:41:17 -0400
X-MC-Unique: 7wU6mV6-MhuR3wnCA94pFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2E2C804308;
        Wed, 23 Jun 2021 07:41:16 +0000 (UTC)
Received: from localhost (ovpn-12-52.pek2.redhat.com [10.72.12.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9C9D60C05;
        Wed, 23 Jun 2021 07:41:15 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 2/3] block: add ->poll_bio to block_device_operations
Date:   Wed, 23 Jun 2021 15:40:31 +0800
Message-Id: <20210623074032.1484665-3-ming.lei@redhat.com>
In-Reply-To: <20210623074032.1484665-1-ming.lei@redhat.com>
References: <20210623074032.1484665-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for supporting IO polling for bio based driver.

Add ->poll_bio callback so that bio driver can provide their own logic
for polling bio.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c       | 13 +++++++++----
 block/genhd.c          |  2 ++
 include/linux/blkdev.h |  1 +
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1e24c71c6738..e585e549c291 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1113,7 +1113,8 @@ EXPORT_SYMBOL(submit_bio);
  */
 int bio_poll(struct bio *bio, unsigned int flags)
 {
-	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+	struct gendisk *disk = bio->bi_bdev->bd_disk;
+	struct request_queue *q = disk->queue;
 	blk_qc_t cookie = READ_ONCE(bio->bi_cookie);
 	int ret;
 
@@ -1125,10 +1126,14 @@ int bio_poll(struct bio *bio, unsigned int flags)
 
 	if (blk_queue_enter(q, BLK_MQ_REQ_NOWAIT))
 		return 0;
-	if (WARN_ON_ONCE(!queue_is_mq(q)))
-		ret = 0;	/* not yet implemented, should not happen */
-	else
+
+	if (queue_is_mq(q))
 		ret = blk_mq_poll(q, cookie, flags);
+	else if (disk->fops->poll_bio)
+		ret = disk->fops->poll_bio(bio, flags);
+	else
+		ret = !WARN_ON_ONCE(1);
+
 	blk_queue_exit(q);
 	return ret;
 }
diff --git a/block/genhd.c b/block/genhd.c
index 5f5628216295..3dfb7d52e280 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -471,6 +471,8 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 {
 	int ret;
 
+	WARN_ON_ONCE(queue_is_mq(disk->queue) && disk->fops->poll_bio);
+
 	/*
 	 * The disk queue should now be all set with enough information about
 	 * the device for the elevator code to pick an adequate default
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index fc0ba0b80776..fc63155d2ac4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1858,6 +1858,7 @@ static inline void blk_ksm_unregister(struct request_queue *q) { }
 
 struct block_device_operations {
 	void (*submit_bio)(struct bio *bio);
+	int (*poll_bio)(struct bio *bio, unsigned int flags);
 	int (*open) (struct block_device *, fmode_t);
 	void (*release) (struct gendisk *, fmode_t);
 	int (*rw_page)(struct block_device *, sector_t, struct page *, unsigned int);
-- 
2.31.1

