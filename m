Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA438783F
	for <lists+linux-block@lfdr.de>; Tue, 18 May 2021 14:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhERMB4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 18 May 2021 08:01:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28342 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233847AbhERMBz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 08:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621339236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iWpqtJ5ftN3E+Jb7OhYS0JQzk1CqeAIBtYSYyEieDas=;
        b=aUcxDVUmRJpRT0q7d24roj4+brY5BsMjkzbzTUaZbf5PmJzIW77rnFtgn9of9jaO1Dx2ar
        /iDx7aQdtizHfRAWXdO5N1anjbl0fnfd/Y/287KcbWQmJTN2Wf7t4Htq1E64rhX74Cak5w
        XR73sCdyX2QVmvX1hopc219IiQg5dPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-5z6l8Sk4NRSnN1-PiuG9cg-1; Tue, 18 May 2021 08:00:34 -0400
X-MC-Unique: 5z6l8Sk4NRSnN1-PiuG9cg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C15F80006E;
        Tue, 18 May 2021 12:00:33 +0000 (UTC)
Received: from T590 (ovpn-13-48.pek2.redhat.com [10.72.13.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE79D5C1C5;
        Tue, 18 May 2021 12:00:07 +0000 (UTC)
Date:   Tue, 18 May 2021 20:00:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Yanhui Ma <yama@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, chenxiang <chenxiang66@hisilicon.com>
Subject: Re: [PATCH] blk-mq: plug request for shared sbitmap
Message-ID: <YKOsQ4StDThlbMko@T590>
References: <20210514022052.1047665-1-ming.lei@redhat.com>
 <b38d671a-530b-244a-bc0f-0b926c796243@huawei.com>
 <YKOiClSTyHl5lbXV@T590>
 <185d1d58-f4e3-2024-e5e4-0831af151e3d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <185d1d58-f4e3-2024-e5e4-0831af151e3d@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 18, 2021 at 12:42:22PM +0100, John Garry wrote:
> On 18/05/2021 12:16, Ming Lei wrote:
> > On Tue, May 18, 2021 at 10:44:43AM +0100, John Garry wrote:
> > > On 14/05/2021 03:20, Ming Lei wrote:
> > > > In case of shared sbitmap, request won't be held in plug list any more
> > > > sine commit 32bc15afed04 ("blk-mq: Facilitate a shared sbitmap per
> > > > tagset"), this way makes request merge from flush plug list & batching
> > > > submission not possible, so cause performance regression.
> > > > 
> > > > Yanhui reports performance regression when running sequential IO
> > > > test(libaio, 16 jobs, 8 depth for each job) in VM, and the VM disk
> > > > is emulated with image stored on xfs/megaraid_sas.
> > > > 
> > > > Fix the issue by recovering original behavior to allow to hold request
> > > > in plug list.
> > > 
> > > Hi Ming,
> > > 
> > > Since testing v5.13-rc2, I noticed that this patch made the hang I was
> > > seeing disappear:
> > > https://lore.kernel.org/linux-scsi/3d72d64d-314f-9d34-e039-7e508b2abe1b@huawei.com/
> > > 
> > > I don't think that problem is solved, though.
> > 
> > This kind of hang or lockup is usually related with cpu utilization, and
> > this patch may reduce cpu utilization in submission context.
> 
> Right.
> 
> > 
> > > 
> > > So I wonder about throughput performance (I had hoped to test before it was
> > > merged). I only have 6x SAS SSDs at hand, but I see some significant changes
> > > (good and bad) for mq-deadline for hisi_sas:
> > > Before 620K (read), 300K IOPs (randread)
> > > After 430K (read), 460-490K IOPs (randread)
> > 
> > 'Before 620K' could be caused by busy queue when batching submission isn't
> > applied, so merge chance is increased. This patch applies batching
> > submission, so queue becomes not busy enough.
> > 
> > BTW, what is the queue depth of sdev and can_queue of shost for your hisilision SAS?
> 
> sdev queue depth is 64 (see hisi_sas_slave_configure()) and host depth is
> 4096 - 96 (for reserved tags) = 4000

OK, so queue depth should get IO merged if there are too many requests
queued.

What is the same read test result without shared tags? still 430K?
And what is your exact read test script? And how many cpu cores in
your system?


Thanks,
Ming

