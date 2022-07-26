Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E9B5809B9
	for <lists+linux-block@lfdr.de>; Tue, 26 Jul 2022 05:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiGZDCe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 25 Jul 2022 23:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiGZDCd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 23:02:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BE87237EF
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 20:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658804552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+kO55hJ2pJtKBLKCqCLTsTPKYDpFdRYtz8Ix6mx8SSE=;
        b=Wqh+Q0dqNa0ks3Uvg+EB6JvTgHMnsSJW8F5Lgis0Dofqlp9FJW1DiD9TxJSWOshecNABH8
        dwnxvaesyJpY5/zcDMtzKugRoFJKJOdaGtL430Jg4cU8MsyhRUTIyXRkNHee9hQBDhJRMf
        wJGS/hla7a3DSnnZ4ZA7KhKz/gWy22Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-4vpsDBl0Nk-NO8SQJd5nSQ-1; Mon, 25 Jul 2022 23:02:29 -0400
X-MC-Unique: 4vpsDBl0Nk-NO8SQJd5nSQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69BD985A581;
        Tue, 26 Jul 2022 03:02:28 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 039102026985;
        Tue, 26 Jul 2022 03:02:21 +0000 (UTC)
Date:   Tue, 26 Jul 2022 11:02:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, Yufen Yu <yuyufen@huawei.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de,
        "zhangyi (F)" <yi.zhang@huawei.com>
Subject: Re: [PATCH] blk-mq: run queue after issuing the last request of the
 plug list
Message-ID: <Yt9ZOFtzm9kfKWhc@T590>
References: <20220718123528.178714-1-yuyufen@huawei.com>
 <YtZ4uSRqR/kLdqm+@T590>
 <0baa5b04-7194-54fa-08a5-51425601343e@huaweicloud.com>
 <Yt66HebQ9//2ahq6@T590>
 <ab899ae0-91fc-48db-cc32-fdc57f61963a@huawei.com>
 <Yt9HkP2mzH0ZTL1l@T590>
 <ba2b30f2-66d9-3acb-787d-fae1894fa5a6@huawei.com>
 <Yt9SMuSlCtwwzyEz@T590>
 <f91f136c-f109-3027-a666-29fe882d3426@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f91f136c-f109-3027-a666-29fe882d3426@huawei.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 26, 2022 at 10:52:56AM +0800, Yu Kuai wrote:
> Hi, Ming
> 在 2022/07/26 10:32, Ming Lei 写道:
> > On Tue, Jul 26, 2022 at 10:08:13AM +0800, Yu Kuai wrote:
> > > 在 2022/07/26 9:46, Ming Lei 写道:
> > > > On Tue, Jul 26, 2022 at 09:08:19AM +0800, Yu Kuai wrote:
> > > > > Hi, Ming!
> > > > > 
> > > > > 在 2022/07/25 23:43, Ming Lei 写道:
> > > > > > On Sat, Jul 23, 2022 at 10:50:03AM +0800, Yu Kuai wrote:
> > > > > > > Hi, Ming!
> > > > > > > 
> > > > > > > 在 2022/07/19 17:26, Ming Lei 写道:
> > > > > > > > On Mon, Jul 18, 2022 at 08:35:28PM +0800, Yufen Yu wrote:
> > > > > > > > > We do test on a virtio scsi device (/dev/sda) and the default mq
> > > > > > > > > scheduler is 'none'. We found a IO hung as following:
> > > > > > > > > 
> > > > > > > > > blk_finish_plug
> > > > > > > > >       blk_mq_plug_issue_direct
> > > > > > > > >           scsi_mq_get_budget
> > > > > > > > >           //get budget_token fail and sdev->restarts=1
> > > > > > > > > 
> > > > > > > > > 			     	 scsi_end_request
> > > > > > > > > 				   scsi_run_queue_async
> > > > > > > > >                                        //sdev->restart=0 and run queue
> > > > > > > > > 
> > > > > > > > >          blk_mq_request_bypass_insert
> > > > > > > > >             //add request to hctx->dispatch list
> > > > > > > > 
> > > > > > > > Here the issue shouldn't be related with scsi's get budget or
> > > > > > > > scsi_run_queue_async.
> > > > > > > > 
> > > > > > > > If blk-mq adds request into ->dispatch_list, it is blk-mq core's
> > > > > > > > responsibility to re-run queue for moving on. Can you investigate a
> > > > > > > > bit more why blk-mq doesn't run queue after adding request to
> > > > > > > > hctx dispatch list?
> > > > > > > 
> > > > > > > I think Yufen is probably thinking about the following Concurrent
> > > > > > > scenario:
> > > > > > > 
> > > > > > > blk_mq_flush_plug_list
> > > > > > > # assume there are three rq
> > > > > > >     blk_mq_plug_issue_direct
> > > > > > >      blk_mq_request_issue_directly
> > > > > > >      # dispatch rq1, succeed
> > > > > > >      blk_mq_request_issue_directly
> > > > > > >      # dispatch rq2
> > > > > > >       __blk_mq_try_issue_directly
> > > > > > >        blk_mq_get_dispatch_budget
> > > > > > >         scsi_mq_get_budget
> > > > > > >          atomic_inc(&sdev->restarts);
> > > > > > >          # rq2 failed to get budget
> > > > > > >          # restarts is 1 now
> > > > > > >                                            scsi_end_request
> > > > > > >                                            # rq1 is completed
> > > > > > >                                            ┊scsi_run_queue_async
> > > > > > >                                            ┊ atomic_cmpxchg(&sdev->restarts,
> > > > > > > old, 0) == old
> > > > > > >                                            ┊ # set restarts to 0
> > > > > > >                                            ┊ blk_mq_run_hw_queues
> > > > > > >                                            ┊ # hctx->dispatch list is empty
> > > > > > >      blk_mq_request_bypass_insert
> > > > > > >      # insert rq2 to hctx->dispatch list
> > > > > > 
> > > > > > After rq2 is added to ->dispatch_list in blk_mq_try_issue_list_directly(),
> > > > > > no matter if list_empty(list) is empty or not, queue will be run either from
> > > > > > blk_mq_request_bypass_insert() or blk_mq_sched_insert_requests().
> > > > > 
> > > > > 1) while inserting rq2 to dispatch list, blk_mq_request_bypass_insert()
> > > > > is called from blk_mq_try_issue_list_directly(), list_empty() won't
> > > > > pass, thus thus blk_mq_request_bypass_insert() won't run queue.
> > > > 
> > > > Yeah, but in blk_mq_try_issue_list_directly() after rq2 is inserted to dispatch
> > > > list, the loop is broken and blk_mq_try_issue_list_directly() returns to
> > > > blk_mq_sched_insert_requests() in which list_empty() is false, so
> > > > blk_mq_insert_requests() and blk_mq_run_hw_queue() are called, queue
> > > > is still run.
> > > > 
> > > > Also not sure why you make rq3 involved, since the list is local list on
> > > > stack, and it can be operated concurrently.
> > > 
> > > I make rq3 involved because there are some conditions that
> > > blk_mq_insert_requests() and blk_mq_run_hw_queue() won't be called from
> > > blk_mq_sched_insert_requests():
> > 
> > The two won't be called if list_empty() is true, and will be called if
> > !list_empty().
> > 
> > That is why I mentioned run queue has been done after rq2 is added to
> > ->dispatch_list.
> 
> I don't follow here, it's right after rq2 is inserted to dispatch list,
> list is not empty, and blk_mq_sched_insert_requests() will be called.
> However, do you think that it's impossible that
> blk_mq_sched_insert_requests() can dispatch rq in the list and list
> will become empty?

Please take a look at blk_mq_sched_insert_requests().

When codes runs into blk_mq_sched_insert_requests(), the following
blk_mq_run_hw_queue() will be run always, how does list empty or not
make a difference there?

In short, after rq2 is added into ->dispatch, the queue is guaranteed
to run, the handling logic isn't wrong. That said that the reported
hang isn't root caused yet, is it?


Thanks,
Ming

