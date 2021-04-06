Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080E7354E66
	for <lists+linux-block@lfdr.de>; Tue,  6 Apr 2021 10:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbhDFIT7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Apr 2021 04:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbhDFIT6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 04:19:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2F1C06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 01:19:51 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ap14so20563094ejc.0
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 01:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRoE8m8SbsuTxVa6zg3sI9/neyey4k5+6cBFrx+lReI=;
        b=iukuwoIFhU16vLUD4XHenSlG4Lfy25OfpAv//JUtRw2GOz5BtzYOeJVGrsjrVnezCq
         YNsBs/sKaYGwf8VVuoXKu5nOZDqumv5KPPG7y0f6OFcg3C8xPTVAw9XNMxUDAJ7OIrji
         9zNr8JwD7TpTF0jaDSMkcJZg0MAnHcqNsTrMuQ/khwKBzZMOzS+PQwld4XCqS358CG5G
         1jtRSvmKAAuKMBaWzse4JuaKrtRViLlpl2IPbLj71+HsGh+iMYKkLE4/oDZzxRZoLIPK
         Ky7NEvYjmUUdhUIv2v6PFI1kFZmxty/sK9TNCuN6M1Z4KfAKFxFolyFWOpbGGkuMYz0y
         I2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRoE8m8SbsuTxVa6zg3sI9/neyey4k5+6cBFrx+lReI=;
        b=VCOF1/4lJgkXrUYzTeMP1bV40Cvlp13NbqMUMRB4dZ6eF6i6J6aAH8NAO0XxwMiS/q
         gmCQDb/Z39lvvNTFMEvDRhf/jZ6gt2UX0/ebcBFE/K7Tzqm7UcXo0gF6DsTjqPZDb5aY
         N4sqjUbqG9MGhGM3HdXBeeSZy4qyDh93DbBtQ4253OOWKYhhy1McrnC1MNw1aUARbPEt
         5n51NPJkEErvl2Ftn6MvHtL8uZQ292UmjJWIsUzhArU1G+r43NwcFZ7Yoxw/d/qtFxmb
         k5/zkN3Q2uQhaaZwTsXiqy3TOu/1Uk9taddNMjfdSxplTdMHx0LtLbNSoc5o7FieMWF4
         OKrw==
X-Gm-Message-State: AOAM533O9vJE8w4jXjzr3NvR5obHAYD5vPnARgdf0zuOqGBbDVuchqoL
        XIEllTPUtgS03Dj975AoJsmSR0CVh145dX490DlPdSBB0ClTCKkn
X-Google-Smtp-Source: ABdhPJwZyEBkzXuAf/MMbGLun+Jl/avUydKJiiv7mqF2S7e2LqKrQtlvRNY5Ns0zl4EDmVVnP1pAGjhmzdxMH6oA7cg=
X-Received: by 2002:a17:906:340f:: with SMTP id c15mr33648329ejb.317.1617697189742;
 Tue, 06 Apr 2021 01:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210406070716.168541-1-gi-oh.kim@ionos.com> <20210406070716.168541-4-gi-oh.kim@ionos.com>
In-Reply-To: <20210406070716.168541-4-gi-oh.kim@ionos.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Tue, 6 Apr 2021 10:19:14 +0200
Message-ID: <CAJX1Ytaab5_D3tbA3rHnpe9UYw+pNw_cY0Smx-w5bAPZi3YztA@mail.gmail.com>
Subject: Re: [PATCHv3 for-next 03/19] block/rnbd-clt: Remove some arguments
 from insert_dev_if_not_exists_devpath
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 6, 2021 at 9:07 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> From: Guoqing Jiang <guoqing.jiang@gmx.com>
>
> Remove 'pathname' and 'sess' since we can dereference it from 'dev'.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@gmx.com>
> Reviewed-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
+ Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
