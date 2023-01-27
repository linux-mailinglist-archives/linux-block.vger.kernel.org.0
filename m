Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F181567E9F7
	for <lists+linux-block@lfdr.de>; Fri, 27 Jan 2023 16:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjA0Psq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 27 Jan 2023 10:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjA0Psn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2023 10:48:43 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874B5CDCC
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 07:48:41 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id u8so2423762ilq.13
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 07:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IjuVPcGEJ54g0Xkgb8ZpMrWHDKfvpP3sUxNeuowuKvw=;
        b=10utZi3a/2Q4Mv5BFJ5kHZb4VOpjNlP9ZmCCC2L3/6+EYJyzuOKjIYnF6r+D8HikKG
         pGvNPEbM+ABzDtQi/ssxOtQt+GWl2PygmwSWwvK29wDcSJSS7+Zhvk8rKU9S2fC9TSPs
         3g499ibd3prLgiF1uvtM34Fnkc0/XWpwijxQSDlJvBM8kmrQ8fGRBY3yn8y+6rywvaQq
         jSPHEkAzfuncwqHrkHG2fs7MgJlqS/HLF7ZWpO0L1XuiT6MSyCaUdRtTgdIysODcGF7B
         KjTgE2EBWfK8HZtWLD2d/nLa4NmCK3ISov2ObjnzzvOAPVeVI+wQAg+fhR5nAidmd2Bb
         2/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjuVPcGEJ54g0Xkgb8ZpMrWHDKfvpP3sUxNeuowuKvw=;
        b=KND/c/Xy29pZDb59KvmvxJVP5SOfsoJ9nz8Tdg9kieCNK6xcvB0lozO72uRnNUyspw
         gaJzsFRcVC/LSpL+BTTUHvPI0Lby9zipX045glBmqVDlKLTsuF7cdkoZOQrFZAbxtxbh
         5mrxu+T6r0gsLfOnfo5NVGyUDR78h3W/Y8Fzvco0LstMtHaF5wfS7p3Cqx/+chnISLLi
         6+kAWDYGvT4nqptmZWftkSB7EFZZYdgcqZ1pmgQ6bxMPtVB1OAySkYzd257pfn/zjs9j
         RXVo1vVgG9MnvIWeMa4jAZLEIYd+D6kiLTbEX8KhKucQKxYdWwVsNCw0e0LktJEJFc6U
         2lMQ==
X-Gm-Message-State: AFqh2kpM9ujEIihabFDqyjYjgOKTux68fUVSxb6Oqpt5Aesid+y0T3I0
        YEKTDlYYK0cUBRFaJLyeXbYL5w==
X-Google-Smtp-Source: AMrXdXvGGz/gvpVF+m1gKFSnWM4m60GCSV6B3WXGIs8qfw953ZwrZtjUJm58wE7kDSSs71qYGLyXtA==
X-Received: by 2002:a92:9501:0:b0:30e:f03e:a76e with SMTP id y1-20020a929501000000b0030ef03ea76emr4842488ilh.2.1674834520779;
        Fri, 27 Jan 2023 07:48:40 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n2-20020a027142000000b0037477c3d04asm1561167jaf.130.2023.01.27.07.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 07:48:40 -0800 (PST)
Message-ID: <5743fb1b-eb4b-d169-a467-ee618bcd75f5@kernel.dk>
Date:   Fri, 27 Jan 2023 08:48:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] block: Default to build the BFQ I/O scheduler
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-block@vger.kernel.org
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230127154339.157460-1-ulf.hansson@linaro.org>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230127154339.157460-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/27/23 8:43 AM, Ulf Hansson wrote:
> Today BFQ is widely used and it's also the default choice for some of the
> single-queue-based storage devices. Therefore, let's make it more
> convenient to build it as default, along with the other I/O schedulers.
> 
> Let's also build the cgroup support for BFQ as default, as it's likely that
> it's wanted too, assuming CONFIG_BLK_CGROUP is also set, of course.

This won't make much of a difference, when the symbols are already in
the .config. So let's please not. It may be a 'y' for you by default,
but for lots of others it is not. Don't impose it on folks.

-- 
Jens Axboe


