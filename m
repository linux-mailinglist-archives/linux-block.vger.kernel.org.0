Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE98271940
	for <lists+linux-block@lfdr.de>; Mon, 21 Sep 2020 04:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIUCWq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 20 Sep 2020 22:22:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44100 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbgIUCWp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Sep 2020 22:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600654964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XOfUQSn+cTTKAJrEJ/8pZZKAqjGimUPpNTQvXyXPpLU=;
        b=gLJgR84vWtNQHRRaW9bVD7VtTJ0DZPSMtvUnGcFHEaqoK+rNZ/OC5AWoXzQu4Q/LofmNyK
        KRjQubpBUoRMFQWFkr9+4IuzT1aKU1zSBGoK3Kx81ucCw9ONvrRUN1/FrlSQNVSXlYnDHN
        1TE0K+/RKvR4/oGmVdEpCJbHqOdoH20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-9jKCDnkoOeOt6QteD4uYOg-1; Sun, 20 Sep 2020 22:22:40 -0400
X-MC-Unique: 9jKCDnkoOeOt6QteD4uYOg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 858C51800D42;
        Mon, 21 Sep 2020 02:22:37 +0000 (UTC)
Received: from T590 (ovpn-13-76.pek2.redhat.com [10.72.13.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AA5605D9D5;
        Mon, 21 Sep 2020 02:22:26 +0000 (UTC)
Date:   Mon, 21 Sep 2020 10:22:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH V6 0/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200921022222.GA1332419@T590>
References: <20200914020827.337615-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914020827.337615-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 14, 2020 at 10:08:23AM +0800, Ming Lei wrote:
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
> V6:
> 	- base on for-5.10/block directly, instead of being against on patchset of
> 	'percpu_ref & block: reduce memory footprint of percpu_ref in fast path',
> 	because these patches don't depend on that patchset. 
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
> 2.25.2
> 

Hello Jens,

Ping...


Thanks, 
Ming

