Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B1D622BE7
	for <lists+linux-block@lfdr.de>; Wed,  9 Nov 2022 13:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiKIMt6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Nov 2022 07:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIMt5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Nov 2022 07:49:57 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED4D1DA7E
        for <linux-block@vger.kernel.org>; Wed,  9 Nov 2022 04:49:56 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 69CC268AA6; Wed,  9 Nov 2022 13:49:53 +0100 (CET)
Date:   Wed, 9 Nov 2022 13:49:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] blk-crypto: pass a gendisk to
 blk_crypto_sysfs_register
Message-ID: <20221109124953.GB32628@lst.de>
References: <20221105080815.775721-1-hch@lst.de> <Y2lirLd1Gxs6+HEd@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2lirLd1Gxs6+HEd@sol.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 07, 2022 at 11:55:24AM -0800, Eric Biggers wrote:
> >  
> > -int blk_crypto_sysfs_register(struct request_queue *q);
> > +int blk_crypto_sysfs_register(struct gendisk *disk);
> >  
> >  void blk_crypto_sysfs_unregister(struct request_queue *q);
> 
> Shouldn't blk_crypto_sysfs_unregister() be updated to match?

While not strictly required, that would keep the interface symmetric,
so yes.
