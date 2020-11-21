Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4072BBB34
	for <lists+linux-block@lfdr.de>; Sat, 21 Nov 2020 01:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgKUAo6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 20 Nov 2020 19:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgKUAo5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 19:44:57 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AECC0613CF;
        Fri, 20 Nov 2020 16:44:57 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 131so9490947pfb.9;
        Fri, 20 Nov 2020 16:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVWaEjiAABmn8Op7XeKTH0w0SCBMzhmRO4CwIavZ0vQ=;
        b=QEn2Qk8e37g6bWbDv84erxY2JdaZrhiRuDHOVS5aqyJRXow3Av858rEsPET2EbiD8R
         EEYBn8I6z0S0D4O1RiJ9howSuhYdLw1Zhf74uBKBONn9nJwOpyKwm7t4jrd5pfXRPhH0
         EQFfbJVHD0k1v2fJLZW37AT4bEmDp0pNpJQohsaPCARzw7Ybl13DBeu95MBTolYd00vP
         V22V6RIOS7lKmvJwjK5HJFuZ9o/nRCJe7MRFLzsTLrv5G7FsV0U8rnprXWpwwqWUvNdi
         OYp9CCvE4VJQ/g2nlS28kDTCYK2pJnSdV+8PESlDJf8MEHwAQfgAHNys9nxfitohfNAk
         lp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVWaEjiAABmn8Op7XeKTH0w0SCBMzhmRO4CwIavZ0vQ=;
        b=dTAtmZ6L5MYHKNiJvmKnMBwIcnY7zAqGShjo1im9nOTOvhRkkKWnSBtZzYH1lekrUx
         pfiTyN+lZuAj5xfD4e58vkE85YrTP2jk3jVlZG4MvFST9bQOW7bwDRZXQBaiobHjgwVr
         juRpPYjPKddw+aHxRBbKT+vIJrEa6SNqoSxWYvr54rgT6PKaVvLoJFEhlOcG/+plucRR
         cJVsN9QMBp5hTr3KDl9MzoxhauFcDxsMJn2NGY6Mr5S2E7HnbOIN26kTOTs7jCLYsdkp
         KMd8pPIk0kU3DdMk7Qx1VpbB/wGf/MjUO9Sy084jwIOYeVdedgvpVGk/88q2Y9xY7x7h
         73lg==
X-Gm-Message-State: AOAM5300yHjPMD+3tiL+hnxmtQmCOupqQ0Qv5MqonpeTFZAlt2te1aG7
        rQxNn0vQ6bCsvTaaGOC5pLMVo/dItNDd4k+AFw==
X-Google-Smtp-Source: ABdhPJykt8fOkmF3zSfvYrEnE3qKUFPKtik4Eb3P/eAy6MXQktDq9ESFTC98mnrpXFRqGnRWsyfBWWppyuu5N38wNpM=
X-Received: by 2002:a63:d44c:: with SMTP id i12mr18560737pgj.92.1605919497178;
 Fri, 20 Nov 2020 16:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20201115101514.954-1-rsalvaterra@gmail.com> <20201119222610.GD3113267@google.com>
 <CALjTZvbK6_UqDQFhMxdEQAR-FbsZKrztkEFronvoFpLUWsi_gw@mail.gmail.com> <20201120214013.GD3377168@google.com>
In-Reply-To: <20201120214013.GD3377168@google.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Sat, 21 Nov 2020 00:44:46 +0000
Message-ID: <CALjTZvafTn4Mv5cp=QpGnmSkn=p++Chy+VeBKCOWuM5rUTXFJQ@mail.gmail.com>
Subject: Re: [PATCH v5] zram: break the strict dependency from lzo
To:     Minchan Kim <minchan@kernel.org>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Minchan,

On Fri, 20 Nov 2020 at 21:40, Minchan Kim <minchan@kernel.org> wrote:
>
> Do I miss your point?

Well, it's quite possible I mis{read,applied} your patch. It's late
here, I'll test it with fresher brains tomorrow to see if it's
functionally equivalent.

Thanks,
Rui
