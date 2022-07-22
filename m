Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCA657DA0A
	for <lists+linux-block@lfdr.de>; Fri, 22 Jul 2022 08:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiGVGLV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 22 Jul 2022 02:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVGLV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 02:11:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C192A405
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 23:11:20 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 461DC68AFE; Fri, 22 Jul 2022 08:11:17 +0200 (CEST)
Date:   Fri, 22 Jul 2022 08:11:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/5] block: move the call to get_max_io_size out of
 blk_bio_segment_split
Message-ID: <20220722061117.GA31570@lst.de>
References: <20220720142456.1414262-1-hch@lst.de> <20220720142456.1414262-4-hch@lst.de> <133b4a85-7106-8cb0-94da-842d7744e19c@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <133b4a85-7106-8cb0-94da-842d7744e19c@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 22, 2022 at 03:09:57PM +0900, Damien Le Moal wrote:
> On 7/20/22 23:24, Christoph Hellwig wrote:
> > Prepare for reusing blk_bio_segment_split for (file system controlled)
> > splits of REQ_OP_ZONE_APPEND bios by letting the caller control the
> > maximum size of the bio.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Looks good. Though I think this patch could wait for the actual users of
> this change.

I don't think passing an additional argument is in any way harmful
even now, and I'd like to reduce the cross-tree dependencies for
the next cycle.  With this series in I just need to an an export
in the btrfs series, which would be great.
