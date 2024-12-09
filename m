Return-Path: <linux-block+bounces-15075-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C84D69E93D1
	for <lists+linux-block@lfdr.de>; Mon,  9 Dec 2024 13:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A74C285792
	for <lists+linux-block@lfdr.de>; Mon,  9 Dec 2024 12:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E714D22371B;
	Mon,  9 Dec 2024 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqmyMop3"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEF722370D;
	Mon,  9 Dec 2024 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747068; cv=none; b=Ir6pY7qE7qkhRLJABojSXzQDV+bXq9ECg4s7+QIupxVLohzkeqWUXUfa59DBmLtrlZTtp4l3i5Ez2Uce6gUzyMHmEB5usIiD2mkEc4ssENWbC6vJApPxwD7X4Kc3xcebiIhv084cMwFWybp0JldRi0/Pv/6yJep1XeeQIqjZpMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747068; c=relaxed/simple;
	bh=ZnBnsqTarQEro22bKrMcNizgeIymQ5Qchu6YVoV6J2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChFBf7c0d5Q3M/Ncr8q/OQwsgwxH6cWOeydujtC5Oruy3+PiG3f/4fLnvQI1HbuuxHAU2QdKFs5HT1eOlCKTYCkkABGDPSUKD0s1ez4h5opgw3HtOC3M/8sMLHV90gE63FmI5TLIcps0xosoVjCp7CJS4+2wMscRU/75NQuyS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqmyMop3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A38DC4CEE2;
	Mon,  9 Dec 2024 12:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733747067;
	bh=ZnBnsqTarQEro22bKrMcNizgeIymQ5Qchu6YVoV6J2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eqmyMop3twx8ElIEDhq+m29PmwRB0RvJUbinHnPE3D47V1lWLwORKRbpjPBePkcte
	 OjFKPByDyrh8iaYp5TL9ebK0brMAICmbuCMj29a+KCGJCRGZ8GhY3Xsbcy7hE0pcqY
	 Gy+NSv3DVvQc0VKrMmUh2BrFEhVTnraA8Qb/EgZnkEX6GRjrJPD+Ykn3wSz8axMP0p
	 3tn7kPb+U9E5bmwJWXzD3hQF0SU15w22Va+vdU44aVo1fsd/RLpLuQX5+VRt37mdwf
	 7s3cIGGsC2SjkDwCp14vxePc50XAEKnypCN4xiavy8jj42ZZip/QslNNXSj2YJ+2uX
	 NPtmAxY0s4fdg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel@lists.linux.dev
Cc: Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 2/4] block: Ignore REQ_NOWAIT for zone reset and zone finish operations
Date: Mon,  9 Dec 2024 21:23:55 +0900
Message-ID: <20241209122357.47838-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209122357.47838-1-dlemoal@kernel.org>
References: <20241209122357.47838-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are currently any issuer of REQ_OP_ZONE_RESET and
REQ_OP_ZONE_FINISH operations that set REQ_NOWAIT. However, as we cannot
handle this flag correctly due to the potential request allocation
failure that may happen in blk_mq_submit_bio() after blk_zone_plug_bio()
has handled the zone write plug write pointer updates for the targeted
zones, modify blk_zone_wplug_handle_reset_or_finish() to warn if this
flag is set and ignore it.

Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 7982b9494d63..ee9c67121c6c 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -707,6 +707,15 @@ static bool blk_zone_wplug_handle_reset_or_finish(struct bio *bio,
 		return true;
 	}
 
+	/*
+	 * No-wait reset or finish BIOs do not make much sense as the callers
+	 * issue these as blocking operations in most cases. To avoid issues
+	 * the BIO execution potentially failing with BLK_STS_AGAIN, warn about
+	 * REQ_NOWAIT being set and ignore that flag.
+	 */
+	if (WARN_ON_ONCE(bio->bi_opf & REQ_NOWAIT))
+		bio->bi_opf &= ~REQ_NOWAIT;
+
 	/*
 	 * If we have a zone write plug, set its write pointer offset to 0
 	 * (reset case) or to the zone size (finish case). This will abort all
-- 
2.47.1


