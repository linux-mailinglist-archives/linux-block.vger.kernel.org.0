Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEBC368159
	for <lists+linux-block@lfdr.de>; Thu, 22 Apr 2021 15:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbhDVNUW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 22 Apr 2021 09:20:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:39886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235977AbhDVNUW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 09:20:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B9218B151;
        Thu, 22 Apr 2021 13:19:46 +0000 (UTC)
Subject: Re: [PATCH V6 04/12] block: move block polling code into one
 dedicated source file
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
References: <20210422122038.2192933-1-ming.lei@redhat.com>
 <20210422122038.2192933-5-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <33f573d9-050a-5395-8d2e-9d4e823b646a@suse.de>
Date:   Thu, 22 Apr 2021 15:19:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210422122038.2192933-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/21 2:20 PM, Ming Lei wrote:
> Prepare for supporting bio based io polling, and move blk polling
> code into one dedicated source file. And three shared functions are
> put into private header of blk-mq.h
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/Makefile   |   3 +-
>   block/blk-mq.c   | 230 -----------------------------------------------
>   block/blk-mq.h   |  40 +++++++++
>   block/blk-poll.c | 196 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 238 insertions(+), 231 deletions(-)
>   create mode 100644 block/blk-poll.c
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
