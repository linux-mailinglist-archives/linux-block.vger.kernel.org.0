Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C1124C422
	for <lists+linux-block@lfdr.de>; Thu, 20 Aug 2020 19:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgHTRIq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Aug 2020 13:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730445AbgHTRIL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 13:08:11 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2FDC061388
        for <linux-block@vger.kernel.org>; Thu, 20 Aug 2020 10:06:57 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m22so2915475ljj.5
        for <linux-block@vger.kernel.org>; Thu, 20 Aug 2020 10:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6WgqePZAKFwWv7oibyf66OC3S+SA0EwtLkT0KHMn7s=;
        b=bo+7UCzu3XtlLDsIdFcX5T2SOSSTsIkuEKVjv+td78vJUz4Qxj8E6pMzu0KujU0A8E
         wEY9X0HcNUH4MKDpEJcRCVekv731AB5t41ds1k6HDNgEAnDfiMuAYEd0JBMBCKkPIAls
         1ofwEbhEVneHVJ6n0purqzcbgSFawo2aR5Qj0bawUT6gizMqMxUdTu5Dax0QynHmnjhd
         hdB/1ctAxAaeD4O9/Pq7Bw19oxiBt6p7riIhI2gRNppDgxaBqie0QR49HWNaHkfr4pZR
         PmOswhZhm3v8rhV4eoYr9SX2GbowE+xyG+XqtRWsKplLcBdxMd2TZogrYKHaEzvA8E9/
         12yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6WgqePZAKFwWv7oibyf66OC3S+SA0EwtLkT0KHMn7s=;
        b=XcWBeJBCgmuCXwhK5ZVBz+JL+4JvTv38V+zOoHOeMRbsRcmN/ELvmrsD1RsA+J3hPZ
         tS7HVRMD7FaOaYKoYtdUso4ORFhwAraRnxNyIh0k9UU9z/WWKz5EpXnxnMd7u2cnGHv5
         I/O6NUgg33+Wyx12lGs3Fmnn9uaVw9G7abp2En/WUdoyIJtGx/Lm/Kn/E6w/hH54AzL1
         /PFAj8j2GzzEpOGLK7RsjhFTFV4w2jlu928G1VP0v+oiGesZJ8MTqeJfmTRxSqMDqP+M
         bjVjqyfGJl76o5Vng0umcuILoGuwUr+lvkVUttNvWIM4fXMnbPpqxufzdGWmDPyu67rW
         u9Pw==
X-Gm-Message-State: AOAM5315uXGqzUSpqyQEewsu2LANyvHEjXBjPeMtCvfK9UClBbkwZH2y
        H0DxIOXo+eQ+oDrw1ByQn+H1OFlwIbdT+8fzBjDFMQ==
X-Google-Smtp-Source: ABdhPJziUJGXBSB9o6ksa6wt3btAspt3JpWrpRS8ydIXvVTIxvdXw64pBpOlKiXdI5HRmfJyA09t5CJD1wgjuiuMX0o=
X-Received: by 2002:a2e:9396:: with SMTP id g22mr2214071ljh.446.1597943215596;
 Thu, 20 Aug 2020 10:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200528135444.11508-1-schatzberg.dan@gmail.com>
In-Reply-To: <20200528135444.11508-1-schatzberg.dan@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Aug 2020 10:06:44 -0700
Message-ID: <CALvZod655MqFxmzwCf4ZLSh9QU+oLb0HL-Q_yKomh3fb-_W0Vg@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Charge loop device i/o to issuing cgroup
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 6:55 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
> Much of the discussion about this has died down. There's been a
> concern raised that we could generalize infrastructure across loop,
> md, etc. This may be possible, in the future, but it isn't clear to me
> how this would look like. I'm inclined to fix the existing issue with
> loop devices now (this is a problem we hit at FB) and address
> consolidation with other cases if and when those need to be addressed.
>

What's the status of this series?
