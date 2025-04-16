Return-Path: <linux-block+bounces-19808-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197BFA90BF1
	for <lists+linux-block@lfdr.de>; Wed, 16 Apr 2025 21:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888035A2786
	for <lists+linux-block@lfdr.de>; Wed, 16 Apr 2025 19:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF3D2045B7;
	Wed, 16 Apr 2025 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AEa+8Jx6"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25BE21A94D
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744830577; cv=none; b=ozRadfDNRZuFHPGwR5eATPw0vqgyvupuWH2+IgGd2lJprqRGRC0rFb7Y0WnI3+DUX9LcHjyC/xavpMIu24GBs10z0M15C4lUEqQ7s7VrZeuP9aomh3gTIKcMIrPjrFqNxfRE+nA6tRIbplZ8KCdI0x9kM7H8l6Sexr4rXJGd2yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744830577; c=relaxed/simple;
	bh=LUgPThMIsky6sp1GBKFgJ6Zf3OH9WZUnYN3jJ3rNGFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qevam8Pj4d9UjoSB1hJtP9fs36NZ9lPL9qyd0P3u8qJEVrog6WqU+wL91CzP8leBkAtb+TJuqix0L9nq9tKttzkHTMIkphiD8zosdxezr36hiA/6GUlB2HhEyCL2/i3yRY3NHirpoX+nApNEfUouZiJkeRnK5c3l+n6WKqUQX/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=AEa+8Jx6; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2279915e06eso364365ad.1
        for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 12:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744830574; x=1745435374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vLh+CvA1DaJTauiGQd9Ick2E3hlWbU9a0ok2P2C0LRc=;
        b=AEa+8Jx6QkC1HpE7GyEi7M2kBF8Y5LwljkbgozZ8sG+IjrYYMFo16kQX3nYjtNJdwp
         vq4heFWD0wwk/sW34HTee2OyuUvurNseBL1AZ6yf0hsYSsD0EU939HLVXzfPS5Eo2NfC
         TMJ/qVanpyM1Sz+cbW5AfNXqer3uX6atOM1pfiUx52TL5UDsHNlV3qB7gUOVf9KtKarQ
         QB+s/esL1pylz94hgXD2KHpdU3OdwYKgvzXXKUOlIl69gt76Zof1NqgUrx5cUtWW1xv7
         241LWKR/3VIMbrSokBaFZqOIpkJBGaEp4Hf7igJ/ol3tz4vIDO6g8hfpF09sBbgY74Hc
         LOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744830574; x=1745435374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLh+CvA1DaJTauiGQd9Ick2E3hlWbU9a0ok2P2C0LRc=;
        b=PCuYCcymcyIxlc1BVFemeDUmQiicCJfloJ8t7x+XuD+WLXDTrhFs9NnqndaXBM+Cie
         U7wi8M/ajCeAcn0IEXvnwh1/E7aromO1AMZ826eYXpCfTHKyL/QOfq/dRWBMsgldVjVk
         JvjxX11KxMsu0oREG6h7rQ/tuGm0L/4VMRW7KV9KFAF/lMXi8elc6zZSBXMCYk0JMjBd
         RfyCJLbHSkeDjiQBa+avjWPbFjM804lvW7t1Kjn5EYvoZri0aFGhzo9jQytB34G7Mm18
         uh6aVs6IUoSeYd6Efbb5qgbFIrqU9rBGrJZJ1Rbiq087nPy9itQgYs6T0DPNvmRrqjUE
         odRw==
X-Forwarded-Encrypted: i=1; AJvYcCXVoNAY8ArAd/jP7TFwshUGy0rQdeEi+EpKqBJnPMG4Y80pRyaVNqa9XlkZ1gyHIJSe0mbQG8WU6Sa4TA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwuQHBdXQGNSny4OL1OJL/prWkjvkja7PmJuKsQx7AAr2CAKdy
	e20oo3Y75HAQvMe8Q4///vi1wAH3/mykb2nAoCWTH+EeXEuvGJh2PRHC/I8RaAhuI8kNb6JOMM2
	H3BSH3T7hzsUoGIYQVxHZ9R9dRgh278xj
X-Gm-Gg: ASbGncu2M9fCaSOxYVDfjHeS92D9Yzxhmfhcy6meKa1tbx3cLlp1yHxNZFWFxYMIzxK
	oChWcjYLsO2IgugdLxTRqAhSwSI3gfkWfj4GTxBIKIYm4YnLQCut0x3gErDIh04aA7xy1NOqFn2
	9IVMUzlw3emEtVBFPalwK531Whm02Bp7Qe40Gd7IQaDeJtetpXSkwCemQoX9/43qV8d6MRWb1c9
	n8oWyj+cnGHDODEWCOEIYpXjL63bmfMQuOw9U5GJe5veShaOosxRSjB0yL7P4UREObI2L5gw2PD
	zOQ7ILbqbLV7BW3VAYp2WC4+JIsH5tOMUqj74kuZFaeD1Q==
X-Google-Smtp-Source: AGHT+IG5dY8f2E8uFNn5/mwrj/AefvyZip+bo3aRMKQRSZ4W7ubBotMxBrTYYyEn3bvgzG0MspLDGNHzUJiL
X-Received: by 2002:a17:903:1a0d:b0:220:d909:1734 with SMTP id d9443c01a7336-22c358d9f8emr50656415ad.14.1744830573855;
        Wed, 16 Apr 2025 12:09:33 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22c33fe4f34sm925915ad.118.2025.04.16.12.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 12:09:33 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 32D3A34014E;
	Wed, 16 Apr 2025 13:09:33 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 294DFE40318; Wed, 16 Apr 2025 13:09:33 -0600 (MDT)
Date: Wed, 16 Apr 2025 13:09:33 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH V2 5/8] ublk: improve detection and handling of ublk
 server exit
Message-ID: <aAAAbSc97R7JlqSh@dev-ushankar.dev.purestorage.com>
References: <20250416035444.99569-1-ming.lei@redhat.com>
 <20250416035444.99569-6-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416035444.99569-6-ming.lei@redhat.com>

On Wed, Apr 16, 2025 at 11:54:39AM +0800, Ming Lei wrote:
> From: Uday Shankar <ushankar@purestorage.com>
> 
> There are currently two ways in which ublk server exit is detected by
> ublk_drv:
> 
> 1. uring_cmd cancellation. If there are any outstanding uring_cmds which
>    have not been completed to the ublk server when it exits, io_uring
>    calls the uring_cmd callback with a special cancellation flag as the
>    issuing task is exiting.
> 2. I/O timeout. This is needed in addition to the above to handle the
>    "saturated queue" case, when all I/Os for a given queue are in the
>    ublk server, and therefore there are no outstanding uring_cmds to
>    cancel when the ublk server exits.
> 
> There are a couple of issues with this approach:
> 
> - It is complex and inelegant to have two methods to detect the same
>   condition
> - The second method detects ublk server exit only after a long delay
>   (~30s, the default timeout assigned by the block layer). This delays
>   the nosrv behavior from kicking in and potential subsequent recovery
>   of the device.
> 
> The second issue is brought to light with the new test_generic_06 which
> will be added in following patch. It fails before this fix:
> 
> selftests: ublk: test_generic_06.sh
> dev id is 0
> dd: error writing '/dev/ublkb0': Input/output error
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 30.0611 s, 0.0 kB/s
> DEAD
> dd took 31 seconds to exit (>= 5s tolerance)!
> generic_06 : [FAIL]
> 
> Fix this by instead detecting and handling ublk server exit in the
> character file release callback. This has several advantages:
> 
> - This one place can handle both saturated and unsaturated queues. Thus,
>   it replaces both preexisting methods of detecting ublk server exit.
> - It runs quickly on ublk server exit - there is no 30s delay.
> - It starts the process of removing task references in ublk_drv. This is
>   needed if we want to relax restrictions in the driver like letting
>   only one thread serve each queue
> 
> There is also the disadvantage that the character file release callback
> can also be triggered by intentional close of the file, which is a
> significant behavior change. Preexisting ublk servers (libublksrv) are
> dependent on the ability to open/close the file multiple times. To
> address this, only transition to a nosrv state if the file is released
> while the ublk device is live. This allows for programs to open/close
> the file multiple times during setup. It is still a behavior change if a
> ublk server decides to close/reopen the file while the device is LIVE
> (i.e. while it is responsible for serving I/O), but that would be highly
> unusual. This behavior is in line with what is done by FUSE, which is
> very similar to ublk in that a userspace daemon is providing services
> traditionally provided by the kernel.
> 
> With this change in, the new test (and all other selftests, and all
> ublksrv tests) pass:
> 
> selftests: ublk: test_generic_06.sh
> dev id is 0
> dd: error writing '/dev/ublkb0': Input/output error
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 0.0376731 s, 0.0 kB/s
> DEAD
> generic_04 : [PASS]

nit: should be generic_06

> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 223 +++++++++++++++++++++------------------
>  1 file changed, 123 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 1fe39cf85b2f..b0a7e5acb2eb 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -199,8 +199,6 @@ struct ublk_device {
>  	struct completion	completion;
>  	unsigned int		nr_queues_ready;
>  	unsigned int		nr_privileged_daemon;
> -
> -	struct work_struct	nosrv_work;
>  };
>  
>  /* header of ublk_params */
> @@ -209,8 +207,9 @@ struct ublk_params_header {
>  	__u32	types;
>  };
>  
> -static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq);
> -
> +static void ublk_stop_dev_unlocked(struct ublk_device *ub);
> +static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
> +static void __ublk_quiesce_dev(struct ublk_device *ub);
>  static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
>  		struct ublk_queue *ubq, int tag, size_t offset);
>  static inline unsigned int ublk_req_build_flags(struct request *req);
> @@ -1336,8 +1335,6 @@ static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
>  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  {
>  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> -	unsigned int nr_inflight = 0;
> -	int i;
>  
>  	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
>  		if (!ubq->timeout) {
> @@ -1348,26 +1345,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  		return BLK_EH_DONE;
>  	}
>  
> -	if (!ubq_daemon_is_dying(ubq))
> -		return BLK_EH_RESET_TIMER;
> -
> -	for (i = 0; i < ubq->q_depth; i++) {
> -		struct ublk_io *io = &ubq->ios[i];
> -
> -		if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
> -			nr_inflight++;
> -	}
> -
> -	/* cancelable uring_cmd can't help us if all commands are in-flight */
> -	if (nr_inflight == ubq->q_depth) {
> -		struct ublk_device *ub = ubq->dev;
> -
> -		if (ublk_abort_requests(ub, ubq)) {
> -			schedule_work(&ub->nosrv_work);
> -		}
> -		return BLK_EH_DONE;
> -	}
> -
>  	return BLK_EH_RESET_TIMER;
>  }
>  
> @@ -1525,13 +1502,105 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
>  	ub->nr_privileged_daemon = 0;
>  }
>  
> +static struct gendisk *ublk_get_disk(struct ublk_device *ub)
> +{
> +	struct gendisk *disk;
> +
> +	spin_lock(&ub->lock);
> +	disk = ub->ub_disk;
> +	if (disk)
> +		get_device(disk_to_dev(disk));
> +	spin_unlock(&ub->lock);
> +
> +	return disk;
> +}
> +
> +static void ublk_put_disk(struct gendisk *disk)
> +{
> +	if (disk)
> +		put_device(disk_to_dev(disk));
> +}
> +
>  static int ublk_ch_release(struct inode *inode, struct file *filp)
>  {
>  	struct ublk_device *ub = filp->private_data;
> +	struct gendisk *disk;
> +	int i;
> +
> +	/*
> +	 * disk isn't attached yet, either device isn't live, or it has
> +	 * been removed already, so we needn't to do anything
> +	 */
> +	disk = ublk_get_disk(ub);
> +	if (!disk)
> +		goto out;
> +
> +	/*
> +	 * All uring_cmd are done now, so abort any request outstanding to
> +	 * the ublk server
> +	 *
> +	 * This can be done in lockless way because ublk server has been
> +	 * gone
> +	 *
> +	 * More importantly, we have to provide forward progress guarantee
> +	 * without holding ub->mutex, otherwise control task grabbing
> +	 * ub->mutex triggers deadlock
> +	 *
> +	 * All requests may be inflight, so ->canceling may not be set, set
> +	 * it now.
> +	 */
> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> +		struct ublk_queue *ubq = ublk_get_queue(ub, i);
> +
> +		ubq->canceling = true;
> +		ublk_abort_queue(ub, ubq);
> +	}
> +	blk_mq_kick_requeue_list(disk->queue);
> +
> +	/*
> +	 * All infligh requests have been completed or requeued and any new
> +	 * request will be failed or requeued via `->canceling` now, so it is
> +	 * fine to grab ub->mutex now.
> +	 */
> +	mutex_lock(&ub->mutex);
> +
> +	/* double check after grabbing lock */
> +	if (!ub->ub_disk)
> +		goto unlock;
> +
> +	/*
> +	 * Transition the device to the nosrv state. What exactly this
> +	 * means depends on the recovery flags
> +	 */
> +	blk_mq_quiesce_queue(disk->queue);
> +	if (ublk_nosrv_should_stop_dev(ub)) {
> +		/*
> +		 * Allow any pending/future I/O to pass through quickly
> +		 * with an error. This is needed because del_gendisk
> +		 * waits for all pending I/O to complete
> +		 */
> +		for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> +			ublk_get_queue(ub, i)->force_abort = true;
> +		blk_mq_unquiesce_queue(disk->queue);
> +
> +		ublk_stop_dev_unlocked(ub);
> +	} else {
> +		if (ublk_nosrv_dev_should_queue_io(ub)) {
> +			__ublk_quiesce_dev(ub);
> +		} else {
> +			ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
> +			for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> +				ublk_get_queue(ub, i)->fail_io = true;
> +		}
> +		blk_mq_unquiesce_queue(disk->queue);
> +	}
> +unlock:
> +	mutex_unlock(&ub->mutex);
> +	ublk_put_disk(disk);
>  
>  	/* all uring_cmd has been done now, reset device & ubq */
>  	ublk_reset_ch_dev(ub);
> -
> +out:
>  	clear_bit(UB_STATE_OPEN, &ub->state);
>  	return 0;
>  }
> @@ -1627,37 +1696,22 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
>  }
>  
>  /* Must be called when queue is frozen */
> -static bool ublk_mark_queue_canceling(struct ublk_queue *ubq)
> +static void ublk_mark_queue_canceling(struct ublk_queue *ubq)
>  {
> -	bool canceled;
> -
>  	spin_lock(&ubq->cancel_lock);
> -	canceled = ubq->canceling;
> -	if (!canceled)
> +	if (!ubq->canceling)
>  		ubq->canceling = true;
>  	spin_unlock(&ubq->cancel_lock);
> -
> -	return canceled;
>  }
>  
> -static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
> +static void ublk_start_cancel(struct ublk_queue *ubq)
>  {
> -	bool was_canceled = ubq->canceling;
> -	struct gendisk *disk;
> -
> -	if (was_canceled)
> -		return false;
> -
> -	spin_lock(&ub->lock);
> -	disk = ub->ub_disk;
> -	if (disk)
> -		get_device(disk_to_dev(disk));
> -	spin_unlock(&ub->lock);
> +	struct ublk_device *ub = ubq->dev;
> +	struct gendisk *disk = ublk_get_disk(ub);
>  
>  	/* Our disk has been dead */
>  	if (!disk)
> -		return false;
> -
> +		return;
>  	/*
>  	 * Now we are serialized with ublk_queue_rq()
>  	 *
> @@ -1666,15 +1720,9 @@ static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
>  	 * touch completed uring_cmd
>  	 */
>  	blk_mq_quiesce_queue(disk->queue);
> -	was_canceled = ublk_mark_queue_canceling(ubq);
> -	if (!was_canceled) {
> -		/* abort queue is for making forward progress */
> -		ublk_abort_queue(ub, ubq);
> -	}
> +	ublk_mark_queue_canceling(ubq);
>  	blk_mq_unquiesce_queue(disk->queue);
> -	put_device(disk_to_dev(disk));
> -
> -	return !was_canceled;
> +	ublk_put_disk(disk);
>  }
>  
>  static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
> @@ -1698,6 +1746,17 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
>  /*
>   * The ublk char device won't be closed when calling cancel fn, so both
>   * ublk device and queue are guaranteed to be live
> + *
> + * Two-stage cancel:
> + *
> + * - make every active uring_cmd done in ->cancel_fn()
> + *
> + * - aborting inflight ublk IO requests in ublk char device release handler,
> + *   which depends on 1st stage because device can only be closed iff all
> + *   uring_cmd are done
> + *
> + * Do _not_ try to acquire ub->mutex before all inflight requests are
> + * aborted, otherwise deadlock may be caused.
>   */
>  static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
>  		unsigned int issue_flags)
> @@ -1705,8 +1764,6 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
>  	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
>  	struct ublk_queue *ubq = pdu->ubq;
>  	struct task_struct *task;
> -	struct ublk_device *ub;
> -	bool need_schedule;
>  	struct ublk_io *io;
>  
>  	if (WARN_ON_ONCE(!ubq))
> @@ -1719,16 +1776,12 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
>  	if (WARN_ON_ONCE(task && task != ubq->ubq_daemon))
>  		return;
>  
> -	ub = ubq->dev;
> -	need_schedule = ublk_abort_requests(ub, ubq);
> +	if (!ubq->canceling)
> +		ublk_start_cancel(ubq);
>  
>  	io = &ubq->ios[pdu->tag];
>  	WARN_ON_ONCE(io->cmd != cmd);
>  	ublk_cancel_cmd(ubq, io, issue_flags);
> -
> -	if (need_schedule) {
> -		schedule_work(&ub->nosrv_work);
> -	}
>  }
>  
>  static inline bool ublk_queue_ready(struct ublk_queue *ubq)
> @@ -1787,13 +1840,11 @@ static void __ublk_quiesce_dev(struct ublk_device *ub)
>  			__func__, ub->dev_info.dev_id,
>  			ub->dev_info.state == UBLK_S_DEV_LIVE ?
>  			"LIVE" : "QUIESCED");
> -	blk_mq_quiesce_queue(ub->ub_disk->queue);
>  	/* mark every queue as canceling */
>  	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
>  		ublk_get_queue(ub, i)->canceling = true;
>  	ublk_wait_tagset_rqs_idle(ub);
>  	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
> -	blk_mq_unquiesce_queue(ub->ub_disk->queue);
>  }
>  
>  static void ublk_force_abort_dev(struct ublk_device *ub)
> @@ -1830,50 +1881,25 @@ static struct gendisk *ublk_detach_disk(struct ublk_device *ub)
>  	return disk;
>  }
>  
> -static void ublk_stop_dev(struct ublk_device *ub)
> +static void ublk_stop_dev_unlocked(struct ublk_device *ub)
> +	__must_hold(&ub->mutex)
>  {
>  	struct gendisk *disk;
>  
> -	mutex_lock(&ub->mutex);
>  	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
> -		goto unlock;
> +		return;
> +
>  	if (ublk_nosrv_dev_should_queue_io(ub))
>  		ublk_force_abort_dev(ub);
>  	del_gendisk(ub->ub_disk);
>  	disk = ublk_detach_disk(ub);
>  	put_disk(disk);
> - unlock:
> -	mutex_unlock(&ub->mutex);
> -	ublk_cancel_dev(ub);
>  }
>  
> -static void ublk_nosrv_work(struct work_struct *work)
> +static void ublk_stop_dev(struct ublk_device *ub)
>  {
> -	struct ublk_device *ub =
> -		container_of(work, struct ublk_device, nosrv_work);
> -	int i;
> -
> -	if (ublk_nosrv_should_stop_dev(ub)) {
> -		ublk_stop_dev(ub);
> -		return;
> -	}
> -
>  	mutex_lock(&ub->mutex);
> -	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
> -		goto unlock;
> -
> -	if (ublk_nosrv_dev_should_queue_io(ub)) {
> -		__ublk_quiesce_dev(ub);
> -	} else {
> -		blk_mq_quiesce_queue(ub->ub_disk->queue);
> -		ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
> -		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
> -			ublk_get_queue(ub, i)->fail_io = true;
> -		}
> -		blk_mq_unquiesce_queue(ub->ub_disk->queue);
> -	}
> -
> - unlock:
> +	ublk_stop_dev_unlocked(ub);
>  	mutex_unlock(&ub->mutex);
>  	ublk_cancel_dev(ub);
>  }
> @@ -2502,7 +2528,6 @@ static void ublk_remove(struct ublk_device *ub)
>  	bool unprivileged;
>  
>  	ublk_stop_dev(ub);
> -	cancel_work_sync(&ub->nosrv_work);
>  	cdev_device_del(&ub->cdev, &ub->cdev_dev);
>  	unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
>  	ublk_put_device(ub);
> @@ -2787,7 +2812,6 @@ static int ublk_ctrl_add_dev(const struct ublksrv_ctrl_cmd *header)
>  		goto out_unlock;
>  	mutex_init(&ub->mutex);
>  	spin_lock_init(&ub->lock);
> -	INIT_WORK(&ub->nosrv_work, ublk_nosrv_work);
>  
>  	ret = ublk_alloc_dev_number(ub, header->dev_id);
>  	if (ret < 0)
> @@ -2919,7 +2943,6 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
>  static int ublk_ctrl_stop_dev(struct ublk_device *ub)
>  {
>  	ublk_stop_dev(ub);
> -	cancel_work_sync(&ub->nosrv_work);
>  	return 0;
>  }
>  
> -- 
> 2.47.0
> 

