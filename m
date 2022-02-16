Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F454B8ED9
	for <lists+linux-block@lfdr.de>; Wed, 16 Feb 2022 18:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbiBPRJ7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Feb 2022 12:09:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbiBPRJ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 12:09:59 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC79F2A64C2
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 09:09:46 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 31F0068B05; Wed, 16 Feb 2022 18:09:44 +0100 (CET)
Date:   Wed, 16 Feb 2022 18:09:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Markus =?iso-8859-1?Q?Bl=F6chl?= <Markus.Bloechl@ipetronik.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: skip the fsync_bdev call in del_gendisk for
 surprise removals
Message-ID: <20220216170943.GB20782@lst.de>
References: <20220216150901.4166235-1-hch@lst.de> <20220216150901.4166235-2-hch@lst.de> <20220216153226.cgwaigrhjdjeuqo7@ipetronik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216153226.cgwaigrhjdjeuqo7@ipetronik.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 16, 2022 at 04:32:26PM +0100, Markus Blöchl wrote:
> On Wed, Feb 16, 2022 at 04:09:01PM +0100, Christoph Hellwig wrote:
> > For surprise removals that have already marked the disk dead, there is
> > no point in calling fsync_bdev as all I/O will fail anyway, so skip it.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  block/genhd.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/genhd.c b/block/genhd.c
> > index 626c8406f21a6..f68bdfe4f883b 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -584,7 +584,14 @@ void del_gendisk(struct gendisk *disk)
> >  	blk_drop_partitions(disk);
> 
> blk_drop_partitions() also invokes fsync_bdev() via delete_partition().
> So why treat them differently?

Yeah. I guess we should just skip this patch for now.
