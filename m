Return-Path: <linux-block+bounces-6811-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1018B88FD
	for <lists+linux-block@lfdr.de>; Wed,  1 May 2024 13:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F94B23034
	for <lists+linux-block@lfdr.de>; Wed,  1 May 2024 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481D5126F16;
	Wed,  1 May 2024 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZSjL0Ec"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAB386AE9;
	Wed,  1 May 2024 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561761; cv=none; b=nodOQjA+Kg+K1GcZqGvEACJKg/rrH3HTTrW8jKR+cx5RVl5UXRw1r0n3MR6b4y1F9ulh0tYiXLD/uYm3vCSas116pvY8F8PGpHHL7QRO7CcNfloPXd91PqWzUkSXd2ZL/rUyYmyPNXlkZSHLT1RMAU9h/XT8BvZ7EZNcYDq89Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561761; c=relaxed/simple;
	bh=y3+WkSsCwjLGqujRlTas9TE+y/lYVxrLmSN7j8qYloY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+/G+TPRPEM2if+S+x9DOsQOJqYqCmD7fwW55XU/tcxHPqrgLfHCs087QWIpihyF0pnC6OrShGWnYYPpKQY4x23YXieKV3h0sPC5d3damSETojibl7bPLoHUXda8GxP7QN0PZyWvxKvB6yybjszDo4D/yjhFrLBwnQ0ehlwLkuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZSjL0Ec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340B5C113CC;
	Wed,  1 May 2024 11:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714561761;
	bh=y3+WkSsCwjLGqujRlTas9TE+y/lYVxrLmSN7j8qYloY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RZSjL0EcAV5ay95awdpWiK5yB+xapVEkQKQeoBQfUEdcrnYnaP3oj6fREZYvSo5iy
	 FtSMdG+kyO3AjGEfd66j8OtSilmItOVKg6m6BTo/4LSwVv6PUMC3rY+iYrDZTIJ2Rn
	 AYeNijbhMV7jikFu/fClbpJoXBTBcH/d9J1qkZtNBzU10eIRfAxAtQYefWuPqQm2CD
	 i5oJVBJf2ysnVJqFq0r4aR9g8kLm3xhWpF/8f+R0X2dX5rPI1f7USSejsKFPbWuW54
	 cIXGzzSB9Ju9tAudd4YJRiR6PbN5hfM2hgCYuxRLVUSeW5uPlM5HhtTU84NfYfoBgS
	 b5AAc8vzuRrjA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH v3 10/14] block: Improve blk_zone_write_plug_bio_merged()
Date: Wed,  1 May 2024 20:09:03 +0900
Message-ID: <20240501110907.96950-11-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501110907.96950-1-dlemoal@kernel.org>
References: <20240501110907.96950-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve blk_zone_write_plug_bio_merged() to check that we succefully get
a reference on the zone write plug of the merged BIO, as expected since
for a merge we already have at least one request and one BIO referencing
the zone write plug. Comments in this function are also improved to
better explain the references to the BIO zone write plug.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index cd0049f5bf2f..1890b6d55d8b 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -885,11 +885,16 @@ void blk_zone_write_plug_bio_merged(struct bio *bio)
 	bio_set_flag(bio, BIO_ZONE_WRITE_PLUGGING);
 
 	/*
-	 * Increase the plug reference count and advance the zone write
-	 * pointer offset.
+	 * Get a reference on the zone write plug of the target zone and advance
+	 * the zone write pointer offset. Given that this is a merge, we already
+	 * have at least one request and one BIO referencing the zone write
+	 * plug. So this should not fail.
 	 */
 	zwplug = disk_get_zone_wplug(bio->bi_bdev->bd_disk,
 				     bio->bi_iter.bi_sector);
+	if (WARN_ON_ONCE(!zwplug))
+		return;
+
 	spin_lock_irqsave(&zwplug->lock, flags);
 	zwplug->wp_offset += bio_sectors(bio);
 	spin_unlock_irqrestore(&zwplug->lock, flags);
-- 
2.44.0


