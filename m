Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199F072E601
	for <lists+linux-block@lfdr.de>; Tue, 13 Jun 2023 16:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbjFMOlw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 13 Jun 2023 10:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbjFMOlv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 10:41:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A02E53
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 07:41:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D3AA6373C
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 14:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59122C433F0;
        Tue, 13 Jun 2023 14:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686667309;
        bh=rz+MvUN0L8ibBl9HEERCSlFQiDhgrt46iEHzqWHPbRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dFF5lZue2Y5RtMYy4iJ03ENWntYI/A6FEw/W3rnw6uAcCsBQpDAuoviVkYjf/QQ/O
         z3NR7BMuUChnsyON/8PvNmeGoO9RGg03SPPLp8AHnQ+OmMvuE8uJHeR8JqJBlt7Jo6
         3GoDzJ6jJgHAI4Npdb2gNb0J6e7oFqPsSwybFt1HRPv9rn+w6D9sTolLUVwUuoghN1
         EuVhNu1yBQm6rY1Coo543hjPHZserD7V0nIqwmtTO46FSpAkzWT7EBHhO8ql3rbXA8
         s6ecfZibxgvgRYFJjg+H52m4yN4GS+YCHcSHCpNpUln4O9Vd1oixaCwbAI1yAFTz41
         y3ys/ygefEjJw==
Date:   Tue, 13 Jun 2023 08:41:46 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 2/2] nvme: don't freeze/unfreeze queues from different
 contexts
Message-ID: <ZIiAKhi5Vmc0Fc9W@kbusch-mbp.dhcp.thefacebook.com>
References: <20230613005847.1762378-1-ming.lei@redhat.com>
 <20230613005847.1762378-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613005847.1762378-3-ming.lei@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 13, 2023 at 08:58:47AM +0800, Ming Lei wrote:
> And this way is correct because quiesce is enough for driver to handle
> error recovery. The only difference is where to wait during error recovery.
> With this way, IO is just queued in block layer queue instead of
> __bio_queue_enter(), finally waiting for completion is done in upper
> layer. Either way, IO can't move on during error recovery.

The point was to contain the fallout from modifying the hctx mappings.
If you allow IO to queue in the blk-mq layer while a reset is in
progress, they may be entering a context that won't be as expected on
the other side of the reset.
