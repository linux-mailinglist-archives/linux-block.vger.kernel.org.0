Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19F360D026
	for <lists+linux-block@lfdr.de>; Tue, 25 Oct 2022 17:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiJYPSY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 Oct 2022 11:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiJYPSV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 11:18:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFED118A011
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 08:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666711098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SalK5HqIzIuDrgqVVvgdYalFARNvvvxgWAStj3syN8o=;
        b=covnTk00ok7mACfe1WrVcL/NBTBhRnE9/w/ZX4pfFzlH0ltCUpUMQct2To4siEcrTIlCma
        /aUBOl+s6I4tA4m9J2j+dvmKI/S1I7BhONUN0t8GlD5VprFUJVmxzMUJWICNrrQl6Ijdl1
        4YFtKA/TmuPkKYZZHMnnDppjKDfHXUg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-PbpooGWqNdq9aWpT3psjsg-1; Tue, 25 Oct 2022 11:18:17 -0400
X-MC-Unique: PbpooGWqNdq9aWpT3psjsg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D5FD3C0F456;
        Tue, 25 Oct 2022 15:18:10 +0000 (UTC)
Received: from T590 (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF7C3202903F;
        Tue, 25 Oct 2022 15:17:59 +0000 (UTC)
Date:   Tue, 25 Oct 2022 23:17:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] ublk_drv: don't call task_work_add for queueing io
 commands
Message-ID: <Y1f+IeFQZhZRmZda@T590>
References: <20221023093807.201946-1-ming.lei@redhat.com>
 <8a225315-3932-62a6-2bc6-8e81e672fd9d@linux.alibaba.com>
 <Y1aRBaUWGH54TTs4@T590>
 <1816adbd-fa1c-71e0-652d-483d47697254@linux.alibaba.com>
 <Y1eN7VqaJrCVJZjb@T590>
 <1ab57612-685a-6272-5d09-bfae47b4a37e@linux.alibaba.com>
 <925c299f-0d2f-2970-9c85-2f67834dd2bf@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <925c299f-0d2f-2970-9c85-2f67834dd2bf@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 25, 2022 at 04:43:56PM +0800, Ziyang Zhang wrote:
> On 2022/10/25 15:46, Ziyang Zhang wrote:
> > On 2022/10/25 15:19, Ming Lei wrote:
> >> On Tue, Oct 25, 2022 at 11:15:57AM +0800, Ziyang Zhang wrote:
> >>> On 2022/10/24 21:20, Ming Lei wrote:
> >>>> Hello Ziyang,
> >>>>
> >>>> On Mon, Oct 24, 2022 at 05:48:51PM +0800, Ziyang Zhang wrote:
> >>>>> On 2022/10/23 17:38, Ming Lei wrote:
> >>>>>> task_work_add() is used for waking ubq daemon task with one batch
> >>>>>> of io requests/commands queued. However, task_work_add() isn't
> >>>>>> exported for module code, and it is still debatable if the symbol
> >>>>>> should be exported.
> >>>>>>
> >>>>>> Fortunately we still have io_uring_cmd_complete_in_task() which just
> >>>>>> can't handle batched wakeup for us.
> >>>>>>
> >>>>>> Add one one llist into ublk_queue and call io_uring_cmd_complete_in_task()
> >>>>>> via current command for running them via task work.
> >>>>>>
> >>>>>> This way cleans up current code a lot, meantime allow us to wakeup
> >>>>>> ubq daemon task after queueing batched requests/io commands.
> >>>>>>
> >>>>>
> >>>>>
> >>>>> Hi, Ming
> >>>>>
> >>>>> This patch works and I have run some tests to compare current version(ucmd)
> >>>>> with your patch(ucmd-batch).
> >>>>>
> >>>>> iodepth=128 numjobs=1 direct=1 bs=4k
> >>>>>
> >>>>> --------------------------------------------
> >>>>> ublk loop target, the backend is a file.
> >>>>> IOPS(k)
> >>>>>
> >>>>> type		ucmd		ucmd-batch
> >>>>> seq-read	54.7		54.2	
> >>>>> rand-read	52.8		52.0
> >>>>>
> >>>>> --------------------------------------------
> >>>>> ublk null target
> >>>>> IOPS(k)
> >>>>>
> >>>>> type		ucmd		ucmd-batch
> >>>>> seq-read	257		257
> >>>>> rand-read	252		253
> >>>>>
> >>>>>
> >>>>> I find that io_req_task_work_add() puts task_work node into a llist
> >>>>> first, then it may call task_work_add() to run batched task_works. So do we really
> >>>>> need such llist in ublk_drv? I think io_uring has already considered task_work batch
> >>>>> optimization.
> >>>>>
> >>>>> BTW, task_work_add() in ublk_drv achieves
> >>>>> higher IOPS(about 5-10% on my machine) than io_uring_cmd_complete_in_task()
> >>>>> in ublk_drv.
> >>>>
> >>>> Yeah, that is same with my observation, and motivation of this patch is
> >>>> to get same performance with task_work_add by building ublk_drv as
> >>>> module. One win of task_work_add() is that we get exact batching info
> >>>> meantime only send TWA_SIGNAL_NO_IPI for whole batch, that is basically
> >>>> what the patch is doing, but needs help of the following ublksrv patch:
> >>>>
> >>>> https://github.com/ming1/ubdsrv/commit/dce6d1d222023c1641292713b311ced01e6dc548
> >>>>
> >>>> which sets IORING_SETUP_COOP_TASKRUN for ublksrv's uring, then
> >>>> io_uring_cmd_complete_in_task will notify via TWA_SIGNAL_NO_IPI, and 5+%
> >>>> IOPS boost is observed on loop/001 by putting image on SSD in my test
> >>>> VM.
> >>>
> >>> Hi Ming,
> >>>
> >>> I have added this ublksrv patch and run the above test again.
> >>> I have also run ublksrv test: loop/001. Please check them.
> >>>
> >>> Intel(R) Xeon(R) Platinum 8369B CPU @ 2.70GHz 16 cores
> >>> 64GB MEM, CentOS 8, kernel 6.0+
> >>>
> >>> --------
> >>> fio test
> >>>
> >>> iodepth=128 numjobs=1 direct=1 bs=4k
> >>>
> >>> ucmd: without your kernel patch. Run io_uring_cmd_complete_in_task()
> >>> for each blk-mq rq.
> >>>
> >>> ucmd-batch: with your kernel patch. Run io_uring_cmd_complete_in_task()
> >>> for the last blk-mq rq.
> >>>
> >>> --------------------------------------------
> >>> ublk loop target, the backend is a file.
> >>>
> >>> IOPS(k)
> >>>
> >>> type		ucmd		ucmd-batch
> >>> seq-read	54.1		53.7
> >>> rand-read	52.0		52.0
> >>>
> >>> --------------------------------------------
> >>> ublk null target
> >>> IOPS(k)
> >>>
> >>> type		ucmd		ucmd-batch
> >>> seq-read	272		265
> >>> rand-read	262		260
> >>>
> >>> ------------
> >>> ublksrv test
> >>>
> >>> -------------
> >>> ucmd
> >>>
> >>> running loop/001
> >>>         fio (ublk/loop( -f /root/work/ubdsrv/tests/tmp/ublk_loop_1G_BZ85U), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
> >>>         randwrite: jobs 1, iops 66737
> >>>         randread: jobs 1, iops 64935
> >>>         randrw: jobs 1, iops read 32694 write 32710
> >>>         rw(512k): jobs 1, iops read 772 write 819
> >>>
> >>> -------------
> >>> ucmd-batch
> >>>
> >>> running loop/001
> >>>         fio (ublk/loop( -f /root/work/ubdsrv/tests/tmp/ublk_loop_1G_F56a3), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
> >>>         randwrite: jobs 1, iops 66720
> >>>         randread: jobs 1, iops 65015
> >>>         randrw: jobs 1, iops read 32743 write 32759
> >>>         rw(512k): jobs 1, iops read 771 write 817
> >>>
> >>>
> >>> It seems that manually putting rqs into llist and calling
> >>> io_uring_cmd_complete_in_task() while handling the last rq does
> >>> not improve IOPS much.
> >>>
> >>> io_req_task_work_add() puts task_work node into a internal llist
> >>> first, then it may call task_work_add() to run batched task_works.
> >>> IMO, io_uring has already done such batch optimization and ublk_drv
> >>> does not need to add such llist.
> >>
> >> The difference is just how batching is handled, looks blk-mq's batch info
> >> doesn't matter any more. In my test, looks the perf improvement is mainly
> >> made by enabling IORING_SETUP_COOP_TASKRUN in ublksrv.
> > 
> > I guess only IORING_SETUP_COOP_TASKRUN helps improve IOPS. The llist in
> > ublk_drv does not improve IOPS.
> > 
> >>
> >> Can you check if enabling IORING_SETUP_COOP_TASKRUN only can reach
> >> same perf with task_work_add()(ublk_drv is builtin) when building
> >> ublk_drv as module?
> >>
> > 
> > OK.
> > 
> 
> Intel(R) Xeon(R) Platinum 8369B CPU @ 2.70GHz 16 cores
> 64GB MEM, CentOS 8, kernel 6.0+
> with IORING_SETUP_COOP_TASKRUN, without this kernel patch
> 
> ucmd: io_uring_cmd_complete_in_task(), ublk_drv is a module
> tw: task_work_add(), ublk is built-in.
> 
> 
> --------
> fio test
> 
> iodepth=128 numjobs=1 direct=1 bs=4k
> 
> --------------------------------------------
> ublk loop target, the backend is a file.
> 
> IOPS(k)
> 
> type		ucmd		tw
> seq-read	54.1		53.8
> rand-read	52.0		52.0
> 
> --------------------------------------------
> ublk null target
> IOPS(k)
> 
> type		ucmd		tw
> seq-read	272		286
> rand-read	262		278
> 
> 
> ------------
> ublksrv test
> 
> -------------
> ucmd
> 
> running loop/001
>         fio (ublk/loop( -f /root/work/ubdsrv/tests/tmp/ublk_loop_1G_BZ85U), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
>         randwrite: jobs 1, iops 66737
>         randread: jobs 1, iops 64935
>         randrw: jobs 1, iops read 32694 write 32710
>         rw(512k): jobs 1, iops read 772 write 819
> 
> running null/001
>         fio (ublk/null(), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
>         randwrite: jobs 1, iops 715863
>         randread: jobs 1, iops 758449
>         randrw: jobs 1, iops read 357407 write 357183
>         rw(512k): jobs 1, iops read 5895 write 5875
> 
> -------------
> tw
> 
> running loop/001
>         fio (ublk/loop( -f /root/work/ubdsrv/tests/tmp/ublk_loop_1G_pvLTL), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
>         randwrite: jobs 1, iops 66856
>         randread: jobs 1, iops 65015
>         randrw: jobs 1, iops read 32751 write 32767
>         rw(512k): jobs 1, iops read 776 write 823
> 
> running null/001
>         fio (ublk/null(), libaio, bs 4k, dio, hw queues:1, uring_comp: 0, get_data: 0)...
>         randwrite: jobs 1, iops 739450
>         randread: jobs 1, iops 787500
>         randrw: jobs 1, iops read 372956 write 372831
>         rw(512k): jobs 1, iops read 5798 write 5777

Looks the gap isn't big between ucmd and tw when running null/001, in
which the fio io process should saturate the CPU. Probably we
should avoid to touch 'cmd'/'pdu'/'io' in ublk_queue_rq() since these
data should be cold at that time.

Can you apply the following delta patch against the current patch(
"ublk_drv: don't call task_work_add for queueing io commands") and
compare with task_work_add()?

From ecbbf6d10dbc63e279ce0b55c45da6721947f18d Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 25 Oct 2022 11:01:25 -0400
Subject: [PATCH] ublk: follow up change

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 7963fba66dd1..18db337094c1 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -56,9 +56,12 @@
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
 
+struct ublk_rq_data {
+	struct llist_node node;
+};
+
 struct ublk_uring_cmd_pdu {
 	struct request *req;
-	struct llist_node node;
 };
 
 /*
@@ -693,7 +696,8 @@ static inline void __ublk_rq_task_work(struct request *req)
 	 *
 	 * (2) current->flags & PF_EXITING.
 	 */
-	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
+	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING
+				|| (io->flags & UBLK_IO_FLAG_ABORTED))) {
 		__ublk_abort_rq(ubq, req);
 		return;
 	}
@@ -757,11 +761,12 @@ static void ublk_rqs_task_work_cb(struct io_uring_cmd *cmd)
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->req->mq_hctx->driver_data;
 	struct llist_node *io_cmds = llist_del_all(&ubq->io_cmds);
+	struct ublk_rq_data *data;
 
 	__ublk_rq_task_work(pdu->req);
 
-	llist_for_each_entry(pdu, io_cmds, node)
-		__ublk_rq_task_work(pdu->req);
+	llist_for_each_entry(data, io_cmds, node)
+		__ublk_rq_task_work(blk_mq_rq_from_pdu(data));
 }
 
 static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
@@ -769,9 +774,6 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 {
 	struct ublk_queue *ubq = hctx->driver_data;
 	struct request *rq = bd->rq;
-	struct ublk_io *io = &ubq->ios[rq->tag];
-	struct io_uring_cmd *cmd = io->cmd;
-	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	blk_status_t res;
 
 	/* fill iod to slot in io cmd buffer */
@@ -805,14 +807,11 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * Since releasing/allocating a tag implies smp_mb(), finding UBLK_IO_FLAG_ABORTED
 	 * guarantees that here is a re-issued request aborted previously.
 	 */
-	if (unlikely(ubq_daemon_is_dying(ubq) ||
-				(io->flags & UBLK_IO_FLAG_ABORTED))) {
+	if (unlikely(ubq_daemon_is_dying(ubq))) {
 		__ublk_abort_rq(ubq, rq);
 		return BLK_STS_OK;
 	}
 
-	pdu->req = rq;
-
 	/*
 	 * Typical multiple producers and single consumer, it is just fine
 	 * to use llist_add() in producer side and llist_del_all() in
@@ -821,10 +820,18 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * The last command can't be added into list, otherwise it could
 	 * be handled twice
 	 */
-	if (bd->last)
+	if (bd->last) {
+		struct ublk_io *io = &ubq->ios[rq->tag];
+		struct io_uring_cmd *cmd = io->cmd;
+		struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+
+		pdu->req = rq;
 		io_uring_cmd_complete_in_task(cmd, ublk_rqs_task_work_cb);
-	else
-		llist_add(&pdu->node, &ubq->io_cmds);
+	} else {
+		struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
+
+		llist_add(&data->node, &ubq->io_cmds);
+	}
 
 	return BLK_STS_OK;
 }
@@ -1426,6 +1433,7 @@ static int ublk_add_tag_set(struct ublk_device *ub)
 	ub->tag_set.queue_depth = ub->dev_info.queue_depth;
 	ub->tag_set.numa_node = NUMA_NO_NODE;
 	ub->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	ub->tag_set.cmd_size = sizeof(struct ublk_rq_data);
 	ub->tag_set.driver_data = ub;
 	return blk_mq_alloc_tag_set(&ub->tag_set);
 }
-- 
2.31.1


Thanks,
Ming

