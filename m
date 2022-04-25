Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB96150D9E0
	for <lists+linux-block@lfdr.de>; Mon, 25 Apr 2022 09:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiDYHKM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 25 Apr 2022 03:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbiDYHKJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Apr 2022 03:10:09 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDEE261
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 00:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650870425; x=1682406425;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+t8dNH5xmbamJ6RM40rXearVG3TcmDoofJmFgspWju8=;
  b=bNx45EgMO31Jbo0jmoG7mLWgVHTgpHdsxGcyT9r5nKG5wgwKdXdubdJG
   Zl5JZvUlS17x5RRLV3Ts5rcudMcXGPliASYGMp840rHARMRoDN+66PYhk
   Cy6rtYlXWCbJhT807I5vqagMuv8e9DYqBYE20dmcoqqVPU+tgQ6G5pIOh
   ZJ7BYN1sh+nsjjfDbbZBjpMqQczfWvY+1A4zBI4QkOMACfD0539hdVLE6
   6ZF9mVeqLkqigvgsq55t+HDgKKpz3TicmgfWqiqRrpU/pZecioJWLflRy
   n25vo9lUTz5YTNywxHOlsNu2ZfaFPuJPy/CPUmngR93CVej4wnqxTQD6x
   w==;
X-IronPort-AV: E=Sophos;i="5.90,287,1643644800"; 
   d="scan'208";a="302940213"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2022 15:07:05 +0800
IronPort-SDR: F8E9cV4oCwNdPU3bxKtcYUkfzMDKBSQxpKEcuTCP7H/YlciqQWkg2ZEQeSp9++/QJKgfFoe7Rl
 D9Lsy30rMjW8L2SZuiwhHQj9gDKuE0ypBxL7W/XhyHOis6kuHQw3Y6kmEdHguWF4HzLuuqe6W7
 bOW9MSz78CWJlqbN97Yigq7JJnibtTdVdM1978skMl9ntxJT0Kdyi0ox80713sEXqtVuuIJ/9F
 lBFoVUV+hMQruKzIN9hqClh8CDqp3NhP8AKRFaiXG7YScHGN/jgCamrY8ez9c/MUY9dmGl8dH3
 QlEO9xbNMcXIU5eClKt4stfa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 23:37:17 -0700
IronPort-SDR: B9bEzS7ytPupomGobErzy0fkazx89fGPB++XK4c9hpal8B2bNMjHxnucZC6azqbil5+tfL1OJI
 CrmC3bAS7FM9ZJjw2LmVIuP1EYetVH55MAz/NnAWWRna/H9ZVisrC8erT/VYnfbhX+ACrcjyKw
 CvMDRXHQJ1E+qQWnKqLFUTU1xhB+dapo4FYrfphs5dHBqQFpkunF1JhlAg2yM1gaO3IsLwtI9T
 67x8kZu0NFTYcmuxJteVd7uJlAXj4jg75qQ8Y9UogoJVJb88SdvaxYvj2LG9/tIrZmOsMJIL4M
 DB0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Apr 2022 00:07:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kmx0857lKz1SVp0
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 00:07:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650870423; x=1653462424; bh=+t8dNH5xmbamJ6RM40rXearVG3TcmDoofJm
        FgspWju8=; b=UC5QpaNjrvrLQkMLhqgHigYe4vpTcxYSoDimin1DZYMSEakGpgD
        BhYw9HDhL/lx1Zt57YA0/VpLslkaD78KiJmwhrw/tXAdTVxd+6yGYTrsjaOTAIOU
        nEx4nY6hFPOwwL5iNRRl8Nmn2++VnGNEu/lgIgC6LadfJ0HHqx65rXEX8vAY6WNq
        FKe8kR0xLw1iG7sJ7/LstILZwC0w9aBdiByBLkz5h/wCFHPt5xaYhNRWVY9acxhf
        NaKaHy80xUECPkaDZvmQciN2f/t+cUKmt8dFs7mDxJiIfxw7MnBNLqTBaek2fbHP
        RzmcL5UlTed8m6GqN1KDMZeVzSaIbkNzdxg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ko3KjhvMwmr4 for <linux-block@vger.kernel.org>;
        Mon, 25 Apr 2022 00:07:03 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kmx046kQtz1Rvlx;
        Mon, 25 Apr 2022 00:07:00 -0700 (PDT)
Message-ID: <2e7969ea-68d0-964a-808e-ee8943de70e3@opensource.wdc.com>
Date:   Mon, 25 Apr 2022 16:06:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next RFC v3 0/8] improve tag allocation under heavy load
Content-Language: en-US
To:     "yukuai (C)" <yukuai3@huawei.com>, axboe@kernel.dk,
        bvanassche@acm.org, andriy.shevchenko@linux.intel.com,
        john.garry@huawei.com, ming.lei@redhat.com, qiulaibin@huawei.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220415101053.554495-1-yukuai3@huawei.com>
 <dc800086-43c6-1ff2-659e-258cb75649dd@huawei.com>
 <3fbadd9f-11dd-9043-11cf-f0839dcf30e1@opensource.wdc.com>
 <63e84f2a-2487-a0c3-cab2-7d2011bc2db4@huawei.com>
 <55e8b04f-0d2f-2ce1-6514-5abd0b67fd48@opensource.wdc.com>
 <6957af40-8720-d74b-5be7-6bcdd9aa1089@huawei.com>
 <237a43f0-3b09-46d0-e73c-57ef51e39590@opensource.wdc.com>
 <c11ebf9e-a232-4a5d-d539-f95f584f220e@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <c11ebf9e-a232-4a5d-d539-f95f584f220e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/25/22 16:05, yukuai (C) wrote:
> =E5=9C=A8 2022/04/25 14:50, Damien Le Moal =E5=86=99=E9=81=93:
>> On 4/25/22 15:47, yukuai (C) wrote:
>>> =E5=9C=A8 2022/04/25 14:23, Damien Le Moal =E5=86=99=E9=81=93:
>>>> On 4/25/22 15:14, yukuai (C) wrote:
>>>>> =E5=9C=A8 2022/04/25 11:24, Damien Le Moal =E5=86=99=E9=81=93:
>>>>>> On 4/24/22 11:43, yukuai (C) wrote:
>>>>>>> friendly ping ...
>>>>>>>
>>>>>>> =E5=9C=A8 2022/04/15 18:10, Yu Kuai =E5=86=99=E9=81=93:
>>>>>>>> Changes in v3:
>>>>>>>>      - update 'waiters_cnt' before 'ws_active' in sbitmap_prepar=
e_to_wait()
>>>>>>>>      in patch 1, in case __sbq_wake_up() see 'ws_active > 0' whi=
le
>>>>>>>>      'waiters_cnt' are all 0, which will cause deap loop.
>>>>>>>>      - don't add 'wait_index' during each loop in patch 2
>>>>>>>>      - fix that 'wake_index' might mismatch in the first wake up=
 in patch 3,
>>>>>>>>      also improving coding for the patch.
>>>>>>>>      - add a detection in patch 4 in case io hung is triggered i=
n corner
>>>>>>>>      cases.
>>>>>>>>      - make the detection, free tags are sufficient, more flexib=
le.
>>>>>>>>      - fix a race in patch 8.
>>>>>>>>      - fix some words and add some comments.
>>>>>>>>
>>>>>>>> Changes in v2:
>>>>>>>>      - use a new title
>>>>>>>>      - add patches to fix waitqueues' unfairness - path 1-3
>>>>>>>>      - delete patch to add queue flag
>>>>>>>>      - delete patch to split big io thoroughly
>>>>>>>>
>>>>>>>> In this patchset:
>>>>>>>>      - patch 1-3 fix waitqueues' unfairness.
>>>>>>>>      - patch 4,5 disable tag preemption on heavy load.
>>>>>>>>      - patch 6 forces tag preemption for split bios.
>>>>>>>>      - patch 7,8 improve large random io for HDD. We do meet the=
 problem and
>>>>>>>>      I'm trying to fix it at very low cost. However, if anyone s=
till thinks
>>>>>>>>      this is not a common case and not worth to optimize, I'll d=
rop them.
>>>>>>>>
>>>>>>>> There is a defect for blk-mq compare to blk-sq, specifically spl=
it io
>>>>>>>> will end up discontinuous if the device is under high io pressur=
e, while
>>>>>>>> split io will still be continuous in sq, this is because:
>>>>>>>>
>>>>>>>> 1) new io can preempt tag even if there are lots of threads wait=
ing.
>>>>>>>> 2) split bio is issued one by one, if one bio can't get tag, it =
will go
>>>>>>>> to wail.
>>>>>>>> 3) each time 8(or wake batch) requests is done, 8 waiters will b=
e woken up.
>>>>>>>> Thus if a thread is woken up, it will unlikey to get multiple ta=
gs.
>>>>>>>>
>>>>>>>> The problem was first found by upgrading kernel from v3.10 to v4=
.18,
>>>>>>>> test device is HDD with 256 'max_sectors_kb', and test case is i=
ssuing 1m
>>>>>>>> ios with high concurrency.
>>>>>>>>
>>>>>>>> Noted that there is a precondition for such performance problem:
>>>>>>>> There is a certain gap between bandwidth for single io with
>>>>>>>> bs=3Dmax_sectors_kb and disk upper limit.
>>>>>>>>
>>>>>>>> During the test, I found that waitqueues can be extremly unbalan=
ced on
>>>>>>>> heavy load. This is because 'wake_index' is not set properly in
>>>>>>>> __sbq_wake_up(), see details in patch 3.
>>>>>>>>
>>>>>>>> Test environment:
>>>>>>>> arm64, 96 core with 200 BogoMIPS, test device is HDD. The defaul=
t
>>>>>>>> 'max_sectors_kb' is 1280(Sorry that I was unable to test on the =
machine
>>>>>>>> where 'max_sectors_kb' is 256).>>
>>>>>>>> The single io performance(randwrite):
>>>>>>>>
>>>>>>>> | bs       | 128k | 256k | 512k | 1m   | 1280k | 2m   | 4m   |
>>>>>>>> | -------- | ---- | ---- | ---- | ---- | ----- | ---- | ---- |
>>>>>>>> | bw MiB/s | 20.1 | 33.4 | 51.8 | 67.1 | 74.7  | 82.9 | 82.9 |
>>>>>>
>>>>>> These results are extremely strange, unless you are running with t=
he
>>>>>> device write cache disabled ? If you have the device write cache e=
nabled,
>>>>>> the problem you mention above would be most likely completely invi=
sible,
>>>>>> which I guess is why nobody really noticed any issue until now.
>>>>>>
>>>>>> Similarly, with reads, the device side read-ahead may hide the pro=
blem,
>>>>>> albeit that depends on how "intelligent" the drive is at identifyi=
ng
>>>>>> sequential accesses.
>>>>>>
>>>>>>>>
>>>>>>>> It can be seen that 1280k io is already close to upper limit, an=
d it'll
>>>>>>>> be hard to see differences with the default value, thus I set
>>>>>>>> 'max_sectors_kb' to 128 in the following test.
>>>>>>>>
>>>>>>>> Test cmd:
>>>>>>>>             fio \
>>>>>>>>             -filename=3D/dev/$dev \
>>>>>>>>             -name=3Dtest \
>>>>>>>>             -ioengine=3Dpsync \
>>>>>>>>             -allow_mounted_write=3D0 \
>>>>>>>>             -group_reporting \
>>>>>>>>             -direct=3D1 \
>>>>>>>>             -offset_increment=3D1g \
>>>>>>>>             -rw=3Drandwrite \
>>>>>>>>             -bs=3D1024k \
>>>>>>>>             -numjobs=3D{1,2,4,8,16,32,64,128,256,512} \
>>>>>>>>             -runtime=3D110 \
>>>>>>>>             -ramp_time=3D10
>>>>>>>>
>>>>>>>> Test result: MiB/s
>>>>>>>>
>>>>>>>> | numjobs | v5.18-rc1 | v5.18-rc1-patched |
>>>>>>>> | ------- | --------- | ----------------- |
>>>>>>>> | 1       | 67.7      | 67.7              |
>>>>>>>> | 2       | 67.7      | 67.7              |
>>>>>>>> | 4       | 67.7      | 67.7              |
>>>>>>>> | 8       | 67.7      | 67.7              |
>>>>>>>> | 16      | 64.8      | 65.6              |
>>>>>>>> | 32      | 59.8      | 63.8              |
>>>>>>>> | 64      | 54.9      | 59.4              |
>>>>>>>> | 128     | 49        | 56.9              |
>>>>>>>> | 256     | 37.7      | 58.3              |
>>>>>>>> | 512     | 31.8      | 57.9              |
>>>>>>
>>>>>> Device write cache disabled ?
>>>>>>
>>>>>> Also, what is the max QD of this disk ?
>>>>>>
>>>>>> E.g., if it is SATA, it is 32, so you will only get at most 64 sch=
eduler
>>>>>> tags. So for any of your tests with more than 64 threads, many of =
the
>>>>>> threads will be waiting for a scheduler tag for the BIO before the
>>>>>> bio_split problem you explain triggers. Given that the numbers you=
 show
>>>>>> are the same for before-after patch with a number of threads <=3D =
64, I am
>>>>>> tempted to think that the problem is not really BIO splitting...
>>>>>>
>>>>>> What about random read workloads ? What kind of results do you see=
 ?
>>>>>
>>>>> Hi,
>>>>>
>>>>> Sorry about the misleading of this test case.
>>>>>
>>>>> This testcase is high concurrency huge randwrite, it's just for the
>>>>> problem that split bios won't be issued continuously, which is the
>>>>> root cause of the performance degradation as the numjobs increases.
>>>>>
>>>>> queue_depth is 32, and numjobs is 64, thus when numjobs is not grea=
ter
>>>>> than 8, performance is fine, because the ratio of sequential io sho=
uld
>>>>> be 7/8. However, as numjobs increases, performance is worse because
>>>>> the ratio is lower. For example, when numjobs is 512, the ratio of
>>>>> sequential io is about 20%.
>>>>
>>>> But with 512 jobs, you will get only 64 jobs only with IOs in the qu=
eue.
>>>> All other jobs will be waiting for a scheduler tag before being able=
 to
>>>> issue their large BIO. No ?
>>>
>>> Hi,
>>>
>>> It's right.
>>>
>>> In fact, after this patchset, since each large io will need total 8
>>> tags, only 8 jobs can be in the queue while others are waiting for
>>> scheduler tag.
>>>
>>>>
>>>> It sounds like the set of scheduler tags should be a bit more elasti=
c:
>>>> always allow BIOs from a split of a large BIO to be submitted (that =
is to
>>>> get a scheduler tag) even if that causes a temporary excess of the n=
umber
>>>> of requests beyond the default number of scheduler tags. Doing so, a=
ll
>>>> fragments of a large BIOs can be queued immediately. From there, if =
the
>>>> scheduler operates correctly, all the requests from the large BIOs s=
plit
>>>> would be issued in sequence to the device.
>>>
>>> This solution sounds feasible in theory, however, I'm not sure yet ho=
w
>>> to implement that 'temporary excess'.
>>
>> It should not be too hard.
>=20
> I'll try to figure out a proper way, in the meantime, any suggestions
> would be appreciated.
>>
>> By the way, did you check that doing something like:
>>
>> echo 2048 > /sys/block/sdX/queue/nr_requests
>>
>> improves performance for your high number of jobs test case ?
>=20
> Yes, performance will not degrade when numjobs is not greater than 256
> in this case.

That is my thinking as well. I am asking if did check that (did you run i=
t ?).

>>
>>>
>>> Thanks,
>>> Kuai
>>>>
>>>>
>>>>>
>>>>> patch 6-8 will let split bios still be issued continuously under hi=
gh
>>>>> pressure.
>>>>>
>>>>> Thanks,
>>>>> Kuai
>>>>>
>>>>
>>>>
>>
>>


--=20
Damien Le Moal
Western Digital Research
