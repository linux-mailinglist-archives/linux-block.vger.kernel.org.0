Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAF434E137
	for <lists+linux-block@lfdr.de>; Tue, 30 Mar 2021 08:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhC3G1x (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Mar 2021 02:27:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:42946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230323AbhC3G1k (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 02:27:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99367AE72;
        Tue, 30 Mar 2021 06:27:39 +0000 (UTC)
Subject: Re: [PATCH V4 10/12] block: add queue_to_disk() to get gendisk from
 request_queue
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20210329152622.173035-1-ming.lei@redhat.com>
 <20210329152622.173035-11-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <7c5ffacf-ea76-2eeb-d19e-d8f2c175499a@suse.de>
Date:   Tue, 30 Mar 2021 08:27:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210329152622.173035-11-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/21 5:26 PM, Ming Lei wrote:
> From: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> Sometimes we need to get the corresponding gendisk from request_queue.
> 
> It is preferred that block drivers store private data in
> gendisk->private_data rather than request_queue->queuedata, e.g. see:
> commit c4a59c4e5db3 ("dm: stop using ->queuedata").
> 
> So if only request_queue is given, we need to get its corresponding
> gendisk to get the private data stored in that gendisk.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Mike Snitzer <snitzer@redhat.com>
> ---
>   include/linux/blkdev.h       | 2 ++
>   include/trace/events/kyber.h | 6 +++---
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

.. and you probably might want to add your signed-off to this one, too :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
