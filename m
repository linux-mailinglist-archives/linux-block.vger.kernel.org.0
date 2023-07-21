Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508CB75BEE0
	for <lists+linux-block@lfdr.de>; Fri, 21 Jul 2023 08:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjGUGbs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 21 Jul 2023 02:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGUGbr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 02:31:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFA8E65
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 23:31:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E07D46732D; Fri, 21 Jul 2023 08:31:42 +0200 (CEST)
Date:   Fri, 21 Jul 2023 08:31:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v2 3/3] block: Improve performance for
 BLK_MQ_F_BLOCKING drivers
Message-ID: <20230721063142.GA21104@lst.de>
References: <20230719182243.2810134-1-bvanassche@acm.org> <20230719182243.2810134-4-bvanassche@acm.org> <20230720055437.GA2665@lst.de> <2c4f838c-aabc-1ef1-45eb-961114da643b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c4f838c-aabc-1ef1-45eb-961114da643b@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 20, 2023 at 08:44:52AM -0700, Bart Van Assche wrote:
> blk_mq_run_hw_queue(hctx, false) is called from inside the block layer
> with an RCU lock held if BLK_MQ_F_BLOCKING and with an SRCU lock held if
> BLK_MQ_F_BLOCKING is not set. So I'm not sure whether it is possible to
> simplify the above might_sleep_if() statement. From block/blk-mq.h:

Ok, it looks like we can't go down that way then.
