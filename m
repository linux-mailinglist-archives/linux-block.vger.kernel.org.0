Return-Path: <linux-block+bounces-1071-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99C0810EB6
	for <lists+linux-block@lfdr.de>; Wed, 13 Dec 2023 11:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C4FBB20C8F
	for <lists+linux-block@lfdr.de>; Wed, 13 Dec 2023 10:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A678C22EEC;
	Wed, 13 Dec 2023 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9LcHToZ"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDBC194;
	Wed, 13 Dec 2023 02:43:00 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7b6f4330598so285262939f.1;
        Wed, 13 Dec 2023 02:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702464179; x=1703068979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRWJvmM8+hpVsGJoyvu2YuvVcQVJUfQcuTmMveSE8/s=;
        b=B9LcHToZ8Ua6JRQQuibqAqPFiUbCOyyoQYmttAMOf7T1DIqXlPfCjykPjuSLgetx9+
         XwHPGn6wjiBOZ3WK5Xxq6JS9APyZ7S/3v2gS31aBNVtNWLr+AKBH33rEmFaaMCnM3VBM
         0PU8gW92QEA3kazMGpcY9jMrPHpIxa9+8Pg3AOvCPa5qRqBTN9t5MyMihek/lwWEiNd0
         IJ1oGJC/X4yVmFqBQFvZHNwPOos8o3AQsiYKPSVAofSzHBZsoc3EOE4O7egkEfeywN3R
         wq/Cl8PMCQsVWDXaHBPCWzfjBeNCO4byiQk8w1zW1pQod7cvrq1bIGmrjbdnWEJH2CMh
         mbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702464179; x=1703068979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRWJvmM8+hpVsGJoyvu2YuvVcQVJUfQcuTmMveSE8/s=;
        b=RKnG/I6gndXdTtGpIn+1/wbhEG+/B/7SbGZUH6q4PJ9JSPIFLlsuFSflaXQ/c6NZOL
         wt2XCrQem8+cOEjqJP6UJOZts25oDvrxTBqfqAmJJnEkJp0SxYEDdIEzn3K4NUtsh0w2
         Ab4z0QJYAbosU7jof1ap8WPXyL9nqSCublNe7mTGdByBO5DB/K4zzU6HkAe/tgfytFvW
         zXSjZkVhxgnpTsSe2y8+EMb+XLhJuuSi05pNH/2Rm32EDROkGthaHlfJ1ihXSSyuIKdD
         eyI1q1TqEhsvC0BZtbNbzYd6vz0Q2T7JYZHXPFS2890MXdgUot2mOybyMCsbNZ5UswXA
         dz8w==
X-Gm-Message-State: AOJu0YxYD4ykxvSSUATzrw/v9dJqKKe+JYe1zD9n4O5Yv4ct+DJ4V5fX
	h51UKw25DxJir3QfG2PFW0I=
X-Google-Smtp-Source: AGHT+IFqnQH5xHRTW7lkDH3nUXotSoQk9CUeHU1CHahsXGxY0QsPY5pXBPOQ53OTwye2jv3CgtPipw==
X-Received: by 2002:a5e:c742:0:b0:7b7:1717:693f with SMTP id g2-20020a5ec742000000b007b71717693fmr8044235iop.10.1702464179355;
        Wed, 13 Dec 2023 02:42:59 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id c11-20020a6b4e0b000000b0078647b08ab0sm3058186iob.6.2023.12.13.02.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:42:59 -0800 (PST)
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
Subject: [PATCH v5 5/5] dm-crypt: Fix lost ioprio when queuing write bios
Date: Wed, 13 Dec 2023 18:42:16 +0800
Message-Id: <20231213104216.27845-6-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213104216.27845-1-hongyu.jin.cn@gmail.com>
References: <CAMQnb4MQUJ0VnA5XO-enrXTJvHbo6FJCVPGszGaq-R34hfbeeg@mail.gmail.com>
 <20231213104216.27845-1-hongyu.jin.cn@gmail.com>
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


