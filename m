Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956AA333036
	for <lists+linux-block@lfdr.de>; Tue,  9 Mar 2021 21:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhCIUrT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 9 Mar 2021 15:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbhCIUrE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Mar 2021 15:47:04 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010ADC06174A
        for <linux-block@vger.kernel.org>; Tue,  9 Mar 2021 12:47:03 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id c10so31504803ejx.9
        for <linux-block@vger.kernel.org>; Tue, 09 Mar 2021 12:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxekq9CmjmqiQezEq23fxoA2lWRbGVUv5ZHopeMn1UE=;
        b=cnHrmQr/VMb/t2E/EgCby5Ir+NbwqGQ0u5beELJg+31cT1IgztSHwumMnd5zdcoDB2
         66n4NERbQg+uvwjesYYTCrNMtq9i9BOp/xxNWs/vGHWpji0JOhm5y/MI1V1Ox4Pc4WRW
         tBCkqmAvU9bVb4X02t4bXL1znuI21REF0jrmhFii+VAU1w787tzlvvkSi8J6MFfQp9Qc
         pDQjCC5HheYIdn0dNKCnxnEBuaRZu7xTQPpa9IDV/OMAz50a7gzVrpOYTiwkLGnkyiNv
         Xl9tJ2GvH5S31+9GqAUexpRyDEuTmNjlBu3J2Ogs0+mgYdfyBUBeIAD+tjEcWDtq2eIa
         u1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxekq9CmjmqiQezEq23fxoA2lWRbGVUv5ZHopeMn1UE=;
        b=pu7VNbt0EnOPBxneYrPOGDd/W3fho/MoKT475ZaIcDVHME48bGqYXMV8OQvAVEkHtR
         10+6DiKRYyImipV+BbdJQR8NtJrzWOQaGB3Yuzb+GnG7S8v+rDkuDD8xurrAfTys/9Wx
         cz39x2XwnX7bt4LjmOY0i0crKLwlKpUuy7I28Py7FLOtyQfvMKt2zjdUhwGziFIHouse
         nFm3nvvVWO0ZzbT/LybnmlDyjUms693fWHON6/l4FCq3cukF8q7hfnppHKnGAEw5FlLn
         AeONA0cnim9PZNAT4xycxYWH1CpY92txrYEtrl/cqg/I82DyaSjCoAYwzkh92U4iPXP8
         2d1Q==
X-Gm-Message-State: AOAM533tGPCyx5l54QpJeJZZeQgsThiOXa5USd9wUWGe/HZj84nDAKS6
        5/qzCZ8VQeovK1VpWdTBYGWsloUsf6P8E8a9b172WA==
X-Google-Smtp-Source: ABdhPJyGCNUbmQJ/wDHu5IcJL/niMgxwiRhAm5hQcCcYAEaJxVRh4Cge+6PJtQJj3bcb2aVMkwUuE9suuO9SNZofuRY=
X-Received: by 2002:a17:906:c405:: with SMTP id u5mr22581663ejz.341.1615322822643;
 Tue, 09 Mar 2021 12:47:02 -0800 (PST)
MIME-Version: 1.0
References: <20210309195747.283796-1-willy@infradead.org>
In-Reply-To: <20210309195747.283796-1-willy@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 9 Mar 2021 12:47:00 -0800
Message-ID: <CAPcyv4iQ8qfyhungkhdDKqmOUrd0e3XtExxC_2yz+zX8ncBsrA@mail.gmail.com>
Subject: Re: [PATCH v2] include: Remove pagemap.h from blkdev.h
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bcache@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 9, 2021 at 11:59 AM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> My UEK-derived config has 1030 files depending on pagemap.h before
> this change.  Afterwards, just 326 files need to be rebuilt when I
> touch pagemap.h.  I think blkdev.h is probably included too widely,
> but untangling that dependency is harder and this solves my problem.
> x86 allmodconfig builds, but there may be implicit include problems
> on other architectures.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> v2: Fix CONFIG_SWAP=n implicit use of pagemap.h by swap.h.  Increases
>     the number of files from 240, but that's still a big win -- 68%
>     reduction instead of 77%.
>
[..]
>  drivers/nvdimm/btt.c      | 1 +
>  drivers/nvdimm/pmem.c     | 1 +

For the nvdimm bits:

Acked-by: Dan Williams <dan.j.williams@intel.com>
