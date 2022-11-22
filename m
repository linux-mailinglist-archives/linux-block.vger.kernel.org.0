Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA1D633394
	for <lists+linux-block@lfdr.de>; Tue, 22 Nov 2022 03:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiKVCxZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 21 Nov 2022 21:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiKVCxV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 21:53:21 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B09AE097
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 18:53:20 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NGTMG67HgzHwLG;
        Tue, 22 Nov 2022 10:52:42 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 10:53:17 +0800
Subject: Re: [PATCH 14/14] nvme: use blk_mq_[un]quiesce_tagset
To:     Shakeel Butt <shakeelb@google.com>, Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
References: <20221101150050.3510-1-hch@lst.de>
 <20221101150050.3510-15-hch@lst.de>
 <20221121204450.6vyg6gixsz4unpaz@google.com>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <a8e3d7a4-c5f6-13d0-a517-72097daa2a7b@huawei.com>
Date:   Tue, 22 Nov 2022 10:53:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221121204450.6vyg6gixsz4unpaz@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2022/11/22 4:44, Shakeel Butt wrote:
> On Tue, Nov 01, 2022 at 04:00:50PM +0100, Christoph Hellwig wrote:
>> From: Chao Leng <lengchao@huawei.com>
>>
>> All controller namespaces share the same tagset, so we can use this
>> interface which does the optimal operation for parallel quiesce based on
>> the tagset type(e.g. blocking tagsets and non-blocking tagsets).
>>
>> nvme connect_q should not be quiesced when quiesce tagset, so set the
>> QUEUE_FLAG_SKIP_TAGSET_QUIESCE to skip it when init connect_q.
>>
>> Currently we use NVME_NS_STOPPED to ensure pairing quiescing and
>> unquiescing. If use blk_mq_[un]quiesce_tagset, NVME_NS_STOPPED will be
>> invalided, so introduce NVME_CTRL_STOPPED to replace NVME_NS_STOPPED.
>> In addition, we never really quiesce a single namespace. It is a better
>> choice to move the flag from ns to ctrl.
>>
>> Signed-off-by: Chao Leng <lengchao@huawei.com>
>> [hch: rebased on top of prep patches]
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Keith Busch <kbusch@kernel.org>
>> Reviewed-by: Chao Leng <lengchao@huawei.com>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> This patch is causing the following crash at the boot and reverting it
> fixes the issue. This is next-20221121 kernel.
This patch can fix it.
https://lore.kernel.org/linux-nvme/20221116072711.1903536-1-hch@lst.de/
