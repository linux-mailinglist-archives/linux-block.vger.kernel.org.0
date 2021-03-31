Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECD0347CC0
	for <lists+linux-block@lfdr.de>; Wed, 24 Mar 2021 16:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbhCXPdk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 Mar 2021 11:33:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:44376 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236723AbhCXPdJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 11:33:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C60BAD9F;
        Wed, 24 Mar 2021 15:33:08 +0000 (UTC)
Subject: Re: [PATCH V3 06/13] block: add new field into 'struct bvec_iter'
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20210324121927.362525-1-ming.lei@redhat.com>
 <20210324121927.362525-7-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <b433eb9e-3d70-8791-93c5-6084bb3a76ed@suse.de>
Date:   Wed, 24 Mar 2021 16:33:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210324121927.362525-7-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/21 1:19 PM, Ming Lei wrote:
> There is a hole at the end of 'struct bvec_iter', so put a new field
> here and we can save cookie returned from submit_bio() here for
> supporting bio based polling.
> 
> This way can avoid to extend bio unnecessarily.
> 
> Meantime add two helpers to get/set this field.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk.h          | 10 ++++++++++
>   include/linux/bvec.h |  8 ++++++++
>   2 files changed, 18 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
