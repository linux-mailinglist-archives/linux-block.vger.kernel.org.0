Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCC42D3B27
	for <lists+linux-block@lfdr.de>; Wed,  9 Dec 2020 07:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgLIGGm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Dec 2020 01:06:42 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:40117 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgLIGGe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 01:06:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607493975; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=BEqIw24aN7ajVBeLVRznTxt4eEZYSdOJ6eV/Lf3Iw9A=;
 b=nhcjGdA4WT6CevFyxEGEO8/2fv/4WjkPHUKOpQDXAsdTyfmPkIKpgvxRPNJy4wZtSuTByLu5
 FgF/EQ+NMcy5TsKgpaQ+gEV3/G0WgoBmjg3TeB3e97FLLEjG6h527AtHucQb2Ix6oTaoagcd
 UTYF2Q4Fjpqdq0ydwl+mdPWsV20=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MmE5NyIsICJsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fd06954a44f9b1da01a9da5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 09 Dec 2020 06:06:12
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 59D73C43463; Wed,  9 Dec 2020 06:06:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C5118C433C6;
        Wed,  9 Dec 2020 06:06:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 09 Dec 2020 14:06:09 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Stanley Chu <stanley.chu@mediatek.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: Re: [PATCH v5 6/8] scsi: Only process PM requests if rpm_status !=
 RPM_ACTIVE
In-Reply-To: <20201209052951.16136-7-bvanassche@acm.org>
References: <20201209052951.16136-1-bvanassche@acm.org>
 <20201209052951.16136-7-bvanassche@acm.org>
Message-ID: <c6b64b3fb553648c0849d608414b464d@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-12-09 13:29, Bart Van Assche wrote:
> Instead of submitting all SCSI commands submitted with scsi_execute() 
> to a
> SCSI device if rpm_status != RPM_ACTIVE, only submit RQF_PM (power
> management requests) if rpm_status != RPM_ACTIVE. This patch makes the
> SCSI core handle the runtime power management status (rpm_status) as it
> should be handled.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Can Guo <cang@codeaurora.org>

> Cc: Can Guo <cang@codeaurora.org>
> Cc: Stanley Chu <stanley.chu@mediatek.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/scsi/scsi_lib.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index b7ac14571415..91bc39a4c3c3 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -249,7 +249,8 @@ int __scsi_execute(struct scsi_device *sdev, const
> unsigned char *cmd,
> 
>  	req = blk_get_request(sdev->request_queue,
>  			data_direction == DMA_TO_DEVICE ?
> -			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, BLK_MQ_REQ_PREEMPT);
> +			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN,
> +			rq_flags & RQF_PM ? BLK_MQ_REQ_PM : 0);
>  	if (IS_ERR(req))
>  		return ret;
>  	rq = scsi_req(req);
> @@ -1206,6 +1207,8 @@ static blk_status_t
>  scsi_device_state_check(struct scsi_device *sdev, struct request *req)
>  {
>  	switch (sdev->sdev_state) {
> +	case SDEV_CREATED:
> +		return BLK_STS_OK;
>  	case SDEV_OFFLINE:
>  	case SDEV_TRANSPORT_OFFLINE:
>  		/*
> @@ -1232,18 +1235,18 @@ scsi_device_state_check(struct scsi_device
> *sdev, struct request *req)
>  		return BLK_STS_RESOURCE;
>  	case SDEV_QUIESCE:
>  		/*
> -		 * If the devices is blocked we defer normal commands.
> +		 * If the device is blocked we only accept power management
> +		 * commands.
>  		 */
> -		if (req && !(req->rq_flags & RQF_PREEMPT))
> +		if (req && WARN_ON_ONCE(!(req->rq_flags & RQF_PM)))
>  			return BLK_STS_RESOURCE;
>  		return BLK_STS_OK;
>  	default:
>  		/*
>  		 * For any other not fully online state we only allow
> -		 * special commands.  In particular any user initiated
> -		 * command is not allowed.
> +		 * power management commands.
>  		 */
> -		if (req && !(req->rq_flags & RQF_PREEMPT))
> +		if (req && !(req->rq_flags & RQF_PM))
>  			return BLK_STS_IOERR;
>  		return BLK_STS_OK;
>  	}
> @@ -2517,15 +2520,13 @@ void sdev_evt_send_simple(struct scsi_device 
> *sdev,
>  EXPORT_SYMBOL_GPL(sdev_evt_send_simple);
> 
>  /**
> - *	scsi_device_quiesce - Block user issued commands.
> + *	scsi_device_quiesce - Block all commands except power management.
>   *	@sdev:	scsi device to quiesce.
>   *
>   *	This works by trying to transition to the SDEV_QUIESCE state
>   *	(which must be a legal transition).  When the device is in this
> - *	state, only special requests will be accepted, all others will
> - *	be deferred.  Since special requests may also be requeued requests,
> - *	a successful return doesn't guarantee the device will be
> - *	totally quiescent.
> + *	state, only power management requests will be accepted, all others 
> will
> + *	be deferred.
>   *
>   *	Must be called with user context, may sleep.
>   *
> @@ -2587,12 +2588,12 @@ void scsi_device_resume(struct scsi_device 
> *sdev)
>  	 * device deleted during suspend)
>  	 */
>  	mutex_lock(&sdev->state_mutex);
> +	if (sdev->sdev_state == SDEV_QUIESCE)
> +		scsi_device_set_state(sdev, SDEV_RUNNING);
>  	if (sdev->quiesced_by) {
>  		sdev->quiesced_by = NULL;
>  		blk_clear_pm_only(sdev->request_queue);
>  	}
> -	if (sdev->sdev_state == SDEV_QUIESCE)
> -		scsi_device_set_state(sdev, SDEV_RUNNING);
>  	mutex_unlock(&sdev->state_mutex);
>  }
>  EXPORT_SYMBOL(scsi_device_resume);
