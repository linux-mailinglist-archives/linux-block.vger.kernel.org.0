Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB847633DF4
	for <lists+linux-block@lfdr.de>; Tue, 22 Nov 2022 14:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiKVNnX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Nov 2022 08:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbiKVNnT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 08:43:19 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE19A5987A
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 05:43:17 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so15254712wmb.2
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 05:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1O6z3OtGyvGFc8IxR2waGYqFO7J9VHH5n+UUZvrXHw=;
        b=IPQyJQu/JEjhmS86Qo8TbZjSpbF6g1sTxxROaP2IhpxAC6wpyOsuqMWQtZBHKbo7aT
         6leIymPt9zIit3QkqE4vWoo7RsnJwSKacIdkWRQKALP2y3K6zBF3J4HsK4qdMAodPQq1
         gMrVrxjm9kfP8+yC0rOdokLnGjcGm+RidCuGFAWvvZKKCgDMINHdYsQCRYDjYQgpjYeU
         voYcxN6tpasEA0889QrH/+nxE9YvNDxgJoMEt/VBWZNCXeIcnlOjBVP0/lBz26FEN4qG
         onP5PjrlpUXmkF5kVMNQ8C026DhYZEkthK5rbhwh7lBh78wdxDhcWXFXSJaIdUSlrzcl
         IOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1O6z3OtGyvGFc8IxR2waGYqFO7J9VHH5n+UUZvrXHw=;
        b=E06vfAXIM40uE/1mGF1K8w/LPzFPXUpTrlzheBlzkEf3e4E7ad8LI95+583+VZEPKU
         iv0nxvmyVY/pnMJ0B8Y3Uv64iYvRjlA+OVDyyNhLtJSqQZiXR9G3xw0jVnMlPRd9QW/u
         kPIDOz+lV6QtQYqV2dU8hVTuTUudqKc8Mtbzc0rt8txuzUccKFerxrnroQntM8ppbln3
         mmaUKEsck4iEyzIfDtnY7eY4in2yVQ0njUoXQGdq4k4EhQxFb/7r8UGNh17D0rsLZ8uQ
         GKs45sC02rpCqtIHGhaRc1brDKuHNAOK4C7ipRfcqTX1F2fW3pOQME40NL7qV3GJz0BF
         38zw==
X-Gm-Message-State: ANoB5pnYqSAx006/6/2Rkbx/MLMnBVR+tT3iKohFYhrgZDMYtxnS9c+M
        lza71xebhX1rubO/y5bT8mk1Tw==
X-Google-Smtp-Source: AA0mqf613IKVcLXqG2MLW3N/+4vlIQupHr8u3755YC6FGh+KHrNBAi6+v2ZMr79Hl4aiy7jJR5BOKA==
X-Received: by 2002:a05:600c:4fc4:b0:3c6:c109:2d9 with SMTP id o4-20020a05600c4fc400b003c6c10902d9mr6451363wmq.149.1669124596402;
        Tue, 22 Nov 2022 05:43:16 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id p6-20020a1c5446000000b003b47e75b401sm21437729wmi.37.2022.11.22.05.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 05:43:14 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Joel Colledge <joel.colledge@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 3/4] lru_cache: remove unused lc_private, lc_set, lc_index_of
Date:   Tue, 22 Nov 2022 14:43:00 +0100
Message-Id: <20221122134301.69258-4-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122134301.69258-1-christoph.boehmwalder@linbit.com>
References: <20221122134301.69258-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Joel Colledge <joel.colledge@linbit.com>

Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 include/linux/lru_cache.h |  3 ---
 lib/lru_cache.c           | 44 ---------------------------------------
 2 files changed, 47 deletions(-)

diff --git a/include/linux/lru_cache.h b/include/linux/lru_cache.h
index 07add7882a5d..c9afcdd9324c 100644
--- a/include/linux/lru_cache.h
+++ b/include/linux/lru_cache.h
@@ -199,7 +199,6 @@ struct lru_cache {
 	unsigned long flags;
 
 
-	void  *lc_private;
 	const char *name;
 
 	/* nr_elements there */
@@ -241,7 +240,6 @@ extern struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
 		unsigned e_count, size_t e_size, size_t e_off);
 extern void lc_reset(struct lru_cache *lc);
 extern void lc_destroy(struct lru_cache *lc);
-extern void lc_set(struct lru_cache *lc, unsigned int enr, int index);
 extern void lc_del(struct lru_cache *lc, struct lc_element *element);
 
 extern struct lc_element *lc_get_cumulative(struct lru_cache *lc, unsigned int enr);
@@ -297,6 +295,5 @@ extern bool lc_is_used(struct lru_cache *lc, unsigned int enr);
 	container_of(ptr, type, member)
 
 extern struct lc_element *lc_element_by_index(struct lru_cache *lc, unsigned i);
-extern unsigned int lc_index_of(struct lru_cache *lc, struct lc_element *e);
 
 #endif
diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 5dd5e4c00a23..b3d9187611de 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -574,48 +574,6 @@ struct lc_element *lc_element_by_index(struct lru_cache *lc, unsigned i)
 	return lc->lc_element[i];
 }
 
-/**
- * lc_index_of
- * @lc: the lru cache to operate on
- * @e: the element to query for its index position in lc->element
- */
-unsigned int lc_index_of(struct lru_cache *lc, struct lc_element *e)
-{
-	PARANOIA_LC_ELEMENT(lc, e);
-	return e->lc_index;
-}
-
-/**
- * lc_set - associate index with label
- * @lc: the lru cache to operate on
- * @enr: the label to set
- * @index: the element index to associate label with.
- *
- * Used to initialize the active set to some previously recorded state.
- */
-void lc_set(struct lru_cache *lc, unsigned int enr, int index)
-{
-	struct lc_element *e;
-	struct list_head *lh;
-
-	if (index < 0 || index >= lc->nr_elements)
-		return;
-
-	e = lc_element_by_index(lc, index);
-	BUG_ON(e->lc_number != e->lc_new_number);
-	BUG_ON(e->refcnt != 0);
-
-	e->lc_number = e->lc_new_number = enr;
-	hlist_del_init(&e->colision);
-	if (enr == LC_FREE)
-		lh = &lc->free;
-	else {
-		hlist_add_head(&e->colision, lc_hash_slot(lc, enr));
-		lh = &lc->lru;
-	}
-	list_move(&e->list, lh);
-}
-
 /**
  * lc_seq_dump_details - Dump a complete LRU cache to seq in textual form.
  * @lc: the lru cache to operate on
@@ -650,7 +608,6 @@ void lc_seq_dump_details(struct seq_file *seq, struct lru_cache *lc, char *utext
 EXPORT_SYMBOL(lc_create);
 EXPORT_SYMBOL(lc_reset);
 EXPORT_SYMBOL(lc_destroy);
-EXPORT_SYMBOL(lc_set);
 EXPORT_SYMBOL(lc_del);
 EXPORT_SYMBOL(lc_try_get);
 EXPORT_SYMBOL(lc_find);
@@ -658,7 +615,6 @@ EXPORT_SYMBOL(lc_get);
 EXPORT_SYMBOL(lc_put);
 EXPORT_SYMBOL(lc_committed);
 EXPORT_SYMBOL(lc_element_by_index);
-EXPORT_SYMBOL(lc_index_of);
 EXPORT_SYMBOL(lc_seq_printf_stats);
 EXPORT_SYMBOL(lc_seq_dump_details);
 EXPORT_SYMBOL(lc_try_lock);
-- 
2.38.1

