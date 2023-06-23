Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A8F73B05C
	for <lists+linux-block@lfdr.de>; Fri, 23 Jun 2023 07:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjFWFwR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 23 Jun 2023 01:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjFWFwJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jun 2023 01:52:09 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F831A1
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 22:52:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8CFEC67373; Fri, 23 Jun 2023 07:52:05 +0200 (CEST)
Date:   Fri, 23 Jun 2023 07:52:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 7/7] block: Inline
 blk_mq_{,delay_}kick_requeue_list()
Message-ID: <20230623055205.GF9085@lst.de>
References: <20230621201237.796902-1-bvanassche@acm.org> <20230621201237.796902-8-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621201237.796902-8-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 21, 2023 at 01:12:34PM -0700, Bart Van Assche wrote:
> Patch "block: Preserve the order of requeued requests" changed
> blk_mq_kick_requeue_list() and blk_mq_delay_kick_requeue_list() into
> blk_mq_run_hw_queues() and blk_mq_delay_run_hw_queues() calls
> respectively. Inline blk_mq_{,delay_}kick_requeue_list() because these
> functions are now too short to keep these as separate functions.

You're not inlining them, but you're removing them and open code
the trivial logic in the callers.

The code change looks good to me, though.
