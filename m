Return-Path: <linux-block+bounces-10937-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAE89602FB
	for <lists+linux-block@lfdr.de>; Tue, 27 Aug 2024 09:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1741F232F7
	for <lists+linux-block@lfdr.de>; Tue, 27 Aug 2024 07:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AD8155A24;
	Tue, 27 Aug 2024 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dHbMHKbB"
X-Original-To: linux-block@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A0B14F125
	for <linux-block@vger.kernel.org>; Tue, 27 Aug 2024 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743531; cv=none; b=OhgPigKaDSnxvHCbA8CJvIIeRxrR/JWNiDuTR1QyrvJYwh1de9bXYKARPIQ3eLBa4IArVHfTEWnPe/f80Q9SOLZgOmwjNo5Ca1QSwKUBLv2NSw25WRo1veb+62FT4ElluUsqtAlNIsjBxlHzeSbHN5OvMRrxebcchVs+6Yb0e1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743531; c=relaxed/simple;
	bh=3YCF25mQueJseVyAYJwRUmqPfkAJ4ajBKsMP+a4QvoM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nkeUr9BYrx5ZSfeZGjqpEuthlpdUctGlGyRBm9gS4pl2ogye3pRerKIWX5UlRKm4Z1nGBsM8E0ZgLLd0/Sn+paLK0KIk18zstijOREGFrLyu0HTHrlNHjnlReMI4oXSrHhJy1Wvo8PlHR1Qhp9gH4DCrEhSZWlp2oWcEb/mTWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dHbMHKbB; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724743527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JQvAYuZ44FtN/ZNgPbJC/QJQ4ziNTC+Wfel6ZKG8kT8=;
	b=dHbMHKbBFBs0OMFWaAOXsW61XrjZBc8PMmB+PgQuQVL9Wu2uPvnjH+sGtQWxfj2K7lDyeA
	WdRRjfjLYIj4Y3tx4VNHVW3H0OpY8CXSYLNo9g80hNmTdEeYq0RvZIj38NkwEKI1xBE6BD
	+Byh+IXT24ifTA7ksGazTVVCpNyh+nQ=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH 4/4] block: fix fix ordering between checking
 QUEUE_FLAG_QUIESCED and adding requests to hctx->dispatch
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ZsxI6uCbGpQh1XrF@fedora>
Date: Tue, 27 Aug 2024 15:24:43 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Jens Axboe <axboe@kernel.dk>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1929CA74-3770-4B5D-B0A5-759911E97815@linux.dev>
References: <20240811101921.4031-1-songmuchun@bytedance.com>
 <20240811101921.4031-5-songmuchun@bytedance.com> <ZshyPVEc9w4sqXJy@fedora>
 <CAMZfGtW-AG9gBD2f=FwNAZqxoFZwoEECbS0+4eurnSoxN5AhRg@mail.gmail.com>
 <45A22FCE-10FA-485C-8624-F1F22086B5E9@linux.dev> <ZsxI6uCbGpQh1XrF@fedora>
To: Ming Lei <ming.lei@redhat.com>
X-Migadu-Flow: FLOW_OUT



> On Aug 26, 2024, at 17:20, Ming Lei <ming.lei@redhat.com> wrote:
>=20
> On Mon, Aug 26, 2024 at 03:33:18PM +0800, Muchun Song wrote:
>>=20
>>=20
>>> On Aug 26, 2024, at 15:06, Muchun Song <songmuchun@bytedance.com> =
wrote:
>>>=20
>>> On Fri, Aug 23, 2024 at 7:28=E2=80=AFPM Ming Lei =
<ming.lei@redhat.com> wrote:
>>>>=20
>>>> On Sun, Aug 11, 2024 at 06:19:21 PM +0800, Muchun Song wrote:
>>>>> Supposing the following scenario.
>>>>>=20
>>>>> CPU0                                                               =
 CPU1
>>>>>=20
>>>>> blk_mq_request_issue_directly()                                    =
 blk_mq_unquiesce_queue()
>>>>>   if (blk_queue_quiesced())                                        =
   blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)   3) store
>>>>>       blk_mq_insert_request()                                      =
   blk_mq_run_hw_queues()
>>>>>           /*                                                       =
       blk_mq_run_hw_queue()
>>>>>            * Add request to dispatch list or set bitmap of         =
           if (!blk_mq_hctx_has_pending())     4) load
>>>>>            * software queue.                  1) store             =
               return
>>>>>            */
>>>>>       blk_mq_run_hw_queue()
>>>>>           if (blk_queue_quiesced())           2) load
>>>>>               return
>>>>>           blk_mq_sched_dispatch_requests()
>>>>>=20
>>>>> The full memory barrier should be inserted between 1) and 2), as =
well as
>>>>> between 3) and 4) to make sure that either CPU0 sees =
QUEUE_FLAG_QUIESCED is
>>>>> cleared or CPU1 sees dispatch list or setting of bitmap of =
software queue.
>>>>> Otherwise, either CPU will not re-run the hardware queue causing =
starvation.
>>>>=20
>>>> Memory barrier shouldn't serve as bug fix for two slow code paths.
>>>>=20
>>>> One simple fix is to add helper of blk_queue_quiesced_lock(), and
>>>> call the following check on CPU0:
>>>>=20
>>>>       if (blk_queue_quiesced_lock())
>>>>        blk_mq_run_hw_queue();
>>>=20
>>> This only fixes blk_mq_request_issue_directly(), I think anywhere =
that
>>> matching this
>>> pattern (inserting a request to dispatch list and then running the
>>> hardware queue)
>>> should be fixed. And I think there are many places which match this
>>> pattern (E.g.
>>> blk_mq_submit_bio()). The above graph should be adjusted to the =
following.
>>>=20
>>> CPU0                                        CPU1
>>>=20
>>> blk_mq_insert_request()         1) store    blk_mq_unquiesce_queue()
>>> blk_mq_run_hw_queue()
>>> blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)       3) store
>>>   if (blk_queue_quiesced())   2) load         blk_mq_run_hw_queues()
>>>       return                                      =
blk_mq_run_hw_queue()
>>>   blk_mq_sched_dispatch_requests()                    if
>>> (!blk_mq_hctx_has_pending())     4) load
>>>                                                           return
>>=20
>> Sorry. There is something wrong with my email client. Resend the =
graph.
>>=20
>> CPU0                                        CPU1
>>=20
>> blk_mq_insert_request()         1) store    blk_mq_unquiesce_queue()
>> blk_mq_run_hw_queue()                       =
blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)       3) store
>>    if (blk_queue_quiesced())   2) load         blk_mq_run_hw_queues()
>>        return                                      =
blk_mq_run_hw_queue()
>>    blk_mq_sched_dispatch_requests()                    if =
(!blk_mq_hctx_has_pending())     4) load
>>                                                            return
>=20
> OK.
>=20
> The issue shouldn't exist if blk_queue_quiesced() return false in
> blk_mq_run_hw_queue(), so it is still one race in two slow paths?
>=20
> I guess the barrier-less approach should work too, such as:
>=20

If we prefer barrier-less approach, I think the following solution
will work as well, I'll use it in v2. Thanks.

>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e3c3c0c21b55..632261982a77 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2202,6 +2202,12 @@ void blk_mq_delay_run_hw_queue(struct =
blk_mq_hw_ctx *hctx, unsigned long msecs)
> }
> EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
>=20
> +static inline bool blk_mq_hw_queue_need_run(struct blk_mq_hw_ctx =
*hctx)
> +{
> + 	return !blk_queue_quiesced(hctx->queue) &&
> + 		blk_mq_hctx_has_pending(hctx);
> +}
> +
> /**
>  * blk_mq_run_hw_queue - Start to run a hardware queue.
>  * @hctx: Pointer to the hardware queue to run.
> @@ -2231,11 +2237,19 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx =
*hctx, bool async)
>  * quiesced.
>  */
> 	__blk_mq_run_dispatch_ops(hctx->queue, false,
> - 		need_run =3D !blk_queue_quiesced(hctx->queue) &&
> - 		blk_mq_hctx_has_pending(hctx));
> + 		need_run =3D blk_mq_hw_queue_need_run(hctx));
>=20
> - 	if (!need_run)
> - 		return;
> + 	if (!need_run) {
> + 		unsigned long flags;
> +
> + 		/* sync with unquiesce */
> + 		spin_lock_irqsave(&hctx->queue->queue_lock, flags);
> + 		need_run =3D blk_mq_hw_queue_need_run(hctx);

One question here: should we use __blk_mq_run_dispatch_ops()? I saw a =
comment above.
It seems it is safe to call blk_mq_hw_queue_need_run under [s]rcu lock.

Thanks.

> + 		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
> +
> + 		if (!need_run)
> + 			return;
> + 	}
>=20
> 	if (async || !cpumask_test_cpu(raw_smp_processor_id(), =
hctx->cpumask)) {
> 		blk_mq_delay_run_hw_queue(hctx, 0);
>=20
>=20
> thanks,
> Ming



