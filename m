Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2422C2D7C7D
	for <lists+linux-block@lfdr.de>; Fri, 11 Dec 2020 18:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391366AbgLKRJ3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 11 Dec 2020 12:09:29 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2251 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391393AbgLKRJF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Dec 2020 12:09:05 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Csxwm34HJz67MVt;
        Sat, 12 Dec 2020 01:04:56 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 11 Dec 2020 18:08:22 +0100
Received: from [10.47.11.239] (10.47.11.239) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 11 Dec
 2020 17:08:22 +0000
Subject: Re: [PATCH 2/3] blk-mq: update arg in comment of blk_mq_map_queue
To:     Minwoo Im <minwoo.im.dev@gmail.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>
References: <20201204152055.31605-1-minwoo.im.dev@gmail.com>
 <20201204152055.31605-3-minwoo.im.dev@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <263b184d-2ffc-5a85-0f44-42b29bc7c295@huawei.com>
Date:   Fri, 11 Dec 2020 17:07:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201204152055.31605-3-minwoo.im.dev@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.11.239]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/12/2020 15:20, Minwoo Im wrote:
> Update mis-named argument description of blk_mq_map_queue().  This patch
> also updates description that argument to software queue percpu context.
> 
> Signed-off-by: Minwoo Im<minwoo.im.dev@gmail.com>

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   block/blk-mq.h | 2 +-
