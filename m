Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4246BF85F
	for <lists+linux-block@lfdr.de>; Sat, 18 Mar 2023 07:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjCRGiS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 18 Mar 2023 02:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCRGiR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Mar 2023 02:38:17 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046E93B3E1
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 23:38:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 552AF68C4E; Sat, 18 Mar 2023 07:38:11 +0100 (CET)
Date:   Sat, 18 Mar 2023 07:38:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 1/2] block: Split blk_recalc_rq_segments()
Message-ID: <20230318063810.GD24880@lst.de>
References: <20230317195938.1745318-1-bvanassche@acm.org> <20230317195938.1745318-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317195938.1745318-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 17, 2023 at 12:59:37PM -0700, Bart Van Assche wrote:
> +unsigned int bio_nr_segments(const struct queue_limits *lim, struct bio *bio)

The name is wrong, as it operates not on a single bio, but
rather on a chain of bios.  That being said it seems like your caller
in the next patch only cares about the regulad read/write bio case,
which is kust this:

> +	for_each_bio(bio)
> +		bio_for_each_bvec(bv, bio, iter)
> +			bvec_split_segs(lim, &bv, &nr_phys_segs, &bytes,
> +					UINT_MAX, UINT_MAX);

So maybe split that into a separat patch.

Also please pass the queue_limit after the bio like the other
functions in this file.
