Return-Path: <linux-block+bounces-1463-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B293E81E679
	for <lists+linux-block@lfdr.de>; Tue, 26 Dec 2023 10:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522421F22312
	for <lists+linux-block@lfdr.de>; Tue, 26 Dec 2023 09:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7DA4D109;
	Tue, 26 Dec 2023 09:38:47 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B85C4D102
	for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SzqTJ2jJdz4f3l1N
	for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 17:38:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BEA271A0B32
	for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 17:38:33 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHSQ8Xn4pl8EezEg--.60657S3;
	Tue, 26 Dec 2023 17:38:33 +0800 (CST)
Subject: Re: [PATCH 1/2] loop: remove a pointless blk_queue_max_hw_sectors
 call
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20231226091405.206166-1-hch@lst.de>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a4c16b17-258c-3d49-ae44-241e95a14e4f@huaweicloud.com>
Date: Tue, 26 Dec 2023 17:38:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231226091405.206166-1-hch@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHSQ8Xn4pl8EezEg--.60657S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr47Kw4kWryfGFW5Zw1fWFg_yoWftFg_C3
	45uF1IvFZ5CF9Y9a9rKF45Xr92kFyxXr97Jry2qFZ7KFyaqa43JF1jqr1rAFn8ZF12kF9Y
	ya47Xr9xKwnYqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

�� 2023/12/26 17:14, Christoph Hellwig д��:
> BLK_DEF_MAX_SECTORS is (as the name implies) already the default.

Looks like this not true. From blk_set_default_limits():

lim->max_sectors = lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;

So, the default is not BLK_DEF_MAX_SECTORS. Or am I missing something?

Thanks,
Kuai
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/loop.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 5bc2b4fcfa772d..371a318e691d02 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2038,8 +2038,6 @@ static int loop_add(int i)
>   	}
>   	lo->lo_queue = lo->lo_disk->queue;
>   
> -	blk_queue_max_hw_sectors(lo->lo_queue, BLK_DEF_MAX_SECTORS);
> -
>   	/*
>   	 * By default, we do buffer IO, so it doesn't make sense to enable
>   	 * merge because the I/O submitted to backing file is handled page by
> 


