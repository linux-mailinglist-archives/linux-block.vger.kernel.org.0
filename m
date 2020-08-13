Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CAE243C02
	for <lists+linux-block@lfdr.de>; Thu, 13 Aug 2020 16:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgHMO4f (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 13 Aug 2020 10:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgHMO4e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Aug 2020 10:56:34 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B62C061383
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2020 07:56:34 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j8so7552632ioe.9
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2020 07:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2N3vz3aoKozJuLd8HhRVAVV0+DlbtHXg7rxrCEwGelY=;
        b=2Av2azx9MhIvUoXaAZXBnYYlP5YN9u45JAgTOqjgnW9MJlQOpjRtOVGtv6zITH6N20
         34yQMx+43blJDN9CwZEFY2EGFBSsba0p7OCFNYfgpJSDFcynpdO0ziqX1zJsENMYMkzE
         /YFiX8ORzlZ5qq/qP0TrVKNgjawRTN2sOsyMErmwsJ1hspoYM3E2/JB38VF7rRMBQALL
         RK2riwofKiC7kxl4YkPouojYjjgcZLoi3D7TOPvCuSvY39rCq/W9EkN5PFt1Aul+2Z2O
         Su1r9y0eBcGqgPhekBoedLpDnYcwNO121jDyo36iJnos86vrInbGyoO/LfAa6EhlqzMT
         G/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2N3vz3aoKozJuLd8HhRVAVV0+DlbtHXg7rxrCEwGelY=;
        b=bofJtBuNfnv6XIVeNrTJ4xavdgDsAz8dBDO8apDvfncTJ+zbTeYKOz57wEzvTXgLFV
         m6rKe4ZLa5WpYEcfb1C21iX9Kg6NFMoj0lwgow7SlSZCbSeJutCmPoT0dHoYy6uul/mM
         qXYxVhDy1n4cIMC3gydtdLpFZm7xsM2KIBAzZu/xL6t4hKrhs5Fwn89Pk+Eppk3akh9u
         WUmiw9KjFZ6OACae50NnxCbG0Ce3ncf7lcnznn0m8yvhKh+AtFyLoo2coYZCM1mQfWt7
         behQpTQIZusNsyaPexzv9wtCZ4fGcvUhCJK27DPs0zy0L2ky8dccSBrRHvYwNXQ8mxpP
         Qi6Q==
X-Gm-Message-State: AOAM531Dj2WEcnlxTH1mM+oGhIYC6Ujwq5pTdCJDfEnOR3vg42fSZTCG
        IAUx4JXwOsbwvDO+RlDvP+S/Bg==
X-Google-Smtp-Source: ABdhPJw2yxzFwbHDrUKj9GjW5VjBSwwvqRtbrnuWKdCOX0w5kMRjsicXpo2Tt4m8J+or3X1H7vOCdQ==
X-Received: by 2002:a02:6d5d:: with SMTP id e29mr5296096jaf.139.1597330591852;
        Thu, 13 Aug 2020 07:56:31 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l2sm2892965ilt.2.2020.08.13.07.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 07:56:31 -0700 (PDT)
Subject: Re: [PATCH] fs/io_uring.c: Fix uninitialized variable is referenced
 in io_submit_sqe
To:     Liu Yong <pkfxxxing@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200813065644.GA91891@ubuntu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9fd08f8f-8c89-9c59-6d9e-5933ccc65967@kernel.dk>
Date:   Thu, 13 Aug 2020 08:56:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813065644.GA91891@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/13/20 12:56 AM, Liu Yong wrote:
> the commit <a4d61e66ee4a> ("<io_uring: prevent re-read of sqe->opcode>") 
> caused another vulnerability. After io_get_req(), the sqe_submit struct 
> in req is not initialized, but the following code defaults that 
> req->submit.opcode is available.

Thanks, I'll add this for 5.4-stable, it doesn't affect any kernels newer
than that.

-- 
Jens Axboe

