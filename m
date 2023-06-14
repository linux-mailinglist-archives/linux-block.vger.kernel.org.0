Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDBA72DA2F
	for <lists+linux-block@lfdr.de>; Tue, 13 Jun 2023 08:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239701AbjFMGw5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 13 Jun 2023 02:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbjFMGw5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 02:52:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C77AE79
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 23:52:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7DD2A68B05; Tue, 13 Jun 2023 08:52:52 +0200 (CEST)
Date:   Tue, 13 Jun 2023 08:52:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sandeep Dhavale <dhavale@google.com>,
        Juan Yescas <jyescas@google.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v6 8/8] null_blk: Support configuring the maximum
 segment size
Message-ID: <20230613065252.GA15939@lst.de>
References: <20230612203314.17820-1-bvanassche@acm.org> <20230612203314.17820-9-bvanassche@acm.org> <407d7371-efa2-154d-a05f-a827171806a0@kernel.org> <2ec5270c-a913-44cf-3a45-0713e6c58224@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ec5270c-a913-44cf-3a45-0713e6c58224@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 12, 2023 at 05:44:51PM -0700, Bart Van Assche wrote:
>
> Hi Damien,
>
> bio_split() enforces the max_sectors limit but not the max_segment_size 
> limit.

bio_split() doesn't enforce any limit, but it's also not used by
null_blk or blk-mq.

bio_split_to_limits enforces max_segment_size in bvec_split_segs.
