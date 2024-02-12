Return-Path: <linux-block+bounces-3124-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C09850DAE
	for <lists+linux-block@lfdr.de>; Mon, 12 Feb 2024 07:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317F028610C
	for <lists+linux-block@lfdr.de>; Mon, 12 Feb 2024 06:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B554125AC;
	Mon, 12 Feb 2024 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fWoxtjzB"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FB6125A9;
	Mon, 12 Feb 2024 06:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707720431; cv=none; b=D1NgNJA10IggajYrnYBHVlV2OWhF5M0M8ecA6b+kOa/9fovpfDRL0Ez4ZSELLKuehLimCxWOkfwe3WdJama8/jc5OO9gmQvq4wh+SuX0Ipc9zJ3xcIjT2kM9Ij0xDHcZYed8vzQGCpuuvv0papLbkkunNbykHf2xjEDzzlEO0OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707720431; c=relaxed/simple;
	bh=xdkwlvQpTV/CV6uqbotx5NJMzhUp+gdubnT+BphgbMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g7ydo8UtASiALrgTF7HgLqGHDH8ICeQtpBReRM34GEHO7ev5Lgkl59nM8igTdELbA7hr1i0I8oMcMEwKKakqAy7ekhxUEHRumLOZv130jONjjGKek3Ezi+2d8JYneratS8R5iMqeRMbqk009VkqHcovxecttbdMG3f8l26ne0aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fWoxtjzB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pvR4YMlI58JJSNlUq2cwBYj9o0FsTZy6GKdNPIYVtlA=; b=fWoxtjzBQte6cxKuakyzsq9ujE
	E7ZNhxcQ4j0Bjej2xEolqbi0aw5jrEhbrhL73pzD3ldtiOrtDP3kXkykHkjtS3HAsumRyw62LfGuN
	XFvSXz4fml+iQOjLtb3bA6TMTlAFMwNOX8oef1tnemjgnr9UqXOGeslvTreJEQMBXQdp2g4S9YQUO
	3XDCCy8w2jJO4PYQVzbn++ZEtO5LgTD40wLydK5oBnjm7hw+OCjCuSu4OnKaOdD58m1+LS/p3gMRU
	ndJc4JXqrfTR+7qgZpOPVrSkBrlREdDoN+BabEEP5pzZy3uzBywdzJsoCqFNbgtL1nyeyeHe0LW7v
	9KjUhRdw==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQ5m-00000004Q50-31Km;
	Mon, 12 Feb 2024 06:47:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 15/15] loop: use the atomic queue limits update API
Date: Mon, 12 Feb 2024 07:46:09 +0100
Message-Id: <20240212064609.1327143-16-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212064609.1327143-1-hch@lst.de>
References: <20240212064609.1327143-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Pass the default limits to blk_mq_alloc_disk and then use the
queue_limits_{start,commit}_update API to change the limits in an
atomic way on existing loop gendisks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/loop.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 26c8ea79086798..28a95fd366fea5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -750,11 +750,11 @@ static void loop_sysfs_exit(struct loop_device *lo)
 				   &loop_attribute_group);
 }
 
-static void loop_config_discard(struct loop_device *lo)
+static void loop_config_discard(struct loop_device *lo,
+		struct queue_limits *lim)
 {
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
-	struct request_queue *q = lo->lo_queue;
 	u32 granularity = 0, max_discard_sectors = 0;
 	struct kstatfs sbuf;
 
@@ -781,12 +781,12 @@ static void loop_config_discard(struct loop_device *lo)
 		granularity = sbuf.f_bsize;
 	}
 
-	blk_queue_max_discard_sectors(q, max_discard_sectors);
-	blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
+	lim->max_hw_discard_sectors = max_discard_sectors;
+	lim->max_write_zeroes_sectors = max_discard_sectors;
 	if (max_discard_sectors)
-		q->limits.discard_granularity = granularity;
+		lim->discard_granularity = granularity;
 	else
-		q->limits.discard_granularity = 0;
+		lim->discard_granularity = 0;
 }
 
 struct loop_worker {
@@ -975,6 +975,20 @@ loop_set_status_from_info(struct loop_device *lo,
 	return 0;
 }
 
+static int loop_reconfigure_limits(struct loop_device *lo, unsigned short bsize,
+		bool update_discard_settings)
+{
+	struct queue_limits lim;
+
+	lim = queue_limits_start_update(lo->lo_queue);
+	lim.logical_block_size = bsize;
+	lim.physical_block_size = bsize;
+	lim.io_min = bsize;
+	if (update_discard_settings)
+		loop_config_discard(lo, &lim);
+	return queue_limits_commit_update(lo->lo_queue, &lim);
+}
+
 static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 			  struct block_device *bdev,
 			  const struct loop_config *config)
@@ -1072,11 +1086,10 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	else
 		bsize = 512;
 
-	blk_queue_logical_block_size(lo->lo_queue, bsize);
-	blk_queue_physical_block_size(lo->lo_queue, bsize);
-	blk_queue_io_min(lo->lo_queue, bsize);
+	error = loop_reconfigure_limits(lo, bsize, true);
+	if (WARN_ON_ONCE(error))
+		goto out_unlock;
 
-	loop_config_discard(lo);
 	loop_update_rotational(lo);
 	loop_update_dio(lo);
 	loop_sysfs_init(lo);
@@ -1143,9 +1156,7 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	lo->lo_offset = 0;
 	lo->lo_sizelimit = 0;
 	memset(lo->lo_file_name, 0, LO_NAME_SIZE);
-	blk_queue_logical_block_size(lo->lo_queue, 512);
-	blk_queue_physical_block_size(lo->lo_queue, 512);
-	blk_queue_io_min(lo->lo_queue, 512);
+	loop_reconfigure_limits(lo, 512, false);
 	invalidate_disk(lo->lo_disk);
 	loop_sysfs_exit(lo);
 	/* let user-space know about this change */
@@ -1477,9 +1488,7 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	invalidate_bdev(lo->lo_device);
 
 	blk_mq_freeze_queue(lo->lo_queue);
-	blk_queue_logical_block_size(lo->lo_queue, arg);
-	blk_queue_physical_block_size(lo->lo_queue, arg);
-	blk_queue_io_min(lo->lo_queue, arg);
+	err = loop_reconfigure_limits(lo, arg, false);
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-- 
2.39.2


