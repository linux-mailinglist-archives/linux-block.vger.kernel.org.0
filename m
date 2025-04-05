Return-Path: <linux-block+bounces-19217-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD272A7C9CA
	for <lists+linux-block@lfdr.de>; Sat,  5 Apr 2025 17:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5581899AAC
	for <lists+linux-block@lfdr.de>; Sat,  5 Apr 2025 15:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1113D1DDC1A;
	Sat,  5 Apr 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWaFTks4"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E3B7A13A
	for <linux-block@vger.kernel.org>; Sat,  5 Apr 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743865192; cv=none; b=jaI+T+vhIBMPq4YCWntxvkbM1PZVLwYpm9A5NZDVxJZVe+G7cpRCKGLVC/Xdmu7Xdil3lZzQD+fizy2uIhVrx8RrWWCTHPkeKkeW6rsGDv2FYoVpoJCo7JtQoVxjpsECPb94MkoeB22nvPNmaAAsDZ6PT9MIV2lfiYcD8rwGRaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743865192; c=relaxed/simple;
	bh=MujoFMWO97NvPreyL+B/x2WoeplqxRBvEV79sESwlJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2FP7JT9TDXVy3uAmZwbrl4qCXdMiCKCVTkZ+G5BywzR4QX/+YaZd2GbNP33KroJDSw7XluKgPSM4HM1yK7q1XUiLJ925NABDc9z4Ofb8iZZQVwJko885S7309Wz8jaMnFRTpWDNMb0p0kc7zX014dSDxAgNVVTBMQ3M+EcPvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YWaFTks4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743865188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cbkTzprJIlguje41tLks2OTXlNo6AoyMKZsgeX069d4=;
	b=YWaFTks4Fdrwsr5uIw9L9n265THCDdmbo//j7YO4z58U/G/TsG5+iBjgpBsR1UQIWE0Cmh
	pPf6Qs3I3l87aWDoOhGmpQrPGin8yd2XTtzpALTTn2+n/tf+/7vAsTD520CDcv059YjubL
	w84MZ0RqcqyW0AlcfKNdcG5/Tkvu/kI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-T_9m49wINh-rUSJBmh1fAw-1; Sat,
 05 Apr 2025 10:59:44 -0400
X-MC-Unique: T_9m49wINh-rUSJBmh1fAw-1
X-Mimecast-MFC-AGG-ID: T_9m49wINh-rUSJBmh1fAw_1743865181
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BF52180049D;
	Sat,  5 Apr 2025 14:59:41 +0000 (UTC)
Received: from fedora (unknown [10.72.120.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 150B7180B489;
	Sat,  5 Apr 2025 14:59:35 +0000 (UTC)
Date: Sat, 5 Apr 2025 22:59:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ublk: improve detection and handling of ublk server
 exit
Message-ID: <Z_FFUXINspN8G0y0@fedora>
References: <20250403-ublk_timeout-v3-1-aa09f76c7451@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403-ublk_timeout-v3-1-aa09f76c7451@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Apr 03, 2025 at 06:05:57PM -0600, Uday Shankar wrote:
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
> The second issue is brought to light with the new test_generic_04. It
> fails before this fix:
> 
> selftests: ublk: test_generic_04.sh
> dev id is 0
> dd: error writing '/dev/ublkb0': Input/output error
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 30.0611 s, 0.0 kB/s
> DEAD
> dd took 31 seconds to exit (>= 5s tolerance)!
> generic_04 : [FAIL]
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
> selftests: ublk: test_generic_04.sh
> dev id is 0
> dd: error writing '/dev/ublkb0': Input/output error
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 0.0376731 s, 0.0 kB/s
> DEAD
> generic_04 : [PASS]
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
> Changes in v3:
> - Quiesce queue earlier to avoid concurrent cancellation and "normal"
>   completion of io_uring cmds (Ming Lei)
> - Fix del_gendisk hang, found by test_stress_02
> - Remove unnecessary parameters in fault_inject target (Ming Lei)
> - Fix delay implementation to have separate per-I/O delay instead of
>   blocking the whole thread (Ming Lei)
> - Add delay_us to docs
> - Link to v2: https://lore.kernel.org/r/20250402-ublk_timeout-v2-1-249bc5523000@purestorage.com
> 
> Changes in v2:
> - Leave null ublk selftests target untouched, instead create new
>   fault_inject target for injecting per-I/O delay (Ming Lei)
> - Allow multiple open/close of ublk character device with some
>   restrictions
> - Drop patches which made it in separately at https://lore.kernel.org/r/20250401-ublk_selftests-v1-1-98129c9bc8bb@purestorage.com
> - Consolidate more nosrv logic in ublk character device release, and
>   associated code cleanup
> - Link to v1: https://lore.kernel.org/r/20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com
> ---
>  drivers/block/ublk_drv.c                        | 228 +++++++++---------------
>  tools/testing/selftests/ublk/Makefile           |   4 +-
>  tools/testing/selftests/ublk/fault_inject.c     |  72 ++++++++
>  tools/testing/selftests/ublk/kublk.c            |   6 +-
>  tools/testing/selftests/ublk/kublk.h            |   4 +
>  tools/testing/selftests/ublk/test_generic_04.sh |  43 +++++
>  6 files changed, 215 insertions(+), 142 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2fd05c1bd30b03343cb6f357f8c08dd92ff47af9..73baa9d22ccafb00723defa755a0b3aab7238934 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -162,7 +162,6 @@ struct ublk_queue {
>  
>  	bool force_abort;
>  	bool timeout;
> -	bool canceling;
>  	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
>  	unsigned short nr_io_ready;	/* how many ios setup */
>  	spinlock_t		cancel_lock;
> @@ -199,8 +198,6 @@ struct ublk_device {
>  	struct completion	completion;
>  	unsigned int		nr_queues_ready;
>  	unsigned int		nr_privileged_daemon;
> -
> -	struct work_struct	nosrv_work;
>  };
>  
>  /* header of ublk_params */
> @@ -209,8 +206,9 @@ struct ublk_params_header {
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
> @@ -1314,8 +1312,6 @@ static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
>  static enum blk_eh_timer_return ublk_timeout(struct request *rq)
>  {
>  	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
> -	unsigned int nr_inflight = 0;
> -	int i;
>  
>  	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
>  		if (!ubq->timeout) {
> @@ -1326,26 +1322,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
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
> @@ -1356,19 +1332,16 @@ static blk_status_t ublk_prep_req(struct ublk_queue *ubq, struct request *rq)
>  	if (unlikely(ubq->fail_io))
>  		return BLK_STS_TARGET;
>  
> -	/* With recovery feature enabled, force_abort is set in
> -	 * ublk_stop_dev() before calling del_gendisk(). We have to
> -	 * abort all requeued and new rqs here to let del_gendisk()
> -	 * move on. Besides, we cannot not call io_uring_cmd_complete_in_task()
> -	 * to avoid UAF on io_uring ctx.
> +	/*
> +	 * force_abort is set in ublk_stop_dev() before calling
> +	 * del_gendisk(). We have to abort all requeued and new rqs here
> +	 * to let del_gendisk() move on. Besides, we cannot not call
> +	 * io_uring_cmd_complete_in_task() to avoid UAF on io_uring ctx.
>  	 *
>  	 * Note: force_abort is guaranteed to be seen because it is set
>  	 * before request queue is unqiuesced.
>  	 */
> -	if (ublk_nosrv_should_queue_io(ubq) && unlikely(ubq->force_abort))
> -		return BLK_STS_IOERR;
> -
> -	if (unlikely(ubq->canceling))
> +	if (unlikely(ubq->force_abort))
>  		return BLK_STS_IOERR;
>  
>  	/* fill iod to slot in io cmd buffer */
> @@ -1391,16 +1364,6 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	if (res != BLK_STS_OK)
>  		return res;
>  
> -	/*
> -	 * ->canceling has to be handled after ->force_abort and ->fail_io
> -	 * is dealt with, otherwise this request may not be failed in case
> -	 * of recovery, and cause hang when deleting disk
> -	 */
> -	if (unlikely(ubq->canceling)) {
> -		__ublk_abort_rq(ubq, rq);
> -		return BLK_STS_OK;
> -	}
> -

If `ubq->canceling` is removed, how to handle recovery? The request has to
be requeued in case of ublk_nosrv_dev_should_queue_io().

And that should be the reason why 'make test T=generic/004' hangs forever
after applying this patch.

>  	ublk_queue_cmd(ubq, rq);
>  	return BLK_STS_OK;
>  }
> @@ -1461,8 +1424,71 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
>  static int ublk_ch_release(struct inode *inode, struct file *filp)
>  {
>  	struct ublk_device *ub = filp->private_data;
> +	int i;
> +
> +	mutex_lock(&ub->mutex);
> +	/*
> +	 * If the device is not live, we will not transition to a nosrv
> +	 * state. This protects against:
> +	 * - accidental poking of the ublk character device
> +	 * - some ublk servers which may open/close the ublk character
> +	 *   device during startup
> +	 */
> +	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
> +		goto out;
> +
> +	/*
> +	 * Since we are releasing the ublk character file descriptor, we
> +	 * know that there cannot be any concurrent file-related
> +	 * activity (e.g. uring_cmds or reads/writes). However, I/O
> +	 * might still be getting dispatched. Quiesce that too so that
> +	 * we don't need to worry about anything concurrent.
> +	 *
> +	 * We may have already quiesced the queue if we canceled any
> +	 * uring_cmds, so only quiesce if necessary (quiesce is not
> +	 * idempotent, it has an internal counter which we need to
> +	 * manage carefully).
> +	 */
> +	if (!blk_queue_quiesced(ub->ub_disk->queue))
> +		blk_mq_quiesce_queue(ub->ub_disk->queue);
> +
> +	/*
> +	 * Handle any requests outstanding to the ublk server
> +	 */
> +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> +		ublk_abort_queue(ub, ublk_get_queue(ub, i));
>  
> +	/*
> +	 * Transition the device to the nosrv state. What exactly this
> +	 * means depends on the recovery flags
> +	 */
> +	if (ublk_nosrv_should_stop_dev(ub)) {
> +		/*
> +		 * Allow any pending/future I/O to pass through quickly
> +		 * with an error. This is needed because del_gendisk
> +		 * waits for all pending I/O to complete
> +		 */
> +		for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> +			ublk_get_queue(ub, i)->force_abort = true;
> +		blk_mq_unquiesce_queue(ub->ub_disk->queue);
> +
> +		ublk_stop_dev_unlocked(ub);
> +	} else {
> +		if (ublk_nosrv_dev_should_queue_io(ub)) {
> +			__ublk_quiesce_dev(ub);

Here only inflight IOs are drained, new IO still comes after queue is
unquiesced, then uring_cmd UAF is triggered.

...

> --- /dev/null
> +++ b/tools/testing/selftests/ublk/test_generic_04.sh
> @@ -0,0 +1,43 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> +
> +TID="generic_04"
> +ERR_CODE=0
> +
> +_prep_test "fault_inject" "fast cleanup when all I/Os of one hctx are in server"
> +
> +# configure ublk server to sleep 2s before completing each I/O
> +dev_id=$(_add_ublk_dev -t fault_inject -q 2 -d 1 --delay_us 2000000)
> +_check_add_dev $TID $?
> +
> +echo "dev id is ${dev_id}"
> +
> +STARTTIME=${SECONDS}
> +
> +dd if=/dev/urandom of=/dev/ublkb${dev_id} oflag=direct bs=4k count=1 &

stdout/stderr need to be discarded.

Also I'd suggest to make the selftest part as one standalone patch.


thanks,
Ming


