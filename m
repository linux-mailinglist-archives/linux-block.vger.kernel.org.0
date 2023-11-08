Return-Path: <linux-block+bounces-29-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D307E4F6C
	for <lists+linux-block@lfdr.de>; Wed,  8 Nov 2023 04:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E8AB20D37
	for <lists+linux-block@lfdr.de>; Wed,  8 Nov 2023 03:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26F91368;
	Wed,  8 Nov 2023 03:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k7si3DRA"
X-Original-To: linux-block@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB181366
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 03:26:32 +0000 (UTC)
X-Greylist: delayed 572 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Nov 2023 19:26:31 PST
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C7F10C9
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 19:26:31 -0800 (PST)
Message-ID: <b87ff5e2-156f-4bf8-9001-9cfbb79871ae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699413415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJayWB9Gx8SRyr0qvwZO08eAjm1AFxboWshwi5jryBE=;
	b=k7si3DRAlTYR76IlM8Foxg/xOS7CSJNt6iPTDW8Hr1YB/CpE28GHALleNHLXLSaTnjjTMe
	6e+SDy3sB9MSrfbcaVaewXnQ2YMDx4acuMcVDX0EyjOybQNBrjD1h4yMfHMUUuRuL+QLsk
	W8JirEu/utOEjmdzW0Pg2gYK3SWNZuI=
Date: Wed, 8 Nov 2023 06:16:52 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vasily Averin <vasily.averin@linux.dev>
Subject: Re: [PATCH] zram: extra zram_get_element call in
 zram_read_from_zspool()
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, zhouxianrong <zhouxianrong@huawei.com>
References: <ec494d90-3f04-4ab4-870b-bb4f015eb0ed@linux.dev>
 <20231108024924.GG11577@google.com>
Content-Language: en-US
In-Reply-To: <20231108024924.GG11577@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/8/23 05:49, Sergey Senozhatsky wrote:
> On (23/11/06 22:55), Vasily Averin wrote:
>>
>> 'element' and 'handle' are union in struct zram_table_entry.
>>
>> Fixes: 8e19d540d107 ("zram: extend zero pages to same element pages")
> 
> Sorry, what exactly does it fix?

It removes unneeded call of zram_get_element() and unneeded variable 'value'.
zram_get_element() == zram_get_handle(), they both access the same field of the same struct zram_table_entry,
no need to read it 2nd time. 
'value' variable is not required, 'handle' can be used instead.

I hope this explain why element/handle union should be removed: it confuses reviewers.

> [..]
>> @@ -1318,12 +1318,10 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
>>  
>>  	handle = zram_get_handle(zram, index);
>>  	if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
>> -		unsigned long value;
>>  		void *mem;
>>  
>> -		value = handle ? zram_get_element(zram, index) : 0;
>>  		mem = kmap_atomic(page);
>> -		zram_fill_page(mem, PAGE_SIZE, value);
>> +		zram_fill_page(mem, PAGE_SIZE, handle);
>>  		kunmap_atomic(mem);
>>  		return 0;
>>  	}


