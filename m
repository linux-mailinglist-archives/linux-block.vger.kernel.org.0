Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1E441A750
	for <lists+linux-block@lfdr.de>; Tue, 28 Sep 2021 07:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbhI1Fzk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Sep 2021 01:55:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49920 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbhI1Fzh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 01:55:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 68EA52214C;
        Tue, 28 Sep 2021 05:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632808437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Br49sDKoln9XyJZlf9dVpU39YnQJZGztoIGwhIPeCyI=;
        b=Uz9EN/3YMG/LJ3GYBeJeTqpZ51NsuzE7ZvCWQ3iwT2f1vjgmTHz8zpL3de4hmfRnCIHZBK
        SFqZB51/gFkhJrPnne0dYIhJzDLPbDpCf4a67EzTwNoDt3dipg+aWbIpasINH6sQx6lPUd
        1IPvls5cNtkuq/7kYHKMu7M50A786qM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632808437;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Br49sDKoln9XyJZlf9dVpU39YnQJZGztoIGwhIPeCyI=;
        b=c8SsMtV8hMxTKSgtba9gx+9vnSr+d+2DenvBfQxwnhPnhBqmv1skHJQiRQw0LjmLouUGUy
        43ntlEubfc31qGCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CA3213A98;
        Tue, 28 Sep 2021 05:53:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jYbhEfWtUmGDOwAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 28 Sep 2021 05:53:57 +0000
Subject: Re: [PATCH v2 4/4] block/mq-deadline: Prioritize high-priority
 requests
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20210927220328.1410161-1-bvanassche@acm.org>
 <20210927220328.1410161-5-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <8e6140f8-adf5-0f4d-0e50-bd0b876ac805@suse.de>
Date:   Tue, 28 Sep 2021 07:53:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210927220328.1410161-5-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/28/21 12:03 AM, Bart Van Assche wrote:
> In addition to reverting commit 7b05bf771084 ("Revert "block/mq-deadline:
> Prioritize high-priority requests""), this patch uses 'jiffies' instead
> of ktime_get() in the code for aging lower priority requests.
> 
> This patch has been tested as follows:
> 
> Measured QD=1/jobs=1 IOPS for nullb with the mq-deadline scheduler.
> Result without and with this patch: 555 K IOPS.
> 
> Measured QD=1/jobs=8 IOPS for nullb with the mq-deadline scheduler.
> Result without and with this patch: about 380 K IOPS.
> 
> Ran the following script:
> 
> set -e
> scriptdir=$(dirname "$0")
> if [ -e /sys/module/scsi_debug ]; then modprobe -r scsi_debug; fi
> modprobe scsi_debug ndelay=1000000 max_queue=16
> sd=''
> while [ -z "$sd" ]; do
>    sd=$(basename /sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block/*)
> done
> echo $((100*1000)) > "/sys/block/$sd/queue/iosched/prio_aging_expire"
> if [ -e /sys/fs/cgroup/io.prio.class ]; then
>    cd /sys/fs/cgroup
>    echo restrict-to-be >io.prio.class
>    echo +io > cgroup.subtree_control
> else
>    cd /sys/fs/cgroup/blkio/
>    echo restrict-to-be >blkio.prio.class
> fi
> echo $$ >cgroup.procs
> mkdir -p hipri
> cd hipri
> if [ -e io.prio.class ]; then
>    echo none-to-rt >io.prio.class
> else
>    echo none-to-rt >blkio.prio.class
> fi
> { "${scriptdir}/max-iops" -a1 -d32 -j1 -e mq-deadline "/dev/$sd" >& ~/low-pri.txt & }
> echo $$ >cgroup.procs
> "${scriptdir}/max-iops" -a1 -d32 -j1 -e mq-deadline "/dev/$sd" >& ~/hi-pri.txt
> 
> Result:
> * 11000 IOPS for the high-priority job
> *    40 IOPS for the low-priority job
> 
> If the prio aging expiry time is changed from 100s into 0, the IOPS results
> change into 6712 and 6796 IOPS.
> 
> The max-iops script is a script that runs fio with the following arguments:
> --bs=4K --gtod_reduce=1 --ioengine=libaio --ioscheduler=${arg_e} --runtime=60
> --norandommap --rw=read --thread --buffered=0 --numjobs=${arg_j}
> --iodepth=${arg_d} --iodepth_batch_submit=${arg_a}
> --iodepth_batch_complete=$((arg_d / 2)) --name=${positional_argument_1}
> --filename=${positional_argument_1}
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 77 ++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 73 insertions(+), 4 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index b262f40f32c0..bb723478baf1 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -31,6 +31,11 @@
>    */
>   static const int read_expire = HZ / 2;  /* max time before a read is submitted. */
>   static const int write_expire = 5 * HZ; /* ditto for writes, these limits are SOFT! */
> +/*
> + * Time after which to dispatch lower priority requests even if higher
> + * priority requests are pending.
> + */
> +static const int prio_aging_expire = 10 * HZ;
>   static const int writes_starved = 2;    /* max times reads can starve a write */
>   static const int fifo_batch = 16;       /* # of sequential requests treated as one
>   				     by the above parameters. For throughput. */
> @@ -96,6 +101,7 @@ struct deadline_data {
>   	int writes_starved;
>   	int front_merges;
>   	u32 async_depth;
> +	int prio_aging_expire;
>   
>   	spinlock_t lock;
>   	spinlock_t zone_lock;
> @@ -338,12 +344,27 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>   	return rq;
>   }
>   
> +/*
> + * Returns true if and only if @rq started after @latest_start where
> + * @latest_start is in jiffies.
> + */
> +static bool started_after(struct deadline_data *dd, struct request *rq,
> +			  unsigned long latest_start)
> +{
> +	unsigned long start_time = (unsigned long)rq->fifo_time;
> +
> +	start_time -= dd->fifo_expire[rq_data_dir(rq)];
> +
> +	return time_after(start_time, latest_start);
> +}
> +
>   /*
>    * deadline_dispatch_requests selects the best request according to
> - * read/write expire, fifo_batch, etc
> + * read/write expire, fifo_batch, etc and with a start time <= @latest.
>    */
>   static struct request *__dd_dispatch_request(struct deadline_data *dd,
> -					     struct dd_per_prio *per_prio)
> +					     struct dd_per_prio *per_prio,
> +					     unsigned long latest_start)
>   {
>   	struct request *rq, *next_rq;
>   	enum dd_data_dir data_dir;
> @@ -355,6 +376,8 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
>   	if (!list_empty(&per_prio->dispatch)) {
>   		rq = list_first_entry(&per_prio->dispatch, struct request,
>   				      queuelist);
> +		if (started_after(dd, rq, latest_start))
> +			return NULL;
>   		list_del_init(&rq->queuelist);
>   		goto done;
>   	}
> @@ -432,6 +455,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
>   	dd->batching = 0;
>   
>   dispatch_request:
> +	if (started_after(dd, rq, latest_start))
> +		return NULL;
> +
>   	/*
>   	 * rq is the selected appropriate request.
>   	 */
> @@ -449,6 +475,34 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
>   	return rq;
>   }
>   
> +/*
> + * Check whether there are any requests with priority other than DD_RT_PRIO
> + * that were inserted more than prio_aging_expire jiffies ago.
> + */
> +static struct request *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
> +						      unsigned long now)
> +{
> +	struct request *rq;
> +	enum dd_prio prio;
> +	int prio_cnt;
> +
> +	lockdep_assert_held(&dd->lock);
> +
> +	prio_cnt = !!dd_queued(dd, DD_RT_PRIO) + !!dd_queued(dd, DD_BE_PRIO) +
> +		   !!dd_queued(dd, DD_IDLE_PRIO);
> +	if (prio_cnt < 2)
> +		return NULL;
> +
> +	for (prio = DD_BE_PRIO; prio <= DD_PRIO_MAX; prio++) {
> +		rq = __dd_dispatch_request(dd, &dd->per_prio[prio],
> +					   now - dd->prio_aging_expire);
> +		if (rq)
> +			return rq;
> +	}
> +
> +	return NULL;
> +}
> +
>   /*
>    * Called from blk_mq_run_hw_queue() -> __blk_mq_sched_dispatch_requests().
>    *
> @@ -460,15 +514,26 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
>   static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>   {
>   	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
> +	const unsigned long now = jiffies;
>   	struct request *rq;
>   	enum dd_prio prio;
>   
>   	spin_lock(&dd->lock);
> +	rq = dd_dispatch_prio_aged_requests(dd, now);
> +	if (rq)
> +		goto unlock;
> +
> +	/*
> +	 * Next, dispatch requests in priority order. Ignore lower priority
> +	 * requests if any higher priority requests are pending.
> +	 */
>   	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
> -		rq = __dd_dispatch_request(dd, &dd->per_prio[prio]);
> -		if (rq)
> +		rq = __dd_dispatch_request(dd, &dd->per_prio[prio], now);
> +		if (rq || dd_queued(dd, prio))
>   			break;
>   	}
> +
> +unlock:
>   	spin_unlock(&dd->lock);
>   
>   	return rq;
> @@ -573,6 +638,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
>   	dd->front_merges = 1;
>   	dd->last_dir = DD_WRITE;
>   	dd->fifo_batch = fifo_batch;
> +	dd->prio_aging_expire = prio_aging_expire;
>   	spin_lock_init(&dd->lock);
>   	spin_lock_init(&dd->zone_lock);
>   
> @@ -796,6 +862,7 @@ static ssize_t __FUNC(struct elevator_queue *e, char *page)		\
>   #define SHOW_JIFFIES(__FUNC, __VAR) SHOW_INT(__FUNC, jiffies_to_msecs(__VAR))
>   SHOW_JIFFIES(deadline_read_expire_show, dd->fifo_expire[DD_READ]);
>   SHOW_JIFFIES(deadline_write_expire_show, dd->fifo_expire[DD_WRITE]);
> +SHOW_JIFFIES(deadline_prio_aging_expire_show, dd->prio_aging_expire);
>   SHOW_INT(deadline_writes_starved_show, dd->writes_starved);
>   SHOW_INT(deadline_front_merges_show, dd->front_merges);
>   SHOW_INT(deadline_async_depth_show, dd->front_merges);
> @@ -825,6 +892,7 @@ static ssize_t __FUNC(struct elevator_queue *e, const char *page, size_t count)
>   	STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, msecs_to_jiffies)
>   STORE_JIFFIES(deadline_read_expire_store, &dd->fifo_expire[DD_READ], 0, INT_MAX);
>   STORE_JIFFIES(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0, INT_MAX);
> +STORE_JIFFIES(deadline_prio_aging_expire_store, &dd->prio_aging_expire, 0, INT_MAX);
>   STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX);
>   STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);
>   STORE_INT(deadline_async_depth_store, &dd->front_merges, 1, INT_MAX);
> @@ -843,6 +911,7 @@ static struct elv_fs_entry deadline_attrs[] = {
>   	DD_ATTR(front_merges),
>   	DD_ATTR(async_depth),
>   	DD_ATTR(fifo_batch),
> +	DD_ATTR(prio_aging_expire),
>   	__ATTR_NULL
>   };
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
