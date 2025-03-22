Return-Path: <linux-block+bounces-18837-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1844A6C6E9
	for <lists+linux-block@lfdr.de>; Sat, 22 Mar 2025 02:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54AAC189CB10
	for <lists+linux-block@lfdr.de>; Sat, 22 Mar 2025 01:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7669822092;
	Sat, 22 Mar 2025 01:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1ybPaju"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF209250EC
	for <linux-block@vger.kernel.org>; Sat, 22 Mar 2025 01:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742606819; cv=none; b=KiV5IKb71VjYAFpVqd72Qf4Dg7tJEWFqOMFGnx1Jcm8a8r/5fQmCZRkx/AxMkoKSnp8M9wkra+5m5nK+ct7tPUASRqVltdgSq95P1/jCMdHeABss82hILhwrBEQFDmYp1XwUgmF6F6ULTe+GLC3A9dYaEJ6otz/+uf/gPlx6l+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742606819; c=relaxed/simple;
	bh=kuqS8iSpcRU+SSvfXL1fQh6lxOKvz35yAlmqzSeQOPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmRcib9v24ovWKZ58M++De6eV7dR5Lxi+dS9AZwANTesJh99T7idXqeD+2xB3k8ve6iy7X6yQbWAIDtvoRDMu5MoQ4HhB6YAxGx2VgJWRaAP1jV3jToP6kveUR1rES/BglvnJFyZDKvEsRc3L6J5vkMYcLbl2F+4POgJBtnsong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1ybPaju; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742606816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzI3y1nF+BEHh35uiaLiJdf3GCOURyVB0kOargkdN8Y=;
	b=I1ybPaju7eVJOW6Pc7b6mff3WTDj6qqKpFRkmgcZ8DmDG2nTnGVT33Gsdtw6LApdDV3GBR
	cdi/Z4U/itaY0EE//mkgz8q2mEQnAbfdVNDVilPfhlACyFQqOel5chP2XvpPtcF3IGV4s7
	HBo8deGLnbhZ01gjGfmT7txky/kyDnQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-04gooGbsP5mZbJQc0Q-qjQ-1; Fri,
 21 Mar 2025 21:26:53 -0400
X-MC-Unique: 04gooGbsP5mZbJQc0Q-qjQ-1
X-Mimecast-MFC-AGG-ID: 04gooGbsP5mZbJQc0Q-qjQ_1742606812
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C638180025B;
	Sat, 22 Mar 2025 01:26:52 +0000 (UTC)
Received: from localhost (unknown [10.72.120.2])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 72C9E19373C4;
	Sat, 22 Mar 2025 01:26:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jooyung Han <jooyung@google.com>,
	Mike Snitzer <snitzer@kernel.org>,
	zkabelac@redhat.com,
	dm-devel@lists.linux.dev,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 4/5] loop: try to handle loop aio command via NOWAIT IO first
Date: Sat, 22 Mar 2025 09:26:13 +0800
Message-ID: <20250322012617.354222-5-ming.lei@redhat.com>
In-Reply-To: <20250322012617.354222-1-ming.lei@redhat.com>
References: <20250322012617.354222-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Try to handle loop aio command via NOWAIT IO first, then we can avoid to
queue the aio command into workqueue. This is usually one big win in
case that FS block mapping is stable, Mikulas verified [1] that this way
improves IO perf by close to 5X in 12jobs sequential read/write test,
in which FS block mapping is just stable.

Fallback to workqueue in case of -EAGAIN. This way may bring a little
cost from the 1st retry, but when running the following write test over
loop/sparse_file, the actual effect on randwrite is obvious:

```
truncate -s 4G 1.img    #1.img is created on XFS/virtio-scsi
losetup -f 1.img --direct-io=on
fio --direct=1 --bs=4k --runtime=40 --time_based --numjobs=1 --ioengine=libaio \
	--iodepth=16 --group_reporting=1 --filename=/dev/loop0 -name=job --rw=$RW
```

- RW=randwrite: obvious IOPS drop observed
- RW=write: a little drop(%5 - 10%)

This perf drop on randwrite over sparse file will be addressed in the
following patch.

BLK_MQ_F_BLOCKING has to be set for calling into .read_iter() or .write_iter()
which might sleep even though it is NOWAIT, and the only effect is that rcu read
lock is replaced with srcu read lock.

Link: https://lore.kernel.org/linux-block/a8e5c76a-231f-07d1-a394-847de930f638@redhat.com/ [1]
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 51 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c14da87efb07..3baabf150488 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -90,6 +90,8 @@ struct loop_cmd {
 #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
 #define LOOP_DEFAULT_HW_Q_DEPTH 128
 
+static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd);
+
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
 static DEFINE_MUTEX(loop_validate_mutex);
@@ -385,6 +387,15 @@ static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
 
 	if (!atomic_dec_and_test(&cmd->ref))
 		return;
+
+	/* -EAGAIN could be returned from bdev's ->ki_complete */
+	if (cmd->ret == -EAGAIN) {
+		struct loop_device *lo = rq->q->queuedata;
+
+		loop_queue_work(lo, cmd);
+		return;
+	}
+
 	kfree(cmd->bvec);
 	if (likely(!blk_should_fake_timeout(rq->q)))
 		blk_mq_complete_request(rq);
@@ -490,15 +501,38 @@ static int lo_submit_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd)
 {
 	unsigned int nr_bvec = lo_cmd_nr_bvec(cmd);
-	int ret = lo_rw_aio_prep(lo, cmd, nr_bvec);
+	int ret;
 
-	if (ret >= 0)
-		ret = lo_submit_rw_aio(lo, cmd, nr_bvec);
+	/*
+	 * This command is prepared, and we have tried IOCB_NOWAIT, but got
+	 * -EAGAIN, so clear it now
+	 */
+	cmd->iocb.ki_flags &= ~IOCB_NOWAIT;
+	ret = lo_submit_rw_aio(lo, cmd, nr_bvec);
 	if (ret != -EIOCBQUEUED)
 		lo_rw_aio_complete(&cmd->iocb, ret);
 	return 0;
 }
 
+static blk_status_t lo_rw_aio_nowait(struct loop_device *lo,
+		struct loop_cmd *cmd)
+{
+	unsigned int nr_bvec = lo_cmd_nr_bvec(cmd);
+	int ret = lo_rw_aio_prep(lo, cmd, nr_bvec);
+
+	if (unlikely(ret < 0))
+		return BLK_STS_IOERR;
+
+	cmd->iocb.ki_flags |= IOCB_NOWAIT;
+	ret = lo_submit_rw_aio(lo, cmd, nr_bvec);
+	if (ret == -EAGAIN)
+		return BLK_STS_AGAIN;
+
+	if (ret != -EIOCBQUEUED)
+		lo_rw_aio_complete(&cmd->iocb, ret);
+	return BLK_STS_OK;
+}
+
 static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 {
 	struct loop_cmd *cmd = blk_mq_rq_to_pdu(rq);
@@ -1943,6 +1977,14 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		break;
 	}
 
+	if (cmd->use_aio) {
+		blk_status_t res = lo_rw_aio_nowait(lo, cmd);
+
+		if (res != BLK_STS_AGAIN)
+			return res;
+		/* fallback to workqueue for handling aio */
+	}
+
 	loop_queue_work(lo, cmd);
 
 	return BLK_STS_OK;
@@ -2093,7 +2135,8 @@ static int loop_add(int i)
 	lo->tag_set.queue_depth = hw_queue_depth;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
-	lo->tag_set.flags = BLK_MQ_F_STACKING | BLK_MQ_F_NO_SCHED_BY_DEFAULT;
+	lo->tag_set.flags = BLK_MQ_F_STACKING | BLK_MQ_F_NO_SCHED_BY_DEFAULT |
+		BLK_MQ_F_BLOCKING;
 	lo->tag_set.driver_data = lo;
 
 	err = blk_mq_alloc_tag_set(&lo->tag_set);
-- 
2.47.0


