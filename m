Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B0224306F
	for <lists+linux-block@lfdr.de>; Wed, 12 Aug 2020 23:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHLVUC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 Aug 2020 17:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgHLVUC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 17:20:02 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2180A20658;
        Wed, 12 Aug 2020 21:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597267201;
        bh=AmjQ5uYR6oxVViDZLWc62fXzkb7VPbyJWVNTNVh5UDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPkAFIa+yTSlYrEFmY/Jh8cQ2yc0sgRkTHVvo9m7vi6vkUYbg7PAtOfIXoOaGgvYh
         Vxdg+cbXLcLCBR/MUujLpReYrtpvw/X+pU+PNDr9ZdldrSsbDt+TrAP7r0Y0rqdEz0
         +W2EqGaWz2NGUno3aEG0bGsWpB73jPB/cLB8jsfE=
Date:   Wed, 12 Aug 2020 14:19:59 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@wdc.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RESEND PATCH] nvme: Use spin_lock_irqsave() when taking the
 ctrl->lock
Message-ID: <20200812211959.GA1238450@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200812210119.7155-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812210119.7155-1-logang@deltatee.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 12, 2020 at 03:01:19PM -0600, Logan Gunthorpe wrote:
> @@ -2971,15 +2971,16 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
>  static struct nvme_cel *nvme_find_cel(struct nvme_ctrl *ctrl, u8 csi)
>  {
>  	struct nvme_cel *cel, *ret = NULL;
> +	unsigned long flags;
> 
> -	spin_lock(&ctrl->lock);
> +	spin_lock_irqsave(&ctrl->lock, flags);
>  	list_for_each_entry(cel, &ctrl->cels, entry) {
>  		if (cel->csi == csi) {
>  			ret = cel;
>  			break;
>  		}
>  	}
> -	spin_unlock(&ctrl->lock);
> +	spin_unlock_irqrestore(&ctrl->lock, flags);
> 
>  	return ret;
>  }
> @@ -2988,6 +2989,7 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
>  				struct nvme_effects_log **log)
>  {
>  	struct nvme_cel *cel = nvme_find_cel(ctrl, csi);
> +	unsigned long flags;
>  	int ret;
> 
>  	if (cel)
> @@ -3006,9 +3008,9 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
> 
>  	cel->csi = csi;
> 
> -	spin_lock(&ctrl->lock);
> +	spin_lock_irqsave(&ctrl->lock, flags);
>  	list_add_tail(&cel->entry, &ctrl->cels);
> -	spin_unlock(&ctrl->lock);
> +	spin_unlock_irqrestore(&ctrl->lock, flags);
>  out:
>  	*log = &cel->log;
>  	return 0;
> 

Neither of these are ever called from an interrupt disabled context,
correct? If so, you can just use spin_lock_irq() without saving the
current irq state.
