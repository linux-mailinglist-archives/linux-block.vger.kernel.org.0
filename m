Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C211E4CFB
	for <lists+linux-block@lfdr.de>; Wed, 27 May 2020 20:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391950AbgE0SVt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 27 May 2020 14:21:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:46428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391948AbgE0SVs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:21:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7691EAEB9;
        Wed, 27 May 2020 18:21:50 +0000 (UTC)
Subject: Re: [PATCH 7/8] blk-mq: add blk_mq_all_tag_iter
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-8-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <8374b3ea-560a-117b-421e-a2f84401bbdb@suse.de>
Date:   Wed, 27 May 2020 20:21:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527180644.514302-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/20 8:06 PM, Christoph Hellwig wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> Add a new blk_mq_all_tag_iter function to iterate over all allocated
> scheduler tags and driver tags.  This is more flexible than the existing
> blk_mq_all_tag_busy_iter function as it allows the callers to do whatever
> they want on allocated request instead of being limited to started
> requests.
> 
> It will be used to implement draining allocated requests on specified
> hctx in this patchset.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> [hch: switch from the two booleans to a more readable flags field and
>   consolidate the tags iter functions]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq-tag.c | 46 +++++++++++++++++++++++++++++-----------------
>   block/blk-mq-tag.h |  2 ++
>   2 files changed, 31 insertions(+), 17 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
