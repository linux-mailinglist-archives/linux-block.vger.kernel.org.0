Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC026C2A22
	for <lists+linux-block@lfdr.de>; Tue, 21 Mar 2023 07:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCUGDN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Mar 2023 02:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjCUGDL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 02:03:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9CC30E9A
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 23:03:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2ACDF68AFE; Tue, 21 Mar 2023 07:03:07 +0100 (CET)
Date:   Tue, 21 Mar 2023 07:03:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 2/3] block: Split and submit bios in LBA order
Message-ID: <20230321060307.GB18078@lst.de>
References: <20230320234905.3832131-1-bvanassche@acm.org> <20230320234905.3832131-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320234905.3832131-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 20, 2023 at 04:49:04PM -0700, Bart Van Assche wrote:
> Submit the bio fragment with the lowest LBA first. This approach prevents
> write errors when submitting large bios to host-managed zoned block devices.
> This patch only modifies the behavior of drivers that call
> bio_split_to_limits() directly. This includes DRBD, pktcdvd, dm, md and
> the NVMe multipath code.

Umm, doesn't it also change how blk-mq splits, which is the prime
reason why you're looking into that?

> +		if (current->bio_list) {
> +			/*
> +			 * The caller will submit the first half ('split')
> +			 * before the second half ('bio').
> +			 */
> +			bio_chain(split, bio);
> +			submit_bio_noacct(bio);
> +			return split;
> +		}
> +		/*
> +		 * Submit the first half ('split') let the caller submit the
> +		 * second half ('bio').
> +		 */
> +		*nr_segs = bio_chain_nr_segments(bio, lim);
> +		bio_chain(split, bio);
> +		submit_bio_noacct(split);

I'm really confused on why you want to change the behavior here
for the case where run in a stacking context vs not, and neither
the comments nor the commit log help me trying to figure out why.
