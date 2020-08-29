Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D59256852
	for <lists+linux-block@lfdr.de>; Sat, 29 Aug 2020 16:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgH2ObT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 29 Aug 2020 10:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgH2ObS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Aug 2020 10:31:18 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CB5C061236
        for <linux-block@vger.kernel.org>; Sat, 29 Aug 2020 07:31:17 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p15so982807pli.6
        for <linux-block@vger.kernel.org>; Sat, 29 Aug 2020 07:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M09rICKtLX9U/C6405AyvuZ0YcBMtiIHaFy/ksBFu3A=;
        b=s+YAfbDwO759wZcJYcpdHuq2OZ8rfGxHTbyKjz2jzS4PD7D11mpWDM0HRP3HXu11Dv
         rX2e5dcV+ahgVkGYcAYXtPh1k0F++QY9ITxc9f+Ec+NPronbKnxMHSbbe8bauzK3muDy
         hQqyhYouN17Kjf2O27aKSCtuD5T1rz7HEVKPEmlHjbrZaoAzPwuB916H/x9NRX+zspQ2
         RtTK1kGNcV3VwP4qB/QQdIA1TrRCWIE0L56XQlfoj8GcBb+O5epQjSJP9R2QaEz+rTII
         tIER2NyXTnsD5eCenPvg2waiMtbsHGbmwLxZE02vQoyZkxZuABISAffEOSTYESND3JRi
         or3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M09rICKtLX9U/C6405AyvuZ0YcBMtiIHaFy/ksBFu3A=;
        b=Zn2VdqlDLwZ26EhhBvdU53lXiIolZ2l19Q97tVpp3qh3P3Xaa4Rqm1FPJUhN9D2lc3
         3ziMsrgj0SJSE+6VrS8Pze7BjQrS9YdDuTv8C/Qsloz+hMTu2e0n6Ty8yU5tdh7IyBwb
         42Zx1/iwRXvgD8V+H8a8Nu7blw73HiPaSVuOLPIjKH+0EtIPMGfFpJdsrVJIclSYgGKt
         34kqDA0RhF+ZD65Z1aIWffHaH1h+uUGYvWTjTRACDZHZUcNNZbbsM6obGtVcdREproHG
         98cVn1K9NXtVRCabC8Nl697BGq5KoEnHAB8ViR5ML5HwS1xIraZe3w5THn3vzsKag+oa
         JCHg==
X-Gm-Message-State: AOAM531YB0mV/HYFZHOxEAf5/3QlMYvwBiZGrKMAXtfRO19fsq5VrSx0
        xihCWMFeW2FUf1oF4aM5ueabKg==
X-Google-Smtp-Source: ABdhPJxei5ePN2ipdu0qfMiaKy5G/ecTdG6kq5CRAuJwVS338a7CQV+cEaAkbpQaOF0rRfuPjHfy5Q==
X-Received: by 2002:a17:90a:a50d:: with SMTP id a13mr3277702pjq.180.1598711475093;
        Sat, 29 Aug 2020 07:31:15 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s17sm2710673pgm.63.2020.08.29.07.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 07:31:14 -0700 (PDT)
Subject: Re: [PATCH] blk-wbt: Remove obsolete multiqueue I/O scheduling
 comment
To:     Danny Lin <danny@kdrag0n.dev>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200829091353.2923361-1-danny@kdrag0n.dev>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6b2923d9-5ac5-2ce7-b8c5-72c888ebc7af@kernel.dk>
Date:   Sat, 29 Aug 2020 08:31:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200829091353.2923361-1-danny@kdrag0n.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/29/20 3:13 AM, Danny Lin wrote:
> This comment was added before the multiqueue I/O scheduler framework
> was introduced; multiqueue has support for I/O scheduling now, so this
> obsolete comment can be removed.

Applied, thanks.

-- 
Jens Axboe

