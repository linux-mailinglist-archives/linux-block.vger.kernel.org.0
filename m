Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08FC34895E
	for <lists+linux-block@lfdr.de>; Thu, 25 Mar 2021 07:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCYGvL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 25 Mar 2021 02:51:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:46468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhCYGuj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 02:50:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 846F3AA55;
        Thu, 25 Mar 2021 06:50:38 +0000 (UTC)
Subject: Re: [PATCH V3 07/13] block/mq: extract one helper function polling hw
 queue
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20210324121927.362525-1-ming.lei@redhat.com>
 <20210324121927.362525-8-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <6acde541-25b5-503b-eb6b-f9340c4e1987@suse.de>
Date:   Thu, 25 Mar 2021 07:50:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210324121927.362525-8-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/21 1:19 PM, Ming Lei wrote:
> From: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> Extract the logic of polling one hw queue and related statistics
> handling out as the helper function.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
