Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A7B36ACE0
	for <lists+linux-block@lfdr.de>; Mon, 26 Apr 2021 09:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhDZHVR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 26 Apr 2021 03:21:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:46022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231816AbhDZHVQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 03:21:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5DABAB036;
        Mon, 26 Apr 2021 07:20:34 +0000 (UTC)
Subject: Re: [PATCH V6 11/12] block: allow to control FLAG_POLL via sysfs for
 bio poll capable queue
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
References: <20210422122038.2192933-1-ming.lei@redhat.com>
 <20210422122038.2192933-12-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <b06f3eb3-d674-9de4-9611-9a3a7d552cde@suse.de>
Date:   Mon, 26 Apr 2021 09:20:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210422122038.2192933-12-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/21 2:20 PM, Ming Lei wrote:
> Prepare for supporting bio based io polling. If one disk is capable of
> bio polling, we allow user to control FLAG_POLL via sysfs.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-sysfs.c     | 14 ++++++++++++--
>  include/linux/genhd.h |  2 ++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
