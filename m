Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD1975A581
	for <lists+linux-block@lfdr.de>; Thu, 20 Jul 2023 07:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjGTFj0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Jul 2023 01:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGTFjZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 01:39:25 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B3811D
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 22:39:25 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C7E0167373; Thu, 20 Jul 2023 07:39:21 +0200 (CEST)
Date:   Thu, 20 Jul 2023 07:39:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] scsi: Inline scsi_kick_queue()
Message-ID: <20230720053921.GA2450@lst.de>
References: <20230719182243.2810134-1-bvanassche@acm.org> <20230719182243.2810134-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719182243.2810134-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 19, 2023 at 11:22:40AM -0700, Bart Van Assche wrote:
> scsi_kick_queue() is too short to keep it as a separate function. Hence
> inline it. This patch prepares for modifying the second argument passed
> to blk_mq_run_hw_queues().

It wouldn't say "too short" as short functions can be useful too.
But this one is indeed quite pointless, so the change looks good,
even if the commit log could be improved a bit:

Reviewed-by: Christoph Hellwig <hch@lst.de>
