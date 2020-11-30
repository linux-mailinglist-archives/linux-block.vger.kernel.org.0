Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621602C7ECD
	for <lists+linux-block@lfdr.de>; Mon, 30 Nov 2020 08:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgK3HiY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 Nov 2020 02:38:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:51610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgK3HiY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 02:38:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0AAA6AD09;
        Mon, 30 Nov 2020 07:37:43 +0000 (UTC)
Subject: Re: [PATCH 27/45] block: simplify the block device claiming interface
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20201128161510.347752-1-hch@lst.de>
 <20201128161510.347752-28-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <1bd1571f-69be-03ab-6d67-3a6cb3a71e1e@suse.de>
Date:   Mon, 30 Nov 2020 08:37:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201128161510.347752-28-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/20 5:14 PM, Christoph Hellwig wrote:
> Stop passing the whole device as a separate argument given that it
> can be trivially deducted and cleanup the !holder debug check.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
>   drivers/block/loop.c   | 12 +++++-----
>   fs/block_dev.c         | 51 +++++++++++++++---------------------------
>   include/linux/blkdev.h |  6 ++---
>   3 files changed, 25 insertions(+), 44 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
