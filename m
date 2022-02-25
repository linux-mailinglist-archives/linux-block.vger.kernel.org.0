Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8A94C3EDC
	for <lists+linux-block@lfdr.de>; Fri, 25 Feb 2022 08:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiBYHSh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 25 Feb 2022 02:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiBYHSg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Feb 2022 02:18:36 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204B0239D5F;
        Thu, 24 Feb 2022 23:18:04 -0800 (PST)
Received: from kwepemi100026.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K4h0c6kkHzdZgJ;
        Fri, 25 Feb 2022 15:16:48 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100026.china.huawei.com (7.221.188.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 25 Feb 2022 15:18:01 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 15:18:01 +0800
Subject: Re: [PATCH v9] block: cancel all throttled bios in del_gendisk()
To:     <ming.lei@redhat.com>, <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220210115637.1074927-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <c000951a-b304-4663-4752-4a2cf8a4cbbb@huawei.com>
Date:   Fri, 25 Feb 2022 15:18:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220210115637.1074927-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

friendly ping ...

�� 2022/02/10 19:56, Yu Kuai д��:
> Throttled bios can't be issued after del_gendisk() is done, thus
> it's better to cancel them immediately rather than waiting for
> throttle is done.
> 
> For example, if user thread is throttled with low bps while it's
> issuing large io, and the device is deleted. The user thread will
> wait for a long time for io to return.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> Changes in v9:
>   - some minor changes as suggested by Ming.
> Changes in v8:
>   - fold two patches into one
> Changes in v7:
>   - use the new solution as suggested by Ming.
> 
>   block/blk-throttle.c | 44 +++++++++++++++++++++++++++++++++++++++++---
>   block/blk-throttle.h |  2 ++
>   block/genhd.c        |  2 ++
>   3 files changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 7c462c006b26..ca92e5fa2769 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -43,8 +43,12 @@
>   static struct workqueue_struct *kthrotld_workqueue;
>   
>   enum tg_state_flags {
> -	THROTL_TG_PENDING	= 1 << 0,	/* on parent's pending tree */
> -	THROTL_TG_WAS_EMPTY	= 1 << 1,	/* bio_lists[] became non-empty */
> +	/* on parent's pending tree */
> +	THROTL_TG_PENDING	= 1 << 0,
> +	/* bio_lists[] became non-empty */
> +	THROTL_TG_WAS_EMPTY	= 1 << 1,
> +	/* starts to cancel all bios, will be set if the disk is deleted */
> +	THROTL_TG_CANCELING	= 1 << 2,
>   };
>   
>   #define rb_entry_tg(node)	rb_entry((node), struct throtl_grp, rb_node)
> @@ -871,7 +875,8 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>   	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
>   
>   	/* If tg->bps = -1, then BW is unlimited */
> -	if (bps_limit == U64_MAX && iops_limit == UINT_MAX) {
> +	if ((bps_limit == U64_MAX && iops_limit == UINT_MAX) ||
> +	    tg->flags & THROTL_TG_CANCELING) {
>   		if (wait)
>   			*wait = 0;
>   		return true;
> @@ -1763,6 +1768,39 @@ static bool throtl_hierarchy_can_upgrade(struct throtl_grp *tg)
>   	return false;
>   }
>   
> +void blk_throtl_cancel_bios(struct request_queue *q)
> +{
> +	struct cgroup_subsys_state *pos_css;
> +	struct blkcg_gq *blkg;
> +
> +	spin_lock_irq(&q->queue_lock);
> +	/*
> +	 * queue_lock is held, rcu lock is not needed here technically.
> +	 * However, rcu lock is still held to emphasize that following
> +	 * path need RCU protection and to prevent warning from lockdep.
> +	 */
> +	rcu_read_lock();
> +	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg) {
> +		struct throtl_grp *tg = blkg_to_tg(blkg);
> +		struct throtl_service_queue *sq = &tg->service_queue;
> +
> +		/*
> +		 * Set the flag to make sure throtl_pending_timer_fn() won't
> +		 * stop until all throttled bios are dispatched.
> +		 */
> +		blkg_to_tg(blkg)->flags |= THROTL_TG_CANCELING;
> +		/*
> +		 * Update disptime after setting the above flag to make sure
> +		 * throtl_select_dispatch() won't exit without dispatching.
> +		 */
> +		tg_update_disptime(tg);
> +
> +		throtl_schedule_pending_timer(sq, jiffies + 1);
> +	}
> +	rcu_read_unlock();
> +	spin_unlock_irq(&q->queue_lock);
> +}
> +
>   static bool throtl_can_upgrade(struct throtl_data *td,
>   	struct throtl_grp *this_tg)
>   {
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index 175f03abd9e4..2ae467ac17ea 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -160,12 +160,14 @@ static inline void blk_throtl_exit(struct request_queue *q) { }
>   static inline void blk_throtl_register_queue(struct request_queue *q) { }
>   static inline void blk_throtl_charge_bio_split(struct bio *bio) { }
>   static inline bool blk_throtl_bio(struct bio *bio) { return false; }
> +static inline void blk_throtl_cancel_bios(struct request_queue *q) { }
>   #else /* CONFIG_BLK_DEV_THROTTLING */
>   int blk_throtl_init(struct request_queue *q);
>   void blk_throtl_exit(struct request_queue *q);
>   void blk_throtl_register_queue(struct request_queue *q);
>   void blk_throtl_charge_bio_split(struct bio *bio);
>   bool __blk_throtl_bio(struct bio *bio);
> +void blk_throtl_cancel_bios(struct request_queue *q);
>   static inline bool blk_throtl_bio(struct bio *bio)
>   {
>   	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
> diff --git a/block/genhd.c b/block/genhd.c
> index 9589d1d59afa..6acc98cd0365 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -29,6 +29,7 @@
>   #include "blk.h"
>   #include "blk-mq-sched.h"
>   #include "blk-rq-qos.h"
> +#include "blk-throttle.h"
>   
>   static struct kobject *block_depr;
>   
> @@ -625,6 +626,7 @@ void del_gendisk(struct gendisk *disk)
>   
>   	blk_mq_freeze_queue_wait(q);
>   
> +	blk_throtl_cancel_bios(disk->queue);
>   	rq_qos_exit(q);
>   	blk_sync_queue(q);
>   	blk_flush_integrity();
> 
