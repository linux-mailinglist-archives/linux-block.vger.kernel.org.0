Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE796A2D9D
	for <lists+linux-block@lfdr.de>; Sun, 26 Feb 2023 04:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjBZDoU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 25 Feb 2023 22:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjBZDoA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Feb 2023 22:44:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D6DE047;
        Sat, 25 Feb 2023 19:43:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6695360C03;
        Sun, 26 Feb 2023 03:43:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF120C433D2;
        Sun, 26 Feb 2023 03:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677382996;
        bh=y/Ex1sxIzzWjeXoa6IJWdQKmOciITNkCMP2aYr8j90s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XzbZ87oVng9QpgYNS9or6abErJKDqqwStTlaM0WeboYi+sCeuKTv11jvCoF2GZ/07
         CnzYuJ422rFTe/Jp86omZ13rz+QTiD/KSNP104eFnaLtxXo47vunuwiRAnjVUJXTY4
         xxwa7+Ddbdf/24zJ42j0rzaquUKNPOvtmzEwB4A8aYi+RmGrJ/CupJNwoKfTufnkej
         htO8bNc5X2L54E0/8G4El0qJX1QRiWV5iNHZV397T/jnLyzI1OhuEYi22Q7omUvLMW
         kXyU7fmqzNPq7gfUOGAnCXNI/SGB93IK0GP8IJ9dQCkysAorJPCUB/rr3ultxshrUS
         tIOQTRbZ6JbDQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 11/21] trace/blktrace: fix memory leak with using debugfs_lookup()
Date:   Sat, 25 Feb 2023 22:42:46 -0500
Message-Id: <20230226034256.771769-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230226034256.771769-1-sashal@kernel.org>
References: <20230226034256.771769-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 83e8864fee26f63a7435e941b7c36a20fd6fe93e ]

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  To make things simpler, just
call debugfs_lookup_and_remove() instead which handles all of the logic
at once.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20230202141956.2299521-1-gregkh@linuxfoundation.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/blktrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index a66cff5a18579..a5b35bcfb0602 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -320,8 +320,8 @@ static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
 	 * under 'q->debugfs_dir', thus lookup and remove them.
 	 */
 	if (!bt->dir) {
-		debugfs_remove(debugfs_lookup("dropped", q->debugfs_dir));
-		debugfs_remove(debugfs_lookup("msg", q->debugfs_dir));
+		debugfs_lookup_and_remove("dropped", q->debugfs_dir);
+		debugfs_lookup_and_remove("msg", q->debugfs_dir);
 	} else {
 		debugfs_remove(bt->dir);
 	}
-- 
2.39.0

