Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A495A8BD7
	for <lists+linux-block@lfdr.de>; Thu,  1 Sep 2022 05:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiIADQw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 31 Aug 2022 23:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiIADQu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 23:16:50 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278DC111AD6
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 20:16:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VNuiB3Q_1662002201;
Received: from 30.97.56.214(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VNuiB3Q_1662002201)
          by smtp.aliyun-inc.com;
          Thu, 01 Sep 2022 11:16:42 +0800
Message-ID: <111bfafe-4d8a-8aec-8d33-958c03bd12c0@linux.alibaba.com>
Date:   Thu, 1 Sep 2022 11:16:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V2 1/1] Docs: ublk: add ublk document
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
References: <20220901023008.669893-1-ming.lei@redhat.com>
 <0dc0e0ac-75cd-81e5-e54b-1b0436090f4c@linux.alibaba.com>
 <YxAjJJLoU7LR4ahh@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <YxAjJJLoU7LR4ahh@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/9/1 11:12, Ming Lei wrote:
> On Thu, Sep 01, 2022 at 11:04:24AM +0800, Ziyang Zhang wrote:
>> On 2022/9/1 10:30, Ming Lei wrote:
>>> +
>>> +- ``UBLK_IO_NEED_GET_DATA``
>>> +
>>> +  ublk server pre-allocates IO buffer for each IO by default. Any new projects
>>> +  should use this buffer to communicate with ublk driver. However, existing
>>> +  projects may break or not able to consume the new buffer interface; that's
>>> +  why this command is added for backwards compatibility so that existing
>>> +  projects can still consume existing buffers.
>>
>> Hi, Ming.
>>
>> Could you please add more information on UBLK_IO_NEED_GET_DATA. stefanha
>> found it hard to understand.
>>
>> Myabe we should write like this:
>>
>> With UBLK_F_NEED_GET_DATA enabled, the WRITE request will be firstly issued to
>> ublksrv without data copy. Then, IO backend receives the request and it can allocate
>> data buffer and embed its addr inside a new ioucmd. After the kernel driver gets the
>> ioucmd, the data copy happens(from biovecs to backend's buffer). Finally,
>> the backend receives the request again with data to be written and it can truly
>> handle the request.
>>
>> UBLK_IO_NEED_GET_DATA add one additional round-trip in ublk_drv and one
>> io_uring_enter() syscall. Any user thinks that it may lower performance
>> should not enable UBLK_F_NEED_GET_DATA. ublk server pre-allocates IO buffer
>> for each IO by default. Any new projects should use this buffer to communicate
>> with ublk driver. However, existing projects may break or not able to consume
>> the new buffer interface; that's why this command is added for backwards
>> compatibility so that existing projects can still consume existing buffers.
> 
> I am fine to add it if V3 is needed. If not, please send a new patch.
> 
> BTW, I guess Jens may consider it for v6.0.

Please add it to V3, Ming.

Thanks,
Zhang
