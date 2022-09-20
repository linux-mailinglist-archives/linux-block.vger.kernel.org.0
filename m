Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA825BDAC8
	for <lists+linux-block@lfdr.de>; Tue, 20 Sep 2022 05:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiITDSf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 19 Sep 2022 23:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiITDSd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2022 23:18:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7BEDEE9
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 20:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663643911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZRQYiuyCGykC8D6YZPLCsCJb0Ongwh2PqdcCpNTQTfw=;
        b=KiEmxQ5fehFzX4wRQTK/eew0kbtFa0Q1KWHWPBmMW9G1PW3AWV38C1ZrQqO9i1yX3P5Hjq
        lDK2Ah7ROTj9VrXdJz1IOQy8NnL64m1BkCBvac5N46RkCI1o4zsPdbB5xNE5/2dMJL/xhn
        qast48yUfNKOsNP2tI9AFV0XiB4NWkU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453--6tSXgzCNfWY77Q2RWDY1Q-1; Mon, 19 Sep 2022 23:18:28 -0400
X-MC-Unique: -6tSXgzCNfWY77Q2RWDY1Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B579801231;
        Tue, 20 Sep 2022 03:18:27 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A43D2166B26;
        Tue, 20 Sep 2022 03:18:22 +0000 (UTC)
Date:   Tue, 20 Sep 2022 11:18:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH V3 4/7] ublk_drv: requeue rqs with recovery feature
 enabled
Message-ID: <Yykw+NdXr/SX4yq4@T590>
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
 <20220913041707.197334-5-ZiyangZhang@linux.alibaba.com>
 <YyfoQuw18kOynxcC@T590>
 <ff61718d-da2d-f754-5e56-b58a3e57820f@linux.alibaba.com>
 <Yyhi/kavaq1aLAQY@T590>
 <84b99294-6859-f49f-d529-c6e3899f2aa2@linux.alibaba.com>
 <Yykn7q/T9CUzZpxH@T590>
 <5383bd34-4f61-f3b0-0a75-a8a2eb75d7ef@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5383bd34-4f61-f3b0-0a75-a8a2eb75d7ef@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 20, 2022 at 11:04:30AM +0800, Ziyang Zhang wrote:
> On 2022/9/20 10:39, Ming Lei wrote:
> > On Tue, Sep 20, 2022 at 09:31:54AM +0800, Ziyang Zhang wrote:
> >> On 2022/9/19 20:39, Ming Lei wrote:
> >>> On Mon, Sep 19, 2022 at 05:12:21PM +0800, Ziyang Zhang wrote:
> >>>> On 2022/9/19 11:55, Ming Lei wrote:
> >>>>> On Tue, Sep 13, 2022 at 12:17:04PM +0800, ZiyangZhang wrote:
> >>>>>> With recovery feature enabled, in ublk_queue_rq or task work
> >>>>>> (in exit_task_work or fallback wq), we requeue rqs instead of
> >>>>>> ending(aborting) them. Besides, No matter recovery feature is enabled
> >>>>>> or disabled, we schedule monitor_work immediately.
> >>>>>>
> >>>>>> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> >>>>>> ---
> >>>>>>  drivers/block/ublk_drv.c | 34 ++++++++++++++++++++++++++++++++--
> >>>>>>  1 file changed, 32 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> >>>>>> index 23337bd7c105..b067f33a1913 100644
> >>>>>> --- a/drivers/block/ublk_drv.c
> >>>>>> +++ b/drivers/block/ublk_drv.c
> >>>>>> @@ -682,6 +682,21 @@ static void ubq_complete_io_cmd(struct ublk_io *io, int res)
> >>>>>>  
> >>>>>>  #define UBLK_REQUEUE_DELAY_MS	3
> >>>>>>  
> >>>>>> +static inline void __ublk_abort_rq_in_task_work(struct ublk_queue *ubq,
> >>>>>> +		struct request *rq)
> >>>>>> +{
> >>>>>> +	pr_devel("%s: %s q_id %d tag %d io_flags %x.\n", __func__,
> >>>>>> +			(ublk_queue_can_use_recovery(ubq)) ? "requeue" : "abort",
> >>>>>> +			ubq->q_id, rq->tag, ubq->ios[rq->tag].flags);
> >>>>>> +	/* We cannot process this rq so just requeue it. */
> >>>>>> +	if (ublk_queue_can_use_recovery(ubq)) {
> >>>>>> +		blk_mq_requeue_request(rq, false);
> >>>>>> +		blk_mq_delay_kick_requeue_list(rq->q, UBLK_REQUEUE_DELAY_MS);
> >>>>>
> >>>>> Here you needn't to kick requeue list since we know it can't make
> >>>>> progress. And you can do that once before deleting gendisk
> >>>>> or the queue is recovered.
> >>>>
> >>>> No, kicking rq here is necessary.
> >>>>
> >>>> Consider USER_RECOVERY is enabled and everything goes well.
> >>>> User sends STOP_DEV, and we have kicked requeue list in
> >>>> ublk_stop_dev() and are going to call del_gendisk().
> >>>> However, a crash happens now. Then rqs may be still requeued
> >>>> by ublk_queue_rq() because ublk_queue_rq() sees a dying
> >>>> ubq_daemon. So del_gendisk() will hang because there are
> >>>> rqs leaving in requeue list and no one kicks them.
> >>>
> >>> Why can't you kick requeue list before calling del_gendisk().
> >>
> >> Yes, we can kick requeue list once before calling del_gendisk().
> >> But a crash may happen just after kicking but before del_gendisk().
> >> So some rqs may be requeued at this moment. But we have already
> >> kicked the requeue list! Then del_gendisk() will hang, right?
> > 
> > ->force_abort is set before kicking in ublk_unquiesce_dev(), so
> > all new requests are failed immediately instead of being requeued,
> > right?
> > 
> 
> ->force_abort is not heplful here because there may be fallback wq running
> which can requeue rqs after kicking requeue list.

After ublk_wait_tagset_rqs_idle() returns, there can't be any
pending requests in fallback wq or task work, can there?

Please look at the 2nd point of the comment log, and I did ask you
to add the words for fallback wq and task work.

> 
> In ublk_unquiesce_dev(), I simply disable recovery feature
> if ub's state is UBLK_S_DEV_LIVE while stopping ublk_dev.

monitor work will provide forward progress in case of not applying
user recovery.

> 
> Note: We can make sure fallback wq does not run if we wait until all rqs with
> ACTIVE flag set are requeued. This is done in quiesce_work(). But it cannot
> run while ublk_stop_dev() is running...
 
Please take a look at the delta patch I just sent, which is supposed to be
simpler for addressing this corner case.


Thanks,
Ming

