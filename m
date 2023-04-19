Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F436E726A
	for <lists+linux-block@lfdr.de>; Wed, 19 Apr 2023 06:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjDSEuG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 Apr 2023 00:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjDSEuF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 00:50:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91EE3C0A
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 21:50:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E2D2C6732D; Wed, 19 Apr 2023 06:50:00 +0200 (CEST)
Date:   Wed, 19 Apr 2023 06:50:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 03/11] block: Introduce blk_rq_is_seq_zoned_write()
Message-ID: <20230419045000.GA25898@lst.de>
References: <20230418224002.1195163-1-bvanassche@acm.org> <20230418224002.1195163-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418224002.1195163-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 18, 2023 at 03:39:54PM -0700, Bart Van Assche wrote:
> +/**
> + * blk_rq_is_seq_zoned_write() - Whether @rq is a zoned write for which the order matters.

Maybe:

 * blk_rq_is_seq_zoned_write() - check if @rq needs zoned write serialization

> +bool blk_rq_is_seq_zoned_write(struct request *rq)
> +{
> +	switch (req_op(rq)) {
> +	case REQ_OP_WRITE:
> +	case REQ_OP_WRITE_ZEROES:
> +		return blk_rq_zone_is_seq(rq);
> +	case REQ_OP_ZONE_APPEND:
> +	default:

The REQ_OP_ZONE_APPEND case here is superflous.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
