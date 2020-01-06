Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC904130FFB
	for <lists+linux-block@lfdr.de>; Mon,  6 Jan 2020 11:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgAFKGG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 6 Jan 2020 05:06:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33177 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726526AbgAFKGG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Jan 2020 05:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578305165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MIhgYZejwb4CBJQwgDu8l+iDOi/YySEAQ2Lt5XrvBYg=;
        b=GMT1AB+h/6AgB+fndiVl70Hww8SxWDsQdGnyMeICnl5V+9wJRaKsMdlGMxH8HAftraUZhQ
        oLbqQGsnm3A4EZdzbAH+I2iNO+C46fV46aCaxD1+X/ypM57AKFMi8/BnMTHZnQmvhIn5qR
        h1wlyxy3Pq4OcWuk9rCVGmRQWr6Nv6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-lBKQ43xSPuSJApJtO8UrMQ-1; Mon, 06 Jan 2020 05:06:02 -0500
X-MC-Unique: lBKQ43xSPuSJApJtO8UrMQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AA4810054E3;
        Mon,  6 Jan 2020 10:06:00 +0000 (UTC)
Received: from ming.t460p (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29BC9108131B;
        Mon,  6 Jan 2020 10:05:51 +0000 (UTC)
Date:   Mon, 6 Jan 2020 18:05:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, hch@lst.de, zhengchuan@huawei.com,
        yi.zhang@huawei.com, paulmck@kernel.org, joel@joelfernandes.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] block: make sure last_lookup set as NULL after part
 deleted
Message-ID: <20200106100547.GA15256@ming.t460p>
References: <20200102012314.GB16719@ming.t460p>
 <c12da8ca-be66-496b-efb2-a60ceaf9ce54@huawei.com>
 <20200103041805.GA29924@ming.t460p>
 <ea362a86-d2de-7dfe-c826-d59e8b5068c3@huawei.com>
 <20200103081745.GA11275@ming.t460p>
 <82c10514-aec5-0d7c-118f-32c261015c6a@huawei.com>
 <20200103151616.GA23308@ming.t460p>
 <582f8e81-6127-47aa-f7fe-035251052238@huawei.com>
 <20200106081137.GA10487@ming.t460p>
 <747c3856-afa4-0909-dae2-f3b23aa38118@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <747c3856-afa4-0909-dae2-f3b23aa38118@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 06, 2020 at 05:41:45PM +0800, Hou Tao wrote:
> Hi,
> 
> On 2020/1/6 16:11, Ming Lei wrote:
> > On Mon, Jan 06, 2020 at 03:39:07PM +0800, Yufen Yu wrote:
> >> Hi, Ming
> >>
> >> On 2020/1/3 23:16, Ming Lei wrote:
> >>> Hello Yufen,
> >>>
> >>> OK, we still can move clearing .last_lookup into __delete_partition(),
> >>> at that time all IO path can observe the partition percpu-refcount killed.
> >>>
> >>> Also the rcu work fn is run after one RCU grace period, at that time,
> >>> the NULL .last_lookup becomes visible in all IO path too.
> >>>
> >>> diff --git a/block/blk-core.c b/block/blk-core.c
> >>> index 089e890ab208..79599f5fd5b7 100644
> >>> --- a/block/blk-core.c
> >>> +++ b/block/blk-core.c
> >>> @@ -1365,18 +1365,6 @@ void blk_account_io_start(struct request *rq, bool new_io)
> >>>   		part_stat_inc(part, merges[rw]);
> >>>   	} else {
> >>>   		part = disk_map_sector_rcu(rq->rq_disk, blk_rq_pos(rq));
> >>> -		if (!hd_struct_try_get(part)) {
> >>> -			/*
> >>> -			 * The partition is already being removed,
> >>> -			 * the request will be accounted on the disk only
> >>> -			 *
> >>> -			 * We take a reference on disk->part0 although that
> >>> -			 * partition will never be deleted, so we can treat
> >>> -			 * it as any other partition.
> >>> -			 */
> >>> -			part = &rq->rq_disk->part0;
> >>> -			hd_struct_get(part);
> >>> -		}
> >>>   		part_inc_in_flight(rq->q, part, rw);
> >>>   		rq->part = part;
> >>>   	}
> >>> diff --git a/block/genhd.c b/block/genhd.c
> >>> index ff6268970ddc..e3dec90b1f43 100644
> >>> --- a/block/genhd.c
> >>> +++ b/block/genhd.c
> >>> @@ -286,17 +286,21 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
> >>>   	ptbl = rcu_dereference(disk->part_tbl);
> >>>   	part = rcu_dereference(ptbl->last_lookup);
> >>> -	if (part && sector_in_part(part, sector))
> >>> +	if (part && sector_in_part(part, sector) && hd_struct_try_get(part))
> >>>   		return part;
> >>>   	for (i = 1; i < ptbl->len; i++) {
> >>>   		part = rcu_dereference(ptbl->part[i]);
> >>>   		if (part && sector_in_part(part, sector)) {
> >>> +                       if (!hd_struct_try_get(part))
> >>> +                               goto exit;
> >>>   			rcu_assign_pointer(ptbl->last_lookup, part);
> >>>   			return part;
> >>>   		}
> >>>   	}
> >>> + exit:
> >>> +	hd_struct_get(&disk->part0);
> >>>   	return &disk->part0;
> >>>   }
> >>>   EXPORT_SYMBOL_GPL(disk_map_sector_rcu);
> >>> diff --git a/block/partition-generic.c b/block/partition-generic.c
> >>> index 1d20c9cf213f..1739f750dbf2 100644
> >>> --- a/block/partition-generic.c
> >>> +++ b/block/partition-generic.c
> >>> @@ -262,6 +262,12 @@ static void delete_partition_work_fn(struct work_struct *work)
> >>>   void __delete_partition(struct percpu_ref *ref)
> >>>   {
> >>>   	struct hd_struct *part = container_of(ref, struct hd_struct, ref);
> >>> +	struct disk_part_tbl *ptbl =
> >>> +		rcu_dereference_protected(part->disk->part_tbl, 1);
> >>> +
> >>> +	rcu_assign_pointer(ptbl->last_lookup, NULL);
> >>> +	put_device(disk_to_dev(part->disk));
> >>> +
> >>>   	INIT_RCU_WORK(&part->rcu_work, delete_partition_work_fn);
> >>>   	queue_rcu_work(system_wq, &part->rcu_work);
> >>>   }
> >>> @@ -283,8 +289,9 @@ void delete_partition(struct gendisk *disk, int partno)
> >>>   	if (!part)
> >>>   		return;
> >>> +	get_device(disk_to_dev(disk));
> >>>   	rcu_assign_pointer(ptbl->part[partno], NULL);
> >>> -	rcu_assign_pointer(ptbl->last_lookup, NULL);
> >>> +
> >>>   	kobject_put(part->holder_dir);
> >>>   	device_del(part_to_dev(part));
> >>> @@ -349,6 +356,7 @@ struct hd_struct *add_partition(struct gendisk *disk, int partno,
> >>>   	p->nr_sects = len;
> >>>   	p->partno = partno;
> >>>   	p->policy = get_disk_ro(disk);
> >>> +	p->disk = disk;
> >>>   	if (info) {
> >>>   		struct partition_meta_info *pinfo = alloc_part_info(disk);
> >>> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> >>> index 8bb63027e4d6..66660ec5e8ee 100644
> >>> --- a/include/linux/genhd.h
> >>> +++ b/include/linux/genhd.h
> >>> @@ -129,6 +129,7 @@ struct hd_struct {
> >>>   #else
> >>>   	struct disk_stats dkstats;
> >>>   #endif
> >>> +	struct gendisk *disk;
> >>>   	struct percpu_ref ref;
> >>>   	struct rcu_work rcu_work;
> >>>   };
> >>
> >>
> >> IMO, this change can solve the problem. But, __delete_partition will
> >> depend on the implementation of disk_release(). If disk .release modify
> >> as blocked in the future, then __delete_partition will also be blocked,
> >> which is not expected in rcu callback function.
> > 
> > __delete_partition() won't be blocked because it just calls queue_rcu_work() to
> > release the partition instance in wq context.
> > 
> >>
> >> We may cache index of part[] instead of part[i] itself to fix the use-after-free bug.
> >> https://patchwork.kernel.org/patch/11318767/
> > 
> > That approach can fix the issue too, but extra overhead is added in the
> > fast path because partition retrieval is changed to the following way:
> > 
> > 	+       last_lookup = READ_ONCE(ptbl->last_lookup);
> > 	+       if (last_lookup > 0 && last_lookup < ptbl->len) {
> > 	+               part = rcu_dereference(ptbl->part[last_lookup]);
> > 	+               if (part && sector_in_part(part, sector))
> > 	+                       return part;
> > 	+       }
> > 
> > from 
> > 	part = rcu_dereference(ptbl->last_lookup);
> > 
> > So ptbl->part[] has to be fetched, it is fine if the ->part[] array
> > shares same cacheline with ptbl->last_lookup, but one disk may have
> > too many partitions, then your approach may introduce one extra cache
> > miss every time.
> > 
> Yes. The solution you proposed also adds an invocation of percpu_ref_tryget_live()
> in the fast path. Not sure which one will have a better performance. However the
> reason we prefer the index caching is the simplicity instead of performance.

No, hd_struct_try_get() and hd_struct_get() is always called once for one IO, the
patch I proposed changes nothing about this usage.

Please take a close look at the patch:

https://lore.kernel.org/linux-block/5cc465cc-d68c-088e-0729-2695279c7853@huawei.com/T/#m8f3e6b4e77eadf006ce142a84c966f50f3a9ae26

which just moves hd_struct_try_get() from blk_account_io_start() into
disk_map_sector_rcu(), doesn't it?


Thanks,
Ming

