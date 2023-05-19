Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301AD709007
	for <lists+linux-block@lfdr.de>; Fri, 19 May 2023 08:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjESGwe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 19 May 2023 02:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjESGwd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 02:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B52EE64
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 23:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684479111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TYycW0VbnYyM9deK7/szFMe8+vHiHWqL+8V16S9u+2c=;
        b=Pl/BSSwUPQ51lgL6bJZfbPL32D1bbLeDavbiXb1N3rPQt6c6moVFjDa2ZJJRWP30jbJ2Ii
        jQHyBFRaTOLo/m7/7LQ5uK+umi/0XcbaZw0JPj9rD2tcYfjejjtKloSKZ9mjAZ255l882A
        pipyig99PPb1qgoc6VzcgwbnI6eIipE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-P4e9tM6DPviVqjjOmZo5oQ-1; Fri, 19 May 2023 02:51:06 -0400
X-MC-Unique: P4e9tM6DPviVqjjOmZo5oQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D02085A5A3;
        Fri, 19 May 2023 06:51:06 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 555521427AE4;
        Fri, 19 May 2023 06:51:04 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Harris James R <james.r.harris@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 6/7] ublk: add read()/write() support for ublk char device
Date:   Fri, 19 May 2023 14:50:29 +0800
Message-Id: <20230519065030.351216-7-ming.lei@redhat.com>
In-Reply-To: <20230519065030.351216-1-ming.lei@redhat.com>
References: <20230519065030.351216-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Support pread()/pwrite() on ublk char device for reading/writing request
io buffer, so data copy between io request buffer and userspace buffer
can be moved to ublk server from ublk driver. Then UBLK_F_NEED_GET_DATA
becomes not necessary, so ublk server can allocate buffer without one
extra round uring command communication for userspace to provide buffer.

IO buffer can be located by iocb->ki_pos which encodes buffer offset, io
tag and queue id info, and type of iocb->ki_pos is u64, so it is big
enough for holding reasonable queue depth, nr_queues and max io buffer
size.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 151 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/ublk_cmd.h |  22 ++++-
 2 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 13523c37a165..ec40ac4f9af3 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -207,6 +207,23 @@ static unsigned int ublks_added;	/* protected by ublk_ctl_mutex */
 
 static struct miscdevice ublk_misc;
 
+static inline unsigned ublk_pos_to_hwq(loff_t pos)
+{
+	return ((pos - UBLKSRV_IO_BUF_OFFSET) >> UBLK_QID_OFF) &
+		UBLK_QID_BITS_MASK;
+}
+
+static inline unsigned ublk_pos_to_buf_off(loff_t pos)
+{
+	return (pos - UBLKSRV_IO_BUF_OFFSET) & UBLK_IO_BUF_BITS_MASK;
+}
+
+static inline unsigned ublk_pos_to_tag(loff_t pos)
+{
+	return ((pos - UBLKSRV_IO_BUF_OFFSET) >> UBLK_TAG_OFF) &
+		UBLK_TAG_BITS_MASK;
+}
+
 static void ublk_dev_param_basic_apply(struct ublk_device *ub)
 {
 	struct request_queue *q = ub->ub_disk->queue;
@@ -1429,6 +1446,36 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	return -EIOCBQUEUED;
 }
 
+static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
+		struct ublk_queue *ubq, int tag, size_t offset)
+{
+	struct request *req;
+
+	if (!ublk_need_req_ref(ubq))
+		return NULL;
+
+	req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
+	if (!req)
+		return NULL;
+
+	if (!ublk_get_req_ref(ubq, req))
+		return NULL;
+
+	if (unlikely(!blk_mq_request_started(req) || req->tag != tag))
+		goto fail_put;
+
+	if (!ublk_rq_has_data(req))
+		goto fail_put;
+
+	if (offset > blk_rq_bytes(req))
+		goto fail_put;
+
+	return req;
+fail_put:
+	ublk_put_req_ref(ubq, req);
+	return NULL;
+}
+
 static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	/*
@@ -1446,11 +1493,112 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	return __ublk_ch_uring_cmd(cmd, issue_flags, &ub_cmd);
 }
 
+static inline bool ublk_check_ubuf_dir(const struct request *req,
+		int ubuf_dir)
+{
+	/* copy ubuf to request pages */
+	if (req_op(req) == REQ_OP_READ && ubuf_dir == ITER_SOURCE)
+		return true;
+
+	/* copy request pages to ubuf */
+	if (req_op(req) == REQ_OP_WRITE && ubuf_dir == ITER_DEST)
+		return true;
+
+	return false;
+}
+
+static struct request *ublk_check_and_get_req(struct kiocb *iocb,
+		struct iov_iter *iter, size_t *off, int dir)
+{
+	struct ublk_device *ub = iocb->ki_filp->private_data;
+	struct ublk_queue *ubq;
+	struct request *req;
+	size_t buf_off;
+	u16 tag, q_id;
+
+	if (!ub)
+		return ERR_PTR(-EACCES);
+
+	if (!user_backed_iter(iter))
+		return ERR_PTR(-EACCES);
+
+	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
+		return ERR_PTR(-EACCES);
+
+	tag = ublk_pos_to_tag(iocb->ki_pos);
+	q_id = ublk_pos_to_hwq(iocb->ki_pos);
+	buf_off = ublk_pos_to_buf_off(iocb->ki_pos);
+
+	if (q_id >= ub->dev_info.nr_hw_queues)
+		return ERR_PTR(-EINVAL);
+
+	ubq = ublk_get_queue(ub, q_id);
+	if (!ubq)
+		return ERR_PTR(-EINVAL);
+
+	if (tag >= ubq->q_depth)
+		return ERR_PTR(-EINVAL);
+
+	req = __ublk_check_and_get_req(ub, ubq, tag, buf_off);
+	if (!req)
+		return ERR_PTR(-EINVAL);
+
+	if (!req->mq_hctx || !req->mq_hctx->driver_data)
+		goto fail;
+
+	if (!ublk_check_ubuf_dir(req, dir))
+		goto fail;
+
+	*off = buf_off;
+	return req;
+fail:
+	ublk_put_req_ref(ubq, req);
+	return ERR_PTR(-EACCES);
+}
+
+static ssize_t ublk_ch_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct ublk_queue *ubq;
+	struct request *req;
+	size_t buf_off;
+	size_t ret;
+
+	req = ublk_check_and_get_req(iocb, to, &buf_off, ITER_DEST);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	ret = ublk_copy_user_pages(req, buf_off, to, ITER_DEST);
+	ubq = req->mq_hctx->driver_data;
+	ublk_put_req_ref(ubq, req);
+
+	return ret;
+}
+
+static ssize_t ublk_ch_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct ublk_queue *ubq;
+	struct request *req;
+	size_t buf_off;
+	size_t ret;
+
+	req = ublk_check_and_get_req(iocb, from, &buf_off, ITER_SOURCE);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	ret = ublk_copy_user_pages(req, buf_off, from, ITER_SOURCE);
+	ubq = req->mq_hctx->driver_data;
+	ublk_put_req_ref(ubq, req);
+
+	return ret;
+}
+
 static const struct file_operations ublk_ch_fops = {
 	.owner = THIS_MODULE,
 	.open = ublk_ch_open,
 	.release = ublk_ch_release,
 	.llseek = no_llseek,
+	.read_iter = ublk_ch_read_iter,
+	.write_iter = ublk_ch_write_iter,
 	.uring_cmd = ublk_ch_uring_cmd,
 	.mmap = ublk_ch_mmap,
 };
@@ -2362,6 +2510,9 @@ static int __init ublk_init(void)
 {
 	int ret;
 
+	BUILD_BUG_ON((u64)UBLKSRV_IO_BUF_OFFSET +
+			UBLKSRV_IO_BUF_TOTAL_SIZE < UBLKSRV_IO_BUF_OFFSET);
+
 	init_waitqueue_head(&ublk_idr_wq);
 
 	ret = misc_register(&ublk_misc);
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 640bf687b94a..c0c1632c671e 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -93,9 +93,29 @@
 #define UBLKSRV_CMD_BUF_OFFSET	0
 #define UBLKSRV_IO_BUF_OFFSET	0x80000000
 
-/* tag bit is 12bit, so at most 4096 IOs for each queue */
+/* tag bit is 16bit, so far limit at most 4096 IOs for each queue */
 #define UBLK_MAX_QUEUE_DEPTH	4096
 
+/* single IO buffer max size is 32MB */
+#define UBLK_IO_BUF_OFF		0
+#define UBLK_IO_BUF_BITS	25
+#define UBLK_IO_BUF_BITS_MASK	((1ULL << UBLK_IO_BUF_BITS) - 1)
+
+/* so at most 64K IOs for each queue */
+#define UBLK_TAG_OFF		UBLK_IO_BUF_BITS
+#define UBLK_TAG_BITS		16
+#define UBLK_TAG_BITS_MASK	((1ULL << UBLK_TAG_BITS) - 1)
+
+/* max 4096 queues */
+#define UBLK_QID_OFF		(UBLK_TAG_OFF + UBLK_TAG_BITS)
+#define UBLK_QID_BITS		12
+#define UBLK_QID_BITS_MASK	((1ULL << UBLK_QID_BITS) - 1)
+
+#define UBLK_MAX_NR_QUEUES	(1U << UBLK_QID_BITS)
+
+#define UBLKSRV_IO_BUF_TOTAL_BITS	(UBLK_QID_OFF + UBLK_QID_BITS)
+#define UBLKSRV_IO_BUF_TOTAL_SIZE	(1ULL << UBLKSRV_IO_BUF_TOTAL_BITS)
+
 /*
  * zero copy requires 4k block size, and can remap ublk driver's io
  * request into ublksrv's vm space
-- 
2.40.1

