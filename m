Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEB62CB514
	for <lists+linux-block@lfdr.de>; Wed,  2 Dec 2020 07:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgLBGgM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Dec 2020 01:36:12 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:60442 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726202AbgLBGgM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 01:36:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UHIapdb_1606890926;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UHIapdb_1606890926)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Dec 2020 14:35:26 +0800
Subject: Re: dm: use gcd() to fix chunk_sectors limit stacking
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, joseph.qi@linux.alibaba.com,
        linux-block@vger.kernel.org
References: <20201201160709.31748-1-snitzer@redhat.com>
 <20201202033855.60882-1-jefflexu@linux.alibaba.com>
 <20201202033855.60882-2-jefflexu@linux.alibaba.com>
 <feb19a02-5ece-505f-e905-86dc84cdb204@linux.alibaba.com>
 <20201202050343.GA20535@redhat.com> <20201202051438.GB20535@redhat.com>
 <bee06a80-302e-ab1a-3eda-79a25adaf0d0@linux.alibaba.com>
Message-ID: <06464bd6-622e-6c24-07b7-b3dcabb066a5@linux.alibaba.com>
Date:   Wed, 2 Dec 2020 14:35:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <bee06a80-302e-ab1a-3eda-79a25adaf0d0@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/2/20 2:31 PM, JeffleXu wrote:
> 
> 
> On 12/2/20 1:14 PM, Mike Snitzer wrote:
>> On Wed, Dec 02 2020 at 12:03am -0500,
>> Mike Snitzer <snitzer@redhat.com> wrote:
>>
>>> What you've done here is fairly chaotic/disruptive:
>>> 1) you emailed a patch out that isn't needed or ideal, I dealt already
>>>    staged a DM fix in linux-next for 5.10-rcX, see:
>>>    https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.10-rcX&id=f28de262ddf09b635095bdeaf0e07ff507b3c41b
>>> 2) you replied to your patch and started referencing snippets of this
>>>    other patch's header (now staged for 5.10-rcX via Jens' block tree):
>>>    https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.10&id=7e7986f9d3ba69a7375a41080a1f8c8012cb0923
>>>    - why not reply to _that_ patch in response something stated in it?
>>
>> I now see you did reply to the original v2 patch:
>> https://www.redhat.com/archives/dm-devel/2020-December/msg00006.html
>>
>> but you changed the Subject to have a "dm" prefix for some reason.
> 
> In my original purpose, this is a new patch, 'dm: XXXXXXXX'. This patch
> should coexist with your patch 'block: XXXXXX'.
> 
> Can I say that it's totally a mistake ;)
s/mistake/misunderstanding

> 
> 
>> Strange but OK.. though it got really weird when you cut-and-paste your
>> other DM patch in reply at the bottom of your email.  If you find
>> yourself cross referencing emails and cutting and pasting like that, you
>> probably shouldn't.  Makes it chaotic for others to follow along.
>>
>> Thanks,
>> Mike
>>
> 

-- 
Thanks,
Jeffle
