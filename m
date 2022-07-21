Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF8857C495
	for <lists+linux-block@lfdr.de>; Thu, 21 Jul 2022 08:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiGUGmL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 Jul 2022 02:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiGUGmK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 02:42:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4415A14D
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 23:42:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C4DB268AFE; Thu, 21 Jul 2022 08:42:04 +0200 (CEST)
Date:   Thu, 21 Jul 2022 08:42:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 4/5] block: move bio_allowed_max_sectors to blk-merge.c
Message-ID: <20220721064204.GA21117@lst.de>
References: <20220720142456.1414262-1-hch@lst.de> <20220720142456.1414262-5-hch@lst.de> <PH0PR04MB741657AA4C6612601C75C60A9B919@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB741657AA4C6612601C75C60A9B919@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 21, 2022 at 06:31:24AM +0000, Johannes Thumshirn wrote:
> On 20.07.22 16:25, Christoph Hellwig wrote:
> > +/*
> > + * The max size one bio can handle is UINT_MAX becasue bvec_iter.bi_size
> > + * is defined as 'unsigned int', meantime it has to aligned to with logical
> > + * block size which is the minimum accepted unit by hardware.
> > + */
> 
> Not your call, as your only moving the comment but 'to be aligned to'

I'm perfectly fine with fixing it, but a little to lazy to resend just
for that :)
