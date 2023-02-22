Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2387669FBD2
	for <lists+linux-block@lfdr.de>; Wed, 22 Feb 2023 20:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjBVTQP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 Feb 2023 14:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjBVTQO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2023 14:16:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93D33D0A9
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 11:16:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BF53B816ED
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 19:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2C4C433D2;
        Wed, 22 Feb 2023 19:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677093366;
        bh=tYh0gZKRagJrVEjHxs/hKbqnFtnnvqrpKDgm4JTX3nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tnPaZp9QpHzKJETsH832jfWn2N7V3CuiJo/AY499jlw/zkbYR1o4pli+lZM1e+CL3
         62PM2O5bwgpJRE3qpyuqbOOOx0m8TLsJH5rVrXvgh0gNj6PGXKVtVMyd0tEAXwB9//
         dVIu50e94yL0vgaholFgHKt+FF9YIfmX9M7eR3drgds31SeU7yt7+ZVsvhk49/i2vi
         MeMCjhonAzO4sxYf/+MLwDmH47hOpQ5M8ba9qfdOqAka9Rhxo/Br6G6ZvMorOnPcf+
         uAQfUPW3PqT4A5rh5N/gmHbOqyF2HN7wkllPjwvAhYfmoDLayh7gfJrHbCSr0L0u4B
         E/H51Rxlwnn7g==
Date:   Wed, 22 Feb 2023 12:16:02 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Uday Shankar <ushankar@purestorage.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] blk-mq: enforce op-specific segment limits in
 blk_insert_cloned_request
Message-ID: <Y/Zp8lb3yUiPUNBv@kbusch-mbp.dhcp.thefacebook.com>
References: <20230222185224.2484590-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222185224.2484590-1-ushankar@purestorage.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 22, 2023 at 11:52:25AM -0700, Uday Shankar wrote:
>  static inline unsigned int blk_rq_get_max_segments(struct request *rq)
>  {
> -	if (req_op(rq) == REQ_OP_DISCARD)
> -		return queue_max_discard_segments(rq->q);
> -	return queue_max_segments(rq->q);
> +	return blk_queue_get_max_segments(rq->q, req_op(rq));
>  }

I think you should just move this function to blk.h instead of
introducing a new one.
