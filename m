Return-Path: <linux-block+bounces-28925-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13990C02251
	for <lists+linux-block@lfdr.de>; Thu, 23 Oct 2025 17:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2585501B90
	for <lists+linux-block@lfdr.de>; Thu, 23 Oct 2025 15:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A292459C9;
	Thu, 23 Oct 2025 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFSINKDQ"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4521331A70
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233595; cv=none; b=ginMUubkXp4O2pig1xMbJp6nYvQF+FvmS0Ab7cobvc/fKt8Equ6uA4QLfOTChlPKfkn6TmONkFP44SRGNEeDntQrXj/DmtiqeGFd0tevs6Vce0ipvIkZTMP8PgAbo2r35s8B+D9DCgcBuXZVaVrs9OtHTyVnHTFy7vnXA9L/Nxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233595; c=relaxed/simple;
	bh=edSvZJEmg6uOXLK6jnvDP1APwHqdeK1J4Mvd0xJdixA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8Qo4FlqLe1MjfyisDlQvpRbR5FuvsnJyS/xyrtN0bRL//mSDn46bEqD1hZzxKqduuPWW/c9TXuOFujzm3RkfvFMU7oXmfWhMVJAt98eEjBMmK397u3EnqAhSD198fIJvbR10pSxyzn+fdFyLt08aYRj5shRMu4kKkAswdpNFbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LFSINKDQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761233592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iV1eMIoK1WK91rFE5nCqA11A4aF9wMqCohOVY1SZAnc=;
	b=LFSINKDQhO0luCRPuXE3BxVH2LlJ2BFxISEPpyOoxIgi1veaMg1vRMfq4a+WerJeszLxTz
	NNtwtMJ8ok5lr1wdIYR5p7D6G5YzymfRrBAlehInlR9YqWCsxnZtdLG+RLY0CdNasBViUY
	NRx9SKxY+qA2rSloVAwLctkqRXN45OA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-NJOQ7Ql-OnGbb4ivgFY41A-1; Thu,
 23 Oct 2025 11:33:09 -0400
X-MC-Unique: NJOQ7Ql-OnGbb4ivgFY41A-1
X-Mimecast-MFC-AGG-ID: NJOQ7Ql-OnGbb4ivgFY41A_1761233588
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E4D6180135A;
	Thu, 23 Oct 2025 15:33:08 +0000 (UTC)
Received: from localhost (unknown [10.72.120.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 25FAE180035A;
	Thu, 23 Oct 2025 15:33:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 05/25] ublk: define ublk_ch_batch_io_fops for the coming feature F_BATCH_IO
Date: Thu, 23 Oct 2025 23:32:10 +0800
Message-ID: <20251023153234.2548062-6-ming.lei@redhat.com>
In-Reply-To: <20251023153234.2548062-1-ming.lei@redhat.com>
References: <20251023153234.2548062-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Introduces the basic structure for a batched I/O feature in the ublk driver.
It adds placeholder functions and a new file operations structure,
ublk_ch_batch_io_fops, which will be used for fetching and committing I/O
commands in batches. Currently, the feature is disabled.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a44e40d1118b..6b6e82ec7e45 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -255,6 +255,11 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 		u16 q_id, u16 tag, struct ublk_io *io, size_t offset);
 static inline unsigned int ublk_req_build_flags(struct request *req);
 
+static inline bool ublk_dev_support_batch_io(const struct ublk_device *ub)
+{
+	return false;
+}
+
 static inline struct ublksrv_io_desc *
 ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
 {
@@ -2578,6 +2583,12 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	return ublk_ch_uring_cmd_local(cmd, issue_flags);
 }
 
+static int ublk_ch_batch_io_uring_cmd(struct io_uring_cmd *cmd,
+				       unsigned int issue_flags)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline bool ublk_check_ubuf_dir(const struct request *req,
 		int ubuf_dir)
 {
@@ -2690,6 +2701,16 @@ static const struct file_operations ublk_ch_fops = {
 	.mmap = ublk_ch_mmap,
 };
 
+static const struct file_operations ublk_ch_batch_io_fops = {
+	.owner = THIS_MODULE,
+	.open = ublk_ch_open,
+	.release = ublk_ch_release,
+	.read_iter = ublk_ch_read_iter,
+	.write_iter = ublk_ch_write_iter,
+	.uring_cmd = ublk_ch_batch_io_uring_cmd,
+	.mmap = ublk_ch_mmap,
+};
+
 static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
 {
 	int size = ublk_queue_cmd_buf_size(ub);
@@ -2827,7 +2848,10 @@ static int ublk_add_chdev(struct ublk_device *ub)
 	if (ret)
 		goto fail;
 
-	cdev_init(&ub->cdev, &ublk_ch_fops);
+	if (ublk_dev_support_batch_io(ub))
+		cdev_init(&ub->cdev, &ublk_ch_batch_io_fops);
+	else
+		cdev_init(&ub->cdev, &ublk_ch_fops);
 	ret = cdev_device_add(&ub->cdev, dev);
 	if (ret)
 		goto fail;
-- 
2.47.0


