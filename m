Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D64355CB6
	for <lists+linux-block@lfdr.de>; Tue,  6 Apr 2021 22:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244917AbhDFUIf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Apr 2021 16:08:35 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:36386 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbhDFUIf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 16:08:35 -0400
Received: by mail-pj1-f50.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so2203pjh.1
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 13:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dmXyWy80JJ/AectGUWJVKrNbLGOjISg4v/YDuUJFBGQ=;
        b=ng9ZOjnZcD1g8A/gQGXoQWyuNP4NLi3IgovjXZTsDd+L2n3PUK35pai+sGMaznWRN8
         r5PRkpvodl+1n/4XQRTRSfLDtzvoST7RTHpCK4ahAlmLP7coZRod51cMX7xiaMjGfTxs
         ro/EXMg+ZvPmehehYZyJ5TVe/Ed3p8Xhr57/s0xQm2rnE6Pv3726EPnUFIti9OpOyYVx
         vKARFHmyA+HUiD4eBkxPgY7W45jDyQVLJPpCH0IpJ1+PRCMLJyKovL/WImZw2LxNpHtS
         NcF/jbHZB3+ukSUxquTFi548xH4R5mhTgD9GULSEAkKVbqFDGupDTi2D5Kpa6gS5BbaG
         xuDw==
X-Gm-Message-State: AOAM531Z1nFNPfKTBx1TU99iEOiQ1pb65zSXg5IoeJBMXkl15ANohqUE
        hLbXoRbFnaJ9phGzqCMidKQ=
X-Google-Smtp-Source: ABdhPJx5B53KSuPAUUeenOvGtunlvKYpzNHnxo3Krp4DQzO4G6Nd+b6cL2nV8UfwfE8O62kaxUB8bA==
X-Received: by 2002:a17:902:a716:b029:e8:ba45:ea0f with SMTP id w22-20020a170902a716b02900e8ba45ea0fmr21244695plq.63.1617739706724;
        Tue, 06 Apr 2021 13:08:26 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:277d:764e:de23:a2e8])
        by smtp.gmail.com with ESMTPSA id j3sm17722364pfc.49.2021.04.06.13.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 13:08:26 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH] blk-zoned: Remove the definition of blk_zone_start()
Date:   Tue,  6 Apr 2021 13:08:20 -0700
Message-Id: <20210406200820.15180-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit e76239a3748c ("block: add a report_zones method") removed the last
blk_zone_start() call. Hence also remove the definition of this function.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index c0276b42d9fb..250cb76ee615 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -52,14 +52,6 @@ const char *blk_zone_cond_str(enum blk_zone_cond zone_cond)
 }
 EXPORT_SYMBOL_GPL(blk_zone_cond_str);
 
-static inline sector_t blk_zone_start(struct request_queue *q,
-				      sector_t sector)
-{
-	sector_t zone_mask = blk_queue_zone_sectors(q) - 1;
-
-	return sector & ~zone_mask;
-}
-
 /*
  * Return true if a request is a write requests that needs zone write locking.
  */
