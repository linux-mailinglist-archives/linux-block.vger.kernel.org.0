Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7C2308468
	for <lists+linux-block@lfdr.de>; Fri, 29 Jan 2021 04:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhA2DvU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 Jan 2021 22:51:20 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2974 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhA2DvN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 22:51:13 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DRjy33vMHz5MVr;
        Fri, 29 Jan 2021 11:49:15 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 29 Jan 2021 11:50:29 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Fri, 29
 Jan 2021 11:50:28 +0800
Subject: Re: [PATCH v4 4/5] nvme-rdma: avoid IO error for nvme native
 multipath
To:     Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <linux-block@vger.kernel.org>,
        <hch@lst.de>, <axboe@kernel.dk>
References: <20210126081539.13320-1-lengchao@huawei.com>
 <20210126081539.13320-5-lengchao@huawei.com>
 <5a368693-65fd-1bdf-924a-f90df7f59b2a@grimberg.me>
 <9c30b18a-6fdd-be1c-f3bc-1d44c35ae274@huawei.com>
 <ca300cac-1f6c-01b2-8691-9a545381523a@grimberg.me>
 <29ccc5e0-66e9-93db-e9b9-09012f1c8fe2@huawei.com>
 <1651456a-3251-77db-42c9-fc1a2d2c5c13@grimberg.me>
 <b5b70392-d4f7-6f0c-d337-a6023dc4b992@huawei.com>
 <a55689cc-0925-c3a3-b7bf-e155cc3d4fe9@grimberg.me>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <871fd11a-b4e7-aa63-97f0-be483b3e1f9e@huawei.com>
Date:   Fri, 29 Jan 2021 11:50:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <a55689cc-0925-c3a3-b7bf-e155cc3d4fe9@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021/1/29 11:37, Sagi Grimberg wrote:
> 
>>>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>>>> index b7ce4f221d99..66b697461bd9 100644
>>>> --- a/drivers/nvme/host/rdma.c
>>>> +++ b/drivers/nvme/host/rdma.c
>>>> @@ -2084,8 +2084,13 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>>>>
>>>>          err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
>>>>                          req->mr ? &req->reg_wr.wr : NULL);
>>>> -       if (unlikely(err))
>>>> +       if (unlikely(err)) {
>>>> +               if (err == -EIO) {
>>>> +                       nvme_complete_failed_rq(rq, NVME_SC_HOST_PATH_ERROR);
>>>
>>> I was thinking about:
>>> -- 
>>>          err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
>>>                          req->mr ? &req->reg_wr.wr : NULL);
>>>          if (unlikely(err)) {
>>>                  if (err == -EIO) {
>>>                          /*
>>>                           * Fail the reuqest so upper layer can failover I/O
>>>                           * if another path is available
>>>                           */
>>>                          req->status = NVME_SC_HOST_PATH_ERROR;
>>>                          nvme_rdma_complete_rq(rq);
>>>                          return BLK_STS_OK;Need to do clean. so can not directly return.
> 
> The completion path cleans up though
ok, i see.
But we need to use the new helper nvme_complete_failed_rq to avoid double request completion.
Or we can do like this:
req->status = NVME_SC_HOST_PATH_ERROR;
blk_mq_set_request_complete(req);
nvme_rdma_complete_rq(rq);
> 
>>>
>>>                  }
>>>                  goto err_unmap;
>>>          }
>>> -- 
>>> .
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme
> .
