Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232DA2CF21C
	for <lists+linux-block@lfdr.de>; Fri,  4 Dec 2020 17:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbgLDQmv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 4 Dec 2020 11:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730821AbgLDQmv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Dec 2020 11:42:51 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B898EC061A4F
        for <linux-block@vger.kernel.org>; Fri,  4 Dec 2020 08:42:10 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id z10so5767850ilu.3
        for <linux-block@vger.kernel.org>; Fri, 04 Dec 2020 08:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fikGB5tiwbaXtQtRZDejlU5o/PV+EqzyE1dSj5rzFBI=;
        b=bHiFuCI22AZUnNQBHXT6REoQEzckuQnfklBROQQuCQtPbr+ryyHI3/pLtt8VoCk+ps
         ONudM1PD8q/KEEZEAjy61xxHR9GuhlgiAzjsU/lD9M+TL1zbBzJEx7YJqWgYtjdmS14I
         xtGYUaM8Rh2C5gkaCUW2tP+MGsW04Ot92aC5zICkV6oozDh5teeY5ZkC+x7K+D/BANVj
         3uzhgRSyfXDxJjYoMw2QZCISqhM9oCYzAhLiucg+EMULUrI4Cq9I5wKbhc5LQEfh7X/H
         0mUYOtWhEgNuc8rfdXggbUAfYFrdg5xl3F9NN3vTQEkrBY3OpI/Zy102mmDdV2eJXkmw
         Wl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fikGB5tiwbaXtQtRZDejlU5o/PV+EqzyE1dSj5rzFBI=;
        b=ZTyxzjrrq/Sjd71MLqobpdae4ybzlhWWqznbmMdkvXJK3SuS9pC2DLFvPsvPgTwGaM
         a2RGo3lz3ENDU7rrKcO9DLP3Eljfbj5aUuurd2KC8VyvSaDOeyhcHdITDCVQd7PLFppC
         5MiNd9GRxLNodIYhC9xT/nvvt3D/qkDmoRpKGaNOkNehDQechZTldjFGngoRoafsakRY
         uPB4rvRPcMUHQeq+T6aDb8JK4leqXTdyVwzq1fmcUiROa+C3hGxoT2yrZIpEeBdI8HhU
         daabWh1gfnQBn73ARNsuAoF/mrKO07I++7PJGm+taAinig9I5Cxl8XWzqs50b9PgxZB2
         VJGQ==
X-Gm-Message-State: AOAM532rJ6Gv/c64liyED+ZDmSYRK2ognpPMgdJVe2L3ABcPuCS5o9p1
        /k3x7jK8bvHgo7E+etUEZRJauGhCHfrHdw==
X-Google-Smtp-Source: ABdhPJyW5yIk7VMQwzcjfu979UjnKKVuVKC1F7TQhIJYUX++QDtGzNaJxMSREo0fly/SWSE8ENM4PA==
X-Received: by 2002:a92:204:: with SMTP id 4mr5121778ilc.79.1607100129990;
        Fri, 04 Dec 2020 08:42:09 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u16sm1849585ilj.6.2020.12.04.08.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 08:42:09 -0800 (PST)
Subject: Re: block tracepoint cleanups v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20201203162139.2110977-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8859c43f-a1fa-60dc-ea27-4a126f95dc68@kernel.dk>
Date:   Fri, 4 Dec 2020 09:42:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203162139.2110977-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/20 9:21 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up the block layer tracepoints by removing unused
> tracepoints or tracepoint arguments and consolidating the implementation
> of various bio based tracepoints.

Applied, thanks.

-- 
Jens Axboe

