Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4801D275E
	for <lists+linux-block@lfdr.de>; Thu, 14 May 2020 08:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgENGSg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 14 May 2020 02:18:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:39076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENGSf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 02:18:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B6D5DABD0;
        Thu, 14 May 2020 06:18:36 +0000 (UTC)
Subject: Re: [PATCH v2] nvme: Fix io_opt limit setting
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20200514055626.1111729-1-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <b7d1fc3e-342f-310f-ad20-fa4076581236@suse.de>
Date:   Thu, 14 May 2020 08:18:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514055626.1111729-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/14/20 7:56 AM, Damien Le Moal wrote:
> Currently, a namespace io_opt queue limit is set by default to the
> physical sector size of the namespace and to the the write optimal
> size (NOWS) when the namespace reports optimal IO sizes. This causes
> problems with block limits stacking in blk_stack_limits() when a
> namespace block device is combined with an HDD which generally do not
> report any optimal transfer size (io_opt limit is 0). The code:
> 
> /* Optimal I/O a multiple of the physical block size? */
> if (t->io_opt & (t->physical_block_size - 1)) {
> 	t->io_opt = 0;
> 	t->misaligned = 1;
> 	ret = -1;
> }
> 
> in blk_stack_limits() results in an error return for this function when
> the combined devices have different but compatible physical sector
> sizes (e.g. 512B sector SSD with 4KB sector disks).
> 
> Fix this by not setting the optimal IO size queue limit if the namespace
> does not report an optimal write size value.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
> 
> * Changes from v1:
>    - Rebased on nvme/nvme-5.8 tree
> 
>   drivers/nvme/host/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 805d289e6cd9..951d558dc662 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1842,7 +1842,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>   {
>   	sector_t capacity = nvme_lba_to_sect(ns, le64_to_cpu(id->nsze));
>   	unsigned short bs = 1 << ns->lba_shift;
> -	u32 atomic_bs, phys_bs, io_opt;
> +	u32 atomic_bs, phys_bs, io_opt = 0;
>   
>   	if (ns->lba_shift > PAGE_SHIFT) {
>   		/* unsupported block size, set capacity to 0 later */
> @@ -1851,7 +1851,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>   	blk_mq_freeze_queue(disk->queue);
>   	blk_integrity_unregister(disk);
>   
> -	atomic_bs = phys_bs = io_opt = bs;
> +	atomic_bs = phys_bs = bs;
>   	nvme_setup_streams_ns(ns->ctrl, ns, &phys_bs, &io_opt);
>   	if (id->nabo == 0) {
>   		/*
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
