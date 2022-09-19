Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4655BD214
	for <lists+linux-block@lfdr.de>; Mon, 19 Sep 2022 18:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiISQTy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 19 Sep 2022 12:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiISQTv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2022 12:19:51 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AF7BF7C
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 09:19:50 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id c4so23324594iof.3
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 09:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=MfR8SYEM/ayWj0nE/c9RrX4FncRoY/5nh8/YlYsAApI=;
        b=5pryB/Qw3pQXpBdl9gbLE40yWfJS8yoigFNBZ9dRXmpVWQftv1bfDS+MB4x+KHHJ//
         qS0s3oI7i8KLh1SRA+vVKdh21N0FjogSAZnfjSHxwyK6wlpagLkpROsMtrGLJO3tEixo
         lHfyc/meiS5YTINNLKFFf+zDNeIJAPj5s2YgJl0zneMwNaFhJpkxf4d0phKQxon5+2BW
         0+pdfbA/8OjBpV5/WxLiQrZaA0uEWxFXK4h1eRMzZATD30+4eXplptvc1M20/u2Xxhsp
         rOWZGbKM5i6VUCJG6rynT5qUvetbCWv17PMvm4sy3gxC7G4pc71E0RVExkVEbRGXmYOF
         P7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MfR8SYEM/ayWj0nE/c9RrX4FncRoY/5nh8/YlYsAApI=;
        b=Woda7Im8Nt7gyLmxSxERK7FiRnF0whZanqm/zZ0mEzwT/qq1qRP7Gm1kN6fOa+GtWS
         ysKsGrEnVPElxaUpbO2WX7dnxQwL/eBhpyf/ZpvlvrnF6x651zA1W/bHHXReAFIIZHAG
         DbfkCcybhryrG6LTGmY0PMS/6eG4KRgF1mh/Igu790Mghsu4AVGLBXBC6evjtBl6TEtm
         4cMs63I6xi4x06Sdr+MZayLBu73vJ0zEV4dXNbX2qLRXMLBVqvo8ib6rdqpTmjxG4a1S
         ERzrQv1AlQwoV6cw4VOcOuHpGXGI3m1rHSfAMcc0sg/jU+sskfuKZaVsTPHpjKAhAhBS
         T5wg==
X-Gm-Message-State: ACrzQf3VNzCA2YpsXzLHLy7wS40lNbmnUNCxSIUjxCen0exXGcm5htLt
        qF3bjobS/nzpmU7fkpovKh4QZA==
X-Google-Smtp-Source: AMsMyM7bw9/pl8Sr1mZdB/6Rdq43+7EevxerAFVzSWA4w5MGue9LlS9E1cQUSZj4rKrT5gM0THJcxQ==
X-Received: by 2002:a05:6638:2488:b0:35a:17ac:8cd2 with SMTP id x8-20020a056638248800b0035a17ac8cd2mr8582586jat.175.1663604389522;
        Mon, 19 Sep 2022 09:19:49 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c7-20020a056638028700b003435c50f000sm5753622jaq.14.2022.09.19.09.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 09:19:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-block@vger.kernel.org
In-Reply-To: <20220919154931.4123002-1-sth@linux.ibm.com>
References: <20220919154931.4123002-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/1] s390/dasd fix oops
Message-Id: <166360438889.14661.10099967634123102461.b4-ty@kernel.dk>
Date:   Mon, 19 Sep 2022 10:19:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 19 Sep 2022 17:49:30 +0200, Stefan Haberland wrote:
> please apply the following patch that fixes an Oops in the DASD driver
> related to a race in a device structure update function.
> 
> Stefan Haberland (1):
>   s390/dasd: fix Oops in dasd_alias_get_start_dev due to missing
>     pavgroup
> 
> [...]

Applied, thanks!

[1/1] s390/dasd: fix Oops in dasd_alias_get_start_dev due to missing pavgroup
      commit: db7ba07108a48c0f95b74fabbfd5d63e924f992d

Best regards,
-- 
Jens Axboe


