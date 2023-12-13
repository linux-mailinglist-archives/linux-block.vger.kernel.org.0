Return-Path: <linux-block+bounces-987-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8F080E1C5
	for <lists+linux-block@lfdr.de>; Tue, 12 Dec 2023 03:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D1828278A
	for <lists+linux-block@lfdr.de>; Tue, 12 Dec 2023 02:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01869156C5;
	Tue, 12 Dec 2023 02:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOu2oZ9P"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB46D5;
	Mon, 11 Dec 2023 18:27:59 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6d9e993d94dso2881092a34.0;
        Mon, 11 Dec 2023 18:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348078; x=1702952878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuotiINhbKGxGGef8K7G7yCOze6MU0SeJK9/E0VqPZk=;
        b=mOu2oZ9PdmyEQBvwYpbB4CxFhLPixosCG/9dqh1Cc/zIR24Fy9cxxE1bnhoq1S4HSH
         2vlmhvyBtQA6tn2USXss6mEQeM9wt3l7Id3Tbu6029uRdoR/RA2glANWTWs/YjBv1Hrf
         RO/Bq3AuywwoN+LCLd+t/kP5HmkKKJGtbX3R58KaCqjuMoNFp/yw9rDdjSIIHkKMPiFJ
         ejqmZaLjmHXR4jE3vqghgoNj8WYXML9w9KOYHNlI/6E8PzshNsPZ6oKg7RLlSFj0GSaE
         4DFw8w8uzqma1JnB04lU5hqrxYCQFneSE1bTt7mVJi7m4RNINMm7qpk/IDGJxwD7hexQ
         o9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348078; x=1702952878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuotiINhbKGxGGef8K7G7yCOze6MU0SeJK9/E0VqPZk=;
        b=hNOl2H/obmBkuHof2JdmjYHXOu7+BQ9EvpAl/06W62xhN8MKny6AmKD7YGffI7etC1
         lpnA5K9w6xOx5pFZQ4V2x8SXsVHz4AnUc1PqpGqXBAMHqsNjZeWdAakpsccUVFS6qetv
         QGZx0/w6+ZecW/OIU6oI9D8/rcx0DcqVsHuAfpg9LvHKbMxH2YhPTy6IolGN9wvyl2IN
         zmwvaySq4eUxSEl6Qlo9AYisCF5BLRvQeAr9QbqK+QbmMmgJb67/gpBgIF/Z/5/Pr31q
         lvR80DxVqOpy3nmrfOHDNZfxyIRpBrl6ovmdsXd/5sw8S7C1ssA5dyI9Vn4BfrNo3Viy
         ZdIg==
X-Gm-Message-State: AOJu0YyMGJIhoR/j94c6UT2TGKIBe06djo4hGnT1j80nujKkkwCefYEV
	RRJemezSlojt0l0VbYAGfpuu5zgrB038Dw==
X-Google-Smtp-Source: AGHT+IEHnCevx/zjXgMWzqImSiSNPCTlhUeZk/gNmGSenVJT/HCL0VqZAYmviFs6i1xsO2WZY35Fqw==
X-Received: by 2002:a05:6830:16d9:b0:6d8:74e2:6f48 with SMTP id l25-20020a05683016d900b006d874e26f48mr4356891otr.68.1702348078162;
        Mon, 11 Dec 2023 18:27:58 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id q1-20020a0de701000000b005cb1bf4d466sm3464287ywe.82.2023.12.11.18.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:27:57 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 03/35] lib/sbitmap; optimize __sbitmap_get_word() by using find_and_set_bit()
Date: Mon, 11 Dec 2023 18:27:17 -0800
Message-Id: <20231212022749.625238-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__sbitmap_get_word() opencodes either find_and_set_bit_wrap(), or
find_and_set_next_bit() depending on wrap parameter. Simplify it by using
atomic find_bit() API.

While here, simplify sbitmap_find_bit_in_word(), which calls it.

CC: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 lib/sbitmap.c | 46 +++++++++-------------------------------------
 1 file changed, 9 insertions(+), 37 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index d0a5081dfd12..8ecd830ba9e8 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -133,38 +133,13 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
 }
 EXPORT_SYMBOL_GPL(sbitmap_resize);
 
-static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
+static inline int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 			      unsigned int hint, bool wrap)
 {
-	int nr;
-
-	/* don't wrap if starting from 0 */
-	wrap = wrap && hint;
-
-	while (1) {
-		nr = find_next_zero_bit(word, depth, hint);
-		if (unlikely(nr >= depth)) {
-			/*
-			 * We started with an offset, and we didn't reset the
-			 * offset to 0 in a failure case, so start from 0 to
-			 * exhaust the map.
-			 */
-			if (hint && wrap) {
-				hint = 0;
-				continue;
-			}
-			return -1;
-		}
+	if (wrap)
+		return find_and_set_bit_wrap_lock(word, depth, hint);
 
-		if (!test_and_set_bit_lock(nr, word))
-			break;
-
-		hint = nr + 1;
-		if (hint >= depth - 1)
-			hint = 0;
-	}
-
-	return nr;
+	return find_and_set_next_bit_lock(word, depth, hint);
 }
 
 static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
@@ -175,15 +150,12 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
 	int nr;
 
 	do {
-		nr = __sbitmap_get_word(&map->word, depth,
-					alloc_hint, wrap);
-		if (nr != -1)
-			break;
-		if (!sbitmap_deferred_clear(map))
-			break;
-	} while (1);
+		nr = __sbitmap_get_word(&map->word, depth, alloc_hint, wrap);
+		if (nr < depth)
+			return nr;
+	} while (sbitmap_deferred_clear(map));
 
-	return nr;
+	return -1;
 }
 
 static int sbitmap_find_bit(struct sbitmap *sb,
-- 
2.40.1


