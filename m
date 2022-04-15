Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F52502371
	for <lists+linux-block@lfdr.de>; Fri, 15 Apr 2022 07:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349385AbiDOFJX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 15 Apr 2022 01:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351881AbiDOFGY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 01:06:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7DB109E
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 21:59:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BC99F68B05; Fri, 15 Apr 2022 06:59:27 +0200 (CEST)
Date:   Fri, 15 Apr 2022 06:59:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH] block: don't print I/O error warning for dead disks
Message-ID: <20220415045927.GA22669@lst.de>
References: <20220323163815.1526998-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323163815.1526998-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping?

On Wed, Mar 23, 2022 at 05:38:15PM +0100, Christoph Hellwig wrote:
> When a disk has been marked dead, don't print warnings for I/O errors
> as they are very much expected.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8e659dc5fcf37..5b6a7c9d0d992 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -794,7 +794,8 @@ bool blk_update_request(struct request *req, blk_status_t error,
>  #endif
>  
>  	if (unlikely(error && !blk_rq_is_passthrough(req) &&
> -		     !(req->rq_flags & RQF_QUIET))) {
> +		     !(req->rq_flags & RQF_QUIET)) &&
> +		     !test_bit(GD_DEAD, &req->q->disk->state)) {
>  		blk_print_req_error(req, error);
>  		trace_block_rq_error(req, error, nr_bytes);
>  	}
> -- 
> 2.30.2
---end quoted text---
