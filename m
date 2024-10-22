Return-Path: <linux-block+bounces-12878-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF669A9BED
	for <lists+linux-block@lfdr.de>; Tue, 22 Oct 2024 10:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C141C233A6
	for <lists+linux-block@lfdr.de>; Tue, 22 Oct 2024 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9ED1714C8;
	Tue, 22 Oct 2024 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fd8kU5wD"
X-Original-To: linux-block@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF5155333
	for <linux-block@vger.kernel.org>; Tue, 22 Oct 2024 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729584177; cv=none; b=ECqUvPOHJ8u2rvsqJJ95bgohqL/U25UyWThg77/j/K0j1Uxp0soSfOz2/6P4hrCtpZ7Esun7lDfbguc/irAjHDoqj0u9Af/3DczdmnAICy+A5hTQbiSk98gxXKm3DjAnGjOPEZT/3MWLlo6qwXSaBWXc90Oz7skSVo/WoMgVOQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729584177; c=relaxed/simple;
	bh=+F0JhNdgzeINwJGp8wLr2K56CdFX9zvu92jlmDr2FQs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=A8KnfXR2ZtPHFM0utPgBn1I3heri3vTZe08/cxQGBQLRJoGxZMOY6fuR2scWFbEQ7ZvP1WcEJ6xJY5BhuNd8bcyF/OJDJtoqPwwlTX1YM/9LiBUs7U1zsIkI9GqkLa2DTo7K5DghuF0JYbnfhXy9k6yUCokJbwzstObrxtqshs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fd8kU5wD; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729584173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MNvdWP267aP5o9FLGaB5KaigNk7jDTNgJvyHFcfALiU=;
	b=Fd8kU5wDYa75gvarplLzjQWRfCrAp4woVPFWXP6NsRqiDtQUoxhJwByOqgdwfXIXPRMSEj
	nXhfkRtPYjkMj71cko1IDYvyPu+KXH7sSY+czCYgJ26TSXNEHsYwt1r6iUn9bIboAQIUUg
	7cRsTlp5+eipUQHbxuJIeDJpekLQiQQ=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH] block: remove redundant explicit memory barrier from
 rq_qos waiter and waker
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <c297cba9-5136-46b6-b2a4-5169a1a3f7cf@linux.dev>
Date: Tue, 22 Oct 2024 16:02:11 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 axboe@kernel.dk,
 josef@toxicpanda.com,
 oleg@redhat.com,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A88698A8-4334-4521-BEE9-39910D37C3DF@linux.dev>
References: <20241021085251.73353-1-songmuchun@bytedance.com>
 <c297cba9-5136-46b6-b2a4-5169a1a3f7cf@linux.dev>
To: Chengming Zhou <chengming.zhou@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Oct 22, 2024, at 15:53, Chengming Zhou <chengming.zhou@linux.dev> =
wrote:
>=20
> On 2024/10/21 16:52, Muchun Song wrote:
>> The memory barriers in list_del_init_careful() and =
list_empty_careful()
>> in pairs already handle the proper ordering between data.got_token
>> and data.wq.entry. So remove the redundant explicit barriers. And =
also
>> change a "break" statement to "return" to avoid redundant calling of
>> finish_wait().
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>=20
> Good catch! Just a small nit below, feel free to add:
>=20
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
>=20
>> ---
>>  block/blk-rq-qos.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
>> index dc510f493ba57..9b0aa7dd6779f 100644
>> --- a/block/blk-rq-qos.c
>> +++ b/block/blk-rq-qos.c
>> @@ -218,7 +218,6 @@ static int rq_qos_wake_function(struct =
wait_queue_entry *curr,
>>   		return -1;
>>     	data->got_token =3D true;
>> - 	smp_wmb();
>>   	wake_up_process(data->task);
>>   	list_del_init_careful(&curr->entry);
>>   	return 1;
>> @@ -274,10 +273,9 @@ void rq_qos_wait(struct rq_wait *rqw, void =
*private_data,
>>  			 * which means we now have two. Put our local =
token
>>  			 * and wake anyone else potentially waiting for =
one.
>>  			 */
>> - 			smp_rmb();
>>   			if (data.got_token)
>>   				cleanup_cb(rqw, private_data);
>> - 			break;
>> + 			return;
>>   		}
>=20
> Would it be better to move this acquire_inflight_cb() above out of
> the do-while(1) since we rely on the waker to get inflight counter
> for us?

I also noticed about this and I am working on this. Will send a separate
patch for this refactoring later.

Thanks.

>=20
> Thanks.
>=20
>>   io_schedule();
>>   has_sleeper =3D true;


