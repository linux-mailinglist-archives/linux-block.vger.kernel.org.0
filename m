Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FB21C3347
	for <lists+linux-block@lfdr.de>; Mon,  4 May 2020 09:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgEDHE5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 May 2020 03:04:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:56704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgEDHE5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 03:04:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 50BBFABC7;
        Mon,  4 May 2020 07:04:57 +0000 (UTC)
Subject: Re: [PATCH V9 05/11] blk-mq: support rq filter callback when
 iterating rqs
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200502235454.1118520-1-ming.lei@redhat.com>
 <20200502235454.1118520-6-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <b6e57562-b2c8-0b2b-5bd2-7d09edf9e051@suse.de>
Date:   Mon, 4 May 2020 09:04:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200502235454.1118520-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/3/20 1:54 AM, Ming Lei wrote:
> Now request is thought as in-flight only when its state is updated as
> MQ_RQ_IN_FLIGHT, which is done by driver via blk_mq_start_request().
> 
> Actually from blk-mq's view, one rq can be thought as in-flight
> after its tag is >= 0.
> 
> Passing one rq filter callback so that we can iterating requests very
> flexible.
> 
> Implement blk_mq_all_tag_busy_iter() which accepts a 'busy_fn' argument
> to filter over which commands to iterate, and make the existing
> blk_mq_tag_busy_iter() a wrapper for the new function.
> 
> Cc: John Garry <john.garry@huawei.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-tag.c | 39 +++++++++++++++++++++++++++------------
>   block/blk-mq-tag.h |  4 ++++
>   2 files changed, 31 insertions(+), 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
