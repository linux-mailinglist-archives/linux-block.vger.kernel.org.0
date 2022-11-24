Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F493637A1C
	for <lists+linux-block@lfdr.de>; Thu, 24 Nov 2022 14:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiKXNoL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 24 Nov 2022 08:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKXNoL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Nov 2022 08:44:11 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8014B9E0AE;
        Thu, 24 Nov 2022 05:44:10 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NHzjH09H8zHw0w;
        Thu, 24 Nov 2022 21:43:31 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 21:44:08 +0800
Subject: Re: [PATCH] blk-mq: fix possible memleak when register 'hctx' failed
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221117022940.873959-1-yebin@huaweicloud.com>
CC:     <ming.lei@redhat.com>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <637F7527.8060307@huawei.com>
Date:   Thu, 24 Nov 2022 21:44:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20221117022940.873959-1-yebin@huaweicloud.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping...

On 2022/11/17 10:29, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
>
> There's issue as follows when do fault injection test:
> unreferenced object 0xffff888132a9f400 (size 512):
>    comm "insmod", pid 308021, jiffies 4324277909 (age 509.733s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 08 f4 a9 32 81 88 ff ff  ...........2....
>      08 f4 a9 32 81 88 ff ff 00 00 00 00 00 00 00 00  ...2............
>    backtrace:
>      [<00000000e8952bb4>] kmalloc_node_trace+0x22/0xa0
>      [<00000000f9980e0f>] blk_mq_alloc_and_init_hctx+0x3f1/0x7e0
>      [<000000002e719efa>] blk_mq_realloc_hw_ctxs+0x1e6/0x230
>      [<000000004f1fda40>] blk_mq_init_allocated_queue+0x27e/0x910
>      [<00000000287123ec>] __blk_mq_alloc_disk+0x67/0xf0
>      [<00000000a2a34657>] 0xffffffffa2ad310f
>      [<00000000b173f718>] 0xffffffffa2af824a
>      [<0000000095a1dabb>] do_one_initcall+0x87/0x2a0
>      [<00000000f32fdf93>] do_init_module+0xdf/0x320
>      [<00000000cbe8541e>] load_module+0x3006/0x3390
>      [<0000000069ed1bdb>] __do_sys_finit_module+0x113/0x1b0
>      [<00000000a1a29ae8>] do_syscall_64+0x35/0x80
>      [<000000009cd878b0>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
> Fault injection context as follows:
>   kobject_add
>   blk_mq_register_hctx
>   blk_mq_sysfs_register
>   blk_register_queue
>   device_add_disk
>   null_add_dev.part.0 [null_blk]
>
> As 'blk_mq_register_hctx' may already add some objects when failed halfway,
> but there isn't do fallback, caller don't know which objects add failed.
> To solve above issue just do fallback when add objects failed halfway in
> 'blk_mq_register_hctx'.
>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>   block/blk-mq-sysfs.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index 93997d297d42..4515288fbe35 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -185,7 +185,7 @@ static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
>   {
>   	struct request_queue *q = hctx->queue;
>   	struct blk_mq_ctx *ctx;
> -	int i, ret;
> +	int i, j, ret;
>   
>   	if (!hctx->nr_ctx)
>   		return 0;
> @@ -197,9 +197,16 @@ static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
>   	hctx_for_each_ctx(hctx, ctx, i) {
>   		ret = kobject_add(&ctx->kobj, &hctx->kobj, "cpu%u", ctx->cpu);
>   		if (ret)
> -			break;
> +			goto out;
>   	}
>   
> +	return 0;
> +out:
> +	hctx_for_each_ctx(hctx, ctx, j) {
> +		if (j < i)
> +			kobject_del(&ctx->kobj);
> +	}
> +	kobject_del(&hctx->kobj);
>   	return ret;
>   }
>   

