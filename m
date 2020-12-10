Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC30C2D587D
	for <lists+linux-block@lfdr.de>; Thu, 10 Dec 2020 11:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388932AbgLJKqN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 10 Dec 2020 05:46:13 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2240 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731564AbgLJKqM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 05:46:12 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cs9Vy2vsTz67Cr2;
        Thu, 10 Dec 2020 18:43:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Dec 2020 11:45:29 +0100
Received: from [10.210.172.228] (10.210.172.228) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Dec 2020 10:45:28 +0000
Subject: Re: [RFC PATCH] blk-mq: Clean up references when freeing rqs
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hch@lst.de>, <hare@suse.de>,
        <ppvk@codeaurora.org>, <bvanassche@acm.org>,
        <kashyap.desai@broadcom.com>
References: <1606827738-238646-1-git-send-email-john.garry@huawei.com>
 <20201202033134.GD494805@T590>
 <aaf77015-3039-6b04-3417-d376e3467444@huawei.com>
 <20201203005505.GB540033@T590>
 <fa222311-2184-0041-61ab-b3d70fb92585@huawei.com>
 <7beb86a2-5c4b-bdc0-9fce-1b583548c6d0@huawei.com>
 <20201209010102.GA1217988@T590>
 <13327a68-6f86-96da-0c5f-5fa0be326d6f@huawei.com>
 <20201210020745.GA1363446@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d8500ca2-1f26-7d28-6baa-237284df0a5c@huawei.com>
Date:   Thu, 10 Dec 2020 10:44:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201210020745.GA1363446@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.172.228]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

On 10/12/2020 02:07, Ming Lei wrote:
>> Apart from this, my concern is that we come with for a solution, but it's a
>> complicated solution and may not be accepted as this issue is not seen as a
>> problem in practice.
> If that is the case, I'd suggest to consider the solution in the
> following link:
> 
> https://lore.kernel.org/linux-block/20200820180335.3109216-1-ming.lei@redhat.com/
> 
> At least, the idea is simple, which can be extended to support allocate driver tags
> request pool dynamically.

As I see with your approach, we may still iterate a stale request, but 
it just has not been freed, so just no use-after-free BUG, right? Rather 
it is cached until all references dropped. It may be best solution.

So I'll try an experiment today to prove your concern about 
blk_mq_queue_tag_busy_iter(). Then look at possible solution which 
builds on patch in $subject, and compare.

Thanks,
John
