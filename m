Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2B45818D1
	for <lists+linux-block@lfdr.de>; Tue, 26 Jul 2022 19:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbiGZRr2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 26 Jul 2022 13:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbiGZRrZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 13:47:25 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0ED712D0A
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 10:47:24 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9E54168AA6; Tue, 26 Jul 2022 19:47:21 +0200 (CEST)
Date:   Tue, 26 Jul 2022 19:47:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH 1/2] ublk_drv: store device parameters
Message-ID: <20220726174721.GA14002@lst.de>
References: <20220723150713.750369-1-ming.lei@redhat.com> <20220723150713.750369-2-ming.lei@redhat.com> <20220725064259.GA20796@lst.de> <Yt5BCtLi70Pits34@T590> <20220726123224.GA9435@lst.de> <Yt/4UBGtFDqr2SfA@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt/4UBGtFDqr2SfA@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 26, 2022 at 10:21:04PM +0800, Ming Lei wrote:
> But most of fields in ublk_params aren't required for one device,
> sending them all isn't friendly from both userspace and kernel side.

I think it actually is easier for both.  For the kernel the benefit
is pretty clear seen by this patch, and for userspae there also is
a lot less boilerplate code.

> Especially inside kernel, a big chunk buffer is allocated for
> the structure, but only few fields are useful for one device. There can
> be lots of ublk device, and total wasted memory can't be ignored.

I think even right now the memory usage is less.  If a lot (and I mean
a lot) new paramters are added, it might be slightly higher than the
minimal config with an xarray, but not to the point where it matters.

> If we group parameters, it is easier to extend by adding new parameter
> type. One ublk device usually just uses several parameter types.
> And the xarray implementation is simple enough too, which is just one
> array, but really sparsed.

Well, it isn't exactly simple.  And the apprach of a struct that just
grows additional members has worked perfectly fine all over the kernel.
