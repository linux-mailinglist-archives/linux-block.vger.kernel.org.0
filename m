Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C49502A38
	for <lists+linux-block@lfdr.de>; Fri, 15 Apr 2022 14:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353664AbiDOMiW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 15 Apr 2022 08:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353690AbiDOMiJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 08:38:09 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A591A06F
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 05:34:25 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id r10so3346376pfh.13
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 05:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cQ6F19l4/uYVnO6D//9Bfxxz5m2KzVhnaSM18vdBJe8=;
        b=1F4+s6sjujb7jDcb3hnhuBMOTCTZhGSotTv/dc8Yjrt/Vec9m5nlnkflrH/fmLqlxo
         XOANiIY2fOQTa4ARGk6tGkmdpwcVqCU0S2WKp8aAGl2E9IVcsjYF0mAKYp2XWsK9Th9/
         hvcvJBaz2FeeHmqqZBkSySwaD2NbkQ95lvPoSpAzk1XImnG7NC3XF+5m7Kh8qVhmwbH0
         vtGGcpo3wyK5hUXd/py5rWuAazrhH+TTyfxGKWG9f7NUe9Nz3aKpqHTG/QAaukg3sbTv
         h+DNoHkTtoLqsaq8CICDRb4B4xUd0XBlF0u8oLMmZic8FNT200RZ/oiA/CIRzUZMyOyF
         dpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cQ6F19l4/uYVnO6D//9Bfxxz5m2KzVhnaSM18vdBJe8=;
        b=fiTUtifzNVvHVadpiZ7pt5ZQQJH/llmsATiqCjQ1WlTlv9OmGn8uia7JHo+3qHhnfO
         jObdNRVPA6R5CWx3qteHzl8jKD/FXXX2FqDitGvBCirtvLdGL/o0B+fGDJD3lrpZ+iy1
         z71A8XL9aRcJZ11wicxBAX230mW2XdQMqwij/KduzbUK5x3RgZ65K6XLXHIkGVbDoFw4
         LqH0z9al8lN6N9ScgnER5oJkQrb5TEqmeRVEE8uggLviSJ3GSmFp8De2NZnpBU6Y4Kyi
         WHYTLuj4Z1OQV6lIIM6tGCTKGjFLuQBkY5vRDQYC0m40ZUY1dBeebV8UJINrOJtmVGfu
         Mt/Q==
X-Gm-Message-State: AOAM531WNjsbkiW6oCUo5PFG4FHKPy5fpADJBrhd/rH2t6MmrqxTOZlz
        V0SsqLJMIL9060uPbtybD/Bi+w==
X-Google-Smtp-Source: ABdhPJzWeHJBfAtHkzC51sAv7hOn5FmqdHWT4uJJqAMo2+dMBRn3AalMPGLtf8wimOK8OQKsb2/fxw==
X-Received: by 2002:a05:6a00:14c1:b0:4fd:f3ba:e488 with SMTP id w1-20020a056a0014c100b004fdf3bae488mr8587179pfu.12.1650026065075;
        Fri, 15 Apr 2022 05:34:25 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id p17-20020a056a0026d100b00505ff62176asm2718353pfw.180.2022.04.15.05.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 05:34:24 -0700 (PDT)
Message-ID: <7b96fa16-00dd-bfec-9c81-56bd40bb2f24@kernel.dk>
Date:   Fri, 15 Apr 2022 06:34:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [GIT PULL] nvme fixes for Linux 5.18
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <Ylj8FUYefzczGF92@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Ylj8FUYefzczGF92@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/14/22 11:01 PM, Christoph Hellwig wrote:
> The following changes since commit 3e3876d322aef82416ecc496a4d4a587e0fdf7a3:
> 
>   block: null_blk: end timed out poll request (2022-04-14 10:16:33 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.18-2022-04-15

Pulled, thanks.

-- 
Jens Axboe

