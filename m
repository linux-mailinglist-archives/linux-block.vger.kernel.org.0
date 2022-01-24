Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDDE49804A
	for <lists+linux-block@lfdr.de>; Mon, 24 Jan 2022 14:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242866AbiAXNCw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 Jan 2022 08:02:52 -0500
Received: from verein.lst.de ([213.95.11.211]:55672 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239721AbiAXNCv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jan 2022 08:02:51 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2EF3868C4E; Mon, 24 Jan 2022 14:02:48 +0100 (CET)
Date:   Mon, 24 Jan 2022 14:02:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 03/13] block: move blkcg initialization/destroy into
 disk allocation/release handler
Message-ID: <20220124130248.GC27269@lst.de>
References: <20220122111054.1126146-1-ming.lei@redhat.com> <20220122111054.1126146-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122111054.1126146-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> @@ -1308,6 +1316,10 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
>  	if (xa_insert(&disk->part_tbl, 0, disk->part0, GFP_KERNEL))
>  		goto out_destroy_part_tbl;
>  
> +	/* todo: move blkcg into gendisk */
> +	if (blkcg_init_queue(q))
> +		goto out_erase_part0;
> +

I don't think having this todo comment here is helpful (even if I agree
with the move and actually half old preliminary patches for that).

With this comment dropped:

Reviewed-by: Christoph Hellwig <hch@lst.de>
