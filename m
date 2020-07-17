Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7782231CF
	for <lists+linux-block@lfdr.de>; Fri, 17 Jul 2020 05:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgGQDvc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Jul 2020 23:51:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7776 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbgGQDvc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 23:51:32 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0B92718BA189383AF769;
        Fri, 17 Jul 2020 11:51:30 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.91) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Jul 2020
 11:51:29 +0800
Subject: Re: [PATCH -next] rsxx: Convert to DEFINE_SHOW_ATTRIBUTE
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200716090432.13691-1-miaoqinglang@huawei.com>
 <e4caa1de-db2c-c2f4-d1e8-fef7073a52ea@kernel.dk>
 <c19c9e32-4b31-bcf1-df45-a29220e7e6cc@huawei.com>
 <87a5f046-e77b-af25-6656-c8b075a16edf@kernel.dk>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <40b2a0b4-08ed-e4df-a7a1-efbf3e140f55@huawei.com>
Date:   Fri, 17 Jul 2020 11:51:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87a5f046-e77b-af25-6656-c8b075a16edf@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.91]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2020/7/17 10:16, Jens Axboe 写道:
> On 7/16/20 7:37 PM, miaoqinglang wrote:
>>
>> 在 2020/7/16 23:45, Jens Axboe 写道:
>>> On 7/16/20 3:04 AM, Qinglang Miao wrote:
>>>> From: Liu Shixin <liushixin2@huawei.com>
>>>>
>>>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>> None of these apply against the 5.9 block tree, looks like some
>>> read -> read_iter conversion has happened in another branch that
>>> I'm not privy to.
>>
>> Hi Jens,
>>
>>       Sorry I didn't mention it in commit log, but this patch is based
>> on linux-next where commit <4d4901c6d7> has switched over direct
>> seq_read method calls to seq_read_iter, this is why there's conflict in
>> your apply.
>>
>>       Do you think I should send a new patch based on 5.8rc?
> 
> That'll just create a needless conflict. But I don't even know what tree
> is carrying the patch that changes it to use seq_read_iter, so hard to
> make other suggestions.
This patch is against linux-next, which is ahead of both
linux-block and mainline tree.  Here's the interlinkage:

https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/+/4d4901c6d748efab8aab6e7d2405dadaed0bea50](javascript:;)

or you can find the commit <4d4901c6d7> which changes seq_read to 
seq_read_iter with the -next tag, in fact, it's just a simple script:

sed -i -e 's/\.read\(\s*=\s*\)seq_read/\.read_iter\1seq_read_iter/g'

By the way, there won't be needless confict because seq_read in both
file and macro are switched to seq_read_iter together.
> 
> Alternatively, I can hang on to them until the other change hits
> mainline, and then queue them up after that.
> 
That looks good to me. Let me know if patch based on 5.8rc is needed.

Thanks.

Qinglang

.





