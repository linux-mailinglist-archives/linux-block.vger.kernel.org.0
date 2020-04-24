Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897501B6B07
	for <lists+linux-block@lfdr.de>; Fri, 24 Apr 2020 04:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgDXCIo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 23 Apr 2020 22:08:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbgDXCIo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Apr 2020 22:08:44 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3DCA95F6857A8304BE3;
        Fri, 24 Apr 2020 10:08:40 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.55) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 24 Apr 2020
 10:08:36 +0800
Subject: Re: [PATCH 1/1] brd: remove a redundant check
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200422012811.1606-1-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <b156aad6-fc0f-8623-acdf-ba59f7b6558a@huawei.com>
Date:   Fri, 24 Apr 2020 10:08:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200422012811.1606-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/4/22 9:28, Zhen Lei wrote:
> Because pages[i] can't be NULL, otherwise "pos = pages[i]->index;" will
> panic. So when "ret" is NULL, it can't be equal to pages[i].

In fact, "ret != pages[i]" is clear enough.

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/block/brd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 2fb25c348d53..59fec4a8ac93 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -147,7 +147,7 @@ static void brd_free_pages(struct brd_device *brd)
>  			BUG_ON(pages[i]->index < pos);
>  			pos = pages[i]->index;
>  			ret = radix_tree_delete(&brd->brd_pages, pos);
> -			BUG_ON(!ret || ret != pages[i]);
> +			BUG_ON(ret != pages[i]);
>  			__free_page(pages[i]);
>  		}
>  
> 

