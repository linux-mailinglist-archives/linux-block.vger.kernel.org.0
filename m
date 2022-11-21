Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9768B631AD6
	for <lists+linux-block@lfdr.de>; Mon, 21 Nov 2022 08:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKUH7C (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 21 Nov 2022 02:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKUH7B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 02:59:01 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2A9D65
        for <linux-block@vger.kernel.org>; Sun, 20 Nov 2022 23:59:00 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F8D768AA6; Mon, 21 Nov 2022 08:58:57 +0100 (CET)
Date:   Mon, 21 Nov 2022 08:58:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kch@nvidia.com" <kch@nvidia.com>
Subject: Re: [PATCH 2/2] blk-mq: simplify blk_mq_realloc_tag_set_tags
Message-ID: <20221121075857.GA24878@lst.de>
References: <20221109100811.2413423-1-hch@lst.de> <20221109100811.2413423-2-hch@lst.de> <20221118140640.featvt3fxktfquwh@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118140640.featvt3fxktfquwh@shindev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The fix looks good, but could be simplified a bit more:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ee16b4c34c6a5..cdd8efcec1916 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4381,7 +4381,7 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 	struct blk_mq_tags **new_tags;
 
 	if (set->nr_hw_queues >= new_nr_hw_queues)
-		return 0;
+		goto done;
 
 	new_tags = kcalloc_node(new_nr_hw_queues, sizeof(struct blk_mq_tags *),
 				GFP_KERNEL, set->numa_node);
@@ -4393,8 +4393,8 @@ static int blk_mq_realloc_tag_set_tags(struct blk_mq_tag_set *set,
 		       sizeof(*set->tags));
 	kfree(set->tags);
 	set->tags = new_tags;
+done:
 	set->nr_hw_queues = new_nr_hw_queues;
-
 	return 0;
 }
 
