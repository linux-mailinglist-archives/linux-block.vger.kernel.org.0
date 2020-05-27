Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B06F1E4CE8
	for <lists+linux-block@lfdr.de>; Wed, 27 May 2020 20:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388778AbgE0SQf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 27 May 2020 14:16:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:44140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388720AbgE0SQf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:16:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4A5DAAEB9;
        Wed, 27 May 2020 18:16:36 +0000 (UTC)
Subject: Re: [PATCH 3/8] blk-mq: move more request initialization to
 blk_mq_rq_ctx_init
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, Daniel Wagner <dwagner@suse.de>
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-4-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <70eecb04-8c44-540d-ac04-ac3a739ef8dd@suse.de>
Date:   Wed, 27 May 2020 20:16:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527180644.514302-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/20 8:06 PM, Christoph Hellwig wrote:
> Don't split request initialization between __blk_mq_alloc_request and
> blk_mq_rq_ctx_init.  Also remove the op argument as it can be derived
> from the blk_mq_alloc_data structure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> ---
>   block/blk-mq.c | 36 +++++++++++++++++++-----------------
>   1 file changed, 19 insertions(+), 17 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
