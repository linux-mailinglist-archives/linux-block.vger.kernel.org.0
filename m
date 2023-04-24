Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D612C6DDB0D
	for <lists+linux-block@lfdr.de>; Tue, 11 Apr 2023 14:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjDKMks (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 11 Apr 2023 08:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDKMkr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 08:40:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993A192
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 05:40:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9521A68C7B; Tue, 11 Apr 2023 14:40:42 +0200 (CEST)
Date:   Tue, 11 Apr 2023 14:40:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v2 04/12] block: Requeue requests if a CPU is unplugged
Message-ID: <20230411124042.GB14106@lst.de>
References: <20230407235822.1672286-1-bvanassche@acm.org> <20230407235822.1672286-5-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407235822.1672286-5-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 07, 2023 at 04:58:14PM -0700, Bart Van Assche wrote:
> +	if (hctx->queue->elevator) {
> +		struct request *rq, *next;
> +
> +		list_for_each_entry_safe(rq, next, &tmp, queuelist)
> +			blk_mq_requeue_request(rq, false);
> +		blk_mq_kick_requeue_list(hctx->queue);
> +	} else {
> +		spin_lock(&hctx->lock);
> +		list_splice_tail_init(&tmp, &hctx->dispatch);
> +		spin_unlock(&hctx->lock);
> +	}

Given that this isn't exactly a fast path, is there any reason to
not always go through the requeue_list?
