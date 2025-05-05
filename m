Return-Path: <linux-block+bounces-21214-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75055AA958B
	for <lists+linux-block@lfdr.de>; Mon,  5 May 2025 16:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD79189BFB6
	for <lists+linux-block@lfdr.de>; Mon,  5 May 2025 14:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2645925C83C;
	Mon,  5 May 2025 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8TL8y55"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727BB25C713
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454805; cv=none; b=riqb1tnIw2C3f/atUVIgIS0eBxSfu+8JfFEpL3tOEKbocjo1IMwxUIbvFP3oQKTnPmQtLZ6gACQjCSqdA0yidn0nM6CcIaUxQ83mhKaI8XedZzMWUJHWITaD5vmPNCqY0LM6f6sPIvdEPBg4bbEwdajHRph4Ij+QTURLYUkefMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454805; c=relaxed/simple;
	bh=PMCB7PhxA4PKEKj0pifJac7QAwb089APyRXRvEAZ6mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmhWiyXZcsl2gRzUO/pQHjXh3ifM51zOY3WNV0USsa48k+slVtHeVALZHiaLsH7kalUX39ZfoAnqH++s17YC1YYRDtmH6YKyO6WEYa8G09//rECeS+OKpITVKG+vJjd0FvDHcgNqNywYjUwyXOja+y+7EPkInuAkafJg1bQxw8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8TL8y55; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y70W9VVz97uDxNYG4qF9Ivtw54xvRnbNQfBBwaIVpgY=;
	b=R8TL8y552w4jCSdgumUzae3p1kkQusEURyKEfv3nRhslLies1Qf7nTLAdLc/2gZj3Js9Ev
	W/YTh79fypWDuJuFk3EZpJgQE3JkQ2Vdbr9jMiGyTe17mKrnvumsMSztih/60RM3NsO6ES
	QvAn1JcMF9SpRG7dgdsRuny7wX0ekMw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-LGPAbwVqOeeByfGtgrganQ-1; Mon,
 05 May 2025 10:19:59 -0400
X-MC-Unique: LGPAbwVqOeeByfGtgrganQ-1
X-Mimecast-MFC-AGG-ID: LGPAbwVqOeeByfGtgrganQ_1746454798
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1846F1800360;
	Mon,  5 May 2025 14:19:58 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5DD619560AB;
	Mon,  5 May 2025 14:19:56 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 24/25] block: move hctx cpuhp add/del out of queue freezing
Date: Mon,  5 May 2025 22:18:02 +0800
Message-ID: <20250505141805.2751237-25-ming.lei@redhat.com>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Move hctx cpuhp add/del out of queue freezing for not connecting freeze
lock with cpuhp locks, then lockdep warning can be avoided.

This way is safe because both needn't queue to be frozen and scheduler
switch isn't allowed, with same reason for moving hctx debugfs/sysfs
register out of queue freeze.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c6098e569c02..88d5546e54f4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5010,7 +5010,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 fallback:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		blk_mq_realloc_hw_ctxs(set, q);
+		__blk_mq_realloc_hw_ctxs(set, q);
 
 		if (q->nr_hw_queues != set->nr_hw_queues) {
 			int i = prev_nr_hw_queues;
@@ -5034,6 +5034,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_sysfs_register_hctxs(q);
 		blk_mq_debugfs_register_hctxs(q);
+
+		blk_mq_remove_hw_queues_cpuhp(q);
+		blk_mq_add_hw_queues_cpuhp(q);
 	}
 	memalloc_noio_restore(memflags);
 
-- 
2.47.0


