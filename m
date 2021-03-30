Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F369F34E15C
	for <lists+linux-block@lfdr.de>; Tue, 30 Mar 2021 08:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhC3GlT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Mar 2021 02:41:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:57520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230416AbhC3GlA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 02:41:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DBBC5B1BD;
        Tue, 30 Mar 2021 06:40:59 +0000 (UTC)
Subject: Re: [PATCH V4 12/12] dm: support IO polling for bio-based dm device
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
References: <20210329152622.173035-1-ming.lei@redhat.com>
 <20210329152622.173035-13-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c9cb5fe6-490e-867c-a8bc-842f3c5de835@suse.de>
Date:   Tue, 30 Mar 2021 08:40:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210329152622.173035-13-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/21 5:26 PM, Ming Lei wrote:
> From: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> IO polling is enabled when all underlying target devices are capable
> of IO polling. The sanity check supports the stacked device model, in
> which one dm device may be build upon another dm device. In this case,
> the mapped device will check if the underlying dm target device
> supports IO polling.
> 
> Reviewed-by: Mike Snitzer <snitzer@redhat.com>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/md/dm-table.c         | 24 ++++++++++++++++++++++++
>   drivers/md/dm.c               | 14 ++++++++++++++
>   include/linux/device-mapper.h |  1 +
>   3 files changed, 39 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
