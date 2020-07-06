Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169EE215920
	for <lists+linux-block@lfdr.de>; Mon,  6 Jul 2020 16:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgGFOH3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 6 Jul 2020 10:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbgGFOH3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jul 2020 10:07:29 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B31C061794
        for <linux-block@vger.kernel.org>; Mon,  6 Jul 2020 07:07:29 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id i18so32995944ilk.10
        for <linux-block@vger.kernel.org>; Mon, 06 Jul 2020 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tQkC3pRo3z9cYoQWMAWHI0hP0e1eFelun0vjEleR4qE=;
        b=FAYHwECfmiiIh+Xu5nKbJeTUVqVyPCP7hPP9gzjX9SXQLGaLpn6GDdDyTXGWh2hNhx
         3rlriw7iaJKiCzaWykvC+FYZQUAonVMDD/61MWixxsis4uBO/wQSeMNTxPfTz8lRuj/l
         GxcSHVYDCbeciFh4hqSnUEPT3Af7Qyso3BzzytiUpS+wF5CE5lrwkQKC1cl9DuluVRcf
         Bg0NkS88jOQyZNqhvLHTnvGsF5g9LvDQq+4B678M4pVz695BwhfvX5Ik8q47iTtJYUtS
         N9d8u4QGeoavy9Y6S7iAXp0mCtIj3C/VMmkbUjjEA9QkrOsOlrsYla3ayxqGsaXWpabz
         6azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tQkC3pRo3z9cYoQWMAWHI0hP0e1eFelun0vjEleR4qE=;
        b=DHjXhfFDs8T1V977mR5fsNr8gHOVfwj0g/zclj/YP4fhgPnpieKnPhUZPpNDYHVVZQ
         aIS/IC1vzS/bydtJ0F10KjC3GL5qO+bh2CsuMhiarX8W8uJaMKldtBL+4jGZzGueTzz0
         fAkgida3fm8V9JWBKO2bzG8GKoDNZ4UsGhtzXOOjENNlmrYCAxRm5yv8UzgWafs53IfP
         aIykgW3CMWHJ8und0ADTpCM6DSFbzft+2+094Q5SCvcFivHc4YxUDAVM/tF1S9ZXy0R7
         Aj/iENRLHvV8TOcePZHuHre4b3HEVMttK7GRvJdAxaxXLi9js1Wz56LKoCP5x9boUdHV
         udlQ==
X-Gm-Message-State: AOAM533Db08Mf93YnBCLNIErQ0yn3dqrmuOjaVBjFgo5mDSsMaS88gqX
        b7y4OwpHUYlzKWd75xZHLItVQnDwmz+vDg==
X-Google-Smtp-Source: ABdhPJxQtAPS3MkrZQLvMXjem6mo9d5zbASndnnrX6/oO0qnf0G65fFFt9xdr7NXZl3h3kMU0MaT5g==
X-Received: by 2002:a05:6e02:11a6:: with SMTP id 6mr13584094ilj.64.1594044448796;
        Mon, 06 Jul 2020 07:07:28 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d6sm9935177ioo.9.2020.07.06.07.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 07:07:28 -0700 (PDT)
Subject: Re: [PATCH] docs: block: update and fix tiny error for bfq
To:     Yufen Yu <yuyufen@huawei.com>, paolo.valente@linaro.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org
References: <20200703061323.959519-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1685fc96-190a-ebd4-eddb-399d04ac2fc0@kernel.dk>
Date:   Mon, 6 Jul 2020 08:07:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200703061323.959519-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/3/20 12:13 AM, Yufen Yu wrote:
> The max value of blkio.bfq.weight is 1000, rather than 10000.
> And 'weights' have been remove from /sys/block/XXX/queue/iosched.

Applied, thanks.

-- 
Jens Axboe

