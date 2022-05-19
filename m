Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EFF52D0D6
	for <lists+linux-block@lfdr.de>; Thu, 19 May 2022 12:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbiESKws (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 May 2022 06:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbiESKwn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 06:52:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF725AF1C0
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 03:52:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5AE411F86C;
        Thu, 19 May 2022 10:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652957558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hpmc3+ltFkrwjxVrsDq9b68XJYDCoIbRnV55KYes/J0=;
        b=S8GWAp4C59TynWccHd/sCVEJDMyaS3KDeuHoYYOvDDnnBh/+wQcaGD68Q0erU5j21Dz5F9
        9Usbn9/RnN6pSZXI4IH3uEPgQ6cDEAsX8Sv2UziooL4MVlVRuInKKChdlNMZxZqJSEUdGN
        RIV5uPDnvxKs5XkrKCr6/MuKZsZEqSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652957558;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hpmc3+ltFkrwjxVrsDq9b68XJYDCoIbRnV55KYes/J0=;
        b=bbFcJLcfD2UPw19y8MTymlU5HJX7/+TzWJr85Ir13AkFLn1TimQYGSAvUe3LqHww8AmkxG
        rFD2F2MnZ62BVtBA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4E9C92C145;
        Thu, 19 May 2022 10:52:38 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7D980A0632; Thu, 19 May 2022 12:52:35 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/4] bfq: Allow current waker to defend against a tentative one
Date:   Thu, 19 May 2022 12:52:30 +0200
Message-Id: <20220519105235.31397-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220519104621.15456-1-jack@suse.cz>
References: <20220519104621.15456-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097; h=from:subject; bh=3MpNAaGjm1nnlvDF9v3+ueqmLrswHCe4Feive2e0iis=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBihiFtMgd4yOJUG3VqNPgYQbRfgadh1iAwUjYVYyzc 06zjfrSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYoYhbQAKCRCcnaoHP2RA2dd3CA DaVEHx1qvOvcjwznvpv6qBHooTTdiDcjIsAazjOBuab+mGlmNF6JdXIFGAoNxMaRe3od/KGzfJEeA7 /UxxSLQho7RjLh9SMJMLrOViID7vK7Ds3rwtNhhYSbhq9wm0AOV92jx/ED9UrQUhWEMIndNafK2p9F Dis0q0kx+ffORtd8HJaopSuS+1pKU+LF7gV+sh0yxTkThUJmkOe2HgzvXYpP5anjicqHd0bwlI8ZUU qnOQEzDVfMmATaeWLQvXOjqHIPFVarQDS4egxxya4/b+w8VesH0brrHXP7jSO+45LLubHuFl5Mmiu5 duxtcNxgnHFWsx9dBqGtHKAkgiJR25
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The code in bfq_check_waker() ignores wake up events from the current
waker. This makes it more likely we select a new tentative waker
although the current one is generating more wake up events. Treat
current waker the same way as any other process and allow it to reset
the waker detection logic.

Fixes: 71217df39dc6 ("block, bfq: make waker-queue detection more robust")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 397f6be3c8fe..1cc242c90fb6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2127,8 +2127,7 @@ static void bfq_check_waker(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	if (!bfqd->last_completed_rq_bfqq ||
 	    bfqd->last_completed_rq_bfqq == bfqq ||
 	    bfq_bfqq_has_short_ttime(bfqq) ||
-	    now_ns - bfqd->last_completion >= 4 * NSEC_PER_MSEC ||
-	    bfqd->last_completed_rq_bfqq == bfqq->waker_bfqq)
+	    now_ns - bfqd->last_completion >= 4 * NSEC_PER_MSEC)
 		return;
 
 	/*
-- 
2.35.3

