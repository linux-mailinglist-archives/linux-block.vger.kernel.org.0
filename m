Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE352F4BFD
	for <lists+linux-block@lfdr.de>; Wed, 13 Jan 2021 14:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbhAMNF6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 Jan 2021 08:05:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:48868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbhAMNF6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 08:05:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A3A1ACC6;
        Wed, 13 Jan 2021 13:05:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D25921E0872; Wed, 13 Jan 2021 14:05:16 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] bfq: Remove stale comment
Date:   Wed, 13 Jan 2021 14:05:15 +0100
Message-Id: <20210113130515.16017-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove comment paragraph that was made stale by a fix of shallow depth
computation.

Fixes: 6d4d27358837 ("bfq: Fix computation of shallow depth")
Reported-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9e4eb0fc1c16..149ab498f516 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6324,12 +6324,6 @@ static unsigned int bfq_update_depths(struct bfq_data *bfqd,
 	/*
 	 * In-word depths if no bfq_queue is being weight-raised:
 	 * leaving 25% of tags only for sync reads.
-	 *
-	 * In next formulas, right-shift the value
-	 * (1U<<bt->sb.shift), instead of computing directly
-	 * (1U<<(bt->sb.shift - something)), to be robust against
-	 * any possible value of bt->sb.shift, without having to
-	 * limit 'something'.
 	 */
 	/* no more than 50% of tags for async I/O */
 	bfqd->word_depths[0][0] = max(bt->sb.depth >> 1, 1U);
-- 
2.26.2

