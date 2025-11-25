Return-Path: <linux-block+bounces-31140-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AE0C851E6
	for <lists+linux-block@lfdr.de>; Tue, 25 Nov 2025 14:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1002A3B4A8F
	for <lists+linux-block@lfdr.de>; Tue, 25 Nov 2025 13:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD75D3233F4;
	Tue, 25 Nov 2025 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KinVzFj7"
X-Original-To: linux-block@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72C030E846
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764076064; cv=none; b=pSeRVFWdXPJY47hcmqj4schmyL45lCkH9FmoN057HJRcJ9PhTaA6+60qynuc6f18BMnPu2cNfU1z+yMenxHtFP6BL8FzcnIYdseTHNLwhKiMXpNbqeWAhOr1S42pXg7lZEPXB8wsiZBoX6Y4rWePH6tlcaxWBG6IspNJetMk+Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764076064; c=relaxed/simple;
	bh=lNucIagiVs8zbMpj2yQpuXNMJ2WMk+a9FSuTPa0ORqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I+kr9dlQFUYi8NVCo1Kqyl9QvgMWdkYNORasrWMX5tZLcA4V3MHCJ2dIr5vOgLJ1ldvkPNU6E1RazaNR5RwPQ/N/6Nw8Xpk0HfBBfsbkLY9n9cC6pfCI6jzy00PaLAynsFdw4i5I1BZ6uFlDyi6+s00KNcgf6od9a+ZumZ/PW50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KinVzFj7; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764076059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Itjt2WLrMlsdKqcQ/VCLGhUm5VlKQxuQKaQ8L19Poak=;
	b=KinVzFj7+xY+PVh0Wu5QyvZeA23MuKgTnnqxdyI0wyW2Y5rXre0d8oiZsFNUvMLphG6x8b
	KJdnd9w4FTK5evd8UkMUgct7GKvGfGl4sdiKjVWEzRNS3cW+slqmNd114LuUeTyxX5Bq6e
	p5J0XmZK9dO/j735l6GJ8JUigqptmug=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangfushuai@baidu.com,
	Fushuai Wang <fushuai.wang@linux.dev>
Subject: [PATCH] block: Use size_add() and array_size() for safe memory allocation
Date: Tue, 25 Nov 2025 21:07:04 +0800
Message-Id: <20251125130704.5953-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Dynamic size calculations should not be performed in memory
allocator due to the risk of overflowing. So use size_add()
and array_size(), which have overflow checks, in bio_kmalloc()
for safe size calculation.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 block/bio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c278..c7789469c892 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -617,8 +617,9 @@ struct bio *bio_kmalloc(unsigned short nr_vecs, gfp_t gfp_mask)
 
 	if (nr_vecs > BIO_MAX_INLINE_VECS)
 		return NULL;
-	return kmalloc(sizeof(*bio) + nr_vecs * sizeof(struct bio_vec),
-			gfp_mask);
+	return kmalloc(size_add(sizeof(*bio),
+				array_size(nr_vecs, sizeof(struct bio_vec))),
+		       gfp_mask);
 }
 EXPORT_SYMBOL(bio_kmalloc);
 
-- 
2.36.1


