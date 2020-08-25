Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABB6251E4A
	for <lists+linux-block@lfdr.de>; Tue, 25 Aug 2020 19:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHYRaD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 Aug 2020 13:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYRaD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 13:30:03 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A26C061574
        for <linux-block@vger.kernel.org>; Tue, 25 Aug 2020 10:30:02 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d27so9550312qtg.4
        for <linux-block@vger.kernel.org>; Tue, 25 Aug 2020 10:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wp/i/cC15zgTxV6xOIq8aaZ9yXKH0W8qgN58c/JikW0=;
        b=WN5ItWTcZkC7BA2xluqGrDp/E16oAlKDvjq1yDroJ/Cag9rxdT9qE313SZojyta6Ke
         wNGRq60KjY6PsOg8XsYWFgRjqZUwpgGZIXl0toD9ZR3FOaZo5JxoeYqDvIXV6QKh0zuj
         je4nGL0qHLuztxpcJRi9uBISyYpgOe+m29I3slFWwDdmenXJGlsYsIcknznQ+DmcNXCP
         X0+lWZ1XfcjjXpH0zTw6kiVpYOeKYJNEESKkwwGDwSrO90sijfBCfSwfdsX15sq6El5M
         A5o44Cp9YAzE1U2mlT7YTxhxs7Knf3eOcUOYzmErNFSNWrfiqWUH4uKqERhsPIVeAIXB
         XYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wp/i/cC15zgTxV6xOIq8aaZ9yXKH0W8qgN58c/JikW0=;
        b=ZneRVh07/btTUaXrY6hs/u3qKbyWjeBFlqt8dWQMCkB2jAiEcysrpk7UdD2E4gseez
         atKdYogcj0W3bLiExvOLuIxCKrz3RcvaEhoQ0u/pmq4hPwnqYwUD7dyySvNzgyQ9wDFw
         TUBaaXwfDasgrGeWDHDgZogajCGlWg4/Zm64kxikFWxoFUcedQWsX9M1PtszQtadxy8o
         ROlFpK61THORAloRVAvw0VB7UZ+DomBtrHTghp6Or1WQNlihWlE1eb0fiIhW5yLrMJ22
         CRV+P8XTbJ+/je6jNGsDjma/Pg2ZQgey4owMxqND/mR1G+5b1HrIJURFylSd3zjNUW/m
         f4CA==
X-Gm-Message-State: AOAM533xFTpGcOK3FfrNDLMyEjfeTl48SqtOsXo46ZbtN+QJRk0e/9El
        E7UdmTqGmggGbm3O+vnawvfRiw==
X-Google-Smtp-Source: ABdhPJzFCENqN4F/R2IuPx2drXDj403SzuJhNZYR43utinpLPvx2w+76ONAdwCMBmzc37oA2Rd07ZQ==
X-Received: by 2002:ac8:320b:: with SMTP id x11mr9890437qta.320.1598376601926;
        Tue, 25 Aug 2020 10:30:01 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e8::1120? ([2620:10d:c091:480::1:4729])
        by smtp.gmail.com with ESMTPSA id x31sm10202070qtx.97.2020.08.25.10.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 10:30:01 -0700 (PDT)
Subject: Re: [PATCH] nbd: restore default timeout when setting it to zero
To:     Hou Pu <houpu@bytedance.com>, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
References: <20200810120044.2152-1-houpu@bytedance.com>
 <38b9de9e-38fe-3090-cea0-377c605c86d4@toxicpanda.com>
 <4e78e4b3-e75b-7428-703d-d8543bcfe348@bytedance.com>
 <1accbf37-1a57-f072-7dc4-063fee991189@toxicpanda.com>
 <701eaeb7-8b91-baa5-ebba-468f890c4cc5@bytedance.com>
 <59db0b1d-4b2c-7966-9c38-929083e7b8f1@toxicpanda.com>
 <6f81b077-e722-1d0e-a506-5507f71540cd@bytedance.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <27dc0e8c-e13b-4671-b739-30628696db7e@toxicpanda.com>
Date:   Tue, 25 Aug 2020 13:29:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6f81b077-e722-1d0e-a506-5507f71540cd@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/25/20 4:27 AM, Hou Pu wrote:
> 
> 
> On 2020/8/24 10:02 PM, Josef Bacik wrote:
>> On 8/23/20 11:23 PM, Hou Pu wrote:
>>>
>>>
>>> On 2020/8/21 9:57 PM, Josef Bacik wrote:
>>>> On 8/21/20 3:21 AM, Hou Pu wrote:
>>>>>
>>>>>
>>>>> On 2020/8/21 3:03 AM, Josef Bacik wrote:
>>>>>> On 8/10/20 8:00 AM, Hou Pu wrote:
>>>>>>> If we configured io timeout of nbd0 to 100s. Later after we
>>>>>>> finished using it, we configured nbd0 again and set the io
>>>>>>> timeout to 0. We expect it would timeout after 30 seconds
>>>>>>> and keep retry. But in fact we could not change the timeout
>>>>>>> when we set it to 0. the timeout is still the original 100s.
>>>>>>>
>>>>>>> So change the timeout to default 30s when we set it to zero.
>>>>>>> It also behaves same as commit 2da22da57348 ("nbd: fix zero
>>>>>>> cmd timeout handling v2").
>>>>>>>
>>>>>>> It becomes more important if we were reconfigure a nbd device
>>>>>>> and the io timeout it set to zero. Because it could take 30s
>>>>>>> to detect the new socket and thus io could be completed more
>>>>>>> quickly compared to 100s.
>>>>>>>
>>>>>>> Signed-off-by: Hou Pu <houpu@bytedance.com>
>>>>>>> ---
>>>>>>>   drivers/block/nbd.c | 2 ++
>>>>>>>   1 file changed, 2 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>>>>>>> index ce7e9f223b20..bc9dc1f847e1 100644
>>>>>>> --- a/drivers/block/nbd.c
>>>>>>> +++ b/drivers/block/nbd.c
>>>>>>> @@ -1360,6 +1360,8 @@ static void nbd_set_cmd_timeout(struct nbd_device 
>>>>>>> *nbd, u64 timeout)
>>>>>>>       nbd->tag_set.timeout = timeout * HZ;
>>>>>>>       if (timeout)
>>>>>>>           blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
>>>>>>> +    else
>>>>>>> +        blk_queue_rq_timeout(nbd->disk->queue, 30 * HZ);
>>>>>>>   }
>>>>>>>   /* Must be called with config_lock held */
>>>>>>>
>>>>>>
>>>>>> What about the tag_set.timeout?  Thanks,
>>>>>
>>>>> I think user space could set io timeout to 0, thus we set tag_set.timeout = 
>>>>> 0 here and also we should tell the block layer
>>>>> to restore 30s timeout in case it is not. tag_set.timeout == 0
>>>>> imply 30s io timeout and retrying after timeout.
>>>>>
>>>>> (Sorry, I am not sure if I understand your question here. Could
>>>>> you explain a little more if needed?)
>>>>>
>>>>
>>>> I misunderstood what I was using the tagset timeout for.  We don't want this 
>>>> here, if we're dropping a config for an nbd device and we want to reset it 
>>>> to defaults then we need to add this to nbd_config_put().  Thanks,
>>>
>>> AFAIK If we killed a nbd server, then restarted it and reconfigured
>>> the nbd socket, I think we might not reconfigure IO timeout to 0 since
>>> nbd_config_put() is not called in such case. So could we still
>>> restore default timeout here. Or am I missing something?
>>>
>>
>> If you kill the NBD server then the config is going to be dropped and need to 
>> be reconfigured, so nbd_config_put() will definitely be called. The only case 
>> it wouldn't be is if you are using the netlink interface, in which case the 
>> device is going to keep all of its original settings. Are you not seeing the 
>> final nbd_config_put() being done when you kill the nbd server?  That seems 
>> like a bug if not, and that should be fixed, and then this timeout thing going 
>> in there will fix your issue.  Thanks,
> 
> I was using the netlink interface. So I could use the reconnect
> feature to update the nbd server without impacting the user of
> nbd device.
> 
> I did not see the final nbd_config_put() when I killed the nbd server.
> After I killed the nbd server, the recv_work() put 1 config_ref.
> Another ref count is still held by nbd_genl_connect(). I thought it
> was as expected.
> 
> Beside in nbd_genl_reconfigure(), it is checked nbd->config_refs should
> not be zero by:
>          if (!refcount_inc_not_zero(&nbd->config_refs)) {
>                  dev_err(nbd_to_dev(nbd),
>                          "not configured, cannot reconfigure\n");
>                  nbd_put(nbd);
>                  return -EINVAL;
>          }
> So AFAIK this behavior is as expected.

Ahh ok I see what you're getting at.  Ok I agree, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
