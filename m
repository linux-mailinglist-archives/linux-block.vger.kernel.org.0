Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69FB2666D6
	for <lists+linux-block@lfdr.de>; Fri, 11 Sep 2020 19:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgIKReD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 11 Sep 2020 13:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgIKReD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 13:34:03 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96866221EB;
        Fri, 11 Sep 2020 17:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599845637;
        bh=K/sYNBIpcDiYdKSYBvYLDBi5omik/y2CDgteLHwS3D0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A0MR2/t5If5ED/X6HevHt50R2980ky9aiE1hVaMvTnhsF9V0SzMHTige6KGscBhmb
         XWufhL0CeFmyrBb4mKrv+HbJvw31nfxEy0yYxv4tZl6QhbZNxpmVCOWGb8EaNY7vgC
         ZdpwDhvuCvs67yDHgwcOw5dFsLnRyF7If5RZ8WOo=
Date:   Fri, 11 Sep 2020 10:33:54 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH V5 0/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200911173354.GA3655155@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200911024117.62480-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911024117.62480-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 11, 2020 at 10:41:13AM +0800, Ming Lei wrote:
> Hi Jens,
> 
> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
> and prepares for replacing srcu with percpu_ref.
> 
> The 2nd patch replaces srcu with percpu_ref.
> 
> The 3rd patch adds tagset quiesce interface.
> 
> The 4th patch applies tagset quiesce interface for NVMe subsystem.
> 
> V5:
> 	- warn once in case that driver unquiesces its queue being
> 	  quiesce and not done, only patch 2 is modified
> 
> V4:
> 	- remove .mq_quiesce_mutex, and switch to test_and_[set|clear] for
> 	avoiding duplicated quiesce action
> 	- pass blktests(block, nvme)
> 
> V3:
> 	- add tagset quiesce interface
> 	- apply tagset quiesce interface for NVMe
> 	- pass blktests(block, nvme)
> 
> V2:
> 	- add .mq_quiesce_lock
> 	- add comment on patch 2 wrt. handling hctx_lock() failure
> 	- trivial patch style change
> 
> Ming Lei (3):
>   block: use test_and_{clear|test}_bit to set/clear QUEUE_FLAG_QUIESCED
>   blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
>   blk-mq: add tagset quiesce interface
> 
> Sagi Grimberg (1):
>   nvme: use blk_mq_[un]quiesce_tagset
> 
>  block/blk-core.c         |  13 +++
>  block/blk-mq-sysfs.c     |   2 -
>  block/blk-mq.c           | 182 +++++++++++++++++++++++++--------------
>  block/blk-sysfs.c        |   6 +-
>  block/blk.h              |   2 +
>  drivers/nvme/host/core.c |  19 ++--
>  include/linux/blk-mq.h   |  10 +--
>  include/linux/blkdev.h   |   4 +
>  8 files changed, 154 insertions(+), 84 deletions(-)
> 
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Cc: Chao Leng <lengchao@huawei.com>
> -- 

This looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>
