Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C2849F251
	for <lists+linux-block@lfdr.de>; Fri, 28 Jan 2022 05:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345966AbiA1ESA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 27 Jan 2022 23:18:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236875AbiA1ER7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 23:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643343479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=tQTNouHLD2pqrJUsY0rGuooqQ0qZGduHNcta+zU07XE=;
        b=ihfiXyDRszgTqM/vMjBa+fUrUfekzTmJn30V/35pSu9CJu9SapQ7zLcYhhHWPJ0OkPmO+s
        bsE5QdYFMB7RjGyXJkHdryXhjW4FSxcjFmodWHPeluhHQv05gTUgBaztcWKb8RoxxQgBHH
        Wu+fkJ/S+PrT6cRVlwPN1TcHNa83a+A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-6BIVMDstMYaCcZRfQPhxlA-1; Thu, 27 Jan 2022 23:17:58 -0500
X-MC-Unique: 6BIVMDstMYaCcZRfQPhxlA-1
Received: by mail-qk1-f197.google.com with SMTP id l23-20020a37f517000000b0049b8b31c76cso4008162qkk.4
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 20:17:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tQTNouHLD2pqrJUsY0rGuooqQ0qZGduHNcta+zU07XE=;
        b=l0hGCor+FjbyJPTk263r9XKzRfny/a5KJVBetTN4d1JZ9ZKE8JMCALYyX8ckrLPx/0
         XxkvFUObHbNDQiXB0SfHv3EKpabiuwZl1ZkskOf2JbB+MvLJ45zDIx247yuOFLS/baeT
         Bq0gzwgE4/1j3jRU2tuot+utBiBkajtCaeP+Qr9Go6lEmfbE4UEOmjSajtRNHPz/LjHl
         sv/D2wqocqEXgpJFX2ILfs/1zP6VSIjTCSsvdn6GQVzyVKbfizH7sKODKl+onlvWRpBV
         /89h+bF24oYvotF4skibH24Yzv9RMc5VdePjb9o65Nfze62le5UK03ifG+uoksi2OU3b
         B+bw==
X-Gm-Message-State: AOAM533yHX0S6eFJO4+R9aFK1v93Cu+Dxfe97XUSTjv+PXgBLrkLgwfz
        LMHjvlQ7LdnYM3fDvRezHFY3soCF+89E0sv7RjixPUnvzK7LUvjDYUMXpzMm/sNe1WV2c5musyZ
        jYgQF40+QUCjR7vbk9fF9aA==
X-Received: by 2002:ac8:7d0a:: with SMTP id g10mr4992286qtb.449.1643343477327;
        Thu, 27 Jan 2022 20:17:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzUbkSikg1u7V0kLUzFH1wyiqaoX9jOQQFHcVBPR42iTH4UoZhdUYJg81QtQgJlbjB1W2H6Q==
X-Received: by 2002:ac8:7d0a:: with SMTP id g10mr4992279qtb.449.1643343477149;
        Thu, 27 Jan 2022 20:17:57 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id o19sm2353114qta.40.2022.01.27.20.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 20:17:56 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v3 2/3] dm: revert partial fix for redundant bio-based IO accounting
Date:   Thu, 27 Jan 2022 23:17:52 -0500
Message-Id: <20220128041753.32195-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20220128041753.32195-1-snitzer@redhat.com>
References: <20220128041753.32195-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reverts a1e1cb72d9649 ("dm: fix redundant IO accounting for bios that
need splitting") because it was too narrow in scope (only addressed
redundant 'sectors[]' accounting and not ios, nsecs[], etc).

Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c0ae8087c602..9849114b3c08 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1442,9 +1442,6 @@ static void init_clone_info(struct clone_info *ci, struct mapped_device *md,
 	ci->sector = bio->bi_iter.bi_sector;
 }
 
-#define __dm_part_stat_sub(part, field, subnd)	\
-	(part_stat_get(part, field) -= (subnd))
-
 /*
  * Entry point to split a bio into clones and submit them to the targets.
  */
@@ -1480,18 +1477,6 @@ static void __split_and_process_bio(struct mapped_device *md,
 						  GFP_NOIO, &md->queue->bio_split);
 			ci.io->orig_bio = b;
 
-			/*
-			 * Adjust IO stats for each split, otherwise upon queue
-			 * reentry there will be redundant IO accounting.
-			 * NOTE: this is a stop-gap fix, a proper fix involves
-			 * significant refactoring of DM core's bio splitting
-			 * (by eliminating DM's splitting and just using bio_split)
-			 */
-			part_stat_lock();
-			__dm_part_stat_sub(dm_disk(md)->part0,
-					   sectors[op_stat_group(bio_op(bio))], ci.sector_count);
-			part_stat_unlock();
-
 			bio_chain(b, bio);
 			trace_block_split(b, bio->bi_iter.bi_sector);
 			submit_bio_noacct(bio);
-- 
2.15.0

