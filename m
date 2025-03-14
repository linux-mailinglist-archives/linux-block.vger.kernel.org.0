Return-Path: <linux-block+bounces-18421-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F2FA60758
	for <lists+linux-block@lfdr.de>; Fri, 14 Mar 2025 03:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CCA46078B
	for <lists+linux-block@lfdr.de>; Fri, 14 Mar 2025 02:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4222317BB6;
	Fri, 14 Mar 2025 02:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/FuD2n6"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6AA18B03
	for <linux-block@vger.kernel.org>; Fri, 14 Mar 2025 02:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741918336; cv=none; b=tRKAYoUt6QTucCuYpbJTB1XgR/qabu1b3Vr/sdNTiAeanORbQB7Hk0bHELN0HNgWhfg3N6hWABrTUZTIeER7m/eR7x+uOJ/UWUeduAfi06adVxnmepQ+6sTPtQljK6s5cq1CcPNfsGx6Skqzp4RJ1ReQqoTYYUQRICMEymVG13g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741918336; c=relaxed/simple;
	bh=DQTQ7+mQKC1JDnfE4frjrkcu3cb21sZ3cRWymGnDmY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jds8iqgTBM8m60EfVYD66D9qrkwtS+9cVnl5hr/h2fuV4ineC2ON7SWsUYRr61LyoEfrZbGnPUoguWtY88xK1rfsOBj3D7aFhRa5wrQ5nDQKFpvjUM/BZFa48z4RuigZDB/nvK2ojixSlPdG6t8raNXEMt5izPk7++eOD29WiqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/FuD2n6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741918333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fgZoRfYizXi+vBT3gu5hmzqhybm+4j1jc5xO3FSiy8s=;
	b=O/FuD2n6Prv0mu3HirPBz9z8faPx1J9Y6Ntj7dYaP13SkflfG2ufotxYYzPWrqV32G8xck
	AWOAEzu1lqOX6mIFcUybpPW/UqUfavntQG6QvEu13K9Hl7eWgJdB01xWFZeNuqBkjglBA+
	WCdZ5hQ2SwbuAis6e5Ly7uTJ9YHaFSo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-JYE5q5slPLSu9QFQgTLWFA-1; Thu,
 13 Mar 2025 22:12:09 -0400
X-MC-Unique: JYE5q5slPLSu9QFQgTLWFA-1
X-Mimecast-MFC-AGG-ID: JYE5q5slPLSu9QFQgTLWFA_1741918327
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBADE195609E;
	Fri, 14 Mar 2025 02:12:07 +0000 (UTC)
Received: from localhost (unknown [10.72.120.27])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7ABA619560AB;
	Fri, 14 Mar 2025 02:12:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jooyung Han <jooyung@google.com>,
	Mike Snitzer <snitzer@kernel.org>,
	zkabelac@redhat.com,
	dm-devel@lists.linux.dev,
	Alasdair Kergon <agk@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/5] loop: cleanup lo_rw_aio()
Date: Fri, 14 Mar 2025 10:11:42 +0800
Message-ID: <20250314021148.3081954-3-ming.lei@redhat.com>
In-Reply-To: <20250314021148.3081954-1-ming.lei@redhat.com>
References: <20250314021148.3081954-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Cleanup lo_rw_aio() a bit by refactoring it into three parts:

- lo_cmd_nr_bvec(), for calculating how many bvecs in this request

- lo_rw_aio_prep(), for preparing loop command, which need to be called
once

- lo_submit_rw_aio(), for submitting this lo command, which can be
called multiple times

Prepare for trying to handle loop command by NOWAIT read/write IO
first.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 81 ++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 25 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 554f6cefe8f6..3f921d9d6de6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -394,7 +394,6 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
 	if (!atomic_dec_and_test(&cmd->ref))
 		return;
 	kfree(cmd->bvec);
-	cmd->bvec = NULL;
 	if (likely(!blk_should_fake_timeout(rq->q)))
 		blk_mq_complete_request(rq);
 }
@@ -407,24 +406,29 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret)
 	lo_rw_aio_do_completion(cmd);
 }
 
-static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd, loff_t pos)
+static inline unsigned lo_cmd_nr_bvec(struct loop_cmd *cmd)
 {
-	struct iov_iter iter;
 	struct req_iterator rq_iter;
-	struct bio_vec *bvec;
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
-	int dir = (req_op(rq) == REQ_OP_READ) ? ITER_DEST : ITER_SOURCE;
-	struct bio *bio = rq->bio;
-	struct file *file = lo->lo_backing_file;
 	struct bio_vec tmp;
-	unsigned int offset;
 	int nr_bvec = 0;
-	int ret;
 
 	rq_for_each_bvec(tmp, rq, rq_iter)
 		nr_bvec++;
 
+	return nr_bvec;
+}
+
+static int lo_rw_aio_prep(struct loop_device *lo, struct loop_cmd *cmd,
+			  unsigned nr_bvec)
+{
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	loff_t pos = ((loff_t) blk_rq_pos(rq) << 9) + lo->lo_offset;
+
 	if (rq->bio != rq->biotail) {
+		struct req_iterator rq_iter;
+		struct bio_vec *bvec;
+		struct bio_vec tmp;
 
 		bvec = kmalloc_array(nr_bvec, sizeof(struct bio_vec),
 				     GFP_NOIO);
@@ -442,35 +446,62 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd, loff_t pos)
 			*bvec = tmp;
 			bvec++;
 		}
-		bvec = cmd->bvec;
-		offset = 0;
 	} else {
+		cmd->bvec = NULL;
+	}
+	cmd->iocb.ki_pos = pos;
+	cmd->iocb.ki_filp = lo->lo_backing_file;
+	cmd->iocb.ki_complete = lo_rw_aio_complete;
+	cmd->iocb.ki_flags = IOCB_DIRECT;
+	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
+
+	return 0;
+}
+
+static int lo_submit_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
+			    int nr_bvec)
+{
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	int dir = (req_op(rq) == REQ_OP_READ) ? ITER_DEST : ITER_SOURCE;
+	struct file *file = lo->lo_backing_file;
+	struct iov_iter iter;
+	int ret;
+
+	if (cmd->bvec) {
+		iov_iter_bvec(&iter, dir, cmd->bvec, nr_bvec, blk_rq_bytes(rq));
+		iter.iov_offset = 0;
+	} else {
+		struct bio *bio = rq->bio;
+		struct bio_vec *bvec = __bvec_iter_bvec(bio->bi_io_vec,
+				bio->bi_iter);
+
 		/*
 		 * Same here, this bio may be started from the middle of the
 		 * 'bvec' because of bio splitting, so offset from the bvec
 		 * must be passed to iov iterator
 		 */
-		offset = bio->bi_iter.bi_bvec_done;
-		bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
+		iov_iter_bvec(&iter, dir, bvec, nr_bvec, blk_rq_bytes(rq));
+		iter.iov_offset = bio->bi_iter.bi_bvec_done;
 	}
-	atomic_set(&cmd->ref, 2);
-
-	iov_iter_bvec(&iter, dir, bvec, nr_bvec, blk_rq_bytes(rq));
-	iter.iov_offset = offset;
-
-	cmd->iocb.ki_pos = pos;
-	cmd->iocb.ki_filp = file;
-	cmd->iocb.ki_complete = lo_rw_aio_complete;
-	cmd->iocb.ki_flags = IOCB_DIRECT;
-	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 
+	atomic_set(&cmd->ref, 2);
 	if (dir == ITER_SOURCE)
 		ret = file->f_op->write_iter(&cmd->iocb, &iter);
 	else
 		ret = file->f_op->read_iter(&cmd->iocb, &iter);
-
 	lo_rw_aio_do_completion(cmd);
 
+	return ret;
+}
+
+
+static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd)
+{
+	unsigned int nr_bvec = lo_cmd_nr_bvec(cmd);
+	int ret = lo_rw_aio_prep(lo, cmd, nr_bvec);
+
+	if (ret >= 0)
+		ret = lo_submit_rw_aio(lo, cmd, nr_bvec);
 	if (ret != -EIOCBQUEUED)
 		lo_rw_aio_complete(&cmd->iocb, ret);
 	return 0;
@@ -507,7 +538,7 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 	case REQ_OP_WRITE:
 	case REQ_OP_READ:
 		if (cmd->use_aio)
-			return lo_rw_aio(lo, cmd, pos);
+			return lo_rw_aio(lo, cmd);
 		else
 			return lo_rw_simple(lo, rq, pos);
 	default:
-- 
2.47.0


