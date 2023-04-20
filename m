Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E726E895A
	for <lists+linux-block@lfdr.de>; Thu, 20 Apr 2023 07:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjDTFBr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Apr 2023 01:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDTFBq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 01:01:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D80C46AA
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 22:01:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BEACA68B05; Thu, 20 Apr 2023 07:01:42 +0200 (CEST)
Date:   Thu, 20 Apr 2023 07:01:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 03/11] block: Introduce blk_rq_is_seq_zoned_write()
Message-ID: <20230420050142.GB4371@lst.de>
References: <20230418224002.1195163-1-bvanassche@acm.org> <20230418224002.1195163-4-bvanassche@acm.org> <20230419045000.GA25898@lst.de> <80cf216a-dc41-0673-6d55-adb32ff42e46@acm.org> <3995e9fd-d9b3-feaa-39a7-d3d518468604@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3995e9fd-d9b3-feaa-39a7-d3d518468604@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 20, 2023 at 10:03:16AM +0900, Damien Le Moal wrote:
> Could also have a comment on top of the switch explicitly saying that only WRITE
> and WRITE ZEROES need to be checked, and that all other commands, including zone
> append writes, do not have strong reordering requirements. This way, no need to
> superfluous cases.

Yes, I think a good comment would be more useful here.
