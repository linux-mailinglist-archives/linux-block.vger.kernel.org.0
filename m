Return-Path: <linux-block+bounces-3219-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D5E8546A9
	for <lists+linux-block@lfdr.de>; Wed, 14 Feb 2024 10:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359D41F23A69
	for <lists+linux-block@lfdr.de>; Wed, 14 Feb 2024 09:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B414417586;
	Wed, 14 Feb 2024 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PyNidrCq"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C82D17581
	for <linux-block@vger.kernel.org>; Wed, 14 Feb 2024 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904520; cv=none; b=RxpbQSwlZ3eZa8LkgRKgDIWzHKoxtFsR2y5lJRG/5BddKBSBxS7lKFG5bkUiwOCqnUjseeBiDL07n514hrOzhuJnzZURCAV/rzVHFxLfFnlZ6ZguYfvPuZHTVN9FiVZWEHnxhDz3ijC5TG/HGkMq4k+aXH3JdKR4PttYcmeJ+ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904520; c=relaxed/simple;
	bh=tKFa61KAE4vCXC6PHKDfzBjhYA0Vagiy8mobWFTaL8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GpSS/RA2MXp1sHAa/EoSL2VEhrYa5Kod/lPqohtLBOqEBOeFI8WRAGlzp1jq7+italOUQSBNb63IzI8tlNHLaVklJXN2dZbTmwU+r+xOLQadxaMIY/Gln/JKdXVaGDPEnzBNZt9qJ9t8wDOFvBxzQy3hClwgjXZF/7p1fYxCK6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PyNidrCq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Rilkxhyd43uI0oPH5hrwLCAEkmbhCioq5UiTDh6hdqk=; b=PyNidrCqYoB0DyxI+6ysakbylO
	ZJI2xqwSiKbHd+h0oM0t+LwTPBDp8wuxqBd7DQs9cf4X6C4zyS3z8540bPupjZQN0gSxeB4gadPFI
	nqMxFRP8GOv3Hb0MPyUIUsTd9Kt1SxsrnX52EwcW8zOYchOQTGl2emAGQRZWYYm3sqySZzDITTMNv
	oaFrBrSQIA+6WanFPQorb+WWu8TYuDsEwijzw5C/F4hYix4mz7z/7zQKg+tBYF6Oq9VjZhnCJ5ydn
	c69n83bXj/V7AHHq/aFUW7NGlBpcdceR10gFT3Nn6YdbRPkxYux2pYZNAGsg9DQBiOWLxFMgSaZgb
	8AXtgLKA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raBz4-0000000CSDI-0NjZ;
	Wed, 14 Feb 2024 09:55:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/5] null_blk: initialize the tag_set timeout in null_init_tag_set
Date: Wed, 14 Feb 2024 10:54:58 +0100
Message-Id: <20240214095501.1883819-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240214095501.1883819-1-hch@lst.de>
References: <20240214095501.1883819-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Otherwise it will be reset to the always same value when initializing a
device using the shared tag_set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d6836327eefb42..89e63d1c610362 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1797,6 +1797,7 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 	set->nr_hw_queues = hw_queues;
 	set->queue_depth = queue_depth;
 	set->numa_node = numa_node;
+	set->timeout = 5 * HZ;
 	if (poll_queues) {
 		set->nr_hw_queues += poll_queues;
 		set->nr_maps = 3;
@@ -1921,7 +1922,6 @@ static int null_add_dev(struct nullb_device *dev)
 	if (rv)
 		goto out_cleanup_queues;
 
-	nullb->tag_set->timeout = 5 * HZ;
 	nullb->disk = blk_mq_alloc_disk(nullb->tag_set, NULL, nullb);
 	if (IS_ERR(nullb->disk)) {
 		rv = PTR_ERR(nullb->disk);
-- 
2.39.2


