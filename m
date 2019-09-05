Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B42F6AAA81
	for <lists+linux-block@lfdr.de>; Thu,  5 Sep 2019 20:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403809AbfIESEP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 5 Sep 2019 14:04:15 -0400
Received: from verein.lst.de ([213.95.11.211]:50741 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403808AbfIESEP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Sep 2019 14:04:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 907B568B05; Thu,  5 Sep 2019 20:04:12 +0200 (CEST)
Date:   Thu, 5 Sep 2019 20:04:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        shlomin@mellanox.com, israelr@mellanox.com
Subject: Re: [PATCH 2/3] block: don't remap ref tag for T10 PI type 0
Message-ID: <20190905180412.GC24146@lst.de>
References: <1567701836-29725-1-git-send-email-maxg@mellanox.com> <1567701836-29725-2-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567701836-29725-2-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> @@ -186,7 +186,8 @@ void t10_pi_prepare(struct request *rq)
>  	u32 ref_tag = t10_pi_ref_tag(rq);
>  	struct bio *bio;
>  
> -	if (rq->rq_disk->protection_type == T10_PI_TYPE3_PROTECTION)
> +	if (rq->rq_disk->protection_type == T10_PI_TYPE0_PROTECTION ||
> +	    rq->rq_disk->protection_type == T10_PI_TYPE3_PROTECTION)

Maybe just check for the ones we want to remap instead.  And add
a little helper

stastic inline bool blk_integrity_need_remap(struct gendisk *disk)
{
	return disk->protection_type == T10_PI_TYPE1_PROTECTION ||
		disk->protection_type == T10_PI_TYPE2_PROTECTION;
}
