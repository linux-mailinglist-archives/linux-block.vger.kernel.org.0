Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29F8772D9A
	for <lists+linux-block@lfdr.de>; Mon,  7 Aug 2023 20:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjHGSTG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 7 Aug 2023 14:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjHGSTG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Aug 2023 14:19:06 -0400
Received: from mp-relay-02.fibernetics.ca (mp-relay-02.fibernetics.ca [208.85.217.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390F4194
        for <linux-block@vger.kernel.org>; Mon,  7 Aug 2023 11:19:04 -0700 (PDT)
Received: from mailpool-fe-01.fibernetics.ca (mailpool-fe-01.fibernetics.ca [208.85.217.144])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-02.fibernetics.ca (Postfix) with ESMTPS id 566B975FDB;
        Mon,  7 Aug 2023 18:14:00 +0000 (UTC)
Received: from localhost (mailpool-mx-01.fibernetics.ca [208.85.217.140])
        by mailpool-fe-01.fibernetics.ca (Postfix) with ESMTP id 4AF1E3EBBA;
        Mon,  7 Aug 2023 18:14:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mailpool-fe-01.fibernetics.ca ([208.85.217.144])
        by localhost (mail-mx-01.fibernetics.ca [208.85.217.140]) (amavisd-new, port 10024)
        with ESMTP id aYMdM2wF4x-V; Mon,  7 Aug 2023 18:13:59 +0000 (UTC)
Received: from [192.168.48.17] (host-192.252-165-26.dyn.295.ca [192.252.165.26])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id C8DDB3EBB6;
        Mon,  7 Aug 2023 18:13:59 +0000 (UTC)
Message-ID: <ecae246e-42a5-850c-4208-e33ab9103511@interlog.com>
Date:   Mon, 7 Aug 2023 14:13:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v5 5/7] scsi: scsi_debug: Support injecting unaligned
 write errors
Content-Language: en-CA
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230731221458.437440-1-bvanassche@acm.org>
 <20230731221458.437440-6-bvanassche@acm.org>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <20230731221458.437440-6-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023-07-31 18:14, Bart Van Assche wrote:
> Allow user space software, e.g. a blktests test, to inject unaligned
> write errors.
> 
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Douglas Gilbert <dgilbert@interlog.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Douglas Gilbert <dgilbert@interlog.com>

Thanks.

> ---
>   drivers/scsi/scsi_debug.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 57c6242bfb26..051b0605f11f 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -181,6 +181,7 @@ static const char *sdebug_version_date = "20210520";
>   #define SDEBUG_OPT_NO_CDB_NOISE		0x4000
>   #define SDEBUG_OPT_HOST_BUSY		0x8000
>   #define SDEBUG_OPT_CMD_ABORT		0x10000
> +#define SDEBUG_OPT_UNALIGNED_WRITE	0x20000
>   #define SDEBUG_OPT_ALL_NOISE (SDEBUG_OPT_NOISE | SDEBUG_OPT_Q_NOISE | \
>   			      SDEBUG_OPT_RESET_NOISE)
>   #define SDEBUG_OPT_ALL_INJECTING (SDEBUG_OPT_RECOVERED_ERR | \
> @@ -188,7 +189,8 @@ static const char *sdebug_version_date = "20210520";
>   				  SDEBUG_OPT_DIF_ERR | SDEBUG_OPT_DIX_ERR | \
>   				  SDEBUG_OPT_SHORT_TRANSFER | \
>   				  SDEBUG_OPT_HOST_BUSY | \
> -				  SDEBUG_OPT_CMD_ABORT)
> +				  SDEBUG_OPT_CMD_ABORT | \
> +				  SDEBUG_OPT_UNALIGNED_WRITE)
>   #define SDEBUG_OPT_RECOV_DIF_DIX (SDEBUG_OPT_RECOVERED_ERR | \
>   				  SDEBUG_OPT_DIF_ERR | SDEBUG_OPT_DIX_ERR)
>   
> @@ -3587,6 +3589,14 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
>   	struct sdeb_store_info *sip = devip2sip(devip, true);
>   	u8 *cmd = scp->cmnd;
>   
> +	if (unlikely(sdebug_opts & SDEBUG_OPT_UNALIGNED_WRITE &&
> +		     atomic_read(&sdeb_inject_pending))) {
> +		atomic_set(&sdeb_inject_pending, 0);
> +		mk_sense_buffer(scp, ILLEGAL_REQUEST, LBA_OUT_OF_RANGE,
> +				UNALIGNED_WRITE_ASCQ);
> +		return check_condition_result;
> +	}
> +
>   	switch (cmd[0]) {
>   	case WRITE_16:
>   		ei_lba = 0;

