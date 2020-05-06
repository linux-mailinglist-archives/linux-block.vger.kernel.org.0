Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D771C666D
	for <lists+linux-block@lfdr.de>; Wed,  6 May 2020 05:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEFDrr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 May 2020 23:47:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33852 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbgEFDrr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 May 2020 23:47:47 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EAB4A1CEDB2C3B6D3534;
        Wed,  6 May 2020 11:47:44 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.55) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 11:47:41 +0800
Subject: Re: [PATCH 2/4] mm/swap: use SECTORS_PER_PAGE_SHIFT to clean up code
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        "Sergey Senozhatsky" <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        dm-devel <dm-devel@redhat.com>, Song Liu <song@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200505115543.1660-1-thunder.leizhen@huawei.com>
 <20200505115543.1660-3-thunder.leizhen@huawei.com>
 <20200505172520.GI16070@bombadil.infradead.org>
 <32ba9907-60ad-27c0-c565-e7b5c80ab03c@huawei.com>
Message-ID: <bddd596b-2e8e-42aa-70cc-41583b15c548@huawei.com>
Date:   Wed, 6 May 2020 11:47:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <32ba9907-60ad-27c0-c565-e7b5c80ab03c@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/5/6 9:33, Leizhen (ThunderTown) wrote:
> 
> 
> On 2020/5/6 1:25, Matthew Wilcox wrote:
>> On Tue, May 05, 2020 at 07:55:41PM +0800, Zhen Lei wrote:
>>> +++ b/mm/swapfile.c
>>> @@ -177,8 +177,8 @@ static int discard_swap(struct swap_info_struct *si)
>>>  
>>>  	/* Do not discard the swap header page! */
>>>  	se = first_se(si);
>>> -	start_block = (se->start_block + 1) << (PAGE_SHIFT - 9);
>>> -	nr_blocks = ((sector_t)se->nr_pages - 1) << (PAGE_SHIFT - 9);
>>> +	start_block = (se->start_block + 1) << SECTORS_PER_PAGE_SHIFT;
>>> +	nr_blocks = ((sector_t)se->nr_pages - 1) << SECTORS_PER_PAGE_SHIFT;
>>
>> Thinking about this some more, wouldn't this look better?
>>
>> 	start_block = page_sectors(se->start_block + 1);
>> 	nr_block = page_sectors(se->nr_pages - 1);
>>
> 
> OK，That's fine, it's clearer. And in this way, there won't be more than 80 columns.

Should we rename "page_sectors" to "page_to_sectors"? Because we may need to define
"sectors_to_page" also.

> 
>>
>> .
>>

