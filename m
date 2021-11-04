Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A034451D0
	for <lists+linux-block@lfdr.de>; Thu,  4 Nov 2021 11:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhKDK7v (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 4 Nov 2021 06:59:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:14716 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhKDK7v (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 06:59:51 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HlLBc56z7zZcYd;
        Thu,  4 Nov 2021 18:55:04 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 18:57:11 +0800
Received: from [10.174.179.189] (10.174.179.189) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 4 Nov 2021 18:57:10 +0800
Subject: Re: [PATCH] block: fix device_add_disk() kobject_create_and_add()
 error handling
To:     Luis Chamberlain <mcgrof@kernel.org>, <axboe@kernel.dk>,
        <hare@suse.de>, <hch@infradead.org>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "kernel test robot" <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20211103164023.1384821-1-mcgrof@kernel.org>
From:   Wu Bo <wubo40@huawei.com>
Message-ID: <143998a3-6c53-77f0-ef8c-af428ac64001@huawei.com>
Date:   Thu, 4 Nov 2021 18:57:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20211103164023.1384821-1-mcgrof@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.189]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/11/4 0:40, Luis Chamberlain wrote:
> Commit 83cbce957446 ("block: add error handling for device_add_disk /
> add_disk") added error handling to device_add_disk(), however the goto
> label for the kobject_create_and_add() failure did not set the return
> value correctly, and so we can end up in a situation where
> kobject_create_and_add() fails but we report success.
> 
> Fixes: 83cbce957446 ("block: add error handling for device_add_disk / add_disk")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   block/genhd.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index be4775c13760..b0b484116c3a 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -478,8 +478,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>   	if (!disk->part0->bd_holder_dir)

in here also should be add ret = -ENOMEM;

>   		goto out_del_integrity;
>   	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
> -	if (!disk->slave_dir)
> +	if (!disk->slave_dir) {
> +		ret = -ENOMEM;
>   		goto out_put_holder_dir;
> +	}
>   
>   	ret = bd_register_pending_holders(disk);
>   	if (ret < 0)
> 

