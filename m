Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B638265910
	for <lists+linux-block@lfdr.de>; Fri, 11 Sep 2020 08:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgIKGDd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 11 Sep 2020 02:03:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:38034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgIKGDb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 02:03:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 95412AB54;
        Fri, 11 Sep 2020 06:03:43 +0000 (UTC)
Subject: Re: [PATCH V5 1/4] block: use test_and_{clear|test}_bit to set/clear
 QUEUE_FLAG_QUIESCED
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>
References: <20200911024117.62480-1-ming.lei@redhat.com>
 <20200911024117.62480-2-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <18b0ac79-73bb-66c4-3a3b-2263f7cd6c24@suse.de>
Date:   Fri, 11 Sep 2020 08:03:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911024117.62480-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/11/20 4:41 AM, Ming Lei wrote:
> Prepare for replacing srcu with percpu-refcount for implementing queue
> quiesce.
> 
> The following patch needs to avoid duplicated quiesce action for
> BLK_MQ_F_BLOCKING, so use test_and_{clear|test}_bit to set/clear
> QUEUE_FLAG_QUIESCED.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Cc: Chao Leng <lengchao@huawei.com>
> ---
>   block/blk-core.c | 13 +++++++++++++
>   block/blk-mq.c   | 11 ++++++++---
>   block/blk.h      |  2 ++
>   3 files changed, 23 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
