Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C8D54C170
	for <lists+linux-block@lfdr.de>; Wed, 15 Jun 2022 08:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiFOF6k (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Jun 2022 01:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243069AbiFOF6U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 01:58:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8772B263
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 22:58:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AF29E67373; Wed, 15 Jun 2022 07:58:16 +0200 (CEST)
Date:   Wed, 15 Jun 2022 07:58:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/3] blk-iocost: Simplify ioc_rqos_done()
Message-ID: <20220615055816.GA22115@lst.de>
References: <20220614175725.612878-1-bvanassche@acm.org> <20220614175725.612878-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614175725.612878-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 14, 2022 at 10:57:23AM -0700, Bart Van Assche wrote:
> Leave out the superfluous "& REQ_OP_MASK" code. The definition of req_op()
> shows that that code is superfluous:
> 
>  #define req_op(req) ((req)->cmd_flags & REQ_OP_MASK)
> 
> Compile-tested only.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
