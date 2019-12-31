Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3E5612DC45
	for <lists+linux-block@lfdr.de>; Wed,  1 Jan 2020 00:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfLaXMA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 31 Dec 2019 18:12:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:58658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbfLaXMA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Dec 2019 18:12:00 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1C9B205ED;
        Tue, 31 Dec 2019 23:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577833918;
        bh=I5VDTlagzgjoV/Vq0KLS6Pp7oec19p27s39/DZHvy6U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pe/rVDeLq/t43ZeJuGpDutta0HAnnwq0I/v2qB96KW7qMVU3GgYVkQ6bs+/tnsOGH
         eE/lgQ0E/iFecx7GRQM1DXU80C2O+6l3m5y+RY+gBlwTdjaoDcZlDjx5JM34TFLxpJ
         opc/fcNXSxzNXiTEO01w5Mr1JcgSrExbQ4KhjQ3U=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B812A352108C; Tue, 31 Dec 2019 15:11:58 -0800 (PST)
Date:   Tue, 31 Dec 2019 15:11:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, ming.lei@redhat.com, hch@lst.de,
        zhengchuan@huawei.com, yi.zhang@huawei.com, joel@joelfernandes.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH] block: make sure last_lookup set as NULL after part
 deleted
Message-ID: <20191231231158.GW13449@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191231110945.10857-1-yuyufen@huawei.com>
 <a9ce86d6-dadb-9301-7d76-8cef81d782fd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9ce86d6-dadb-9301-7d76-8cef81d782fd@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 31, 2019 at 10:55:47PM +0800, Hou Tao wrote:
> Hi,
> 
> On 2019/12/31 19:09, Yufen Yu wrote:
> > When delete partition executes concurrently with IOs issue,
> > it may cause use-after-free on part in disk_map_sector_rcu()
> > as following:
> snip
> 
> > 
> > diff --git a/block/genhd.c b/block/genhd.c
> > index ff6268970ddc..39fa8999905f 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -293,7 +293,23 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
> >  		part = rcu_dereference(ptbl->part[i]);
> >  
> >  		if (part && sector_in_part(part, sector)) {
> snip
> 
> >  			rcu_assign_pointer(ptbl->last_lookup, part);
> > +			part = rcu_dereference(ptbl->part[i]);
> > +			if (part == NULL) {
> > +				rcu_assign_pointer(ptbl->last_lookup, NULL);
> > +				break;
> > +			}
> >  			return part;
> >  		}
> >  	}
> 
> Not ensure whether the re-read can handle the following case or not:
> 
> process A                                 process B                          process C
> 
> disk_map_sector_rcu():                    delete_partition():               disk_map_sector_rcu():
> 
> rcu_read_lock
> 
>   // need to iterate partition table
>   part[i] != NULL   (1)                   part[i] = NULL (2)
>                                           smp_mb()
>                                           last_lookup = NULL (3)
>                                           call_rcu()  (4)
>     last_lookup = part[i] (5)
> 
> 
>                                                                              rcu_read_lock()
>                                                                              read last_lookup return part[i] (6)
>                                                                              sector_in_part() is OK (7)
>                                                                              return part[i] (8)

Just for the record...

Use of RCU needs to ensure that readers cannot access the to-be-freed
structure -before- invoking call_rcu().  Which does look to happen here
with the "last_lookup = NULL".  But in addition, the callback needs to
get access to the to-be-freed structure via some sideband (usually the
structure passed to call_rcu()), not from the reader-accessible structure.

Or am I misinterpreting this sequence of events?

							Thanx, Paul

>   part[i] == NULL (9)
>       last_lookup = NULL (10)
>   rcu_read_unlock() (11)
>                                            one RCU grace period completes
>                                            __delete_partition() (12)
>                                            free hd_partition (13)
>                                                                              // use-after-free
>                                                                              hd_struct_try_get(part[i])  (14)
> 
> * the number in the parenthesis is the sequence of events.
> 
> Maybe RCU experts can shed some light on this problem, so cc +paulmck@kernel.org, +joel@joelfernandes.org and +RCU maillist.
> 
> If the above case is possible, maybe we can fix the problem by pinning last_lookup through increasing its ref-count
> (the following patch is only compile tested):
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 6e8543ca6912..179e0056fae1 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -279,7 +279,14 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
>  		part = rcu_dereference(ptbl->part[i]);
> 
>  		if (part && sector_in_part(part, sector)) {
> -			rcu_assign_pointer(ptbl->last_lookup, part);
> +			struct hd_struct *old;
> +
> +			if (!hd_struct_try_get(part))
> +				break;
> +
> +			old = xchg(&ptbl->last_lookup, part);
> +			if (old)
> +				hd_struct_put(old);
>  			return part;
>  		}
>  	}
> @@ -1231,7 +1238,11 @@ static void disk_replace_part_tbl(struct gendisk *disk,
>  	rcu_assign_pointer(disk->part_tbl, new_ptbl);
> 
>  	if (old_ptbl) {
> -		rcu_assign_pointer(old_ptbl->last_lookup, NULL);
> +		struct hd_struct *part;
> +
> +		part = xchg(&old_ptbl->last_lookup, NULL);
> +		if (part)
> +			hd_struct_put(part);
>  		kfree_rcu(old_ptbl, rcu_head);
>  	}
>  }
> diff --git a/block/partition-generic.c b/block/partition-generic.c
> index 98d60a59b843..441c1c591c04 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -285,7 +285,8 @@ void delete_partition(struct gendisk *disk, int partno)
>  		return;
> 
>  	rcu_assign_pointer(ptbl->part[partno], NULL);
> -	rcu_assign_pointer(ptbl->last_lookup, NULL);
> +	if (cmpxchg(&ptbl->last_lookup, part, NULL) == part)
> +		hd_struct_put(part);
>  	kobject_put(part->holder_dir);
>  	device_del(part_to_dev(part));
> 
> -- 
> 2.22.0
> 
> Regards,
> Tao
> 
> 
> > diff --git a/block/partition-generic.c b/block/partition-generic.c
> > index 1d20c9cf213f..1e0065ed6f02 100644
> > --- a/block/partition-generic.c
> > +++ b/block/partition-generic.c
> > @@ -284,6 +284,13 @@ void delete_partition(struct gendisk *disk, int partno)
> >  		return;
> >  
> >  	rcu_assign_pointer(ptbl->part[partno], NULL);
> > +	/*
> > +	 * Without the memory barrier, disk_map_sector_rcu()
> > +	 * may read the old value after overwriting the
> > +	 * last_lookup. Then it can not clear last_lookup,
> > +	 * which may cause use-after-free.
> > +	 */
> > +	smp_mb();
> >  	rcu_assign_pointer(ptbl->last_lookup, NULL);
> >  	kobject_put(part->holder_dir);
> >  	device_del(part_to_dev(part));
> > 
> 
