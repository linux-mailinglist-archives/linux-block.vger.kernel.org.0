Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0EB6F6180
	for <lists+linux-block@lfdr.de>; Thu,  4 May 2023 00:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjECWwR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 3 May 2023 18:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjECWwP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 18:52:15 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA3144B7
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 15:52:15 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1aafa03f541so41227985ad.0
        for <linux-block@vger.kernel.org>; Wed, 03 May 2023 15:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154334; x=1685746334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Meycj9u3JfaVnzaUnu3BPLSoAESUUt4GW23IhKc0tM8=;
        b=NiHUv9+QxXw1+Z5CbKymHe7Rz+5V0CDdNbu7PnSATImkjQ7p1CxO3ZQVyE5Dve/0to
         S/v3h4bmIwZQjadj61B3NG/zSPXffYXLzJ0ZTBwnIMS48XwFF/76yEwEYbFltHHYgPO5
         xyc1TSOmyP9JU7OTRtM7TVZFypZ8XY7PlbPRm+M6bhvw5irHo+vojd3MSFOmvBWGZZGv
         dmiJaSc9mcoG5L58t8njcxDY5cNl3bYpm9DhoWrRoebJIfRFiBxENrHsJOa9XoxWdSr9
         YtJIQYwX+k+rsHGzfwm5UXvWmRP8+QdD+DsZ3EcDpydWpMz6BzMoS+6wMoxtufbiSYQ6
         2QcQ==
X-Gm-Message-State: AC+VfDwPIddTJHxpO1sWtrfIcHnHRZWG/YjvKIIkwHbNnlj6Ow/eydxk
        eI7SvKXEN/eYTgaBtjEG6yI=
X-Google-Smtp-Source: ACHHUZ4ivY+VwCxliJ2LO6froTtEADOjHG74pqXFOhBzO4Y7SGEYy9J/wdrfLIM09m1JX/hDEHy3Cw==
X-Received: by 2002:a17:902:d512:b0:1aa:fcfa:91da with SMTP id b18-20020a170902d51200b001aafcfa91damr2017153plg.52.1683154334553;
        Wed, 03 May 2023 15:52:14 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2c3b:81e:ce21:2437])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902744300b001aad4be4503sm227085plt.2.2023.05.03.15.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:52:14 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 01/11] block: Simplify blk_req_needs_zone_write_lock()
Date:   Wed,  3 May 2023 15:51:58 -0700
Message-ID: <20230503225208.2439206-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
In-Reply-To: <20230503225208.2439206-1-bvanassche@acm.org>
References: <20230503225208.2439206-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the blk_rq_is_passthrough() check because it is redundant:
blk_req_needs_zone_write_lock() also calls bdev_op_is_zoned_write()
and the latter function returns false for pass-through requests.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index fce9082384d6..835d9e937d4d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -57,9 +57,6 @@ EXPORT_SYMBOL_GPL(blk_zone_cond_str);
  */
 bool blk_req_needs_zone_write_lock(struct request *rq)
 {
-	if (blk_rq_is_passthrough(rq))
-		return false;
-
 	if (!rq->q->disk->seq_zones_wlock)
 		return false;
 
