Return-Path: <linux-block+bounces-4074-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E7D872075
	for <lists+linux-block@lfdr.de>; Tue,  5 Mar 2024 14:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDAB28652D
	for <lists+linux-block@lfdr.de>; Tue,  5 Mar 2024 13:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6205A7A4;
	Tue,  5 Mar 2024 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ecMbkdtQ"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FF985920
	for <linux-block@vger.kernel.org>; Tue,  5 Mar 2024 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646047; cv=none; b=KiPukhszLIpsfRH4GYf48zY6HV7nEJH0ukKLRWRmCmbQuMTJ7RjRNJi3PlbQs5HIsnL3ZOwuA8Yp2gnsEFG0vnXlID7H416R3mRTBivttJJqXU4GANi8FIH37bvRprI2/ZsrsQAxAJY7BuefMKXybd0FOc3LdCBw7cnCtpsD44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646047; c=relaxed/simple;
	bh=tOmNqTt6Uod/QfwH0I/6BBHuD/cSjNyPVCopoGh7ipk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tF6mQn0Qmizkk+0BZpjrtMBXvP1fcSwOYm6/ctnvMLNCc/XImfC+oCOtwzfiGQO4GqlX9SnrFH74/gXvqkTF+cj7KE2keJaFprNp71GEY3Zzbf9rLXvw8bHBe0W9fM4q1meHFbDZUp9nQORlN5GbTAB1biRKKdlKknah/SAdSdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ecMbkdtQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CBcRvD9T7h9nmDg518Gqzpn+ib6AyjtQBtWpmonmt1k=; b=ecMbkdtQZJuDggvyU4hWQBcAe0
	rSIYHAWON4zvz6gpl9PlxoMa7CsH2FSkCCA8QgZ94gv1vcKCq6Yi4JLemX51iOR0qzVNCeOLjyUqx
	FoahsTbpgT+VPREq1m1B+yvWwXbiQaQscRqYihoaIk8nNvtW8CwnRVe4xt1nf/0nUtoVDvgoyxFyv
	sQ6m+yKRwCfCNSxBDrRDfR51vol2h2ljN8nN9SURHIp8YVGxmNtkra8HA1viqZST1RH2e/9FsNBqY
	QWohfxeUAoneHMiwkLGxjDnTNGN+riSe/sl5SBlPJNCNr3lqaWXOEqLNtw4Gd1/tYD2yDWHv3CkIf
	0bP21nuA==;
Received: from [50.219.53.154] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhV2C-0000000Dqx4-0MDA;
	Tue, 05 Mar 2024 13:40:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org
Subject: [PATCH 2/7] drbd: refactor drbd_reconsider_queue_parameters
Date: Tue,  5 Mar 2024 06:40:36 -0700
Message-Id: <20240305134041.137006-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305134041.137006-1-hch@lst.de>
References: <20240305134041.137006-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Split out a drbd_max_peer_bio_size helper for the peer I/O size,
and condense the various checks to a nested min3(..., max())) instead
of using a lot of local variables.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_nl.c | 84 +++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 35 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 43747a1aae4353..9135001a8e572d 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1189,6 +1189,33 @@ static int drbd_check_al_size(struct drbd_device *device, struct disk_conf *dc)
 	return 0;
 }
 
+static unsigned int drbd_max_peer_bio_size(struct drbd_device *device)
+{
+	/*
+	 * We may ignore peer limits if the peer is modern enough.  From 8.3.8
+	 * onwards the peer can use multiple BIOs for a single peer_request.
+	 */
+	if (device->state.conn < C_WF_REPORT_PARAMS)
+		return device->peer_max_bio_size;
+
+	if (first_peer_device(device)->connection->agreed_pro_version < 94)
+		return min(device->peer_max_bio_size, DRBD_MAX_SIZE_H80_PACKET);
+
+	/*
+	 * Correct old drbd (up to 8.3.7) if it believes it can do more than
+	 * 32KiB.
+	 */
+	if (first_peer_device(device)->connection->agreed_pro_version == 94)
+		return DRBD_MAX_SIZE_H80_PACKET;
+
+	/*
+	 * drbd 8.3.8 onwards, before 8.4.0
+	 */
+	if (first_peer_device(device)->connection->agreed_pro_version < 100)
+		return DRBD_MAX_BIO_SIZE_P95;
+	return DRBD_MAX_BIO_SIZE;
+}
+
 static void blk_queue_discard_granularity(struct request_queue *q, unsigned int granularity)
 {
 	q->limits.discard_granularity = granularity;
@@ -1303,48 +1330,35 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 	fixup_discard_support(device, q);
 }
 
-void drbd_reconsider_queue_parameters(struct drbd_device *device, struct drbd_backing_dev *bdev, struct o_qlim *o)
+void drbd_reconsider_queue_parameters(struct drbd_device *device,
+		struct drbd_backing_dev *bdev, struct o_qlim *o)
 {
-	unsigned int now, new, local, peer;
-
-	now = queue_max_hw_sectors(device->rq_queue) << 9;
-	local = device->local_max_bio_size; /* Eventually last known value, from volatile memory */
-	peer = device->peer_max_bio_size; /* Eventually last known value, from meta data */
+	unsigned int now = queue_max_hw_sectors(device->rq_queue) <<
+			SECTOR_SHIFT;
+	unsigned int new;
 
 	if (bdev) {
-		local = queue_max_hw_sectors(bdev->backing_bdev->bd_disk->queue) << 9;
-		device->local_max_bio_size = local;
-	}
-	local = min(local, DRBD_MAX_BIO_SIZE);
-
-	/* We may ignore peer limits if the peer is modern enough.
-	   Because new from 8.3.8 onwards the peer can use multiple
-	   BIOs for a single peer_request */
-	if (device->state.conn >= C_WF_REPORT_PARAMS) {
-		if (first_peer_device(device)->connection->agreed_pro_version < 94)
-			peer = min(device->peer_max_bio_size, DRBD_MAX_SIZE_H80_PACKET);
-			/* Correct old drbd (up to 8.3.7) if it believes it can do more than 32KiB */
-		else if (first_peer_device(device)->connection->agreed_pro_version == 94)
-			peer = DRBD_MAX_SIZE_H80_PACKET;
-		else if (first_peer_device(device)->connection->agreed_pro_version < 100)
-			peer = DRBD_MAX_BIO_SIZE_P95;  /* drbd 8.3.8 onwards, before 8.4.0 */
-		else
-			peer = DRBD_MAX_BIO_SIZE;
+		struct request_queue *b = bdev->backing_bdev->bd_disk->queue;
 
-		/* We may later detach and re-attach on a disconnected Primary.
-		 * Avoid this setting to jump back in that case.
-		 * We want to store what we know the peer DRBD can handle,
-		 * not what the peer IO backend can handle. */
-		if (peer > device->peer_max_bio_size)
-			device->peer_max_bio_size = peer;
+		device->local_max_bio_size =
+			queue_max_hw_sectors(b) << SECTOR_SHIFT;
 	}
-	new = min(local, peer);
 
-	if (device->state.role == R_PRIMARY && new < now)
-		drbd_err(device, "ASSERT FAILED new < now; (%u < %u)\n", new, now);
-
-	if (new != now)
+	/*
+	 * We may later detach and re-attach on a disconnected Primary.  Avoid
+	 * decreasing the value in this case.
+	 *
+	 * We want to store what we know the peer DRBD can handle, not what the
+	 * peer IO backend can handle.
+	 */
+	new = min3(DRBD_MAX_BIO_SIZE, device->local_max_bio_size,
+		max(drbd_max_peer_bio_size(device), device->peer_max_bio_size));
+	if (new != now) {
+		if (device->state.role == R_PRIMARY && new < now)
+			drbd_err(device, "ASSERT FAILED new < now; (%u < %u)\n",
+					new, now);
 		drbd_info(device, "max BIO size = %u\n", new);
+	}
 
 	drbd_setup_queue_param(device, bdev, new, o);
 }
-- 
2.39.2


