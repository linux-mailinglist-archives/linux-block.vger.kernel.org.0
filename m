Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89EC5FC1ED
	for <lists+linux-block@lfdr.de>; Thu, 14 Nov 2019 09:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfKNIx2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 14 Nov 2019 03:53:28 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:45490 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfKNIx2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 03:53:28 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id BB46962AD09;
        Thu, 14 Nov 2019 09:53:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1573721605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQpRA1+NNzJ7pjkdIiMBtnBObqoCwmJxV5F51GwtKwk=;
        b=DN57vSl6poMIMXB91KvAZ1El1tD9zrdvUB0iZU7h18T33YoPbDo7TtooVm1uPzikrBAM8Y
        6CyZypgFxGS278pbG4TdT44USWgk+aqzJkQjGxu7Vnv+t85jo2LAMsE2QycRcXnAWBVfBu
        2TBgY/Y39O4JWcYWjWnHuAvTXgS3v9k=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 Nov 2019 09:53:25 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, Chris Evich <cevich@redhat.com>,
        Patrick Dung <patdung100@gmail.com>,
        Thorsten Schubert <tschubert@bafh.org>
Subject: Re: [PATCH BUGFIX] block, bfq: deschedule empty bfq_queues not
 referred by any process
In-Reply-To: <69B451DE-B04B-4E0E-9464-826C4A7619AD@linaro.org>
References: <20191112074856.40433-1-paolo.valente@linaro.org>
 <bb393dcaa426786e0963cf0e70f0b062@natalenko.name>
 <2FB3736A-693E-44B9-9D1F-39AE0D016644@linaro.org>
 <65fc0bffbcb2296d121b3d5a79108e76@natalenko.name>
 <5773ff54421ccf179ef57d96e19ef042@natalenko.name>
 <69B451DE-B04B-4E0E-9464-826C4A7619AD@linaro.org>
User-Agent: Roundcube Webmail/1.4.0
Message-ID: <5b0b07fc8e50a1beac215230ca84d955@natalenko.name>
X-Sender: oleksandr@natalenko.name
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi.

On 13.11.2019 18:42, Paolo Valente wrote:
>> Il giorno 13 nov 2019, alle ore 16:01, Oleksandr Natalenko 
>> <oleksandr@natalenko.name> ha scritto:
> Ok, you may have given me enough information, thank you very much.
> 
> Could you please apply the attached (compressed) patch on top of my
> offending patch?  For review purposes, here is the simple change:
> 
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2728,7 +2728,8 @@ void bfq_release_process_ref(struct bfq_data
> *bfqd, struct bfq_queue *bfqq)
>          * freed when dequeued from service. But this is assumed to
>          * never happen.
>          */
> -       if (bfq_bfqq_busy(bfqq) && RB_EMPTY_ROOT(&bfqq->sort_list))
> +       if (bfq_bfqq_busy(bfqq) && RB_EMPTY_ROOT(&bfqq->sort_list) &&
> +           bfqq != bfqd->in_service_queue)
>                 bfq_del_bfqq_busy(bfqd, bfqq, false);
> 
>         bfq_put_queue(bfqq);

The issue is not reproducible for me after applying this patch.

Thank you.

-- 
   Oleksandr Natalenko (post-factum)
