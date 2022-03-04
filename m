Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1564CDFD7
	for <lists+linux-block@lfdr.de>; Fri,  4 Mar 2022 22:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiCDVkY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 4 Mar 2022 16:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiCDVkX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Mar 2022 16:40:23 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBC01FED91
        for <linux-block@vger.kernel.org>; Fri,  4 Mar 2022 13:39:34 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so9087409pjl.4
        for <linux-block@vger.kernel.org>; Fri, 04 Mar 2022 13:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=78QaTqsXQXyIFIsYWFuWJ7jcVfFlJEtOtOpOvJoppYs=;
        b=a7FNAUjjMbbGCm4dC1Q5J2bz06IwLxMtzNX7kzAQqIX8sEKm9wPLNdLTwG6XGb60SS
         2HcOX9e3xLs3SiIhWHebUZFXgQz3KNoIWb+MqDnzfA0GFedV3eS90W9pkEQKcE3XBlya
         cN4OdakOc2B39quXNB36PUQXeyt1qGn4nB8qfoXZKbOP0TQpZBFIc4yudlEPFiWoG3+W
         hJkdUE7E6FWGuH1+cxZFbQd1LquoIJnMX+tiWUfXo4fmOhASl5vfHHPzyscFnZIrXOCG
         uzMf71yZC9XZyHGP+qd3tumvrM0yLEoaOxYc3wS719scc3aFxgm8os2KSDLVHCMFE3vt
         TzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=78QaTqsXQXyIFIsYWFuWJ7jcVfFlJEtOtOpOvJoppYs=;
        b=s7gmpqRs99ybsYo+eo+sJqNXBZqrw86+aLIxbF8vbSzwftHqmzW/ZWJB/z+muwRZdI
         RCgeio4qCmeCCCW9FAEgMq8uwPz/0gbHMb0qJonodJiVI/cx/RzjP6nz4vw0m2ZJk+XM
         SGZ3cXQnD9IeRN8dffUH2ji+QCLYRO+rieggo0mhccN/w7H6Kci7nLXAcen6mdeWt7aE
         00D3wINngXKKHeV7orW0iCNwmCBANLUqr6M4SJBqlEaKAsC+L1ir8ItZYVC/J3LEWgUH
         nsxEuZ0+XO5w0DuqgVNFTEgz2UK57WZW3u3hy82Ci8TJshNcZwxO9h6umJ3T2fCjIasV
         8wEw==
X-Gm-Message-State: AOAM531BYgOHJvs4qoh13bnoC/g8duiQ6avk+xo7MFGFZf3RYTssJ+O0
        KByZU71g8guVZMWNYiWCXthSpZN91uYlng==
X-Google-Smtp-Source: ABdhPJxi2cea2xLDIbaQRIK6mLwzI2z+go/DuAdqGmvmKUYauL5++FshM20u6QIIyFCDunuYkFyc9w==
X-Received: by 2002:a17:902:70c8:b0:151:a8ec:5890 with SMTP id l8-20020a17090270c800b00151a8ec5890mr398551plt.55.1646429974178;
        Fri, 04 Mar 2022 13:39:34 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u7-20020a056a00158700b004f6ae198a56sm4088567pfk.9.2022.03.04.13.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 13:39:33 -0800 (PST)
Message-ID: <9d5d4f0d-7028-0505-7463-ec740967b8e2@kernel.dk>
Date:   Fri, 4 Mar 2022 14:39:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 5.17-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a small UAF fix for blktrace, please pull!


The following changes since commit b2750f14007f0e1b36caf51058c161d2c93e63b6:

  Merge tag 'nvme-5.17-2022-02-24' of git://git.infradead.org/nvme into block-5.17 (2022-02-24 07:02:15 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.17-2022-03-04

for you to fetch changes up to 30939293262eb433c960c4532a0d59c4073b2b84:

  blktrace: fix use after free for struct blk_trace (2022-02-28 06:36:33 -0700)

----------------------------------------------------------------
block-5.17-2022-03-04

----------------------------------------------------------------
Yu Kuai (1):
      blktrace: fix use after free for struct blk_trace

 kernel/trace/blktrace.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

-- 
Jens Axboe

