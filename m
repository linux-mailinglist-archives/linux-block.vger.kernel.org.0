Return-Path: <linux-block+bounces-29123-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5A7C18228
	for <lists+linux-block@lfdr.de>; Wed, 29 Oct 2025 04:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D0D40077A
	for <lists+linux-block@lfdr.de>; Wed, 29 Oct 2025 03:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7B9148830;
	Wed, 29 Oct 2025 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U065r2hn"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B792ED16D
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707468; cv=none; b=mGalczhiMvbImDhpqmhAbj+Jhm1SKrW6+XZOloZX/hmCGxAYfV50ki3+Y7wsfBMPA/GGhtlxgPSHPTk8HupouzpE2oQvKPUYSejtzN74zNyhQ5hQt+BoJXp5ecXzPkQ5FCbZ58w5KTROIfHe0gPeTMkmvnc8H7yL//3VLvkf2l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707468; c=relaxed/simple;
	bh=gF4eeexDaRxmWP+A8lqef7Gcisz+qLegkzEZG9gkbKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnMR1mVnNGwYq/UVbh/GYRGly4K2JCe+CMYSYMrZaVqQoGqyqW1hK0X9L2n/llUyXplkTraXpAhmYh22DR5w+f8oomiQQErIDvShHry/rSjhz0Gs5OG9t9gyBXVXZL8VRIP9yNsyPOGFnYt//GgbO19CTTlReHpmES5rdY5kO30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U065r2hn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761707465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSSljwOaBsd1AYSARVZU+/v/6pXiqfvYBPTeIdQ1Y1I=;
	b=U065r2hnFqKjm4i17LamGF2qNOLc/H17yqfIiQWuqUbZIzjgfPA6JEnbdbji3PMVaKbz3L
	ppzxvDbY/UM9k5cYiv7hwnm8tnA0fEAkD1ivtrRZwwJMR3f5+Iy8cUPsDgwX0YSYxjRCaR
	8OphOZNZK9co5hbdntHSOLZqRS85wWg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-HRXLZ334NlanN_0CT6r9rw-1; Tue,
 28 Oct 2025 23:11:01 -0400
X-MC-Unique: HRXLZ334NlanN_0CT6r9rw-1
X-Mimecast-MFC-AGG-ID: HRXLZ334NlanN_0CT6r9rw_1761707460
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8AB118001DD;
	Wed, 29 Oct 2025 03:11:00 +0000 (UTC)
Received: from localhost (unknown [10.72.120.24])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36E36180035A;
	Wed, 29 Oct 2025 03:10:58 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 3/5] ublk: use struct_size() for allocation
Date: Wed, 29 Oct 2025 11:10:29 +0800
Message-ID: <20251029031035.258766-4-ming.lei@redhat.com>
In-Reply-To: <20251029031035.258766-1-ming.lei@redhat.com>
References: <20251029031035.258766-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Convert ublk_queue to use struct_size() for allocation.

Changes in this commit:

1. Update ublk_init_queue() to use struct_size(ubq, ios, depth)
   instead of manual size calculation (sizeof(struct ublk_queue) +
   depth * sizeof(struct ublk_io)).

This provides better type safety and makes the code more maintainable
by using standard kernel macro for flexible array handling.

Meantime annotate ublk_queue.ios by __counted_by().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ed77b4527b33..409874714c62 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -203,7 +203,7 @@ struct ublk_queue {
 	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
 	spinlock_t		cancel_lock;
 	struct ublk_device *dev;
-	struct ublk_io ios[];
+	struct ublk_io ios[] __counted_by(q_depth);
 };
 
 struct ublk_device {
@@ -2700,7 +2700,6 @@ static int ublk_get_queue_numa_node(struct ublk_device *ub, int q_id)
 static int ublk_init_queue(struct ublk_device *ub, int q_id)
 {
 	int depth = ub->dev_info.queue_depth;
-	int ubq_size = sizeof(struct ublk_queue) + depth * sizeof(struct ublk_io);
 	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO;
 	struct ublk_queue *ubq;
 	struct page *page;
@@ -2711,7 +2710,8 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 	numa_node = ublk_get_queue_numa_node(ub, q_id);
 
 	/* Allocate queue structure on local NUMA node */
-	ubq = kvzalloc_node(ubq_size, GFP_KERNEL, numa_node);
+	ubq = kvzalloc_node(struct_size(ubq, ios, depth), GFP_KERNEL,
+			    numa_node);
 	if (!ubq)
 		return -ENOMEM;
 
-- 
2.47.0


