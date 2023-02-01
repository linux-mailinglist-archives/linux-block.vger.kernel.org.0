Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889AA67915C
	for <lists+linux-block@lfdr.de>; Tue, 24 Jan 2023 07:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjAXG5b (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Jan 2023 01:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjAXG5a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 01:57:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185CC3C2B6;
        Mon, 23 Jan 2023 22:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VWwPZdmK4rNkY5M0ChzWfV9yf3Jd1QwvNFbGSddgKhc=; b=aNFhekhXQgfzMBXDzIPdnTI0qW
        n/brvcYPf/mP8qDPVRqjo277TARKkGvkM+eYjpuPBZvug/Zerxkkr8OXcDodFbOu6NNcSnGqZL03m
        LKEtCMAdMFNaCzp4moe7EpY+tigQcbnhWMJoXs2YLKXNuINy+qWOJu9M8ig9wgCImYRk3j/xPtA3C
        CLNjB1mqV6tHOBtxP+0C1zKSu4c/8/uGP89hjEmZeOgbFhBeuyzS+DLdjMEmimbpcnSybBbC9AVhA
        dzDftU8h8W0cqyW5GsLjIRgdmTqHgUBSvz+Giup3xLIjYXmk51JK3bdvYPl7G+dZKiFZl/6tcXelz
        S6t8yXJw==;
Received: from [2001:4bb8:19a:27af:ea4c:1aa8:8f64:2866] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKDFH-002aQc-Hp; Tue, 24 Jan 2023 06:57:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH 02/15] block: don't call blk_throtl_stat_add for non-READ/WRITE commands
Date:   Tue, 24 Jan 2023 07:57:02 +0100
Message-Id: <20230124065716.152286-3-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230124065716.152286-1-hch@lst.de>
References: <20230124065716.152286-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_throtl_stat_add is called from blk_stat_add explicitly, unlike the
other stats that go through q->stats->callbacks.  To prepare for cgroup
data moving to the gendisk, ensure blk_throtl_stat_add is only called
for the plain READ and WRITE commands that it actually handles internally,
as blk_stat_add can also be called for passthrough commands on queues that
do not have a gendisk associated with them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
---
 block/blk-stat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index 2ea01b5c1aca04..c6ca16abf911e2 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -58,7 +58,8 @@ void blk_stat_add(struct request *rq, u64 now)
 
 	value = (now >= rq->io_start_time_ns) ? now - rq->io_start_time_ns : 0;
 
-	blk_throtl_stat_add(rq, value);
+	if (req_op(rq) == REQ_OP_READ || req_op(rq) == REQ_OP_WRITE)
+		blk_throtl_stat_add(rq, value);
 
 	rcu_read_lock();
 	cpu = get_cpu();
-- 
2.39.0

