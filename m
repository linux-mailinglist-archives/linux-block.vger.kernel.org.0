Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8935D1DE2B8
	for <lists+linux-block@lfdr.de>; Fri, 22 May 2020 11:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgEVJNo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 22 May 2020 05:13:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:47426 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbgEVJNo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 05:13:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 72535B2038;
        Fri, 22 May 2020 09:13:45 +0000 (UTC)
Subject: Re: [PATCH 2/6] blk-mq: simplify the blk_mq_get_request calling
 convention
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200520170635.2094101-1-hch@lst.de>
 <20200520170635.2094101-3-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <6d356a18-a104-323b-34c0-ed69929fa986@suse.de>
Date:   Fri, 22 May 2020 11:13:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520170635.2094101-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/20 7:06 PM, Christoph Hellwig wrote:
> The bio argument is entirely unused, and the request_queue can be passed
> through the alloc_data, given that it needs to be filled out for the
> low-level tag allocation anyway.  Also rename the function to
> __blk_mq_alloc_request as the switch between get and alloc in the call
> chains is rather confusing.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq.c | 36 ++++++++++++++++++++++--------------
>   1 file changed, 22 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
