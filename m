Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5A81B773F
	for <lists+linux-block@lfdr.de>; Fri, 24 Apr 2020 15:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgDXNmv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Apr 2020 09:42:51 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2097 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727887AbgDXNmq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 09:42:46 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id EEC27BE69C308BB1D476;
        Fri, 24 Apr 2020 14:42:43 +0100 (IST)
Received: from [127.0.0.1] (10.47.6.64) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 24 Apr
 2020 14:42:43 +0100
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-8-ming.lei@redhat.com>
Message-ID: <bce125a3-0e27-5077-c441-8056307da0b9@huawei.com>
Date:   Fri, 24 Apr 2020 14:42:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200424102351.475641-8-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.6.64]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 24/04/2020 11:23, Ming Lei wrote:
>   static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>   {
> +	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> +			struct blk_mq_hw_ctx, cpuhp_online);
> +
> +	if (!cpumask_test_cpu(cpu, hctx->cpumask))
> +		return 0;
> +
> +	if ((cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) != cpu) ||
> +	    (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids))
> +		return 0;


nit: personally I prefer what we had previously, as it was easier to 
read, even if it did cause the code to be indented:

	if ((cpumask_next_and(-1, cpumask, online_mask) == cpu) &&
	    (cpumask_next_and(cpu, cpumask, online_mask) >= nr_cpu_ids)) {
		// do deactivate
	}

	return 0	

and it could avoid the cpumask_test_cpu() test, unless you want that as 
an optimisation. If so, a comment could help.

cheers,
John

> +
> +	/*
> +	 * The current CPU is the last one in this hctx, S_INACTIVE
> +	 * can be observed in dispatch path without any barrier needed,
> +	 * cause both are run on one same CPU.
> +	 */
> +	set_bit(BLK_MQ_S_INACTIVE, &hctx->state);
> +	/*
> +	 * Order setting BLK_MQ_S_INACTIVE and checking rq->tag & rqs[tag],
> +	 * and its pair is the smp_mb() in blk_mq_get_driver_tag
> +	 */
> +	smp_mb__after_atomic();
> +	blk_mq_hctx_drain_inflight_rqs(hctx);
> +	return 0;
> +}
> +

