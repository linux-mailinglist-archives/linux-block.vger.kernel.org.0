Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0811239094A
	for <lists+linux-block@lfdr.de>; Tue, 25 May 2021 20:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhEYSzr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 May 2021 14:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhEYSzr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 14:55:47 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ED8C061756
        for <linux-block@vger.kernel.org>; Tue, 25 May 2021 11:54:16 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id l15so17495058ilh.1
        for <linux-block@vger.kernel.org>; Tue, 25 May 2021 11:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dv2ynAk0e0j4ABap5LyrOWTO8mSQEIfMbBNW1vXhUIU=;
        b=fAu9RsPKECVBFIwMotcagPLUyEHuxfp5Y3dy/lk7L0LQtxFAbhu1Yq0KdwYPo3G0Qd
         I1o1HSGJY+c3ZAYJcehtkE1wTB5Yy0qf7D+OQWEpFvhH0NipTxfe88xvlOhsX62PRIN4
         RQsGmK+qrvo3gtRgBI1CUVQ1x0JX0GsRp2qrqIDcH72Ep7AU/yP2PUhYeuyyVa5MIPtl
         mfedRidkJz325Pd0FOOrhm3aJqKJi29XSVFVmAyJHlfmQu23FwNgNy2lwrW5ockRLgoc
         72hmfBe9I+vZXebzqw441gILdQmwd1nzct22jfEyTnXM7qRc4JQF5NwVTiOHMkAdPEDN
         Qy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dv2ynAk0e0j4ABap5LyrOWTO8mSQEIfMbBNW1vXhUIU=;
        b=DlhKKqCoabT6DcYo1Jty5DghrCydEDvU+rLWM3GUg+mwwYg2GF9UCcy4K304Slr10y
         m2O+nlEmcVLxZnGOdYUgojXTwPyY/JQmTpcKr5k044OX9T2Iof5KsAGGE+lAPSmcnbbN
         7CVCUFE/tcCD5+YFuYFjNXYODNg4umNYL596dI/dI77dGbhlQED4FnT21KtzzYUxXwKz
         y1lv2FdTXXk0xR0JXHE1VKxtsyzwRcUcYP1tyoLpiS/UAQD/9q48gAvvJkWj8vim8L6r
         4GBYNX5u7iA1NLjDiuUsqUQmtuNsWUXAlqVJaGhghdRbSf9gj7oIB7XNY5hkiRRT0jME
         X0og==
X-Gm-Message-State: AOAM532h4PHFQBDVpsG3DibFWW4ecpIGvCiDA6dpbQYs9ILcjkEh2r70
        PlWOoTuhhnai93Zy7m/JCm9m5wSvTKPFzDRA
X-Google-Smtp-Source: ABdhPJxMIsiRpGZNoEoY8UBeLDfP1Nr4kSAwOLtXiavBUWZwL3TfAJzcMmGFOZQf9QcORnK25HV0QQ==
X-Received: by 2002:a05:6e02:587:: with SMTP id c7mr22716661ils.24.1621968855390;
        Tue, 25 May 2021 11:54:15 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a19sm13852802ila.31.2021.05.25.11.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 11:54:14 -0700 (PDT)
Subject: Re: [PATCH 0/1] s390/dasd: fix kernel panic due to missing discipline
 function
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20210525125006.157531-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a2b5d28e-bf85-bafe-65d4-bba0c92a5382@kernel.dk>
Date:   Tue, 25 May 2021 12:54:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210525125006.157531-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/25/21 6:50 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please apply the following patch that fixes a kernel panic in the DASD
> device driver.
> 
> Stefan Haberland (1):
>   s390/dasd: add missing discipline function
> 
>  drivers/s390/block/dasd_diag.c | 8 +++++++-
>  drivers/s390/block/dasd_fba.c  | 8 +++++++-
>  drivers/s390/block/dasd_int.h  | 1 -
>  3 files changed, 14 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Jens Axboe

