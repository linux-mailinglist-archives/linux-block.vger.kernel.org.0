Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01F13D885B
	for <lists+linux-block@lfdr.de>; Wed, 28 Jul 2021 08:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhG1G5A (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 28 Jul 2021 02:57:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12415 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbhG1G47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 02:56:59 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GZPWX07Fgzcjfk;
        Wed, 28 Jul 2021 14:53:28 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 14:56:49 +0800
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 14:56:48 +0800
Subject: Re: [PATCH] nbd: do del_gendisk() asynchronously
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <nbd@other.debian.org>
References: <20210728044211.115787-1-houtao1@huawei.com>
 <20210728053915.GA3374@lst.de>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <3b55c3e6-d286-9c64-46bf-3018929c7a54@huawei.com>
Date:   Wed, 28 Jul 2021 14:56:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210728053915.GA3374@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Thanks for your review.

Now I am not sure whether or not it is a better idea that doing synchronous or asynchronous del_gendisk()

according to NBD_CFLAG_DESTROY_ON_DISCONNECT, and will wait for some feedback from Josef.

Thanks,

Tao

On 7/28/2021 1:39 PM, Christoph Hellwig wrote:
> Thanks,
>
> this looks good to me:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> .
