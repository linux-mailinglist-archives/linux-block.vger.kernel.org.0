Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4502CB54F
	for <lists+linux-block@lfdr.de>; Wed,  2 Dec 2020 07:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbgLBGv1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Dec 2020 01:51:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:53934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387543AbgLBGv1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 01:51:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 425F2ABD2;
        Wed,  2 Dec 2020 06:50:45 +0000 (UTC)
Subject: Re: [PATCH v4 2/9] block: Introduce BLK_MQ_REQ_PM
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Can Guo <cang@codeaurora.org>
References: <20201130024615.29171-1-bvanassche@acm.org>
 <20201130024615.29171-3-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <b83d9b8b-ebc9-c236-89ed-38edfc5008c5@suse.de>
Date:   Wed, 2 Dec 2020 07:50:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130024615.29171-3-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/20 3:46 AM, Bart Van Assche wrote:
> Introduce the BLK_MQ_REQ_PM flag. This flag makes the request allocation
> functions set RQF_PM. This is the first step towards removing
> BLK_MQ_REQ_PREEMPT.
> 
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Stanley Chu <stanley.chu@mediatek.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Can Guo <cang@codeaurora.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-core.c       | 7 ++++---
>   block/blk-mq.c         | 2 ++
>   include/linux/blk-mq.h | 2 ++
>   3 files changed, 8 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
