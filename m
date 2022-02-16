Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF7B4B8C44
	for <lists+linux-block@lfdr.de>; Wed, 16 Feb 2022 16:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbiBPPUl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Feb 2022 10:20:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiBPPUk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 10:20:40 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C604E2A39F5
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 07:20:23 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D43FE68B05; Wed, 16 Feb 2022 16:20:19 +0100 (CET)
Date:   Wed, 16 Feb 2022 16:20:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
        markus.bloechl@ipetronik.com, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: skip the fsync_bdev call in del_gendisk for
 surprise removals
Message-ID: <20220216152019.GA19002@lst.de>
References: <20220216150901.4166235-1-hch@lst.de> <20220216150901.4166235-2-hch@lst.de> <4f29d9a3-021c-f2f0-b452-e682fa1db459@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f29d9a3-021c-f2f0-b452-e682fa1db459@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 16, 2022 at 04:18:43PM +0100, Hannes Reinecke wrote:
> My turn to be picky:
> In the previous patch you use 'set_bit()' for GD_DEAD, which to my 
> knowledge doesn't imply a memory barrier.
> Yet here you rely on that for the 'test_bit()' to return the correct/most 
> recent value.
> Don't we need a memory barrier here somewhere?

Well, we only do the test to skip useless work.  A race is not a
problem here.
