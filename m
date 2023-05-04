Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387246F7190
	for <lists+linux-block@lfdr.de>; Thu,  4 May 2023 19:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjEDRvu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 4 May 2023 13:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjEDRvt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2023 13:51:49 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEEA19B0
        for <linux-block@vger.kernel.org>; Thu,  4 May 2023 10:51:48 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-769a4e76f30so5150439f.1
        for <linux-block@vger.kernel.org>; Thu, 04 May 2023 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683222707; x=1685814707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmsEyvQWQLhz8Wo2w2vPqihJ7gBJNKHrPhp6n9tMN2E=;
        b=twe8mnAMI1n1ZENXvEQiP/IWTAqjuK9bihn8ytCraFymd2ek0d/gXO7PK92qlGXZJy
         K7Q0TjoPjJHO6ynWmw8JqDe1SDr7pwdV5FZgK4E9Vx6r0ad8uWNRoPU4WrHpBDvxP1ev
         cDhVRBXHZDfxtDyrtiIHlNXfxa2baPuYjTWcQ/ENtccBcuzW0Oq+jSwWU/iyQLqrzwaR
         2ZsZVKzFnAPiGkOpmvbCjnEOR8RtEAmSoQDGMSrDQgfB+c6kUXF9+Ce3s/Vw1ovmj9Lt
         CGcKP+fnizUQN1OZFqyz3MwwGGCe72Pwm8tm57h8HK20EMkUefQBHiXyZLIqEabhpBnZ
         qaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683222707; x=1685814707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmsEyvQWQLhz8Wo2w2vPqihJ7gBJNKHrPhp6n9tMN2E=;
        b=AnFZSKb1q7YTXLmOdb2U6TDsMRahNA3qFKIcwf26yEN081MFweZrESTvpI7xF/6V7T
         NWWWHsbBOtfwt2DpZEy9ONQMeFIznJL81oM9x9sgsTqR0+zoZ2ntk02T6gUaYw0TcNLj
         wunvZLfEXAojEq4FP5Qx/uXa4LR45zF+QnuGBmFnQrePhzyhV4m6QOK9a7vW6am7WL1S
         7YP2yfRVfXKzTElvby01KUEdgsNF6OzQwFn/yhoaDtM/kquIjjcxVnRpr7V+wATOD6iO
         2LJQYh4VPl0kUecx5fFqOjcl/UK9dxBJbk7vg6819j4ZORrgqKA8XhBcNPQbELMELsPx
         dX/w==
X-Gm-Message-State: AC+VfDxcUXS+5X+E7sLXUJc8hYdSihKgFCnh3VtwMLHXUeC9LQtia02F
        ZGbsq5S4W/+FnpZOdWLn5A+ogA==
X-Google-Smtp-Source: ACHHUZ7A56eBv7M/lXClJyQTCjp11K7TI6GQUUHhOUm5qb0Uiv+T2alaqH2egBBXju3lGMhMD2yWBw==
X-Received: by 2002:a6b:4115:0:b0:769:8d14:7d15 with SMTP id n21-20020a6b4115000000b007698d147d15mr4982579ioa.0.1683222707633;
        Thu, 04 May 2023 10:51:47 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x20-20020a6bda14000000b007635e44126bsm9822062iob.53.2023.05.04.10.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 10:51:47 -0700 (PDT)
Message-ID: <0a50fae3-1cf4-475e-48ae-25f41967842f@kernel.dk>
Date:   Thu, 4 May 2023 11:51:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 0/3] io_uring: Pass the whole sqe to commands
Content-Language: en-US
To:     Breno Leitao <leitao@debian.org>, io-uring@vger.kernel.org,
        linux-nvme@lists.infradead.org, asml.silence@gmail.com, hch@lst.de,
        ming.lei@redhat.com
Cc:     leit@fb.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, sagi@grimberg.me, joshi.k@samsung.com,
        kbusch@kernel.org
References: <20230504121856.904491-1-leitao@debian.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230504121856.904491-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/4/23 6:18 AM, Breno Leitao wrote:
> These three patches prepare for the sock support in the io_uring cmd, as
> described in the following RFC:
> 
> Link: https://lore.kernel.org/lkml/20230406144330.1932798-1-leitao@debian.org/
> 
> Since the support linked above depends on other refactors, such as the sock
> ioctl() sock refactor, I would like to start integrating patches that have
> consensus and can bring value right now.  This will also reduce the
> patchset size later.
> 
> Regarding to these three patches, they are simple changes that turn
> io_uring cmd subsystem more flexible (by passing the whole SQE to the
> command), and cleaning up an unnecessary compile check.
> 
> These patches were tested by creating a file system and mounting an NVME disk
> using ubdsrv/ublkb0.

Thanks Breno, applied!

-- 
Jens Axboe


