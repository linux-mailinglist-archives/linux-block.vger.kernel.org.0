Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54AB475D70
	for <lists+linux-block@lfdr.de>; Wed, 15 Dec 2021 17:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244815AbhLOQaO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Dec 2021 11:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244821AbhLOQaO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Dec 2021 11:30:14 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1508C061574
        for <linux-block@vger.kernel.org>; Wed, 15 Dec 2021 08:30:13 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id x6so30857987iol.13
        for <linux-block@vger.kernel.org>; Wed, 15 Dec 2021 08:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3EhyZ30nQFeKraMAxV9eYGygtfaD2lNomjgGVObfnqo=;
        b=i1Rievg6JWKC/XjQucj2spa/b4JmJfps1+Q+3ILsR7qU7AGYqySbH9npuPjw3rQFe8
         RmJuZwZvosMMYwQeHraYsbJ7zGzpToSmPsvnVSu7cpkmoDUt5YRCzvtnmGg9W7uRrvd5
         2ije8/BAvqD7Ehtsd2rPWpZteDnlFsgm1cn0Un3OhukgbCnFU+xaxHMxVNq7YxJSJ2BD
         Tu/j/ifw+SqTPC815zZQU3d9abtkYeAniiOUUPVcTqs+VfYcz6i+tR+v2XInKGA85Yfz
         h7r4zPGUd9eXkV010TRC5sil2HRSdH2XoEkZoMT/kvssCOzA+lC1T+ms78lj0lOx2WJs
         xsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3EhyZ30nQFeKraMAxV9eYGygtfaD2lNomjgGVObfnqo=;
        b=Pyzwo6MFCqEmCjbTi7sFPzhiegar7eB24J2BAoUcE4HgreFRyJYOp5tU4P4qgVgLkE
         tqVLRfBRI845JwMQbKxiO0MySyWibAk++mbjsfu230R5/bnoWnZEmmSeUaim4BK3NC2r
         c3dCya+XvZpIGiT+NWkWG2PzzdeJru6YjrRmccJXVnbr0lgVr8ouM3E3VXhb6DFroyqV
         oNtlfUZe3OIegjop2ntQuG1UhzAKdq4A04wa6N6lXEixWa1XOeA79t+WqTahlBwlaFDB
         a0LntLgIWRSLx79LGffwWj6JJnHPaOIy2ZJf4VeaU/AO20F+Ufhmfcorh/46mdHEU/BN
         J8NQ==
X-Gm-Message-State: AOAM533zFikDFF4RYKTCfj1DYUH7kfHJFTH+lTkQSAsMpujZf+DIhpxV
        dnCSmfBIpRBTe635V4Rc76j/TZpbsM+Vcg==
X-Google-Smtp-Source: ABdhPJx6SLR+dfLopaZsnwX17G5Pf4gk6MZ5Jpuo95ukiTN4MAqDiTeYKZA7t07zW6NYRE91YZbNLg==
X-Received: by 2002:a05:6602:2dd0:: with SMTP id l16mr7101823iow.198.1639585813187;
        Wed, 15 Dec 2021 08:30:13 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d12sm1338528ilg.85.2021.12.15.08.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:30:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] block: use singly linked list for bio cache
Date:   Wed, 15 Dec 2021 09:30:08 -0700
Message-Id: <20211215163009.15269-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211215163009.15269-1-axboe@kernel.dk>
References: <20211215163009.15269-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pointless to maintain a head/tail for the list, as we never need to
access the tail. Entries are always LIFO for cache hotness reasons.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index d9d8e1143edc..a76a3134625a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -26,7 +26,7 @@
 #include "blk-rq-qos.h"
 
 struct bio_alloc_cache {
-	struct bio_list		free_list;
+	struct bio		*free_list;
 	unsigned int		nr;
 };
 
@@ -630,7 +630,9 @@ static void bio_alloc_cache_prune(struct bio_alloc_cache *cache,
 	unsigned int i = 0;
 	struct bio *bio;
 
-	while ((bio = bio_list_pop(&cache->free_list)) != NULL) {
+	while (cache->free_list) {
+		bio = cache->free_list;
+		cache->free_list = bio->bi_next;
 		cache->nr--;
 		bio_free(bio);
 		if (++i == nr)
@@ -689,7 +691,8 @@ void bio_put(struct bio *bio)
 
 		bio_uninit(bio);
 		cache = per_cpu_ptr(bio->bi_pool->cache, get_cpu());
-		bio_list_add_head(&cache->free_list, bio);
+		bio->bi_next = cache->free_list;
+		cache->free_list = bio;
 		if (++cache->nr > ALLOC_CACHE_MAX + ALLOC_CACHE_SLACK)
 			bio_alloc_cache_prune(cache, ALLOC_CACHE_SLACK);
 		put_cpu();
@@ -1700,8 +1703,9 @@ struct bio *bio_alloc_kiocb(struct kiocb *kiocb, unsigned short nr_vecs,
 		return bio_alloc_bioset(GFP_KERNEL, nr_vecs, bs);
 
 	cache = per_cpu_ptr(bs->cache, get_cpu());
-	bio = bio_list_pop(&cache->free_list);
-	if (bio) {
+	if (cache->free_list) {
+		bio = cache->free_list;
+		cache->free_list = bio->bi_next;
 		cache->nr--;
 		put_cpu();
 		bio_init(bio, nr_vecs ? bio->bi_inline_vecs : NULL, nr_vecs);
-- 
2.34.1

