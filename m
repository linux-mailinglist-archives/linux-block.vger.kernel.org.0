Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59313201E75
	for <lists+linux-block@lfdr.de>; Sat, 20 Jun 2020 01:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbgFSXDF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 19 Jun 2020 19:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729996AbgFSXDF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 19:03:05 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D378922403;
        Fri, 19 Jun 2020 23:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592607785;
        bh=cdYHEQGb0tbwPgvd2pSEGoqkzQY6K9R5bsBpdMaNIo4=;
        h=Date:From:To:Cc:Subject:From;
        b=CEGiLtkFlaDdzvrRc56GKEv39hmbXW/QU/MwrqMvM1CfQL/NAuGNA12sNXwJhv6MA
         z08fRif5tEl8fcUgodCC3HSph9zcFlifWAaCTmdNkBO8AWwnrOcmiU4Ot3Sxz0/aDd
         tyoIJp1hklHh/iaXuZRuqPTuCychYNerCpl8mcx8=
Date:   Fri, 19 Jun 2020 18:08:30 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] blk-iocost: Use struct_size() in kzalloc_node()
Message-ID: <20200619230830.GA25608@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 block/blk-iocost.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 8ac4aad66ebc..cea5ee9be639 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2045,8 +2045,7 @@ static struct blkg_policy_data *ioc_pd_alloc(gfp_t gfp, struct request_queue *q,
 	int levels = blkcg->css.cgroup->level + 1;
 	struct ioc_gq *iocg;
 
-	iocg = kzalloc_node(sizeof(*iocg) + levels * sizeof(iocg->ancestors[0]),
-			    gfp, q->node);
+	iocg = kzalloc_node(struct_size(iocg, ancestors, levels), gfp, q->node);
 	if (!iocg)
 		return NULL;
 
-- 
2.27.0

