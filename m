Return-Path: <linux-block+bounces-10401-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52E394C2B9
	for <lists+linux-block@lfdr.de>; Thu,  8 Aug 2024 18:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D826E1C2371F
	for <lists+linux-block@lfdr.de>; Thu,  8 Aug 2024 16:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E06818FC85;
	Thu,  8 Aug 2024 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HI6BTijx"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8DD2107
	for <linux-block@vger.kernel.org>; Thu,  8 Aug 2024 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134353; cv=none; b=G+U8ZG+vqnEuboV4rhvB2FnjciNt+IZgzWRZUEZjzKPAXLsvln4y/+LpXZokX7dN/GU8/zvnNoZJYV0uoi0/YIcD+Lwfs3bhi9dM4XEWfakcKfC60LI4nFp2xjcJVQydZ9ximfJ/Zpp3OiNr7LTtU4GIIhWsDI+xdOWakQv5ce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134353; c=relaxed/simple;
	bh=KF19b1lckOfG6P6krNbPSfTR+o7qwHQTjHJXS0wN72Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxe9017TWNM94tvIcKtAbzSJnEIFz3s9svTjl7Oe3b8PkrsXbY40B+OGcK4Lwxs82rM9fROzdEfFTvxkrtGsZFhgR5xn6iszG8QsWokwpFo7QJUWFKH8iL8WFFen3/AgZtYF+r4yXfzZ+9HNqQ42BhX8daDyotpP5uihrS55isk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HI6BTijx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723134350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvvRGhJB0aHoomJDI/dXo70sQjMhyFO3eSuebTQOrHY=;
	b=HI6BTijxy/9fscamT29bvFl+ljcBlbjuccBIwPXlcZsx7feWPm1YNbw+KC5VhXYlEoISad
	vaQFeeR4/LD5leSkpx/LBEtLzGyi4qOMebXj+/HnWoSv8NZtSUlROWirJzYhDDq9x4gRrk
	+DD31xAQlBnEMdich114LT76xKoQ5RE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-IGCYkGwTOSK81TsIHVvWWA-1; Thu,
 08 Aug 2024 12:25:48 -0400
X-MC-Unique: IGCYkGwTOSK81TsIHVvWWA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE15219560AB;
	Thu,  8 Aug 2024 16:25:47 +0000 (UTC)
Received: from localhost (unknown [10.72.116.29])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F1B6C1959166;
	Thu,  8 Aug 2024 16:25:46 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 8/8] ublk: support provide io buffer
Date: Fri,  9 Aug 2024 00:24:57 +0800
Message-ID: <20240808162503.345913-9-ming.lei@redhat.com>
In-Reply-To: <20240808162503.345913-1-ming.lei@redhat.com>
References: <20240808162503.345913-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Implement uring command's IORING_PROVIDE_GROUP_KBUF, and provide
io buffer for userpace to run io_uring operations(FS, network IO),
then ublk zero copy can be supported.

userspace code:

	https://github.com/ublk-org/ublksrv/tree/group-provide-buf.v2
	git clone https://github.com/ublk-org/ublksrv.git -b group-provide-buf.v2

And both loop and nbd zero copy(io_uring send and send zc) are covered.

Performance improvement is quite obvious in big block size test, such as
'loop --buffered_io' perf is doubled in 64KB block test("loop/007 vs
loop/009").

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 160 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |   7 +-
 2 files changed, 156 insertions(+), 11 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 890c08792ba8..d5813e20c177 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -51,6 +51,8 @@
 /* private ioctl command mirror */
 #define UBLK_CMD_DEL_DEV_ASYNC	_IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
 
+#define UBLK_IO_PROVIDE_IO_BUF _IOC_NR(UBLK_U_IO_PROVIDE_IO_BUF)
+
 /* All UBLK_F_* have to be included into UBLK_F_ALL */
 #define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY \
 		| UBLK_F_URING_CMD_COMP_IN_TASK \
@@ -74,6 +76,8 @@ struct ublk_rq_data {
 	__u64 sector;
 	__u32 operation;
 	__u32 nr_zones;
+	bool allocated_bvec;
+	struct io_uring_kernel_buf buf[0];
 };
 
 struct ublk_uring_cmd_pdu {
@@ -192,11 +196,15 @@ struct ublk_params_header {
 	__u32	types;
 };
 
+static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
+		struct ublk_queue *ubq, int tag, size_t offset);
 static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq);
 
 static inline unsigned int ublk_req_build_flags(struct request *req);
 static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
 						   int tag);
+static void ublk_io_buf_giveback_cb(const struct io_uring_kernel_buf *buf);
+
 static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
 {
 	return ub->dev_info.flags & UBLK_F_USER_COPY;
@@ -558,6 +566,11 @@ static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
 	return ublk_support_user_copy(ubq);
 }
 
+static inline bool ublk_support_zc(const struct ublk_queue *ubq)
+{
+	return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
+}
+
 static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
 		struct request *req)
 {
@@ -821,6 +834,71 @@ static size_t ublk_copy_user_pages(const struct request *req,
 	return done;
 }
 
+/*
+ * The built command buffer is immutable, so it is fine to feed it to
+ * concurrent io_uring provide buf commands
+ */
+static int ublk_init_zero_copy_buffer(struct request *req)
+{
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+	struct io_uring_kernel_buf *imu = data->buf;
+	struct req_iterator rq_iter;
+	unsigned int nr_bvecs = 0;
+	struct bio_vec *bvec;
+	unsigned int offset;
+	struct bio_vec bv;
+
+	if (!ublk_rq_has_data(req))
+		goto exit;
+
+	rq_for_each_bvec(bv, req, rq_iter)
+		nr_bvecs++;
+
+	if (!nr_bvecs)
+		goto exit;
+
+	if (req->bio != req->biotail) {
+		int idx = 0;
+
+		bvec = kvmalloc_array(nr_bvecs, sizeof(struct bio_vec),
+				GFP_NOIO);
+		if (!bvec)
+			return -ENOMEM;
+
+		offset = 0;
+		rq_for_each_bvec(bv, req, rq_iter)
+			bvec[idx++] = bv;
+		data->allocated_bvec = true;
+	} else {
+		struct bio *bio = req->bio;
+
+		offset = bio->bi_iter.bi_bvec_done;
+		bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
+	}
+	imu->bvec = bvec;
+	imu->nr_bvecs = nr_bvecs;
+	imu->offset = offset;
+	imu->len = blk_rq_bytes(req);
+	imu->dir = req_op(req) == REQ_OP_READ ? ITER_DEST : ITER_SOURCE;
+	imu->grp_kbuf_ack = ublk_io_buf_giveback_cb;
+
+	return 0;
+exit:
+	imu->bvec = NULL;
+	return 0;
+}
+
+static void ublk_deinit_zero_copy_buffer(struct request *req)
+{
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+	struct io_uring_kernel_buf *imu = data->buf;
+
+	if (data->allocated_bvec) {
+		kvfree(imu->bvec);
+		data->allocated_bvec = false;
+	}
+}
+
 static inline bool ublk_need_map_req(const struct request *req)
 {
 	return ublk_rq_has_data(req) && req_op(req) == REQ_OP_WRITE;
@@ -832,13 +910,25 @@ static inline bool ublk_need_unmap_req(const struct request *req)
 	       (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN);
 }
 
-static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
+static int ublk_map_io(const struct ublk_queue *ubq, struct request *req,
 		struct ublk_io *io)
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (ublk_support_user_copy(ubq))
+	if (ublk_support_user_copy(ubq)) {
+		if (ublk_support_zc(ubq)) {
+			int ret = ublk_init_zero_copy_buffer(req);
+
+			/*
+			 * The only failure is -ENOMEM for allocating providing
+			 * buffer command, return zero so that we can requeue
+			 * this req.
+			 */
+			if (unlikely(ret))
+				return 0;
+		}
 		return rq_bytes;
+	}
 
 	/*
 	 * no zero copy, we delay copy WRITE request data into ublksrv
@@ -856,13 +946,16 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 }
 
 static int ublk_unmap_io(const struct ublk_queue *ubq,
-		const struct request *req,
+		struct request *req,
 		struct ublk_io *io)
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (ublk_support_user_copy(ubq))
+	if (ublk_support_user_copy(ubq)) {
+		if (ublk_support_zc(ubq))
+			ublk_deinit_zero_copy_buffer(req);
 		return rq_bytes;
+	}
 
 	if (ublk_need_unmap_req(req)) {
 		struct iov_iter iter;
@@ -1008,6 +1101,7 @@ static inline void __ublk_complete_rq(struct request *req)
 
 	return;
 exit:
+	ublk_deinit_zero_copy_buffer(req);
 	blk_mq_end_request(req, res);
 }
 
@@ -1650,6 +1744,45 @@ static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
 	io_uring_cmd_mark_cancelable(cmd, issue_flags);
 }
 
+static void ublk_io_buf_giveback_cb(const struct io_uring_kernel_buf *buf)
+{
+	struct ublk_rq_data *data = container_of(buf, struct ublk_rq_data, buf[0]);
+	struct request *req = blk_mq_rq_from_pdu(data);
+	struct ublk_queue *ubq = req->mq_hctx->driver_data;
+
+	ublk_put_req_ref(ubq, req);
+}
+
+static int ublk_provide_io_buf(struct io_uring_cmd *cmd,
+		struct ublk_queue *ubq, int tag)
+{
+	struct ublk_device *ub = cmd->file->private_data;
+	struct ublk_rq_data *data;
+	struct request *req;
+
+	if (!ub)
+		return -EPERM;
+
+	req = __ublk_check_and_get_req(ub, ubq, tag, 0);
+	if (!req)
+		return -EINVAL;
+
+	pr_devel("%s: qid %d tag %u request bytes %u\n",
+			__func__, tag, ubq->q_id, blk_rq_bytes(req));
+
+	data = blk_mq_rq_to_pdu(req);
+
+	/*
+	 * io_uring guarantees that the callback will be called after
+	 * the provided buffer is consumed, and it is automatic removal
+	 * before this uring command is freed.
+	 *
+	 * This request won't be completed unless the callback is called,
+	 * so ublk module won't be unloaded too.
+	 */
+	return io_uring_cmd_provide_kbuf(cmd, data->buf);
+}
+
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
@@ -1666,6 +1799,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			__func__, cmd->cmd_op, ub_cmd->q_id, tag,
 			ub_cmd->result);
 
+	if ((cmd->flags & IORING_PROVIDE_GROUP_KBUF) &&
+			cmd_op != UBLK_U_IO_PROVIDE_IO_BUF)
+		return -EOPNOTSUPP;
+
 	if (ub_cmd->q_id >= ub->dev_info.nr_hw_queues)
 		goto out;
 
@@ -1701,6 +1838,8 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 
 	ret = -EINVAL;
 	switch (_IOC_NR(cmd_op)) {
+	case UBLK_IO_PROVIDE_IO_BUF:
+		return ublk_provide_io_buf(cmd, ubq, tag);
 	case UBLK_IO_FETCH_REQ:
 		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
 		if (ublk_queue_ready(ubq)) {
@@ -2120,11 +2259,14 @@ static void ublk_align_max_io_size(struct ublk_device *ub)
 
 static int ublk_add_tag_set(struct ublk_device *ub)
 {
+	int zc = !!(ub->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY);
+	struct ublk_rq_data *data;
+
 	ub->tag_set.ops = &ublk_mq_ops;
 	ub->tag_set.nr_hw_queues = ub->dev_info.nr_hw_queues;
 	ub->tag_set.queue_depth = ub->dev_info.queue_depth;
 	ub->tag_set.numa_node = NUMA_NO_NODE;
-	ub->tag_set.cmd_size = sizeof(struct ublk_rq_data);
+	ub->tag_set.cmd_size = struct_size(data, buf, zc);
 	ub->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	ub->tag_set.driver_data = ub;
 	return blk_mq_alloc_tag_set(&ub->tag_set);
@@ -2420,8 +2562,12 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		goto out_free_dev_number;
 	}
 
-	/* We are not ready to support zero copy */
-	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
+	/* zero copy depends on user copy */
+	if ((ub->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY) &&
+			!ublk_dev_is_user_copy(ub)) {
+		ret = -EINVAL;
+		goto out_free_dev_number;
+	}
 
 	ub->dev_info.nr_hw_queues = min_t(unsigned int,
 			ub->dev_info.nr_hw_queues, nr_cpu_ids);
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index c8dc5f8ea699..897ace0794c2 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -94,6 +94,8 @@
 	_IOWR('u', UBLK_IO_COMMIT_AND_FETCH_REQ, struct ublksrv_io_cmd)
 #define	UBLK_U_IO_NEED_GET_DATA		\
 	_IOWR('u', UBLK_IO_NEED_GET_DATA, struct ublksrv_io_cmd)
+#define	UBLK_U_IO_PROVIDE_IO_BUF	\
+	_IOWR('u', 0x23, struct ublksrv_io_cmd)
 
 /* only ABORT means that no re-fetch */
 #define UBLK_IO_RES_OK			0
@@ -126,10 +128,7 @@
 #define UBLKSRV_IO_BUF_TOTAL_BITS	(UBLK_QID_OFF + UBLK_QID_BITS)
 #define UBLKSRV_IO_BUF_TOTAL_SIZE	(1ULL << UBLKSRV_IO_BUF_TOTAL_BITS)
 
-/*
- * zero copy requires 4k block size, and can remap ublk driver's io
- * request into ublksrv's vm space
- */
+/* io_uring provide kbuf command based zero copy */
 #define UBLK_F_SUPPORT_ZERO_COPY	(1ULL << 0)
 
 /*
-- 
2.42.0


