Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20451587D42
	for <lists+linux-block@lfdr.de>; Tue,  2 Aug 2022 15:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbiHBNiW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Aug 2022 09:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiHBNiV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Aug 2022 09:38:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993851D327
        for <linux-block@vger.kernel.org>; Tue,  2 Aug 2022 06:38:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0129E68AA6; Tue,  2 Aug 2022 15:38:16 +0200 (CEST)
Date:   Tue, 2 Aug 2022 15:38:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, axboe@kernel.dk
Subject: Re: [PATCH 0/3] improve nvme quiesce time for large amount of
 namespaces
Message-ID: <20220802133815.GA380@lst.de>
References: <20220729073948.32696-1-lengchao@huawei.com> <20220729142605.GA395@lst.de> <1b3d753a-6ff5-bdf1-8c91-4b4760ea1736@huawei.com> <fc7a303f-0921-f784-a559-f03511f2e4be@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc7a303f-0921-f784-a559-f03511f2e4be@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 31, 2022 at 01:23:36PM +0300, Sagi Grimberg wrote:
> But maybe we can avoid that, and because we allocate
> the connect_q ourselves, and fully know that it should
> not be apart of the tagset quiesce, perhaps we can introduce
> a new interface like:
> --
> static inline int nvme_ctrl_init_connect_q(struct nvme_ctrl *ctrl)
> {
> 	ctrl->connect_q = blk_mq_init_queue_self_quiesce(ctrl->tagset);
> 	if (IS_ERR(ctrl->connect_q))
> 		return PTR_ERR(ctrl->connect_q);
> 	return 0;
> }
> --
>
> And then blk_mq_quiesce_tagset can simply look into a per request-queue
> self_quiesce flag and skip as needed.

I'd just make that a queue flag set after allocation to keep the
interface simple, but otherwise this seems like the right thing
to do.
