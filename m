Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7A36C2A2E
	for <lists+linux-block@lfdr.de>; Tue, 21 Mar 2023 07:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCUGGB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Mar 2023 02:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCUGFf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 02:05:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E146D2BEEB
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 23:05:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 44BD668AFE; Tue, 21 Mar 2023 07:05:30 +0100 (CET)
Date:   Tue, 21 Mar 2023 07:05:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 2/3] block: Split and submit bios in LBA order
Message-ID: <20230321060530.GC18078@lst.de>
References: <20230320234905.3832131-1-bvanassche@acm.org> <20230320234905.3832131-3-bvanassche@acm.org> <20230321060307.GB18078@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321060307.GB18078@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 21, 2023 at 07:03:07AM +0100, Christoph Hellwig wrote:
> > +		if (current->bio_list) {
> > +			/*
> > +			 * The caller will submit the first half ('split')
> > +			 * before the second half ('bio').
> > +			 */
> > +			bio_chain(split, bio);
> > +			submit_bio_noacct(bio);
> > +			return split;
> > +		}
> > +		/*
> > +		 * Submit the first half ('split') let the caller submit the
> > +		 * second half ('bio').
> > +		 */
> > +		*nr_segs = bio_chain_nr_segments(bio, lim);
> > +		bio_chain(split, bio);
> > +		submit_bio_noacct(split);
> 
> I'm really confused on why you want to change the behavior here
> for the case where run in a stacking context vs not, and neither
> the comments nor the commit log help me trying to figure out why.

In fact I wonder how you managed to get into __bio_split_to_limits
wtih a NULL current->bio_list at all.
