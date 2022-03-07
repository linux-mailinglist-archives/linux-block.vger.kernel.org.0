Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F6A4CF276
	for <lists+linux-block@lfdr.de>; Mon,  7 Mar 2022 08:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbiCGHOR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 7 Mar 2022 02:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbiCGHOP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 02:14:15 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C0240930
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 23:13:21 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 07FBD68AA6; Mon,  7 Mar 2022 08:13:18 +0100 (CET)
Date:   Mon, 7 Mar 2022 08:13:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 6/6] blk-mq: manage hctx map via xarray
Message-ID: <20220307071317.GC32227@lst.de>
References: <20220307064401.30056-1-ming.lei@redhat.com> <20220307064401.30056-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307064401.30056-7-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 07, 2022 at 02:44:01PM +0800, Ming Lei wrote:
> Firstly code becomes more clean by switching to xarray from plain array.
> 
> Secondly use-after-free on q->queue_hw_ctx can be fixed because

Not a native speaker, but shouldn't this read First and Second?

>  	mutex_lock(&q->sysfs_lock);
>  	for (i = 0; i < set->nr_hw_queues; i++) {
>  		int old_node;
>  		int node = blk_mq_get_hctx_node(set, i);
> -		struct blk_mq_hw_ctx *old_hctx = hctxs[i];
> +		struct blk_mq_hw_ctx *old_hctx = xa_load(&q->hctx_table, i);

This should cand can xa_for_each_range.

>  	for (; j < end; j++) {
> -		struct blk_mq_hw_ctx *hctx = hctxs[j];
> +		struct blk_mq_hw_ctx *hctx = xa_load(&q->hctx_table, j);
>  
> -		if (hctx) {
> +		if (hctx)
>  			blk_mq_exit_hctx(q, set, hctx, j);
> -			hctxs[j] = NULL;
> -		}

Same here.
