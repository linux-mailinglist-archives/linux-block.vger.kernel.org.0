Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFEE3B7F34
	for <lists+linux-block@lfdr.de>; Wed, 30 Jun 2021 10:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbhF3Ipc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 30 Jun 2021 04:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233210AbhF3Ipc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 04:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625042583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+K2zZjhe3r1i8JK801FyLP5ypzTQN49MZp3LuTInG34=;
        b=NHULOkXPqAOOGlEvkEib44GmiM7I/qzN4q2N7gZ8OSfJCJgbSm1yQi6V52kDfYBuqklVJs
        JMNIOOptFE0qvEyOnCboUOqLmz4eYIVBnuAuCZpNCsCvA7fVVtfHbO2pyTdv61ttTTAAFM
        dGE8tdHO6VlcNrdK6kz8RUlIiWMkyts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-RjPb-VVCNJ-VPL9wbvj3xg-1; Wed, 30 Jun 2021 04:42:58 -0400
X-MC-Unique: RjPb-VVCNJ-VPL9wbvj3xg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6866800C60;
        Wed, 30 Jun 2021 08:42:56 +0000 (UTC)
Received: from T590 (ovpn-13-153.pek2.redhat.com [10.72.13.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6661E60843;
        Wed, 30 Jun 2021 08:42:47 +0000 (UTC)
Date:   Wed, 30 Jun 2021 16:42:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/2] blk-mq: fix blk_mq_alloc_request_hctx
Message-ID: <YNwug8n7qGL5uXfo@T590>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <5f304121-38ce-034b-2d17-93d136c77fe6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f304121-38ce-034b-2d17-93d136c77fe6@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 30, 2021 at 10:18:37AM +0200, Hannes Reinecke wrote:
> On 6/29/21 9:49 AM, Ming Lei wrote:
> > Hi,
> > 
> > blk_mq_alloc_request_hctx() is used by NVMe fc/rdma/tcp/loop to connect
> > io queue. Also the sw ctx is chosen as the 1st online cpu in hctx->cpumask.
> > However, all cpus in hctx->cpumask may be offline.
> > 
> > This usage model isn't well supported by blk-mq which supposes allocator is
> > always done on one online CPU in hctx->cpumask. This assumption is
> > related with managed irq, which also requires blk-mq to drain inflight
> > request in this hctx when the last cpu in hctx->cpumask is going to
> > offline.
> > 
> > However, NVMe fc/rdma/tcp/loop don't use managed irq, so we should allow
> > them to ask for request allocation when the specified hctx is inactive
> > (all cpus in hctx->cpumask are offline).
> > 
> > Fix blk_mq_alloc_request_hctx() by adding/passing flag of
> > BLK_MQ_F_NOT_USE_MANAGED_IRQ.
> > 
> > 
> > Ming Lei (2):
> >    blk-mq: not deactivate hctx if the device doesn't use managed irq
> >    nvme: pass BLK_MQ_F_NOT_USE_MANAGED_IRQ for fc/rdma/tcp/loop
> > 
> >   block/blk-mq.c             | 6 +++++-
> >   drivers/nvme/host/fc.c     | 3 ++-
> >   drivers/nvme/host/rdma.c   | 3 ++-
> >   drivers/nvme/host/tcp.c    | 3 ++-
> >   drivers/nvme/target/loop.c | 3 ++-
> >   include/linux/blk-mq.h     | 1 +
> >   6 files changed, 14 insertions(+), 5 deletions(-)
> > 
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Cc: Daniel Wagner <dwagner@suse. thede>
> > Cc: Wen Xiong <wenxiong@us.ibm.com>
> > Cc: John Garry <john.garry@huawei.com>
> > 
> > 
> I have my misgivings about this patchset.
> To my understanding, only CPUs present in the hctx cpumask are eligible to
> submit I/O to that hctx.

It is just true for managed irq, and should be CPUs online.

However, no such constraint for non managed irq, since irq may migrate to
other online CPUs if all CPUs in irq's current affinity become offline.

> Consequently if all cpus in that mask are offline, where is the point of
> even transmitting a 'connect' request?

nvmef requires to submit the connect request via one specified hctx
which index has to be same with the io queue's index.

Almost all nvmef drivers fail to setup controller in case of
connect io queue error.

Also CPU can become offline & online, especially it is done in
lots of sanity test.

So we should allow to allocate the connect request successful, and
submit it to drivers given it is allowed in this way for non-managed
irq.

> Shouldn't we rather modify the tagset to only refer to the current online
> CPUs _only_, thereby never submit a connect request for hctx with only
> offline CPUs?

Then you may setup very less io queues, and performance may suffer even
though lots of CPUs become online later.


Thanks,
Ming

