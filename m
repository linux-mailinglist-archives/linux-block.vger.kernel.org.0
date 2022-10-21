Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704EA606E03
	for <lists+linux-block@lfdr.de>; Fri, 21 Oct 2022 04:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJUCuM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Oct 2022 22:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJUCuL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 22:50:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1733F81122
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 19:50:10 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mtppw15cGzHvBh;
        Fri, 21 Oct 2022 10:50:00 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:50:08 +0800
Subject: Re: [PATCH 8/8] nvme: use blk_mq_[un]quiesce_tagset
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-9-hch@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <5896579b-f5be-ab98-d858-1943981797cd@huawei.com>
Date:   Fri, 21 Oct 2022 10:50:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221020105608.1581940-9-hch@lst.de>
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

Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2022/10/20 18:56, Christoph Hellwig wrote:
> From: Chao Leng <lengchao@huawei.com>
> 
> All controller namespaces share the same tagset, so we can use this
> interface which does the optimal operation for parallel quiesce based on
> the tagset type(e.g. blocking tagsets and non-blocking tagsets).
> 
> nvme connect_q should not be quiesced when quiesce tagset, so set the
> QUEUE_FLAG_SKIP_TAGSET_QUIESCE to skip it when init connect_q.
> 
> Currently we use NVME_NS_STOPPED to ensure pairing quiescing and
> unquiescing. If use blk_mq_[un]quiesce_tagset, NVME_NS_STOPPED will be
> invalided, so introduce NVME_CTRL_STOPPED to replace NVME_NS_STOPPED.
> In addition, we never really quiesce a single namespace. It is a better
> choice to move the flag from ns to ctrl.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> [hch: rebased on top of prep patches]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 38 +++++++++-----------------------------
>   drivers/nvme/host/nvme.h |  2 +-
>   2 files changed, 10 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0ab3a18fd9f85..cc71f1001144f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4891,6 +4891,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>   			ret = PTR_ERR(ctrl->connect_q);
>   			goto out_free_tag_set;
>   		}
> +		blk_queue_flag_set(QUEUE_FLAG_SKIP_TAGSET_QUIESCE, ctrl->connect_q);
>   	}
>   
>   	ctrl->tagset = set;
> @@ -5090,20 +5091,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(nvme_init_ctrl);
>   
> -static void nvme_start_ns_queue(struct nvme_ns *ns)
> -{
> -	if (test_and_clear_bit(NVME_NS_STOPPED, &ns->flags))
> -		blk_mq_unquiesce_queue(ns->queue);
> -}
> -
> -static void nvme_stop_ns_queue(struct nvme_ns *ns)
> -{
> -	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
> -		blk_mq_quiesce_queue(ns->queue);
> -	else
> -		blk_mq_wait_quiesce_done(ns->queue->tag_set);
> -}
> -
>   /**
>    * nvme_kill_queues(): Ends all namespace queues
>    * @ctrl: the dead controller that needs to end
> @@ -5120,10 +5107,9 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>   	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
>   		nvme_start_admin_queue(ctrl);
>   	if (!test_and_set_bit(NVME_CTRL_NS_DEAD, &ctrl->flags)) {
> -		list_for_each_entry(ns, &ctrl->namespaces, list) {
> +		list_for_each_entry(ns, &ctrl->namespaces, list)
>   			blk_mark_disk_dead(ns->disk);
> -			nvme_start_ns_queue(ns);
> -		}
> +		nvme_start_queues(ctrl);
>   	}
>   	up_read(&ctrl->namespaces_rwsem);
>   }
> @@ -5179,23 +5165,17 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
>   
>   void nvme_stop_queues(struct nvme_ctrl *ctrl)
>   {
> -	struct nvme_ns *ns;
> -
> -	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> -		nvme_stop_ns_queue(ns);
> -	up_read(&ctrl->namespaces_rwsem);
> +	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
> +		blk_mq_quiesce_tagset(ctrl->tagset);
> +	else
> +		blk_mq_wait_quiesce_done(ctrl->tagset);
>   }
>   EXPORT_SYMBOL_GPL(nvme_stop_queues);
>   
>   void nvme_start_queues(struct nvme_ctrl *ctrl)
>   {
> -	struct nvme_ns *ns;
> -
> -	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> -		nvme_start_ns_queue(ns);
> -	up_read(&ctrl->namespaces_rwsem);
> +	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
> +		blk_mq_unquiesce_tagset(ctrl->tagset);
>   }
>   EXPORT_SYMBOL_GPL(nvme_start_queues);
>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 82989a3322130..54d8127fb6dc5 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -238,6 +238,7 @@ enum nvme_ctrl_flags {
>   	NVME_CTRL_ADMIN_Q_STOPPED	= 1,
>   	NVME_CTRL_STARTED_ONCE		= 2,
>   	NVME_CTRL_NS_DEAD     		= 3,
> +	NVME_CTRL_STOPPED		= 4,
>   };
>   
>   struct nvme_ctrl {
> @@ -487,7 +488,6 @@ struct nvme_ns {
>   #define NVME_NS_ANA_PENDING	2
>   #define NVME_NS_FORCE_RO	3
>   #define NVME_NS_READY		4
> -#define NVME_NS_STOPPED		5
>   
>   	struct cdev		cdev;
>   	struct device		cdev_device;
> 
