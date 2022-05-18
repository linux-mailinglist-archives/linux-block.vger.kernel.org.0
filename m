Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6D152BC18
	for <lists+linux-block@lfdr.de>; Wed, 18 May 2022 16:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbiERNlN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 18 May 2022 09:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbiERNkv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 09:40:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4E3B84E
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 06:40:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id p26so3071141eds.5
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 06:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unimore.it; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=C4enMuSsWShHZvSMfmofWFHp1s0VWIVvo26glgzEjsU=;
        b=P4SxG7mcd2ke1GYLJFHSLqgxP7V7hogPl4RGWYBlVVrhY0axP1Iky6IK5YixeM5qp6
         3P9VhN+xwQ9KOpKRMWfvAQN2c6IT+8AooRe1nS9VL4wwXGzFeYH7G3Q7EscLmz15j+OW
         OB5DmKYjWSx3K7kjSVfSN5kIKYTK2qlUaos8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=C4enMuSsWShHZvSMfmofWFHp1s0VWIVvo26glgzEjsU=;
        b=vhKIxp3oJomTFb/McZdU16fhQB26fGT4tJcD2IBkKg9qxCHQ8G7bIG1yjNyg6z1Uet
         SpVjbmxU28iXmXy3NbO+187BKu6ubyI8J9LedulO3I3VggUkXz6pX65B+wY7cn92mZT4
         QFtYEaQ+tx3OgnXW1ChPqQUFzMioZZRwo67+hKYOJkPQiwF1t6R4wX+BoKXDqWUN9vXC
         /fQqTZdOIYmAam/0EwanQgyJhWsktJHC+/YHkhgNluHBZInxogebIndoVR5rxdMZ7/rc
         ZU0xnobxRdtZloZLFzStmOk/xuPVTq0PtoAWJcGd3kUihdVUvCvkzPFlAN02QJregHci
         OyzA==
X-Gm-Message-State: AOAM530lGWZ1P17HcG3oFDLCM2yTX7bEUKhx02jwxjEXiWlUT1MvE0Fd
        poPKlVDcM6gu6s3wVF37jWoL
X-Google-Smtp-Source: ABdhPJwTPnRlBvY02OOPDtbxOajP27ccZ9X78R/IJy1C8Be6exSnJxYvAQyjuumvZ/BeEbQhBTQ0lQ==
X-Received: by 2002:a05:6402:2803:b0:42a:e4de:3270 with SMTP id h3-20020a056402280300b0042ae4de3270mr4516167ede.261.1652881244720;
        Wed, 18 May 2022 06:40:44 -0700 (PDT)
Received: from [192.168.94.233] (mob-5-90-205-72.net.vodafone.it. [5.90.205.72])
        by smtp.gmail.com with ESMTPSA id n24-20020a056402515800b0042ad0358c8bsm1353204edd.38.2022.05.18.06.40.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 May 2022 06:40:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v2 2/2] block, bfq: make bfq_has_work() more
 accurate
From:   Paolo VALENTE <paolo.valente@unimore.it>
In-Reply-To: <54d06657-a5e2-a94d-c9af-2f10900e7f32@huawei.com>
Date:   Wed, 18 May 2022 15:40:05 +0200
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <75C5D422-A11F-4965-8785-781E13EC6C1B@unimore.it>
References: <20220513023507.2625717-1-yukuai3@huawei.com>
 <20220513023507.2625717-3-yukuai3@huawei.com>
 <20220516095620.ge5gxmwrnbanfqea@quack3.lan>
 <740D270D-8723-4399-82CC-26CD861843D7@linaro.org>
 <22FEB802-2872-45A7-8ED8-2DE7D0D5E6CD@linaro.org>
 <54d06657-a5e2-a94d-c9af-2f10900e7f32@huawei.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 18 mag 2022, alle ore 03:17, yukuai (C) <yukuai3@huawei.com> =
ha scritto:
>=20
> =E5=9C=A8 2022/05/17 23:06, Paolo Valente =E5=86=99=E9=81=93:
>>> Il giorno 17 mag 2022, alle ore 16:21, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>>=20
>>>=20
>>>=20
>>>> Il giorno 16 mag 2022, alle ore 11:56, Jan Kara <jack@suse.cz> ha =
scritto:
>>>>=20
>>>> On Fri 13-05-22 10:35:07, Yu Kuai wrote:
>>>>> bfq_has_work() is using busy_queues currently, which is not =
accurate
>>>>> because bfq_queue is busy doesn't represent that it has requests. =
Since
>>>>> bfqd aready has a counter 'queued' to record how many requests are =
in
>>>>> bfq, use it instead of busy_queues.
>>>>>=20
>>>=20
>>> The number of requests queued is not equal to the number of busy
>>> queues (it is >=3D).
>> No, sorry. It is actually !=3D in general.
> Hi, Paolo
>=20
> I'm aware that number of requests queued is not equal to the number of
> busy queues, and that is the motivation of this patch.
>=20
>> In particular, if queued =3D=3D 0 but there are busy queues (although
>> still waiting for I/O to arrive), then responding that there is no
>> work caused blk-mq to stop asking, and hence an I/O freeze.  IOW I/O
>> eventually arrives for a busy queue, but blk-mq does not ask for a =
new
>> request any longer.  But maybe things have changed around bfq since
>> then.
>=20
> The problem is that if queued =3D=3D 0 while there are busy queues, is =
there
> any point to return true in bfq_has_work() ? IMO, it will only cause
> unecessary run queue. And if new request arrives,
> blk_mq_sched_insert_request() will trigger a run queue.

Great, if this is the scheme now, then the patch is correct and =
optimizing.

Thanks,
Paolo

>=20
> Thanks,
> Kuai
>> Paolo
>>>  If this patch is based on this assumption then
>>> unfortunately it is wrong :(
>>>=20
>>> Paolo
>>>=20
>>>>> Noted that bfq_has_work() can be called with 'bfqd->lock' held, =
thus the
>>>>> lock can't be held in bfq_has_work() to protect 'bfqd->queued'.
>>>>>=20
>>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>>=20
>>>> Looks good. Feel free to add:
>>>>=20
>>>> Reviewed-by: Jan Kara <jack@suse.cz>
>>>>=20
>>>> 								Honza
>>>>=20
>>>>> ---
>>>>> block/bfq-iosched.c | 16 ++++++++++++----
>>>>> 1 file changed, 12 insertions(+), 4 deletions(-)
>>>>>=20
>>>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>>>> index 61750696e87f..740dd83853a6 100644
>>>>> --- a/block/bfq-iosched.c
>>>>> +++ b/block/bfq-iosched.c
>>>>> @@ -2210,7 +2210,11 @@ static void bfq_add_request(struct request =
*rq)
>>>>>=20
>>>>> 	bfq_log_bfqq(bfqd, bfqq, "add_request %d", rq_is_sync(rq));
>>>>> 	bfqq->queued[rq_is_sync(rq)]++;
>>>>> -	bfqd->queued++;
>>>>> +	/*
>>>>> +	 * Updating of 'bfqd->queued' is protected by 'bfqd->lock', =
however, it
>>>>> +	 * may be read without holding the lock in bfq_has_work().
>>>>> +	 */
>>>>> +	WRITE_ONCE(bfqd->queued, bfqd->queued + 1);
>>>>>=20
>>>>> 	if (RB_EMPTY_ROOT(&bfqq->sort_list) && bfq_bfqq_sync(bfqq)) {
>>>>> 		bfq_check_waker(bfqd, bfqq, now_ns);
>>>>> @@ -2402,7 +2406,11 @@ static void bfq_remove_request(struct =
request_queue *q,
>>>>> 	if (rq->queuelist.prev !=3D &rq->queuelist)
>>>>> 		list_del_init(&rq->queuelist);
>>>>> 	bfqq->queued[sync]--;
>>>>> -	bfqd->queued--;
>>>>> +	/*
>>>>> +	 * Updating of 'bfqd->queued' is protected by 'bfqd->lock', =
however, it
>>>>> +	 * may be read without holding the lock in bfq_has_work().
>>>>> +	 */
>>>>> +	WRITE_ONCE(bfqd->queued, bfqd->queued - 1);
>>>>> 	elv_rb_del(&bfqq->sort_list, rq);
>>>>>=20
>>>>> 	elv_rqhash_del(q, rq);
>>>>> @@ -5063,11 +5071,11 @@ static bool bfq_has_work(struct =
blk_mq_hw_ctx *hctx)
>>>>> 	struct bfq_data *bfqd =3D hctx->queue->elevator->elevator_data;
>>>>>=20
>>>>> 	/*
>>>>> -	 * Avoiding lock: a race on bfqd->busy_queues should cause at
>>>>> +	 * Avoiding lock: a race on bfqd->queued should cause at
>>>>> 	 * most a call to dispatch for nothing
>>>>> 	 */
>>>>> 	return !list_empty_careful(&bfqd->dispatch) ||
>>>>> -		bfq_tot_busy_queues(bfqd) > 0;
>>>>> +		READ_ONCE(bfqd->queued);
>>>>> }
>>>>>=20
>>>>> static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx =
*hctx)
>>>>> --=20
>>>>> 2.31.1
>>>>>=20
>>>> --=20
>>>> Jan Kara <jack@suse.com>
>>>> SUSE Labs, CR
>>>=20
>> .

