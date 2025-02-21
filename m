Return-Path: <linux-block+bounces-17448-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC4CA3EF87
	for <lists+linux-block@lfdr.de>; Fri, 21 Feb 2025 10:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445EB188C318
	for <lists+linux-block@lfdr.de>; Fri, 21 Feb 2025 09:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4621D201253;
	Fri, 21 Feb 2025 09:05:09 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ABC201103;
	Fri, 21 Feb 2025 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128709; cv=none; b=ELzTgjjukhCWsaN4Eur4yTshrAdrdKOr5fV4sCV4+TriX+nBGjG6ORKEwSt4ln1EHLDhD9Y73fzwtwFGoX+iQF0pYDUPNOu42wzq6kffKExU05X/7ncc+PZArp6tOqurEEZgFAh5kU/eHA7qzfoWdOfegoUNt9Nod7IqYJDhXd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128709; c=relaxed/simple;
	bh=N8/wlm3/Kh2z6281y/qhT89jW4sGX8ovwWLK+ph1WiM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ule4liXfNggijgWargDMsxS75PShqL9pU37PLHe5DJLvyyTR6dXgm3BB27607c5y6e9oAyqtLgZ8AO+rZRcEeIZU5Fz1HxgisQ5XdgiLP79nfZnTOmasfyj6UTYodOswtyirtTQeN+5j7L3EHNDnKwmgJIYI6fxwWWPYtuBQhhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YzkjC709kz4f3jsy;
	Fri, 21 Feb 2025 17:04:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4AFD91A16FB;
	Fri, 21 Feb 2025 17:05:04 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnC2C+QbhnXLrhEQ--.6525S3;
	Fri, 21 Feb 2025 17:05:03 +0800 (CST)
Subject: Re: [PATCH 01/12] badblocks: Fix error shitf ops
To: Zheng Qixing <zhengqixing@huaweicloud.com>, axboe@kernel.dk,
 song@kernel.org, colyli@kernel.org, dan.j.williams@intel.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, ira.weiny@intel.com,
 dlemoal@kernel.org, yanjun.zhu@linux.dev, kch@nvidia.com, hare@suse.de,
 zhengqixing@huawei.com, john.g.garry@oracle.com, geliang@kernel.org,
 xni@redhat.com, colyli@suse.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev, yi.zhang@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250221081109.734170-1-zhengqixing@huaweicloud.com>
 <20250221081109.734170-2-zhengqixing@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5bc52368-ed61-f3f6-324b-6e036d50d334@huaweicloud.com>
Date: Fri, 21 Feb 2025 17:05:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250221081109.734170-2-zhengqixing@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnC2C+QbhnXLrhEQ--.6525S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw45Kw43AF1Utr4kurW5Awb_yoW8Wry8pr
	1DG3sxGrW7G34j93W5X3WUGr9aq345GF43Cw4xJ348Cry5K3s7tw1kXrySv3Wa9FW3Grn0
	v3WruryrurWIy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUxo7KDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

�� 2025/02/21 16:10, Zheng Qixing д��:
> From: Li Nan <linan122@huawei.com>
> 
> 'bb->shift' is used directly in badblocks. It is wrong, fix it.
> 
> Fixes: 3ea3354cb9f0 ("badblocks: improve badblocks_check() for multiple ranges handling")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   block/badblocks.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/block/badblocks.c b/block/badblocks.c
> index db4ec8b9b2a8..bcee057efc47 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -880,8 +880,8 @@ static int _badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>   		/* round the start down, and the end up */
>   		sector_t next = s + sectors;
>   
> -		rounddown(s, bb->shift);
> -		roundup(next, bb->shift);
> +		rounddown(s, 1 << bb->shift);
> +		roundup(next, 1 << bb->shift);
>   		sectors = next - s;
>   	}
>   
> @@ -1157,8 +1157,8 @@ static int _badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
>   		 * isn't than to think a block is not bad when it is.
>   		 */
>   		target = s + sectors;
> -		roundup(s, bb->shift);
> -		rounddown(target, bb->shift);
> +		roundup(s, 1 << bb->shift);
> +		rounddown(target, 1 << bb->shift);
>   		sectors = target - s;
>   	}
>   
> @@ -1288,8 +1288,8 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
>   
>   		/* round the start down, and the end up */
>   		target = s + sectors;
> -		rounddown(s, bb->shift);
> -		roundup(target, bb->shift);
> +		rounddown(s, 1 << bb->shift);
> +		roundup(target, 1 << bb->shift);
>   		sectors = target - s;
>   	}
>   
> 


