Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612833E9C15
	for <lists+linux-block@lfdr.de>; Thu, 12 Aug 2021 03:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhHLB4H (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Aug 2021 21:56:07 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13415 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbhHLB4G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 21:56:06 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GlV6m3sPQzdZWr;
        Thu, 12 Aug 2021 09:52:00 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 12 Aug 2021 09:55:34 +0800
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 12 Aug 2021 09:55:33 +0800
Subject: Re: [PATCH -next v3] nbd: add the check to prevent overflow in
 __nbd_ioctl()
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>
CC:     <patchwork@huawei.com>, <yukuai3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
References: <20210804021212.990223-1-libaokun1@huawei.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <572832a1-818e-1309-08f5-4a3dc2b03999@huawei.com>
Date:   Thu, 12 Aug 2021 09:55:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210804021212.990223-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ÔÚ 2021/8/4 10:12, Baokun Li Ð´µÀ:
> If user specify a large enough value of NBD blocks option, it may trigger
> signed integer overflow which may lead to nbd->config->bytesize becomes a
> large or small value, zero in particular.
>
> UBSAN: Undefined behaviour in drivers/block/nbd.c:325:31
> signed integer overflow:
> 1024 * 4611686155866341414 cannot be represented in type 'long long int'
> [...]
> Call trace:
> [...]
>   handle_overflow+0x188/0x1dc lib/ubsan.c:192
>   __ubsan_handle_mul_overflow+0x34/0x44 lib/ubsan.c:213
>   nbd_size_set drivers/block/nbd.c:325 [inline]
>   __nbd_ioctl drivers/block/nbd.c:1342 [inline]
>   nbd_ioctl+0x998/0xa10 drivers/block/nbd.c:1395
>   __blkdev_driver_ioctl block/ioctl.c:311 [inline]
> [...]
>
> Although it is not a big deal, still silence the UBSAN by limit
> the input value.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> V1->V2:
> 	Use check_mul_overflow().
> V2->V3:
> 	The check_mul_overflow function requires the same input parameter type.
>
>   drivers/block/nbd.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index c38317979f74..5a42b838d26c 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1384,6 +1384,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>   		       unsigned int cmd, unsigned long arg)
>   {
>   	struct nbd_config *config = nbd->config;
> +	loff_t bytesize;
>   
>   	switch (cmd) {
>   	case NBD_DISCONNECT:
> @@ -1398,8 +1399,11 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>   	case NBD_SET_SIZE:
>   		return nbd_set_size(nbd, arg, config->blksize);
>   	case NBD_SET_SIZE_BLOCKS:
> -		return nbd_set_size(nbd, arg * config->blksize,
> -				    config->blksize);
> +		if (unlikely(check_mul_overflow((loff_t)arg,
> +						config->blksize,
> +						&bytesize)))
> +			return -EINVAL;
> +		return nbd_set_size(nbd, bytesize, config->blksize);
>   	case NBD_SET_TIMEOUT:
>   		nbd_set_cmd_timeout(nbd, arg);
>   		return 0;

ping

