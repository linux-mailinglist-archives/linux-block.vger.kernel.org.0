Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3226318B9CE
	for <lists+linux-block@lfdr.de>; Thu, 19 Mar 2020 15:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgCSOzf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 Mar 2020 10:55:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43460 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgCSOze (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Mar 2020 10:55:34 -0400
Received: by mail-io1-f66.google.com with SMTP id n21so2507450ioo.10
        for <linux-block@vger.kernel.org>; Thu, 19 Mar 2020 07:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C4+olscRmDkJUGGrKZilEsCLLFWydM2Fth0GPit+sPo=;
        b=EGZIBubHHk8d4a4F2EFuhXDJ/3/kxTbYtwhsoIVT9DEkvcYU5yPx2yHMMRAneZyym8
         llxAJv/otFMZd2sV257rwYflgbrh108TwHHsqTZsNNNAuoexY+l8HHZrU5RxBP08+ra5
         eTzD8V6EUzNhGCflmOPej6PZQNQJvOhldq7o7vEDjbbHvfTVUi/gLEC7fE9o2xq8Fucl
         ilycZqAADxijBJ/DdCE6pq6EOBrBuGrHB2NUGTFVzkW/tHPw80ZAXCpDo3T8Hi7GEWWP
         9ybEhpJUGTLSNb3aveIvousWYnq4TJs5UA38qox9cbnOJ/uEXKDOgWkJ+iLAJu2R3CY1
         yaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C4+olscRmDkJUGGrKZilEsCLLFWydM2Fth0GPit+sPo=;
        b=a9JbHDXNrGSY3MOY4ajIzsm9gKtGk3udf9mgFp8MwymQ4OmDjPjF89szPiGFeWY3VL
         qx3EVqrYtuIglfHm6LfHlmqtbf6xzwJ/tBCaOKoQBFjk7S86XklsYB73KH6y+TWwFe4A
         nxDOMMoXFSzHNy0X0ixui4kGSQN+V7CyGeh/EINmBWlPTCQIeFVduSlbru4K1lif8TPV
         IkP0u6n0z6TFhubGTwo8bONl+AN6ntvAMfFMiAB9QEembNUuecOK2/IE5UfoWwMJb38b
         wnakENLkGEM2ytxvrxcGg5okiDk3LQT45m9RRbzIy8+bPj1935cAmVyWjiVaZN60SnGt
         BvAw==
X-Gm-Message-State: ANhLgQ2bl1UQViK4NBYYDn1lpd2LsZRY1h1hlcyvcWAH04f9+du0cp11
        p2dHXDY+49pOtE04Ms8OKAJx3wuDUpeJeQ==
X-Google-Smtp-Source: ADFU+vsQeduYgUa5hb7MMXlj7yglSJhOT0mtW+hAnGdqEV0gOlRd4Jj5P7VO6TchZcsfrJvzMr3nBg==
X-Received: by 2002:a02:7:: with SMTP id 7mr3649460jaa.130.1584629732028;
        Thu, 19 Mar 2020 07:55:32 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p14sm825223ios.38.2020.03.19.07.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 07:55:31 -0700 (PDT)
Subject: Re: [PATCH liburing 0/2] spec: RPM spec file changes for liburing-0.5
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20200319132658.8552-1-stefanha@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fce4f581-cef2-5eed-9833-f9865d84039c@kernel.dk>
Date:   Thu, 19 Mar 2020 08:55:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200319132658.8552-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/19/20 7:26 AM, Stefan Hajnoczi wrote:
> These patches fix issues with the liburing-0.5 RPM spec file.  I encountered
> them when packaging it for Fedora.
> 
> Stefan Hajnoczi (2):
>   spec: use "or" instead of "/" in License line
>   spec: add ./configure --libdevdir= for development package files
> 
>  liburing.spec | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied.

BTW, we have io-uring@vger.kernel.org, that's probably a better list to use
going forward.

-- 
Jens Axboe

