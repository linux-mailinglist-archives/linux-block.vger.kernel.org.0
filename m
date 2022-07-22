Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0843B57DEEA
	for <lists+linux-block@lfdr.de>; Fri, 22 Jul 2022 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbiGVJxb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 22 Jul 2022 05:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbiGVJx2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 05:53:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367A0D1
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 02:53:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6FF0468AFE; Fri, 22 Jul 2022 11:53:19 +0200 (CEST)
Date:   Fri, 22 Jul 2022 11:53:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 2/2] ublk_drv: make sure that correct
 flags(features) returned to userspace
Message-ID: <20220722095319.GA13942@lst.de>
References: <20220722084516.624457-1-ming.lei@redhat.com> <20220722084516.624457-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722084516.624457-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 22, 2022 at 04:45:16PM +0800, Ming Lei wrote:
>  	/* We are not ready to support zero copy */
> +	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;

Nit: I'd move this below the clearing of UBLK_F_ALL.  Not because it
makes much of a differece, but because it flows more logical.

> +/* All UBLK_F_* have to be included into UBLK_F_ALL */
> +#define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_URING_CMD_COMP_IN_TASK)

And this should not be in the uapi header but only kernel internal.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
