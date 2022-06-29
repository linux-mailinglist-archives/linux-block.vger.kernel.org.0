Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4BB560D7E
	for <lists+linux-block@lfdr.de>; Thu, 30 Jun 2022 01:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiF2Xd1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Jun 2022 19:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiF2XdU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:33:20 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82925958D
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:09 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id w19-20020a17090a8a1300b001ec79064d8dso1020574pjn.2
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3L+13jbsL2KytYOAIGe5reLvhMdInbYdB1ucfP6bHbc=;
        b=iTB9n6quhTM851spcxopO4cNhsrYrc7AZJjSyxhgF4OrB4I+ipk0HTcqX658kpKVpg
         IKAG6KD1j3VPY8BCrEovDvt2fjU3C9GFao5Vlulc+D5pni9GjFQDdFo7aAGFeD3Y7sAg
         hNR2rkjgI0cdMnnPSuGCDbTfAUJACtAQPLcnD0SA5yPLjPfLF4uLD0GC74v7O6oVuSqa
         rxIqMz5xClxPqrTcJuvrQyoIoxMaU6uabCInfcrjToz5L+xdlwkQqnD3bVgbwzq6m6pB
         uhprlA+mFONB2L7qAMxaQUs0yPk+SvSIIxC6z5w0lax+Tw7MKNv6HBaAqzAKnJS1z8y2
         OVpA==
X-Gm-Message-State: AJIora+j+6uHAQouOtfCjj5AxnkhE+tVsx9JuqyOIx1VR2NHKBSPrN0B
        2O+Wv+XBS1BEIW/ietc5hoE=
X-Google-Smtp-Source: AGRyM1uSGvqRrs0h37xwMGBAYPV39iNO+faSD+HFdws14GeOVrwAqMDBOBqmypvxNf23dnupbYU6/w==
X-Received: by 2002:a17:90a:6809:b0:1ec:c213:56c8 with SMTP id p9-20020a17090a680900b001ecc21356c8mr8365331pjj.82.1656545588653;
        Wed, 29 Jun 2022 16:33:08 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:33:07 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 49/63] fs/mpage: Use the new blk_opf_t type
Date:   Wed, 29 Jun 2022 16:31:31 -0700
Message-Id: <20220629233145.2779494-50-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the new blk_opf_t type for the
combination of a block layer request with block layer request flags.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/mpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 0d25f44f5707..5830705672dd 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -145,7 +145,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	struct block_device *bdev = NULL;
 	int length;
 	int fully_mapped = 1;
-	int op = REQ_OP_READ;
+	blk_opf_t op = REQ_OP_READ;
 	unsigned nblocks;
 	unsigned relative_block;
 	gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
