Return-Path: <linux-block+bounces-8994-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F36590BB55
	for <lists+linux-block@lfdr.de>; Mon, 17 Jun 2024 21:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3038D282D72
	for <lists+linux-block@lfdr.de>; Mon, 17 Jun 2024 19:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A79188CAE;
	Mon, 17 Jun 2024 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XZ3N4HBI"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com [209.85.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286EA187565
	for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653501; cv=none; b=fvWCOqi66H2v8BWlGjZXHQODNrEJH8nRNGbZWPFzUMcoODEpoCkeMoKzpee/zQmTRSqJLUwbPAlPFknaeuvELTC1pHEjkr6rA8gGPvcwAIXMEMeC4nb2ilw+RUSw34mODvWQDPYdC/1v0Pr77gUvJ0edm09zGrha4MFnirC4txg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653501; c=relaxed/simple;
	bh=zHh5cInX6LbAD9zKOLYTffSQaG4k+QriHA4NDndLIeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ircbh5BYWFf/9gWaQt/EDevc7Gii2MbFkvos2K/kIs4vDcKBVkFf2kK1WWwUpdBh1ve+/xbzonapqyddgNf+8aUNTeqMEhIcSkpsLgJAakZ2Vc/Lc5M/ZVa8FtcMY5RAATctpuI0eR2R1tkgLuVRtqhG9KeHLpmIcnd9WsCzyYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XZ3N4HBI; arc=none smtp.client-ip=209.85.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lf1-f99.google.com with SMTP id 2adb3069b0e04-52b7ffd9f6eso4651564e87.3
        for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 12:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1718653497; x=1719258297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRG4KmmpYlaV0TAj9hrThh+HxSU+Y2tSkTCvMoWEui8=;
        b=XZ3N4HBItIuT8O68gRVld51MCZ9UvtaQHnLGkCTOHj1l2F4dqdCejCkGlvWdNSxUZN
         Jxk6LPtAn0/CnPklg/CAYqEwBKxgaGoMMHfjPz+eBqE/lPVbhu+L9n9IwlaAtu0Gy0M1
         bST8fiaCmamgE92umzWEOfU53+oa+6iyv+WWAy8O30iDoMaFgx2QV/jsKc9dizh4l1pM
         X/fuNLPJm5Dsw37Dx+MEIZ1ZcwyK4Vh8cgHLVtNl9FLVVZg1bCAybG5+4VTDk8WpFpEZ
         Hb5zVuN8rnR8uMgkiqzh+4btMqs2djKj+ckfYS4YWL1gCbfA0e8SUxWAmA1jyX+RSfWT
         WAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718653497; x=1719258297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRG4KmmpYlaV0TAj9hrThh+HxSU+Y2tSkTCvMoWEui8=;
        b=oWzBvH8wAvVyOWUUHla7EAXueqI7CAN+7VScLSLg3Yt/cPEo1xkU8TK0LQ30/JsbkV
         fKMQIQeCZusLj9YbGZstvR9tbc7f4Qir2pe6UZmYvBM/A6RgP1+m2/6R9C2TtNN0Dp8G
         rsEUxmMhGtNIptX6jl9sQwZwPxpisq5/gPZCFE62a0uE1QP23PqD4AaDYF9wWugvNTSK
         hNlolMHfD5UFz3b/9upof7iXwE0/sP1qM0qRw7qYKw1cACOR2hmxVGlmHEE3leezuLmn
         dfsYx0MFIaEAZIjlCXEIICq7i1q5b4B2QF89omCOimzzqbO8Tl38K9L8lzRjFDjzagSW
         1k/g==
X-Forwarded-Encrypted: i=1; AJvYcCUGQrGFbG0lZhfZpM9Ljju4Shki+Sto+GuGbGCi8BErPPj22Iffto8tfdmcd51s6CIJAduuUUXhKtVXCIkPXcQmaeY/atmw7TsxqO8=
X-Gm-Message-State: AOJu0YxYHGeY+1H43Hkv6DXCznWpswpIjAlo4liZzwwxqOQ3HLvTe4Nm
	1WwV9drTJ6NC6x4HonJOlvv+4p4iTpyFE318w4DKY6NzaqzaWmJ3cVOtV9H2nI2g29TuYcTUUfk
	ly7D3xNmdAmEyZYYrzjUqn9C6hjKDZJey
X-Google-Smtp-Source: AGHT+IF+QlL0V5HbkCBcsh05FT8zTC679DjWT9hTmYB+z8ASdbQxMa0mcuh9Zm5Eg9zithYY6OZe7A+wR/SK
X-Received: by 2002:a05:6512:3992:b0:52c:c22d:3d4b with SMTP id 2adb3069b0e04-52cc22d3f85mr549683e87.54.1718653497217;
        Mon, 17 Jun 2024 12:44:57 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-a6f56f18f09sm13017566b.248.2024.06.17.12.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 12:44:57 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E612A340509;
	Mon, 17 Jun 2024 13:44:55 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id E13EFE4143F; Mon, 17 Jun 2024 13:44:55 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/4] ublk: refactor recovery configuration flag helpers
Date: Mon, 17 Jun 2024 13:44:49 -0600
Message-Id: <20240617194451.435445-3-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617194451.435445-1-ushankar@purestorage.com>
References: <20240617194451.435445-1-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk currently supports the following behaviors on ublk server exit:

A: outstanding I/Os get errors, subsequently issued I/Os get errors
B: outstanding I/Os get errors, subsequently issued I/Os queue
C: outstanding I/Os get reissued, subsequently issued I/Os queue

and the following behaviors for recovery of preexisting block devices by
a future incarnation of the ublk server:

1: ublk devices stopped on ublk server exit (no recovery possible)
2: ublk devices are recoverable using start/end_recovery commands

The userspace interface allows selection of combinations of these
behaviors using flags specified at device creation time, namely:

default behavior: A + 1
UBLK_F_USER_RECOVERY: B + 2
UBLK_F_USER_RECOVERY|UBLK_F_USER_RECOVERY_REISSUE: C + 2

We can't easily change the userspace interface to allow independent
selection of one of {A, B, C} and one of {1, 2}, but we can refactor the
internal helpers which test for the flags. Replace the existing helpers
with the following set:

ublk_nosrv_should_reissue_outstanding: tests for behavior C
ublk_nosrv_should_queue_io: tests for behavior B
ublk_nosrv_should_stop_dev: tests for behavior 1

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c | 55 +++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2752a9afe9d4..e8cca58a71bc 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -652,22 +652,35 @@ static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
 			PAGE_SIZE);
 }
 
-static inline bool ublk_queue_can_use_recovery_reissue(
-		struct ublk_queue *ubq)
+/*
+ * Should I/O outstanding to the ublk server when it exits be reissued?
+ * If not, outstanding I/O will get errors.
+ */
+static inline bool ublk_nosrv_should_reissue_outstanding(struct ublk_device *ub)
 {
-	return (ubq->flags & UBLK_F_USER_RECOVERY) &&
-			(ubq->flags & UBLK_F_USER_RECOVERY_REISSUE);
+	return (ub->dev_info.flags & UBLK_F_USER_RECOVERY) &&
+	       (ub->dev_info.flags & UBLK_F_USER_RECOVERY_REISSUE);
 }
 
-static inline bool ublk_queue_can_use_recovery(
-		struct ublk_queue *ubq)
+/*
+ * Should I/O issued while there is no ublk server queue? If not, I/O
+ * issued while there is no ublk server will get errors.
+ */
+static inline bool ublk_nosrv_should_queue_io(struct ublk_device *ub)
 {
-	return ubq->flags & UBLK_F_USER_RECOVERY;
+	return ub->dev_info.flags & UBLK_F_USER_RECOVERY;
 }
 
-static inline bool ublk_can_use_recovery(struct ublk_device *ub)
+/*
+ * Should ublk devices be stopped (i.e. no recovery possible) when the
+ * ublk server exits? If not, devices can be used again by a future
+ * incarnation of a ublk server via the start_recovery/end_recovery
+ * commands.
+ */
+static inline bool ublk_nosrv_should_stop_dev(struct ublk_device *ub)
 {
-	return ub->dev_info.flags & UBLK_F_USER_RECOVERY;
+	return (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY)) &&
+	       (!(ub->dev_info.flags & UBLK_F_USER_RECOVERY_REISSUE));
 }
 
 static void ublk_free_disk(struct gendisk *disk)
@@ -1043,7 +1056,7 @@ static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
 {
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
 
-	if (ublk_queue_can_use_recovery_reissue(ubq))
+	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
 		blk_mq_requeue_request(req, false);
 	else
 		ublk_put_req_ref(ubq, req);
@@ -1071,7 +1084,7 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 		struct request *rq)
 {
 	/* We cannot process this rq so just requeue it. */
-	if (ublk_queue_can_use_recovery(ubq))
+	if (ublk_nosrv_should_queue_io(ubq->dev))
 		blk_mq_requeue_request(rq, false);
 	else
 		blk_mq_end_request(rq, BLK_STS_IOERR);
@@ -1216,10 +1229,10 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 		struct ublk_device *ub = ubq->dev;
 
 		if (ublk_abort_requests(ub, ubq)) {
-			if (ublk_can_use_recovery(ub))
-				schedule_work(&ub->quiesce_work);
-			else
+			if (ublk_nosrv_should_stop_dev(ub))
 				schedule_work(&ub->stop_work);
+			else
+				schedule_work(&ub->quiesce_work);
 		}
 		return BLK_EH_DONE;
 	}
@@ -1248,7 +1261,7 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * Note: force_abort is guaranteed to be seen because it is set
 	 * before request queue is unqiuesced.
 	 */
-	if (ublk_queue_can_use_recovery(ubq) && unlikely(ubq->force_abort))
+	if (ublk_nosrv_should_queue_io(ubq->dev) && unlikely(ubq->force_abort))
 		return BLK_STS_IOERR;
 
 	if (unlikely(ubq->canceling)) {
@@ -1469,10 +1482,10 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	ublk_cancel_cmd(ubq, io, issue_flags);
 
 	if (need_schedule) {
-		if (ublk_can_use_recovery(ub))
-			schedule_work(&ub->quiesce_work);
-		else
+		if (ublk_nosrv_should_stop_dev(ub))
 			schedule_work(&ub->stop_work);
+		else
+			schedule_work(&ub->quiesce_work);
 	}
 }
 
@@ -1577,7 +1590,7 @@ static void ublk_stop_dev(struct ublk_device *ub)
 	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
 		goto unlock;
-	if (ublk_can_use_recovery(ub)) {
+	if (ublk_nosrv_should_queue_io(ub)) {
 		if (ub->dev_info.state == UBLK_S_DEV_LIVE)
 			__ublk_quiesce_dev(ub);
 		ublk_unquiesce_dev(ub);
@@ -2674,7 +2687,7 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 	int i;
 
 	mutex_lock(&ub->mutex);
-	if (!ublk_can_use_recovery(ub))
+	if (ublk_nosrv_should_stop_dev(ub))
 		goto out_unlock;
 	/*
 	 * START_RECOVERY is only allowd after:
@@ -2725,7 +2738,7 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
 
 	mutex_lock(&ub->mutex);
-	if (!ublk_can_use_recovery(ub))
+	if (ublk_nosrv_should_stop_dev(ub))
 		goto out_unlock;
 
 	if (ub->dev_info.state != UBLK_S_DEV_QUIESCED) {
-- 
2.34.1


