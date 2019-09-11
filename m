Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80951B0568
	for <lists+linux-block@lfdr.de>; Thu, 12 Sep 2019 00:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfIKWNW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Sep 2019 18:13:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36920 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfIKWNW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 18:13:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id c17so4488763pgg.4
        for <linux-block@vger.kernel.org>; Wed, 11 Sep 2019 15:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nf55d0M2fgrTAZT8patiiuxPZwICTFJSYQN2V2QrDmQ=;
        b=anYEbfk0b5+4asQZViJ4GPOYj9WhTStLmh+ecrhz8v0xdn4zwEPtVsZfof1Lme4QKG
         b32MZ4jlp1aoNGec5iHuPGezZ3FzV6+R16gp2x0cz7OsJCmV/AthIUpblCcZuw36Gto7
         mJkKm7YXtOUw2VruFSiLqhQj0OJu9fPbzDsFVuzSNY/cxfPyn9H0FwUDZLL1LMqq00G1
         oI1QPoTi1nvd0pX87LlIIbwYg89eK2LT1S43DfayBVQKgXroKePJDLEGsZqSvKP18I9I
         cHuVxbQjxuvEUCu+JKod7gM2xasHWrJxerWu65fq7bPTxfGnDob4I8Jir7+fVc6Xf8Kk
         JWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nf55d0M2fgrTAZT8patiiuxPZwICTFJSYQN2V2QrDmQ=;
        b=L1qRl+BzggOyL4cUyy1Ml5hEiejX8iz8zyiErESytBRS6b8khmhyf7rdZXAmQPZjs3
         DwPx3IhaJfYMLnS+RNx4B1HI5UOuxcr+T3EiRn9kWXwv6r0QfbWEOMgKknp0vqsNr53L
         WzcNdaN+VWmzof7wgalSieSz1GhxuOzrtsioEbNY43c5r4MKRU/iAIyJbgsCwesOJDlM
         RQMqeu6JMpMbaJENLBgz2a90KH1v9yVz4ue20zoqqzhM6XdYPclKO3FKDt1kh9VK2kez
         bu0PYYDlJs5odJvV0hnDtwTe/A4xJA6bcYbAcZkI8Ei7bb0eZOffDCXoJ60T4RZONu3Z
         IMwA==
X-Gm-Message-State: APjAAAWqKjL9zZ4wpb1dcHqNbVLPqke8VvibPeuPW0tLOCP/Gx2jGCDf
        w+8g1HX5e4B7RVCkcLaW5NXzhQ==
X-Google-Smtp-Source: APXvYqzPGDfNqvq/dqDwP6b3TOEtC3Bb+5uRpJ4DO9WApq2laqUm31jZznk69DG8lZqgNynRXwxbkg==
X-Received: by 2002:a65:6284:: with SMTP id f4mr13973604pgv.416.1568239999858;
        Wed, 11 Sep 2019 15:13:19 -0700 (PDT)
Received: from [192.168.1.188] ([23.158.160.160])
        by smtp.gmail.com with ESMTPSA id r1sm18455579pgv.70.2019.09.11.15.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 15:13:18 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] block: bypass blk_set_runtime_active for
 uninitialized q->dev
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.ibm.com, matthias.bgg@gmail.com
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kuohong.wang@mediatek.com,
        peter.wang@mediatek.com, chun-hung.wu@mediatek.com,
        andy.teng@mediatek.com
References: <1568183562-18241-1-git-send-email-stanley.chu@mediatek.com>
 <1568183562-18241-2-git-send-email-stanley.chu@mediatek.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <66fddf12-0dc4-1c73-affd-f8404e87342f@kernel.dk>
Date:   Wed, 11 Sep 2019 16:13:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568183562-18241-2-git-send-email-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/11/19 12:32 AM, Stanley Chu wrote:
> Some devices may skip blk_pm_runtime_init() and have null pointer
> in its request_queue->dev. For example, SCSI devices of UFS Well-Known
> LUNs.
> 
> Currently the null pointer is checked by the user of
> blk_set_runtime_active(), i.e., scsi_dev_type_resume(). It is better to
> check it by blk_set_runtime_active() itself instead of by its users.
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>   block/blk-pm.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-pm.c b/block/blk-pm.c
> index 0a028c189897..56ed94f7a2a3 100644
> --- a/block/blk-pm.c
> +++ b/block/blk-pm.c
> @@ -207,6 +207,9 @@ EXPORT_SYMBOL(blk_post_runtime_resume);
>    */
>   void blk_set_runtime_active(struct request_queue *q)
>   {
> +	if (!q->dev)
> +		return;
> +
>   	spin_lock_irq(&q->queue_lock);
>   	q->rpm_status = RPM_ACTIVE;
>   	pm_runtime_mark_last_busy(q->dev);

I'd prefer just doing:

	if (q->dev) {
		...
	}

instead. Other than that little complaint, looks good to me.

-- 
Jens Axboe

