Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC5B38FDFE
	for <lists+linux-block@lfdr.de>; Tue, 25 May 2021 11:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhEYJjf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 May 2021 05:39:35 -0400
Received: from mail.synology.com ([211.23.38.101]:53532 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232563AbhEYJjc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 05:39:32 -0400
Subject: Re: [PATCH v2] block: fix trace completion for chained bio
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1621935449; bh=pyh7Wvy0eo8qDjfoSG3IQUSH3Z/keP/gcb0hzR7DpoU=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=MJiUB/Yf+sXio24HtfILVjS+nsMDr6KoYJgHhDXEt2cjCbQp8dm/XWLkIXxvlW5DP
         7diC2grtpkywKzRaP6yyws3/Eu6DpakCxpPB93cGIhFtyDL+9lqIt3uoZUo2yoNYFz
         8Yjm+lLT7504ZRpiQNSnT/lgiK5G2AAeLQMvCGKc=
From:   Edward Hsieh <edwardh@synology.com>
To:     NeilBrown <neilb@suse.de>, axboe@kernel.dk, neilb@suse.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        s3t@synology.com, bingjingc@synology.com, cccheng@synology.com
References: <1614741726-28074-1-git-send-email-edwardh@synology.com>
 <87zgyudgss.fsf@notabene.neil.brown.name>
 <fb8620bf-f4e9-5787-ab79-6e0a5d79d26d@synology.com>
 <10f3e198-f34c-47e9-608a-e5f84e3379a1@synology.com>
Message-ID: <3600b6c0-f83d-f375-bebc-cd5ac811c3d5@synology.com>
Date:   Tue, 25 May 2021 17:37:29 +0800
MIME-Version: 1.0
In-Reply-To: <10f3e198-f34c-47e9-608a-e5f84e3379a1@synology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/10/2021 10:06 AM, Edward Hsieh wrote:
> 
> On 4/23/2021 4:04 PM, Edward Hsieh wrote:
>> On 3/23/2021 5:22 AM, NeilBrown wrote:
>>> On Wed, Mar 03 2021, edwardh wrote:
>>>
>>>> From: Edward Hsieh <edwardh@synology.com>
>>>>
>>>> For chained bio, trace_block_bio_complete in bio_endio is currently 
>>>> called
>>>> only by the parent bio once upon all chained bio completed.
>>>> However, the sector and size for the parent bio are modified in 
>>>> bio_split.
>>>> Therefore, the size and sector of the complete events might not 
>>>> match the
>>>> queue events in blktrace.
>>>>
>>>> The original fix of bio completion trace <fbbaf700e7b1> ("block: trace
>>>> completion of all bios.") wants multiple complete events to correspond
>>>> to one queue event but missed this.
>>>>
>>>> md/raid5 read with bio cross chunks can reproduce this issue.
>>>>
>>>> To fix, move trace completion into the loop for every chained bio to 
>>>> call.
>>>
>>> Thanks.  I think this is correct as far as tracing goes.
>>> However the code still looks a bit odd.
>>>
>>> The comment for the handling of bio_chain_endio suggests that the *only*
>>> purpose for that is to avoid deep recursion.  That suggests it should be
>>> at the end of the function.
>>> As it is blk_throtl_bio_endio() and bio_unint() are only called on the
>>> last bio in a chain.
>>> That seems wrong.
>>>
>>> I'd be more comfortable if the patch moved the bio_chain_endio()
>>> handling to the end, after all of that.
>>> So the function would end.
>>>
>>> if (bio->bi_end_io == bio_chain_endio) {
>>>     bio = __bio_chain_endio(bio);
>>>     goto again;
>>> } else if (bio->bi_end_io)
>>>     bio->bi_end_io(bio);
>>>
>>> Jens:  can you see any reason why that functions must only be called on
>>> the last bio in the chain?
>>>
>>> Thanks,
>>> NeilBrown
>>>
>>
>> Hi Neil and Jens,
>>
>>  From the commit message, bio_uninit is put here for bio allocated in
>> special ways (e.g., on stack), that will not be release by bio_free. For
>> chained bio, __bio_chain_endio invokes bio_put and release the
>> resources, so it seems that we don't need to call bio_uninit for chained
>> bio.
>>
>> The blk_throtl_bio_endio is used to update the latency for the throttle
>> group. I think the latency should only be updated after the whole bio is
>> finished?
>>
>> To make sense for the "tail call optimization" in the comment, I'll
>> suggest to wrap the whole statement with an else. What do you think?
>>
>> if (bio->bi_end_io == bio_chain_endio) {
>>      bio = __bio_chain_endio(bio);
>>      goto again;
>> } else {
>>      blk_throtl_bio_endio(bio);
>>      /* release cgroup info */
>>      bio_uninit(bio);
>>      if (bio->bi_end_io)
>>          bio->bi_end_io(bio);
>> }
>>
>> Thanks,
>> Edward Hsieh
> 
> Hi Neil and Jens,
> 
> Any feedback on this one?
> 
> Thank you,
> Edward Hsieh >

  Hi Neil and Jens,

Any comments?

Thank you,
Edward Hsieh
