Return-Path: <linux-block+bounces-1016-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEE380EA16
	for <lists+linux-block@lfdr.de>; Tue, 12 Dec 2023 12:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A0FB20E46
	for <lists+linux-block@lfdr.de>; Tue, 12 Dec 2023 11:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FCA5CD1C;
	Tue, 12 Dec 2023 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2RHzZKk"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15E71710;
	Tue, 12 Dec 2023 03:12:34 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d0aaa979f0so31514645ad.0;
        Tue, 12 Dec 2023 03:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702379554; x=1702984354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRWJvmM8+hpVsGJoyvu2YuvVcQVJUfQcuTmMveSE8/s=;
        b=c2RHzZKkum9NRONbaeT4jXwKCCVFHUqe5Q41RMCOVKCoyQRbyeen+mfbfqXb90MhHQ
         OE2pUZnsH3fHowyc8v6LxD3T84t9Uo40t9aqIf2iy++6OtEcwRrmDXNaYtHHqnk08HD6
         DerSRz91i6ZpDKMXHFKGHpvfww4ypTHPZoQiV9AOgWnBsedwaV/JcXk2vEQ3IGfzmrlJ
         NwV0NnylvJM4WIkBLw17bhsouuBuccKW1zFej5wBrs0zxXqqVzdbiKjJSnZ6SjUKi2vW
         +yCJ2mESMchde54tZgnHydGt6bwjCBqkbc8ROScJnOYPji1SK7WDGzwWm4Ex42thBZms
         4PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702379554; x=1702984354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRWJvmM8+hpVsGJoyvu2YuvVcQVJUfQcuTmMveSE8/s=;
        b=hx3/PmBitkBd2/sLg4JodXUIGi3v62m8BMUGJb11XAO11kuVnm2c268A7A2Lc/oZSP
         IeW5day9W7YFVO0jjD+rmSnfNHE4w7UzqfD6xev8pmvFfQjGnf9QomdGd79JcAkNysFE
         XA+ZHujVnF+bxm0wXWeN+5K/L4W59OeiS6EXDAWetr7AXl6OLb+eSNXxbYOOPg2vkIQX
         bsKX7wABiHdYpQEJwmmOYeg0EuFS5QZJKRfQ739qITAl2m4Oz3UrBgl09Gmv81nQ21On
         0voLz6Hooi05IBGgLjgGjaTBnHYHkcTrYNNpXFVLWo9Vbd2msCwGxSrV8XPgbsUazWxF
         A88g==
X-Gm-Message-State: AOJu0Yx/dw4eCAWONhgafgx83OqEv2zKlzqjFdnMte4aA3qgCtN5INVM
	3fFhMLV4L/dJobMEGBON01o=
X-Google-Smtp-Source: AGHT+IFlcy+h/DMb4yTLMEPWYaQdXpLguXXRtdGTaHrTLhSYejeIi4auC/X/p0G23rVz46hOssocww==
X-Received: by 2002:a17:902:780a:b0:1d3:3876:bfe with SMTP id p10-20020a170902780a00b001d338760bfemr169241pll.90.1702379553803;
        Tue, 12 Dec 2023 03:12:33 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b001d0511c990csm8345453plo.237.2023.12.12.03.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 03:12:33 -0800 (PST)
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	axboe@kernel.dk,
	ebiggers@kernel.org
Cc: zhiguo.niu@unisoc.com,
	ke.wang@unisoc.com,
	yibin.ding@unisoc.com,
	hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH v4 5/5] dm-crypt: Fix lost ioprio when queuing write bios
Date: Tue, 12 Dec 2023 19:11:50 +0800
Message-Id: <20231212111150.18155-6-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212111150.18155-1-hongyu.jin.cn@gmail.com>
References: <ZXeJ9jAKEQ31OXLP@redhat.com>
 <20231212111150.18155-1-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Jin <hongyu.jin@unisoc.com>

The original submitting bio->bi_ioprio setting can be retained by
struct dm_crypt_io::base_bio, we set the original bio's ioprio to
the cloned bio for write.

Link: https://lore.kernel.org/dm-devel/alpine.LRH.2.11.1612141049250.13402@mail.ewheeler.net

Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
---
 drivers/md/dm-crypt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 6de107aff331..7149da6555b8 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1683,6 +1683,7 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
 				 GFP_NOIO, &cc->bs);
 	clone->bi_private = io;
 	clone->bi_end_io = crypt_endio;
+	clone->bi_ioprio = io->base_bio->bi_ioprio;
 
 	remaining_size = size;
 
-- 
2.34.1


