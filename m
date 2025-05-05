Return-Path: <linux-block+bounces-21208-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4E9AA9587
	for <lists+linux-block@lfdr.de>; Mon,  5 May 2025 16:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE231178F72
	for <lists+linux-block@lfdr.de>; Mon,  5 May 2025 14:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF1225B69D;
	Mon,  5 May 2025 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sdh64H+Q"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29F825A647
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454778; cv=none; b=sPxW+q7WUBFp8kFC6DDEv82bHjYqQMK91xmyKud4LjwpdqKH4op2T/tY5fSo4fARiQeU6NQbCJwxoZVx+7Z5O0SbtM9vi31vtZEP9dB35LssI/HeQszqnqDwcEAnppLR/gvIHcL17TxHZpMFa6hChIQMvYl4Z95RJ/siYWaSYwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454778; c=relaxed/simple;
	bh=Um8T6b4cSmFwwW1MvXCVa6u2PuTHetm7pvF9ebLePT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7h1MmVd5nuoo0WuTu9DlevPQDoZlSoDbp/R4BKYv4IX3h8p3JgkQhV5n+LPcAAxCMri3yP3PllexmTM4COmJn/j472VuptbVFjlWmRTEFypPF0sxpUg6/e/b0KT8Bi/Jeo15cXZxQz2xlgh2tNATZu5PUYQlbp154UdFdMYOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sdh64H+Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ri1aBOm3ff7Dx5/qf5HdzQvsz4TKsruSrd76qFlOgmY=;
	b=Sdh64H+QHRJB2EHX760IGAIaWkfSRkRuSvnJR5whfH5RHPBWdUQhV8kQYT8BF5x/RG88MP
	oUh/CAKsJpxIm4E5QnlEB7J52In1OdZ0H0i9X63K1nb20Hwkdy/8n+G/kHLdShJpy7AmDn
	PZdk002oFpAkCNaD4Xnneg7QF0DegYE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-55HTdkHBNAWMsO808eMfkQ-1; Mon,
 05 May 2025 10:19:29 -0400
X-MC-Unique: 55HTdkHBNAWMsO808eMfkQ-1
X-Mimecast-MFC-AGG-ID: 55HTdkHBNAWMsO808eMfkQ_1746454768
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6705118001CA;
	Mon,  5 May 2025 14:19:28 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 838CF30001A2;
	Mon,  5 May 2025 14:19:27 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 17/25] block: pass elevator_queue to elv_register_queue & unregister_queue
Date: Mon,  5 May 2025 22:17:55 +0800
Message-ID: <20250505141805.2751237-18-ming.lei@redhat.com>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Pass elevator_queue reference to elv_register_queue() & elv_unregister_queue().

No functional change, and prepare for moving the two out of elevator
lock & freezing queue, when we need to store the old & new elevator
queue in `struct elv_change_ctx` instance, then both two can co-exist
for short while, so we have to pass the exact elevator_queue instance
to elv_register_queue & unregister_queue.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 540542cee21c..eb7140a678d5 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -458,9 +458,10 @@ static const struct kobj_type elv_ktype = {
 	.release	= elevator_release,
 };
 
-static int elv_register_queue(struct request_queue *q, bool uevent)
+static int elv_register_queue(struct request_queue *q,
+			      struct elevator_queue *e,
+			      bool uevent)
 {
-	struct elevator_queue *e = q->elevator;
 	int error;
 
 	lockdep_assert_held(&q->elevator_lock);
@@ -488,10 +489,9 @@ static int elv_register_queue(struct request_queue *q, bool uevent)
 	return error;
 }
 
-static void elv_unregister_queue(struct request_queue *q)
+static void elv_unregister_queue(struct request_queue *q,
+				 struct elevator_queue *e)
 {
-	struct elevator_queue *e = q->elevator;
-
 	lockdep_assert_held(&q->elevator_lock);
 
 	if (e && test_and_clear_bit(ELEVATOR_FLAG_REGISTERED, &e->flags)) {
@@ -584,7 +584,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 	blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
-		elv_unregister_queue(q);
+		elv_unregister_queue(q, q->elevator);
 		elevator_exit(q);
 	}
 
@@ -592,7 +592,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
 		ret = blk_mq_init_sched(q, new_e);
 		if (ret)
 			goto out_unfreeze;
-		ret = elv_register_queue(q, !ctx->no_uevent);
+		ret = elv_register_queue(q, q->elevator, !ctx->no_uevent);
 		if (ret) {
 			elevator_exit(q);
 			goto out_unfreeze;
-- 
2.47.0


