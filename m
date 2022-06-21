Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11DD553CB2
	for <lists+linux-block@lfdr.de>; Tue, 21 Jun 2022 23:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355555AbiFUVAs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Jun 2022 17:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355162AbiFUU5M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 16:57:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C01531DE9;
        Tue, 21 Jun 2022 13:50:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4799618B9;
        Tue, 21 Jun 2022 20:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95064C385A9;
        Tue, 21 Jun 2022 20:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655844638;
        bh=lfy/DZCrv24kyMVUIOeDOcUGM+Acl7i43DdckyjHqYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MvU5mJSzO3RklVy2g2593FiBhqnOLjEBNmYlrOwf9/lZabkHEV1KRbB4dx5yvDtH1
         Mvpp6dNYCDwgtoXcm07Tr9H+NHpr7J1/N2fl7Ipt711uUeR6jHCssUYXSkrNhiLtvv
         J+NZQstuW85vzc2PZCHxxlOH9PSb9eUTWciiRc9phrPfaCNm9FFIUalxR3Tdsq3VtX
         LQKuuwlb7k/LXiPQelTiV1a+bqcXXJ8Be4320zfAt1Wqzvc5YLWYEL6URrXIxiU3nM
         /SjjWNSJ6I+4whOIUrq4L81PUbd5eAl34Psw5FQrHRcOUsBs10l/WUAsZu6AgyquHf
         dEY9FaaCUm2VQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Yu Kuai <yukuai3@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.17 18/20] blk-mq: don't clear flush_rq from tags->rqs[]
Date:   Tue, 21 Jun 2022 16:50:08 -0400
Message-Id: <20220621205010.250185-18-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621205010.250185-1-sashal@kernel.org>
References: <20220621205010.250185-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 6cfeadbff3f8905f2854735ebb88e581402c16c4 ]

commit 364b61818f65 ("blk-mq: clearing flush request reference in
tags->rqs[]") is added to clear the to-be-free flush request from
tags->rqs[] for avoiding use-after-free on the flush rq.

Yu Kuai reported that blk_mq_clear_flush_rq_mapping() slows down boot time
by ~8s because running scsi probe which may create and remove lots of
unpresent LUNs on megaraid-sas which uses BLK_MQ_F_TAG_HCTX_SHARED and
each request queue has lots of hw queues.

Improve the situation by not running blk_mq_clear_flush_rq_mapping if
disk isn't added when there can't be any flush request issued.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reported-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20220616014401.817001-4-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8f77023c0f39..047d8b44878f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3413,8 +3413,9 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 	if (blk_mq_hw_queue_mapped(hctx))
 		blk_mq_tag_idle(hctx);
 
-	blk_mq_clear_flush_rq_mapping(set->tags[hctx_idx],
-			set->queue_depth, flush_rq);
+	if (blk_queue_init_done(q))
+		blk_mq_clear_flush_rq_mapping(set->tags[hctx_idx],
+				set->queue_depth, flush_rq);
 	if (set->ops->exit_request)
 		set->ops->exit_request(set, flush_rq, hctx_idx);
 
-- 
2.35.1

