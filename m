Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FFF2CD5F6
	for <lists+linux-block@lfdr.de>; Thu,  3 Dec 2020 13:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbgLCMum (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 3 Dec 2020 07:50:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:36640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbgLCMum (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 3 Dec 2020 07:50:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64D10AC6A;
        Thu,  3 Dec 2020 12:50:00 +0000 (UTC)
Subject: Re: [PATCH 5/5] block: remove the request_queue to argument request
 based tracepoints
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-s390@vger.kernel.org
References: <20201130175854.982460-1-hch@lst.de>
 <20201130175854.982460-6-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d7798a1e-70b5-27bc-3bb9-e8d300907920@suse.de>
Date:   Thu, 3 Dec 2020 13:49:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130175854.982460-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/20 6:58 PM, Christoph Hellwig wrote:
> The request_queue can trivially be derived from the request.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-merge.c            |  2 +-
>   block/blk-mq-sched.c         |  2 +-
>   block/blk-mq.c               |  8 +++----
>   drivers/md/dm-rq.c           |  2 +-
>   drivers/s390/scsi/zfcp_fsf.c |  3 +--
>   include/linux/blktrace_api.h |  5 ++--
>   include/trace/events/block.h | 30 ++++++++++--------------
>   kernel/trace/blktrace.c      | 44 ++++++++++++++----------------------
>   8 files changed, 39 insertions(+), 57 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
