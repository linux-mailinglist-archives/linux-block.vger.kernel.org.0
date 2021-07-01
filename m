Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5259D3B900C
	for <lists+linux-block@lfdr.de>; Thu,  1 Jul 2021 11:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbhGAJzA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 1 Jul 2021 05:55:00 -0400
Received: from verein.lst.de ([213.95.11.211]:47023 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235300AbhGAJy7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Jul 2021 05:54:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 188EF6736F; Thu,  1 Jul 2021 11:52:27 +0200 (CEST)
Date:   Thu, 1 Jul 2021 11:52:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't
 use managed irq
Message-ID: <20210701095226.GB2066@lst.de>
References: <20210629074951.1981284-1-ming.lei@redhat.com> <20210629074951.1981284-2-ming.lei@redhat.com> <c31aa259-d3a8-8c70-efce-b7af02bfd609@huawei.com> <YNu7rs7j5/KtQjAi@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNu7rs7j5/KtQjAi@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 30, 2021 at 08:32:46AM +0800, Ming Lei wrote:
> Indeed, we may replace BLK_MQ_F_STACKING with BLK_MQ_F_NOT_USE_MANAGED_IRQ
> (BLK_MQ_F_NO_MANAGED_IRQ) too, and the latter is one general solution.

And now turn the polarity around and make it a BLK_MQ_F_MANAGED_IRQ set
by the map_queue helpers that rely on managed irqs.
