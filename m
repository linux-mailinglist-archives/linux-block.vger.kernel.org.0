Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C634E46F9
	for <lists+linux-block@lfdr.de>; Tue, 22 Mar 2022 20:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiCVTzs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Mar 2022 15:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiCVTzr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 15:55:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6400F340EC
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 12:54:17 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AD0EE68AFE; Tue, 22 Mar 2022 20:54:14 +0100 (CET)
Date:   Tue, 22 Mar 2022 20:54:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] block: allow BIOSET_PERCPU_CACHE use from
 bio_alloc_clone
Message-ID: <20220322195414.GA8650@lst.de>
References: <20220322194927.42778-1-snitzer@kernel.org> <20220322194927.42778-2-snitzer@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322194927.42778-2-snitzer@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 22, 2022 at 03:49:25PM -0400, Mike Snitzer wrote:
> -	bio = bio_alloc_bioset(bdev, 0, bio_src->bi_opf, gfp, bs);
> +	if (bs->cache && bio_src->bi_opf & REQ_POLLED)
> +		bio = bio_alloc_percpu_cache(bdev, 0, bio_src->bi_opf, gfp, bs);
> +	else

I don't think we can just unconditionally do this based on REQ_POLLED.
We'd either need a flag for bio_alloc_bioset or (probably better)
a separate interface.
