Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FCE1D4F94
	for <lists+linux-block@lfdr.de>; Fri, 15 May 2020 15:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgEONxD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 15 May 2020 09:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgEONxC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 09:53:02 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAE6C061A0C
        for <linux-block@vger.kernel.org>; Fri, 15 May 2020 06:53:02 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y25so981217pfn.5
        for <linux-block@vger.kernel.org>; Fri, 15 May 2020 06:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KLHDMMAfcXZ/sKsrs2509XkriszmE5YcTBkAUiw9NP0=;
        b=qW8u9dwLX6Pw5v4y6WxHDJ6iEH9Y1g0kvElJUII+0IqDiBUpd5WnaxwRtnd6+sV1Iq
         pMEzmb6dZr2tqxZwoX194wLFsO31RV+8UXj72w6QxPiFxsg21ScITE2skoazff5xzG1l
         KI8eza5f1jYi1+XK98blCugSTl03hvxkCsQDGv1rqOk1A/zseVeXIRuNBN2QVDFs2Jn6
         UEekGgx1LU1JBcu2cXQ76UwVsKOdbyDK7iQnjGbgFpNJRGpaMStxRwyUEoCZZnmo/mMJ
         5w2tzpqOwpVadOE0z8BPv9PR7E2iAXRATTgE6haWbSp52yajsh4BB0A81ytnihrdxpKR
         eQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KLHDMMAfcXZ/sKsrs2509XkriszmE5YcTBkAUiw9NP0=;
        b=Tr988vKJYHkkXSBTey3dbR7FgEqZoZXVOPH1fjgc4RRBjky5QFF06XuFQeLVfdgMG2
         XhN/iPlGa4+5lsg5keAJdnRM8kLJO8ZAH/3jBWjfgo0ptBZIQH0C4RB9Dylmp6jn6i9d
         4cBxHSuC6OtGLjjP//Ui7L2FSAhsbs2FNNCWPzaTNzcSy0xGX06OFCu9mz8ILaj3BIiN
         AXewXs39S4OhXXxrk41gM70dNtF5aw2OK67OXsLNmieaW/OOQYQwpVSgNs+TRTdbswyq
         eoh9wwirzhbS1BObUtv34YZI5tzUXMrJRZK/a7WowZ77ibsKtNCvNF/+o1Vq4v4004PR
         vapA==
X-Gm-Message-State: AOAM531ZfnX2aFN+KMo+lsRADyUzpX3X/7C4qGUpIE7d9vSFdhNWXO2i
        9eONE4Vy77amGLyQ4ZivO/pXdw==
X-Google-Smtp-Source: ABdhPJxgv7XbaHg/4AQxteRaeeW3ROhmjMu7FDQUH73FPz430Br2KwdmCoDucndGudp8IY6VCFIgDA==
X-Received: by 2002:a63:5a5d:: with SMTP id k29mr3266957pgm.176.1589550782324;
        Fri, 15 May 2020 06:53:02 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21d6::1089? ([2620:10d:c090:400::5:7df0])
        by smtp.gmail.com with ESMTPSA id u45sm1739435pjb.7.2020.05.15.06.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 06:53:01 -0700 (PDT)
Subject: Re: [PATCH v15 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>
References: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
 <CAHg0HuyYO913MmHt7qi12T6mVXo9nabUs6GJyqRAGfWAdfPjCQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e04fc798-ee25-53a5-fae0-5985306b55fd@kernel.dk>
Date:   Fri, 15 May 2020 07:53:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHg0HuyYO913MmHt7qi12T6mVXo9nabUs6GJyqRAGfWAdfPjCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/15/20 4:29 AM, Danil Kipnis wrote:
> Hi Jens,
> 
> we've fixed the kbuild cross-compile problem identified for our
> patches for 5.7-rc4. The block part has been reviewed by Bart van
> Assche (thanks a lot Bart), we also replaced idr by xarray there as
> Jason suggested. You planned to queue us
> for 5.7: https://www.spinics.net/lists/linux-rdma/msg88472.html. Could
> you please give Jason an OK to take this through the rdma tree, see
> https://www.spinics.net/lists/linux-rdma/msg91400.html?

My main worry isn't the current state of it, it's more how it's going
to be handled going forward. If you're definitely going to maintain
the upstream code in a suitable fashion, and not maintain an on-the-side
version that you push to clients, then I'm fine with it going upstream
and you can add my acked-by to the block part of the series.

But maintaining the upstream version as the canonical version is key
here.

-- 
Jens Axboe

