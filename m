Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C052AA8B0
	for <lists+linux-block@lfdr.de>; Sun,  8 Nov 2020 02:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgKHBJ6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 7 Nov 2020 20:09:58 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:37861 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbgKHBJ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 7 Nov 2020 20:09:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UEYXK2x_1604797793;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UEYXK2x_1604797793)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 08 Nov 2020 09:09:54 +0800
Subject: Re: [dm-devel] [RFC 0/3] Add support of iopoll for dm device
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com,
        dm-devel@redhat.com, haoxu@linux.alibaba.com,
        io-uring@vger.kernel.org
References: <20201020065420.124885-1-jefflexu@linux.alibaba.com>
 <20201021203906.GA10896@redhat.com>
 <da936cfa-93a8-d6ec-bd88-c0fad6c67c8b@linux.alibaba.com>
 <20201026185334.GA8463@redhat.com>
 <33c32cd1-5116-9a42-7fe2-b2a383f1c7a0@linux.alibaba.com>
 <20201102152822.GA20466@redhat.com>
 <f165f38a-91d1-79aa-829d-a9cc69a5eee6@linux.alibaba.com>
 <20201104150847.GB32761@redhat.com>
 <2c5dab21-8125-fcdf-078e-00a158c57f43@linux.alibaba.com>
 <20201106174526.GA13292@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <23c73ad7-23e3-3172-8f0e-3c15e0fa5a87@linux.alibaba.com>
Date:   Sun, 8 Nov 2020 09:09:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201106174526.GA13292@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 11/7/20 1:45 AM, Mike Snitzer wrote:
> On Thu, Nov 05 2020 at  9:51pm -0500,
> JeffleXu <jefflexu@linux.alibaba.com> wrote:
>
>> On 11/4/20 11:08 PM, Mike Snitzer wrote:
>>>> I'm doubted if this should be implemented in block layer like:
>>>>
>>>> ```
>>>>
>>>> struct bio {
>>>>
>>>>      ...
>>>>
>>>>      struct list_head  cookies;
>>>>
>>>> };
>>>>
>>>> ```
>>>>
>>>> After all it's only used by bio-based queue, or more specifically
>>>> only dm device currently.
>>> I do think this line of work really should be handled in block core
>>> because I cannot see any reason why MD or bcache or whatever bio-based
>>> device wouldn't want the ability to better support io_uring (with IO
>>> poll).
>>>
>>>> Another design I can come up with is to maintain a global data
>>>> structure for the very beginning
>>>> original bio. Currently the blocking point is that now one original
>>>> bio to the dm device (@bio of dm_submit()) can correspond to multiple
>>>> dm_io and thus we have nowhere to place the @cookies list.
>>> Yes, and that will always be the case.  We need the design to handle an
>>> arbitrary sprawl of splitting from a given bio.  The graph of bios
>>> resulting from that fan-out needs to be walked at various levels -- be
>>> it the top-level original bio's submit_bio() returned cookie or some
>>> intermediate point in the chain of bios.
>>>
>>> The problem is the lifetime of the data structure created for a given
>>> split bio versus layering boundaries (that come from block core's
>>> simplistic recursion via bio using submit_bio).
>>>
>>>> Now we have to maintain one data structure for every original bio,
>>>> something like
>>>>
>>>> ```
>>>>
>>>> struct dm_poll_instance {
>>>>
>>>>      ...
>>>>
>>>>      struct list_head cookies;
>>>>
>>>> };
>>>>
>>>> ```
>>> I do think we need a hybrid where at the point of recursion we're able
>>> to make the associated data structure available across the recursion
>>> boundary so that modeling the association in a chain of split bios is
>>> possible. (e.g. struct dm_poll_data or dm_poll_instance as you named it,
>>> _but_ that struct definition would live in block core, but would be part
>>> of per-bio-data; so 'struct blk_poll_data' is more logical name when
>>> elevated to block core).
>>>
>>> It _might_ be worthwhile to see if a new BIO_ flag could be added to
>>> allow augmenting the bio_split + bio_chain pattern to also track this
>>> additional case of carrying additional data per-bio while creating
>>> bio-chains.  I may not be clear yet, said differently: augmenting
>>> bio_chain to not only chain bios, but to _also_ thread/chain together
>>> per-bio-data that lives within those chained bios.  SO you have the
>>> chain of bios _and_ the chain of potentially opaque void * that happens
>>> to point to a list head for a list of 'struct blk_poll_data'.
>>>
>>> Does that make sense?
>>
>> I'm doubted if it really makes sense to maintain a *complete* bio
>> chain across the recursive
>>
>> call boundary.
>>
>>
>> Considering the following device stack:
>>
>> ```
>>
>>                                    dm0
>>
>>          dm1                   dm2           dm3
>>
>> nvme0  nvme1          ....               ....
>>
>> ```
>>
>>
>> We have the following bio graph (please let me know if it's wrong or
>> the image can't display)
>>
>>
>> For example, for dm1 there are three bios containing valid cookie in
>> the end, that is
>>
>> bio 9/10/11. We only need to insert the corresponding blk_poll_data
>> (containing
>>
>> request_queue, cookie, etc) of these three bios into the very
>> beginning original
>>
>> bio (that is bio0). Of course we can track all the sub-bios down
>> through the device
>>
>> stack, layer by layer, e.g.,
>>
>> - get bio 1/2/3 from bio 0
>>
>> - get bio 4 from bio 3
>>
>> - finally get bio 9 from bio 4
>>
>> But I'm doubted if it's overkill to just implement the iopoll.
>>
>>
>> Another issue still unclear is that, if we should implement the
>> iopoll in a recursive way.
>>
>> In a recursive way, to poll dm 0, we should poll all its
>> sub-devices, that is, bio 4/5/7/8.
>>
>> Oppositely we can insert only the bottom bio (bio 9/10/11 which have
>> valid cookie) at
>>
>> the very beginning (at submit_bio() phase), and to poll dm 0, we
>> only need to poll bio 9/10/11.
> I feel we need the ability to walk the entire graph and call down to
> next level.  The lowest level would be what you call a "valid cookie"
> that blk-mq returned.  But the preceding cookies need to be made valid
> and used when walking the graph (from highest to lowest) and calling
> down to the underlying layers.
>
>>
>> To implement this non-recursive design, we can add a field in struct bio
>>
>> ```
>>
>> struct bio {
>>
>>      ...
>>
>>      struct bio *orig;
>>
>> }
>>
>> ```
>>
>> @orig points to the original bio inputted into submit_bio(), that is, bio 0.
>>
>>
>> @orig field is transmitted through bio splitting.
>>
>> ```
>>
>> bio_split()
>>
>>      split->orig = bio->orig ? : bio
>>
>>
>> dm.c: __clone_and_map_data_bio
>>
>>      clone->orig = bio->orig ? : bio
>>
>> ```
>>
>>
>> Finally bio 9/10/11 can be inserted into bio 0.
>>
>> ```
>>
>> blk-mq.c: blk_mq_submit_bio
>>
>>      if (bio->orig)
>>
>>          init blk_poll_data and insert it into bio->orig's @cookies list
>>
>> ```
> If you feel that is doable: certainly give it a shot.

Make sense.

> But it is not clear to me how you intend to translate from cookie passed
> in to ->blk_poll hook (returned from submit_bio) to the saved off
> bio->orig.
>
> What is your cookie strategy in this non-recursive implementation?  What
> will you be returning?  Where will you be storing it?

Actually I think it's a common issue to design the cookie returned by 
submit_bio() whenever

it's implemented in a recursive or non-recursive way. After all you need 
to translate the

returned cookie to the original bio even if it's implemented in a 
recursive way as you

described. Or how could you walk through the bio graph when the returned 
cookie is

only 'unsigned int' type?


How about this:


```

typedef uintptr_t blk_qc_t;

```


or something like union

```

typedef union {

     unsigned int cookie;

     struct bio *orig; // the original bio of submit_bio()

} blk_qc_t;

```


When serving for blk-mq, the integer part of blk_qc_t is used and it 
stores the valid cookie,

while it stores a pointer to the original bio when serving bio-based device.


By the way, would you mind sharing your plan and progress on this work, 
I mean, supporting

iopoll for dm device. To be honest, I don't want to re-invent the wheel 
as you have started on

this work, but I do want to participate in somehow. Please let me know 
if there's something

I could do here.


-- 
Thanks,
Jeffle

