Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A7F4C0CB1
	for <lists+linux-block@lfdr.de>; Wed, 23 Feb 2022 07:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbiBWGnB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 23 Feb 2022 01:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbiBWGnA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Feb 2022 01:43:00 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC146D870;
        Tue, 22 Feb 2022 22:42:30 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A272A68B05; Wed, 23 Feb 2022 07:42:26 +0100 (CET)
Date:   Wed, 23 Feb 2022 07:42:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 01/12] blk-mq: do not include passthrough requests in
 I/O accounting
Message-ID: <20220223064226.GA31307@lst.de>
References: <20220222141450.591193-1-hch@lst.de> <20220222141450.591193-2-hch@lst.de> <YhWXFMhdms1QO1dL@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhWXFMhdms1QO1dL@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 23, 2022 at 10:08:20AM +0800, Ming Lei wrote:
> > -	return (rq->rq_flags & RQF_IO_STAT) && rq->q->disk;
> > +	return (rq->rq_flags & RQF_IO_STAT) && !blk_rq_is_passthrough(rq);
> 
> I guess this way may cause regression for workloads with lots of userspace IO
> from user viewpoint?

I'd say it fixes it as the accounting right now is completely bogus.
