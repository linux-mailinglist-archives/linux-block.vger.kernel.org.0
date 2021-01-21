Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4212FE68B
	for <lists+linux-block@lfdr.de>; Thu, 21 Jan 2021 10:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbhAUJ3E (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 Jan 2021 04:29:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:35380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728723AbhAUJ2l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 04:28:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3A52B96F;
        Thu, 21 Jan 2021 09:27:57 +0000 (UTC)
Subject: Re: [PATCH v3 3/5] nvme-fabrics: avoid double request completion for
 nvmf_fail_nonready_command
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chao Leng <lengchao@huawei.com>, kbusch@kernel.org
References: <20210121070330.19701-1-lengchao@huawei.com>
 <20210121070330.19701-4-lengchao@huawei.com>
 <fda1fdb8-8a9d-2e95-4d08-8d8ee1df450d@suse.de>
 <20210121090012.GA27342@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <467a43b0-82cc-69b7-460a-413ddc8cf574@suse.de>
Date:   Thu, 21 Jan 2021 10:27:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210121090012.GA27342@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/21/21 10:00 AM, Christoph Hellwig wrote:
> On Thu, Jan 21, 2021 at 09:58:37AM +0100, Hannes Reinecke wrote:
>> On 1/21/21 8:03 AM, Chao Leng wrote:
>>> When reconnect, the request may be completed with NVME_SC_HOST_PATH_ERROR
>>> in nvmf_fail_nonready_command. The state of request will be changed to
>>> MQ_RQ_IN_FLIGHT before call nvme_complete_rq. If free the request
>>> asynchronously such as in nvme_submit_user_cmd, in extreme scenario
>>> the request may be completed again in tear down process.
>>> nvmf_fail_nonready_command do not need calling blk_mq_start_request
>>> before complete the request. nvmf_fail_nonready_command should set
>>> the state of request to MQ_RQ_COMPLETE before complete the request.
>>>
>>
>> So what you are saying is that there is a race condition between
>> blk_mq_start_request()
>> and
>> nvme_complete_request()
> 
> Between those to a teardown that cancels all requests can come in.
> 
Doesn't nvme_complete_request() insulate against a double completion?
I seem to remember we've gone through great lengths ensuring that.

And if this is just about setting the correct error code on completion 
I'd really prefer to stick with the current code. Moving that into a 
helper is fine, but I'd rather not introduce our own code modifying 
request state.

If there really is a race condition this feels like a more generic 
problem; calling blk_mq_start_request() followed by blk_mq_end_request() 
is a quite common pattern, and from my impression the recommended way.
So if there is an issue it would need to be addressed for all drivers, 
not just some nvme-specific way.
Plus I'd like to have Jens' opinion here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
