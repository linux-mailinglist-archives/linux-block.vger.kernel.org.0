Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C6B61F2BE
	for <lists+linux-block@lfdr.de>; Mon,  7 Nov 2022 13:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiKGMRb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 7 Nov 2022 07:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiKGMRa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 07:17:30 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A3BE095;
        Mon,  7 Nov 2022 04:17:21 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8D08C67373; Mon,  7 Nov 2022 13:16:27 +0100 (CET)
Date:   Mon, 7 Nov 2022 13:16:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v5 5/7] ata: libata: Fix FUA handling in
 ata_build_rw_tf()
Message-ID: <20221107121627.GA17441@lst.de>
References: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com> <20221107005021.1327692-6-damien.lemoal@opensource.wdc.com> <20221107055000.GD28873@lst.de> <ca10f501-0d3e-fcae-2b98-d39ca1822a67@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca10f501-0d3e-fcae-2b98-d39ca1822a67@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 07, 2022 at 09:12:57PM +0900, Damien Le Moal wrote:
> On 11/7/22 14:50, Christoph Hellwig wrote:
> > On Mon, Nov 07, 2022 at 09:50:19AM +0900, Damien Le Moal wrote:
> >> Finally, since the block layer should never issue a FUA read
> >> request, warn in ata_build_rw_tf() if we see such request.
> > 
> > Couldn't this be triggered using SG_IO passthrough with a SCSI 
> > WRITE* command that has the FUA bit set?
> 
> Yes indeed. Should I drop the warn ?

I think the warn needs to go.  But don't we also need to handle the
non-NCQ fua case if we don't want to break pure passthrough appliations?
Or do we simply not care?  In the latter case we'll at least need a
comment documenting that tradeoff.
