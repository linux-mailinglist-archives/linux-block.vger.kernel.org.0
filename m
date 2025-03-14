Return-Path: <linux-block+bounces-18420-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3E9A60757
	for <lists+linux-block@lfdr.de>; Fri, 14 Mar 2025 03:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C30627AD273
	for <lists+linux-block@lfdr.de>; Fri, 14 Mar 2025 02:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE7417BB6;
	Fri, 14 Mar 2025 02:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elFCfTmz"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D345E38DD8
	for <linux-block@vger.kernel.org>; Fri, 14 Mar 2025 02:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741918331; cv=none; b=kB2ye5K1T/RcM3UgfCCrj5CihAD3rSUhrtRDCWAmTQl/T3Oqriz3IGOOA+wtIXlM/hmLf6RCl/RWcW0durvEwjYKzsMp8UHUCp3x75HLbNRE1+m6u17EskhOjqhdHA6ggm0obo9zIBe8GUrrdhQ2kK/f/Zwel+A0FyqVWyZI7ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741918331; c=relaxed/simple;
	bh=XBrTJOi6RUf+zfX7H5Ssv7FsOXcGn3VYi6NQzhzSg8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwgcW/J9csmNFza3zFrbbNTEJJpqaH+nc9bkdvq1b++AefX5CLJnZOHt0My6tKlF5Wj+MdgRtqegVQaOCpQwr0vm+0eUrerqI9azCCnw6eqHxELOerCPeGL21wV82WRy8kES8SRp5DbZBu3DkAwGtTH+HErYwMSyrB5LGEGXwhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=elFCfTmz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741918328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJM7fhnzSVkAI0uB0b+VZz7idxBiXe+D5iz1Ay+75YE=;
	b=elFCfTmzaFbKhF8PCM5/Qp7EMQer7+DYx1F0bmvxp0bnnl9YfK+aQYUN98FotVdvSWHDbw
	p7qBwAUC43Btx/HZxNJuLgvpkK05QhrG0ahX/qy1ac3jUSTg8tPvXSdWBYYTrtdHkk0jO+
	7iKW/DprMCwm5mRlwMAwA6SdshfLcgc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-_S5p_J8vPNq2zUOrYratmA-1; Thu,
 13 Mar 2025 22:12:05 -0400
X-MC-Unique: _S5p_J8vPNq2zUOrYratmA-1
X-Mimecast-MFC-AGG-ID: _S5p_J8vPNq2zUOrYratmA_1741918324
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BA86180AB1C;
	Fri, 14 Mar 2025 02:12:03 +0000 (UTC)
Received: from localhost (unknown [10.72.120.27])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1ACF1828A87;
	Fri, 14 Mar 2025 02:12:00 +0000 (UTC)
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
Subject: [PATCH V2 1/5] loop: simplify do_req_filebacked()
Date: Fri, 14 Mar 2025 10:11:41 +0800
Message-ID: <20250314021148.3081954-2-ming.lei@redhat.com>
In-Reply-To: <20250314021148.3081954-1-ming.lei@redhat.com>
References: <20250314021148.3081954-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

lo_rw_aio() is only called for READ/WRITE operation, which can be
figured out from request directly, so remove 'rw' parameter from
lo_rw_aio(), meantime rename the local variable as 'dir' which makes
the check more readable in lo_rw_aio().

Meantime add lo_rw_simple() so that do_req_filebacked() can be
simplified in the following way:

```
	if (cmd->use_aio)
		return lo_rw_aio(lo, cmd, pos);
	else
		return lo_rw_simple(lo, rq, pos);
```

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 657bf53decf3..554f6cefe8f6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -285,6 +285,13 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
 	return 0;
 }
 
+static int lo_rw_simple(struct loop_device *lo, struct request *rq, loff_t pos)
+{
+	if (req_op(rq) == REQ_OP_READ)
+		return lo_read_simple(lo, rq, pos);
+	return lo_write_simple(lo, rq, pos);
+}
+
 static void loop_clear_limits(struct loop_device *lo, int mode)
 {
 	struct queue_limits lim = queue_limits_start_update(lo->lo_queue);
@@ -400,13 +407,13 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret)
 	lo_rw_aio_do_completion(cmd);
 }
 
-static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
-		     loff_t pos, int rw)
+static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd, loff_t pos)
 {
 	struct iov_iter iter;
 	struct req_iterator rq_iter;
 	struct bio_vec *bvec;
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
+	int dir = (req_op(rq) == REQ_OP_READ) ? ITER_DEST : ITER_SOURCE;
 	struct bio *bio = rq->bio;
 	struct file *file = lo->lo_backing_file;
 	struct bio_vec tmp;
@@ -448,7 +455,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	}
 	atomic_set(&cmd->ref, 2);
 
-	iov_iter_bvec(&iter, rw, bvec, nr_bvec, blk_rq_bytes(rq));
+	iov_iter_bvec(&iter, dir, bvec, nr_bvec, blk_rq_bytes(rq));
 	iter.iov_offset = offset;
 
 	cmd->iocb.ki_pos = pos;
@@ -457,7 +464,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_flags = IOCB_DIRECT;
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 
-	if (rw == ITER_SOURCE)
+	if (dir == ITER_SOURCE)
 		ret = file->f_op->write_iter(&cmd->iocb, &iter);
 	else
 		ret = file->f_op->read_iter(&cmd->iocb, &iter);
@@ -498,15 +505,11 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 	case REQ_OP_DISCARD:
 		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_WRITE:
-		if (cmd->use_aio)
-			return lo_rw_aio(lo, cmd, pos, ITER_SOURCE);
-		else
-			return lo_write_simple(lo, rq, pos);
 	case REQ_OP_READ:
 		if (cmd->use_aio)
-			return lo_rw_aio(lo, cmd, pos, ITER_DEST);
+			return lo_rw_aio(lo, cmd, pos);
 		else
-			return lo_read_simple(lo, rq, pos);
+			return lo_rw_simple(lo, rq, pos);
 	default:
 		WARN_ON_ONCE(1);
 		return -EIO;
-- 
2.47.0


