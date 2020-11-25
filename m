Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42162C3641
	for <lists+linux-block@lfdr.de>; Wed, 25 Nov 2020 02:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgKYBcN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Nov 2020 20:32:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57569 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727534AbgKYBcN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 20:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606267932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33B9Bc8AL4A8pd4lTa4MRYTlvTr/1KxG8KKDCk2V4gA=;
        b=Hd1IXYSOnGvckomCJ7Dr2IFFHNy9IGdfYOqHT2QDuY+MmOksqFO7wRtcYr2UHw+1pfm18/
        Lgmh4JNtMejaCx0mRLqXa4+C2NVzaHvz5+l7+PZaosmaRt/T7pAxSpWchGFAlLxwhz5ASn
        Gge3mmX0rfJU3L/oWpwz1h3qKOcc4LQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55--xLtkNnqNWeUwypcmPt-PQ-1; Tue, 24 Nov 2020 20:32:06 -0500
X-MC-Unique: -xLtkNnqNWeUwypcmPt-PQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA73C805F01;
        Wed, 25 Nov 2020 01:32:04 +0000 (UTC)
Received: from T590 (ovpn-12-203.pek2.redhat.com [10.72.12.203])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74B3E5C1A1;
        Wed, 25 Nov 2020 01:31:51 +0000 (UTC)
Date:   Wed, 25 Nov 2020 09:31:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Qian Cai <cai@redhat.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 0/3] blk-mq/nvme-loop: use nvme-loop's lock class for
 addressing lockdep false positive warning
Message-ID: <20201125013147.GA8825@T590>
References: <20201112075526.947079-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112075526.947079-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 12, 2020 at 03:55:23PM +0800, Ming Lei wrote:
> Hi,
> 
> Qian reported there is hang during booting when shared host tagset is
> introduced on megaraid sas. Sumit reported the whole SCSI probe takes
> about ~45min in his test.
> 
> Turns out it is caused by nr_hw_queues increased, especially commit
> b3c6a5997541("block: Fix a lockdep complaint triggered by request queue flushing")
> adds synchronize_rcu() for each hctx's release handler.
> 
> Address the original lockdep false positive warning by simpler way, then
> long scsi probe can be avoided with lockdep enabled.
> 
> Ming Lei (3):
>   blk-mq: add new API of blk_mq_hctx_set_fq_lock_class
>   nvme-loop: use blk_mq_hctx_set_fq_lock_class to set loop's lock class
>   Revert "block: Fix a lockdep complaint triggered by request queue
>     flushing"
> 
>  block/blk-flush.c          | 30 +++++++++++++++++++++++++-----
>  block/blk.h                |  1 -
>  drivers/nvme/target/loop.c | 10 ++++++++++
>  include/linux/blk-mq.h     |  3 +++
>  4 files changed, 38 insertions(+), 6 deletions(-)
> 
> Cc: Qian Cai <cai@redhat.com>
> Cc: Sumit Saxena <sumit.saxena@broadcom.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.de>

Hello Jens,

Ping...


thanks,
Ming

