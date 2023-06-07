Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CAE726990
	for <lists+linux-block@lfdr.de>; Wed,  7 Jun 2023 21:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjFGTQJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 7 Jun 2023 15:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjFGTQI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jun 2023 15:16:08 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65048E;
        Wed,  7 Jun 2023 12:16:07 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso6968869a12.3;
        Wed, 07 Jun 2023 12:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686165367; x=1688757367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbZKLeKTm0bcOQYlnV8iDh8X4Z+dw9elSp8VEqzuMU0=;
        b=eJKUhaDwJa5ompXrERmVE8TG/jnrZkvBbFIPzKC9lBDDnYStao0qDnF7uj3028qyOb
         GNajuictu+/Jp4t3kd0qeclLvxT0E8qNLFA/FnvsaGW8i7bvEPGW7Q4QUIsGlPLMinev
         9UiNiyLsqvjL9gF9olpTre2WcguLzD7oYmP3515Ew/yDOrz/pfOg5RHsM/SyD6m6NH5m
         d8mdbnaohhTnmuNteQq9XU2zvRjkZvMPJQqDwsUF9OzuJruoXZcdEGx7m40dDdx7fKYh
         Fe+kXMBM/keQv1r2L/GcjkrFuLbLgJCLjMXvUXGwfIhe2mHmf6MbpsuctjT8OzZNc8Dy
         +mYA==
X-Gm-Message-State: AC+VfDxBa6FDk1d4xQpzzbt2j/iy70bDxncudUcTQ+D/TtoLq2/RO02r
        kei85qF8fsKca/kU/do4698=
X-Google-Smtp-Source: ACHHUZ6tjYMALMl1KizR/bJuXfYlKQSS+qR+2YwClxD9TsUdeMnYqtt0bgPTUIDSY97+gOkmcinG+w==
X-Received: by 2002:a17:902:7c97:b0:1af:babd:7b84 with SMTP id y23-20020a1709027c9700b001afbabd7b84mr5373042pll.41.1686165367083;
        Wed, 07 Jun 2023 12:16:07 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id b6-20020a170903228600b001a9873495f2sm10816466plh.233.2023.06.07.12.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 12:16:06 -0700 (PDT)
Message-ID: <3b8b13bf-a458-827a-b916-07d7eee8ae00@acm.org>
Date:   Wed, 7 Jun 2023 12:16:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 4/8] scsi: call scsi_stop_queue() without state_mutex
 held
Content-Language: en-US
To:     mwilck@suse.com, "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
References: <20230607182249.22623-1-mwilck@suse.com>
 <20230607182249.22623-5-mwilck@suse.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230607182249.22623-5-mwilck@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/7/23 11:22, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> sdev->state_mutex protects only sdev->sdev_state. There's no reason
> to keep it held while calling scsi_stop_queue().
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>   drivers/scsi/scsi_lib.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index ce5788643011..26e7ce25fa05 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -2795,9 +2795,9 @@ static void scsi_device_block(struct scsi_device *sdev, void *data)
>   
>   	mutex_lock(&sdev->state_mutex);
>   	err = __scsi_internal_device_block_nowait(sdev);
> +	mutex_unlock(&sdev->state_mutex);
>   	if (err == 0)
>   		scsi_stop_queue(sdev, false);
> -	mutex_unlock(&sdev->state_mutex);
>   
>   	WARN_ONCE(err, "__scsi_internal_device_block_nowait(%s) failed: err = %d\n",
>   		  dev_name(&sdev->sdev_gendev), err);

There is a reason why scsi_stop_queue() is called with the sdev state 
mutex held: if this mutex is not held, unblocking of a SCSI device can 
start before the scsi_stop_queue() call has finished. It is not allowed 
to swap the order of the blk_mq_quiesce_queue() and 
blk_mq_unquiesce_queue() calls.

Bart.
