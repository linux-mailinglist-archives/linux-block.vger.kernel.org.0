Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F3C233CF4
	for <lists+linux-block@lfdr.de>; Fri, 31 Jul 2020 03:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbgGaBmz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 30 Jul 2020 21:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbgGaBmy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 21:42:54 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1561C061575;
        Thu, 30 Jul 2020 18:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ht9aEgGtbxzNRbhRSDyB2yjNtp9N/RM12jUwfQdOb9c=; b=bT2D0h0Ndi1xiOu+RIzvkuZITM
        MxUP8MM4dE4cSuhek6AMg1fMWlOA7Zfru9ccnvdyzih+Uci4RHdG28j8nD6lkZ2fkdIJdQkv2IIfN
        fN0FO0yKZp68I02/ad9+KI8bCN4NYzJSE46PLkpUnO8yGXSb4u2zuItBMQLN/DqAvCPPxScZ+ErGu
        4lbXfOYybzfH+VDfQ2pAVCbMlnLMe71PpxkK9Fs2GgiYBWRFs1Uv8yrolsq1Mft/rhu+rjyVPGfFA
        hwhedfzyGuAxBI94JKkTt1uvZn6Zc1mCCuccSioY76OT45aX3Vs5UqazHiAdGhv+dEZLedqWGdO24
        ho0VJ1Zg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1K4R-0006bc-8b; Fri, 31 Jul 2020 01:42:51 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH 6/7] block: blk-mq-sched: delete duplicated word
Date:   Thu, 30 Jul 2020 18:42:32 -0700
Message-Id: <20200731014233.6418-7-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200731014233.6418-1-rdunlap@infradead.org>
References: <20200731014233.6418-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drop the repeated word "to".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 block/blk-mq-sched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200730.orig/block/blk-mq-sched.c
+++ linux-next-20200730/block/blk-mq-sched.c
@@ -225,7 +225,7 @@ static struct blk_mq_ctx *blk_mq_next_ct
  * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
  *
  * Returns -EAGAIN if hctx->dispatch was found non-empty and run_work has to
- * to be run again.  This is necessary to avoid starving flushes.
+ * be run again.  This is necessary to avoid starving flushes.
  */
 static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 {
