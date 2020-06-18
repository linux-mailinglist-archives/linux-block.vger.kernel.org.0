Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FAC1FF669
	for <lists+linux-block@lfdr.de>; Thu, 18 Jun 2020 17:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgFRPSJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Jun 2020 11:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgFRPSI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 11:18:08 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B22FC06174E
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 08:18:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n2so2544302pld.13
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HOJP6wvSVr5cP9VUVwOJUZjUCeQr91p+ALeEGFJ2Uuw=;
        b=VkMZVqIDULx69/93VDiJvXALKl0x3dVQtv37s5iXSF6yNDNjNUIn4+4PtBNPJ/ikcf
         FT38ZuddsBMnhkap/oVa5EkEPFinpzx/l2X9gqKrwYajrdJ5sW02G0AgHf+IITm4vZnw
         DCVSLojf/JtW/ufz87GQzKXE6CPXgDfOive7XR0sK9ViVC8i5AEEnMBjR1lFlTGsZWrC
         /DRnUnD1Ist3h8/1NuVShKfAZ9Cr3CtCSMAX5WHLPPzd+hTCn5mrgjWq5LhGqKctmSEf
         an3BqXabsLwf+lqrRB4HI3G0iPNMuMYDUNMV6TNnhJNyPpelqL4PeAkTcsyCtZhBrpcz
         8ncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HOJP6wvSVr5cP9VUVwOJUZjUCeQr91p+ALeEGFJ2Uuw=;
        b=enK33ila5wV4CRk6u5Gqe25jAt9KgZvkh+/TmvGta3wL2Ak2cc3XZT2rJ1cPiN/w7a
         TsjYwB7Lq3vNqB1aNVbSt4c/J6MvAvfXnLUAX6V7TYPUwxD9UrEkxFgRZSIHe4farbia
         k9G/Kt1UpqdWEQxZQtYo8LD1iAjjaM1gwlcVkEjaUE8odgajTpT0p2MHf1iLm6BrJdeV
         BX5jxMkmIs6JKdnQLvYauwhglvn1/KDlCSlc5XBF4sA5qmnyFD/l6D7OECXePfBZdMJd
         fgMG4zl6cEOE2DEUli79u/u/gHNL7LzbIwIZhjcX1ruazBg04QMYjm6iqkDC8MuZ6AQk
         3BUQ==
X-Gm-Message-State: AOAM531/pvkDehnKvMmRrtHQz1Loph7tFFr8Zo1YoapXwGLzNk8UbIOm
        pIRJ85BiUBgElvPyTc3xR0tMvoLhnnRO9Q==
X-Google-Smtp-Source: ABdhPJyKbE/hcxHeJAWi5OdQxlewCp0j5xpxQTHssL82cdNWLNgZqVKuqg9p269GbY95oxRbhPOrGg==
X-Received: by 2002:a17:90b:e89:: with SMTP id fv9mr4714013pjb.131.1592493486640;
        Thu, 18 Jun 2020 08:18:06 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id nl11sm7157204pjb.0.2020.06.18.08.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:18:06 -0700 (PDT)
Subject: Re: [PATCH v1] partitions/ldm: Replace uuid_copy() with import_uuid()
 where it makes sense
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        linux-block@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
References: <20200422130317.38683-1-andriy.shevchenko@linux.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <05fd74af-453a-b751-b27b-109e0eba377f@kernel.dk>
Date:   Thu, 18 Jun 2020 09:18:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200422130317.38683-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/20 7:03 AM, Andy Shevchenko wrote:
> There is a specific API to treat raw data as UUID, i.e. import_uuid().
> Use it instead of uuid_copy() with explicit casting.

Applied, thanks.

-- 
Jens Axboe

