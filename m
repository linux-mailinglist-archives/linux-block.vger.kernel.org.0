Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBF759190C
	for <lists+linux-block@lfdr.de>; Sat, 13 Aug 2022 08:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiHMGlu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 13 Aug 2022 02:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMGlt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Aug 2022 02:41:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ED02ACD
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 23:41:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1217068AA6; Sat, 13 Aug 2022 08:41:43 +0200 (CEST)
Date:   Sat, 13 Aug 2022 08:41:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] block: Submit flush requests to the I/O scheduler
Message-ID: <20220813064142.GA10753@lst.de>
References: <20220812210355.2252143-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812210355.2252143-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 12, 2022 at 02:03:55PM -0700, Bart Van Assche wrote:
> When submitting a REQ_OP_WRITE | REQ_FUA request to a zoned storage
> device, these requests must be passed to the (mq-deadline) I/O scheduler
> to ensure that these happen at the write pointer.

Yes.

But maybe I'm stupid, but how is the patch related to fixing that?
blk_mq_plug_issue_direct is called from blk_mq_flush_plug_list for
only the !has_elevator case.  How does that change a thing?

Also please include a description of why these changes are otherwise
good and won't regress other cases.

> +		blk_mq_sched_insert_request(rq, /*at_head=*/false,
> +			/*run_queue=*/last, /*async=*/false);

I find thise comment style very hard to read.  Yes, maybe the three
bools here should become flags, but this is even worse than just
passing the arguments.
