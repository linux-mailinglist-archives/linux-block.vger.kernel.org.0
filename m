Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED984CEBD8
	for <lists+linux-block@lfdr.de>; Sun,  6 Mar 2022 15:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbiCFOSu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 6 Mar 2022 09:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiCFOSu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Mar 2022 09:18:50 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69951CB24
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 06:17:57 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id q11so11656337pln.11
        for <linux-block@vger.kernel.org>; Sun, 06 Mar 2022 06:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ILaW05fUQ1dnyzBz2lx6yZLVLQRGUBkLodqqsOJxlfI=;
        b=Uwa0QMeKDwN0s9YWycovMkoEzs1FonPzncoYixFDaCLKKWE8NRke377Ds+vQRw0zvF
         vLD1tb4jZaXTOOc6LfZ3AhSIf/h8bq9qMqjEJIimGkMROi1V8OTwG2adZGKUuZoudFQc
         uI9b8RW139golTXremkXKYtTHWAb0MBX1qjV+CLhQ7VxjKH/syB8PgU21dNujv4d27+2
         O4KgLszw9f2gyrH+NYrdqkfqUVG5+cKgj1BGVkx7O2SfBvPrnnESD/Z9FYYgG8vSH3jv
         oMboe/pScahu/N4HXDrbMuMpS4rglMGUnTodetPWhllk9E+0IRq2qaWyTPOM8h4CgCe4
         G35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ILaW05fUQ1dnyzBz2lx6yZLVLQRGUBkLodqqsOJxlfI=;
        b=y3bQaLF2xd6hVcVauqf3Nh4brlmB67FDagxt1RXYKmCVRcyKHYdtKLehcc+tTTSOi/
         AHOLlUUfAD92viH72gwkJnIjoExUHk1RlCR8E0DqBhASBVO7kJcfY27QGXtbBBaPqmjj
         XgoJS09y8uVnCMzTjdXhqMfnlP8ZhvAem5ghRhW0g/pFKj3NGL4cPKdJlMhQKWxNRrn3
         zMwY9hXwxBENSooaY0yHhF5STILOIGjM+sGluX6LCbLuC9bqo1NbWOqIGmlcOBYr5cO5
         5q59D6kQI0Zx+ZKOqnyO2GdSR53dchBFWsMDDmsbS4xw6+2bp6ihxXiQyj6eWHZeknK3
         Dvng==
X-Gm-Message-State: AOAM533yT4vaki7qlHAT8zLzLUvOzzjOKib/FajerMXk9JcDMQKjxwv4
        iy1AbhlKdUzccNopA2AzJDGKmQ==
X-Google-Smtp-Source: ABdhPJx6LAZv4jYCV9Zgk/CzJKt97QDYhDOzKJXDgh9qczi9Rnn5hhrALqKfNFxkUtAziLz7Ggy7Ag==
X-Received: by 2002:a17:902:ea02:b0:14f:fd0e:e433 with SMTP id s2-20020a170902ea0200b0014ffd0ee433mr8070303plg.24.1646576277022;
        Sun, 06 Mar 2022 06:17:57 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s42-20020a056a0017aa00b004df8133df4asm13133348pfg.179.2022.03.06.06.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 06:17:55 -0800 (PST)
Message-ID: <c94f9c70-7052-0bae-ca0e-9b9ccc48c46b@kernel.dk>
Date:   Sun, 6 Mar 2022 07:17:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: bcache patches for Linux v5.18
Content-Language: en-US
To:     Coly Li <colyli@suse.de>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <084b5385-ebe7-5fca-8b56-a66276005e78@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <084b5385-ebe7-5fca-8b56-a66276005e78@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/6/22 3:35 AM, Coly Li wrote:
> Hi Jens,
> 
> I have technical problem to send patches via email this time, please
> consider to pull the bcache changes from my bcache tree. They can be
> applied on top of your for-5.18/drivers branch.
> 
> We have 2 patches for Linux v5.18, both of them are from Mingzhe Zou.
> The first patch improves bcache initialization speed by avoid
> unnecessary cost of cache consistency, the second one fixes a
> potential NULL pointer deference in bcache initialization time,
> 
> Please take them for Linux v5.18, thanks in advance.

I can take a git pull, but don't base it on something that isn't a tree
of mine. If I pull your branch right now, I'll get a ton of unrelated
changes.

If you want to do a git pull vs sending patches, base it on
for-5.18/drivers instead.

-- 
Jens Axboe

