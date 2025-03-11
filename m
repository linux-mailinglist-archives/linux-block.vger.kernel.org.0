Return-Path: <linux-block+bounces-18242-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 083B0A5D09E
	for <lists+linux-block@lfdr.de>; Tue, 11 Mar 2025 21:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B623B65A3
	for <lists+linux-block@lfdr.de>; Tue, 11 Mar 2025 20:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1855263F3F;
	Tue, 11 Mar 2025 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WoRpsrIU"
X-Original-To: linux-block@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86E4264A71
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741724141; cv=none; b=H2Okta4tt7cp5VwldpSX1TOAkZHl+zSyMp+7s3hsmB3tpJfepM6zRXqk7FxC76WHcAlPSX5ygPejZAqrzuDzppsvW4QuJaUa20pw3A1yGwI8N85uDRWn81+JkIyEtIDqMxNOR0FW+ML4n+HNl098VYzR1zHt4gZMRhoU4yEdJtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741724141; c=relaxed/simple;
	bh=FEISgi/l4oR05eYMQZtexpwvOvtdSl5KimiXIHb0ch8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCgR7hhI/tik5AlYWCtJg0bT0SLu7JXbtKMc2gqz0dVhOJdxrX7x4PfY2SEYAl9C6ZfOGfe7J6tV49BEG2osbm2tIcj2no2O1RieKSxYUa/K9kneJL495bjoKKmaMNI9UXJWzYOvRwPWQ4RazCux7PxkaM2f1pR5TTHVl92I91c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WoRpsrIU; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741724137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3k/t7z7wqE8OoTjAqtCf+7y0qN5BcjA4jAcbb7jrc4=;
	b=WoRpsrIUazYlL8JVLUi6H26W+CNs9bkGn0kPQ04FPGmeMnuoPWOCVWFQnPbCT+NiL0Fm46
	opLCUAIb9yHqfsqYjgESSfy8TvXBNieziKIdzOt2VBvsE665FvmT0ZgKuyLOndkm60ufMm
	jJxRX82tekYkkSygnD2l0VDBEwfSU6g=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 13/14] block: Allow REQ_FUA|REQ_READ
Date: Tue, 11 Mar 2025 16:15:15 -0400
Message-ID: <20250311201518.3573009-14-kent.overstreet@linux.dev>
In-Reply-To: <20250311201518.3573009-1-kent.overstreet@linux.dev>
References: <20250311201518.3573009-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

REQ_FUA|REQ_READ means "do a read that bypasses the controller cache",
the same as writes.

This is useful for when the filesystem gets a checksum error, it's
possible that a bit was flipped in the controller cache, and when we
retry we want to retry the entire IO, not just from cache.

The nvme driver already passes through REQ_FUA for reads, not just
writes, so disabling the warning is sufficient to start using it, and
bcachefs is implementing additional retries for checksum errors so can
immediately use it.

Link: https://lore.kernel.org/linux-block/20250311133517.3095878-1-kent.overstreet@linux.dev/
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 block/blk-core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d6c4fa3943b5..7b1103eb877d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -793,20 +793,21 @@ void submit_bio_noacct(struct bio *bio)
 			goto end_io;
 	}
 
+	if (WARN_ON_ONCE((bio->bi_opf & REQ_PREFLUSH) &&
+			 bio_op(bio) != REQ_OP_WRITE &&
+			 bio_op(bio) != REQ_OP_ZONE_APPEND))
+		goto end_io;
+
 	/*
 	 * Filter flush bio's early so that bio based drivers without flush
 	 * support don't have to worry about them.
 	 */
-	if (op_is_flush(bio->bi_opf)) {
-		if (WARN_ON_ONCE(bio_op(bio) != REQ_OP_WRITE &&
-				 bio_op(bio) != REQ_OP_ZONE_APPEND))
+	if (op_is_flush(bio->bi_opf) &&
+	    !bdev_write_cache(bdev)) {
+		bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
+		if (!bio_sectors(bio)) {
+			status = BLK_STS_OK;
 			goto end_io;
-		if (!bdev_write_cache(bdev)) {
-			bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
-			if (!bio_sectors(bio)) {
-				status = BLK_STS_OK;
-				goto end_io;
-			}
 		}
 	}
 
-- 
2.47.2


