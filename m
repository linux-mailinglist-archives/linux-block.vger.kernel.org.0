Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D75C565658
	for <lists+linux-block@lfdr.de>; Mon,  4 Jul 2022 15:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbiGDNB6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 Jul 2022 09:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbiGDNB5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2022 09:01:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8554B1C2;
        Mon,  4 Jul 2022 06:01:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 35AC368AA6; Mon,  4 Jul 2022 15:01:53 +0200 (CEST)
Date:   Mon, 4 Jul 2022 15:01:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 01/17] block: remove a superflous ifdef in blkdev.h
Message-ID: <20220704130153.GA23752@lst.de>
References: <20220704124500.155247-1-hch@lst.de> <20220704124500.155247-2-hch@lst.de> <PH0PR04MB741671715E7F16D5335002509BBE9@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB741671715E7F16D5335002509BBE9@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 04, 2022 at 12:58:40PM +0000, Johannes Thumshirn wrote:
> > -#ifdef CONFIG_BLK_DEV_ZONED
> > -
> >  /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
> >  const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);
> >  
> 
> Won't this break tracing in null_blk, which uses blk_zone_cond_str()?

How could removing an ifdef and exposing a prototype unconditionally
in a header break tracing?
