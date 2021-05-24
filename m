Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D561538E224
	for <lists+linux-block@lfdr.de>; Mon, 24 May 2021 10:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhEXIGA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 May 2021 04:06:00 -0400
Received: from verein.lst.de ([213.95.11.211]:53643 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhEXIF6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 04:05:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AAB8667373; Mon, 24 May 2021 10:04:28 +0200 (CEST)
Date:   Mon, 24 May 2021 10:04:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv3 4/4] nvme: use return value from blk_execute_rq()
Message-ID: <20210524080428.GA24488@lst.de>
References: <20210521202145.3674904-1-kbusch@kernel.org> <20210521202145.3674904-5-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521202145.3674904-5-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +/*
> + * Return values:
> + * 0:  success
> + * >0: nvme controller's cqe status response
> + * <0: kernel error in lieu of controller response
> + */

For better reading flow I'd reformat this as:

/*
 * Return value:
 *   0:	success
 * > 0:	nvme controller's cqe status response
 * < 0: kernel error in lieu of controller response
 */

> +static int nvme_passthrough_status(struct request *rq, blk_status_t status)
> +{
> +	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
> +		return -EINTR;
> +	else if (nvme_req(rq)->status)
> +		return nvme_req(rq)->status;
> +	return blk_status_to_errno(status);
> +}

I find this a little odd disconnected from the actual execure call.
What about a helper like this instead:

static int nvme_execute_rq(struct gendisk *disk, struct request *rq,
		bool at_head)
{
	blk_status_t status;

	status = blk_execute_rq(disk, req, at_head);
	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
		return -EINTR;
	if (nvme_req(rq)->status)
		return nvme_req(rq)->status;
	return blk_status_to_errno(status);
}

> -	nvme_execute_passthru_rq(rq);
> +	status = nvme_execute_passthru_rq(rq);
>  
> -	status = nvme_req(rq)->status;
>  	if (status == NVME_SC_SUCCESS &&
>  	    req->cmd->common.opcode == nvme_admin_identify) {
>  		switch (req->cmd->identify.cns) {
> @@ -168,7 +167,8 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
>  			nvmet_passthru_override_id_ns(req);
>  			break;
>  		}
> -	}
> +	} else if (status < 0)
> +		status = NVME_SC_INTERNAL;

Don't we need a better translation here?
