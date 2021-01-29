Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B003083E4
	for <lists+linux-block@lfdr.de>; Fri, 29 Jan 2021 03:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhA2Ctm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 Jan 2021 21:49:42 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2803 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA2Ctl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 21:49:41 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DRhZC1JCrz13mL4;
        Fri, 29 Jan 2021 10:46:59 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 29 Jan 2021 10:48:59 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 29
 Jan 2021 10:48:58 +0800
Subject: Re: [PATCH v4 4/5] nvme-rdma: avoid IO error for nvme native
 multipath
To:     Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>
References: <20210126081539.13320-1-lengchao@huawei.com>
 <20210126081539.13320-5-lengchao@huawei.com>
 <5a368693-65fd-1bdf-924a-f90df7f59b2a@grimberg.me>
 <9c30b18a-6fdd-be1c-f3bc-1d44c35ae274@huawei.com>
 <ca300cac-1f6c-01b2-8691-9a545381523a@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <29ccc5e0-66e9-93db-e9b9-09012f1c8fe2@huawei.com>
Date:   Fri, 29 Jan 2021 10:48:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ca300cac-1f6c-01b2-8691-9a545381523a@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/1/29 9:35, Sagi Grimberg wrote:
> 
>>>> @@ -2084,8 +2085,10 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>>       err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
>>>>               req->mr ? &req->reg_wr.wr : NULL);
>>>> -    if (unlikely(err))
>>>> +    if (unlikely(err)) {
>>>> +        driver_error = true;
>>>>           goto err_unmap;
>>>
>>> Why not just call set the status and call nvme_rdma_complete_rq and
>>> return here?
>> If the err is ENOMEM or EAGAIN, I am not sure the err must be a
>> path-related error for all HBA drivers. So reused the error check code.
>> I think it would be more reasonable to assume any errors returned by HBA
>> driver as path-related errors.
>> If you think so, I will modify it in next patch version.
> 
> Meant to do that only for -EIO. We should absolutely not do any of this
> for stuff like EINVAL, EOPNOTSUPP, EPERM or any strange error that may
> return due to a bug or anything like that.
ok, please review again, thank you.
---
  drivers/nvme/host/rdma.c | 9 +++++++--
  1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index b7ce4f221d99..66b697461bd9 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2084,8 +2084,13 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,

         err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
                         req->mr ? &req->reg_wr.wr : NULL);
-       if (unlikely(err))
+       if (unlikely(err)) {
+               if (err == -EIO) {
+                       nvme_complete_failed_rq(rq, NVME_SC_HOST_PATH_ERROR);
+                       err = 0;
+               }
                 goto err_unmap;
+       }

         return BLK_STS_OK;

@@ -2094,7 +2099,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
  err:
         if (err == -ENOMEM || err == -EAGAIN)
                 ret = BLK_STS_RESOURCE;
-       else
+       else if (err)
                 ret = BLK_STS_IOERR;
         nvme_cleanup_cmd(rq);
  unmap_qe:
-- 
> .
