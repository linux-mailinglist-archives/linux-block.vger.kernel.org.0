Return-Path: <linux-block+bounces-4927-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE8E887DCE
	for <lists+linux-block@lfdr.de>; Sun, 24 Mar 2024 18:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26551F212C4
	for <lists+linux-block@lfdr.de>; Sun, 24 Mar 2024 17:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741873DBB2;
	Sun, 24 Mar 2024 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjBsOlJR"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DE13D994;
	Sun, 24 Mar 2024 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711299996; cv=none; b=DJYqTfgLXv/xLkqiiFJv68m88TyNG+sf9zuLygK5YQ2NokMLqstBlY+YgUyAYyqxJ27WUWsC6DVHXerGAnG5kUbDQQZsSfSdXWyyaQNuLmIConnCIE0BD9qVu3+s9TANv085zDLhfbQwIDetOefP4dxdf4PR73xBkGMxEb2cYcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711299996; c=relaxed/simple;
	bh=0pqNxaLcbkQ7KCRmakADyDfAYk41/fLh/4lRyyT542Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIHOxpY+ZN7VdHf+gj6oivMwuMNwMVrLIFu/Rp5pM0GAVf7rCCuyjEnRXqvZd9RXTiifO/wV9gMKdh1mnZj/RGKdbjRtq8Z69/MpJrCA4uTYvrGrpHcXrSMq4DH/vC/yhhH4Y3rE6sP8T6kaA3wKef1uKvhJV6391Ud2/Cf9/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjBsOlJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F1CC433C7;
	Sun, 24 Mar 2024 17:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711299995;
	bh=0pqNxaLcbkQ7KCRmakADyDfAYk41/fLh/4lRyyT542Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CjBsOlJRYfBMHUSHcv77q4BZwnu5EaJFmBGhYx0NY/yJxZlIGLXKYA80GY+MiHyU/
	 xBEO//A5sqExOSqMMGpSaxjrmbHzDCR8ZpMmBdWqg4XEZFI1Oa/mMUPwj24vV4CcUY
	 DPFmZq7HPrNw/Cm7IboZHjmGvQF1y0X/XwsRJJYFf8KOimGSIYgcCr7u8xZL1Iciw/
	 EoEKS7S6+cv5BM+msVwXQhRAN5QOHSiyunNU1uEmytt769uYG9+zATBV3+VBw+2WzR
	 BlB+c+omEO4vXxIxmdWfncRQ/f3D8jMskGvftzQFKztY/TfN98GQVT8LcjULqhTmaE
	 lJFvDwuTWUk1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 08/11] block: prevent division by zero in blk_rq_stat_sum()
Date: Sun, 24 Mar 2024 13:06:11 -0400
Message-ID: <20240324170619.545975-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170619.545975-1-sashal@kernel.org>
References: <20240324170619.545975-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.10
Content-Transfer-Encoding: 8bit

From: Roman Smirnov <r.smirnov@omp.ru>

[ Upstream commit 93f52fbeaf4b676b21acfe42a5152620e6770d02 ]

The expression dst->nr_samples + src->nr_samples may
have zero value on overflow. It is necessary to add
a check to avoid division by zero.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/20240305134509.23108-1-r.smirnov@omp.ru
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index 7ff76ae6c76a9..e42c263e53fb9 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -27,7 +27,7 @@ void blk_rq_stat_init(struct blk_rq_stat *stat)
 /* src is a per-cpu stat, mean isn't initialized */
 void blk_rq_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 {
-	if (!src->nr_samples)
+	if (dst->nr_samples + src->nr_samples <= dst->nr_samples)
 		return;
 
 	dst->min = min(dst->min, src->min);
-- 
2.43.0


