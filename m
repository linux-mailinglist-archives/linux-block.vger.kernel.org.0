Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97193354E83
	for <lists+linux-block@lfdr.de>; Tue,  6 Apr 2021 10:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbhDFIZt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Apr 2021 04:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240035AbhDFIZr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 04:25:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C68C061756
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 01:25:40 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id qo10so10153140ejb.6
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 01:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kPEC7Z0C1S3CtWI0bKM/SzVawZ4wVR7pzA9z9+9Y4iM=;
        b=TAPlMWUf9wyJ1Ary1eORH0Gp1bNpfZlB8U6NIfCM1dosXsTjrczuqhzvn5ekHLSCTv
         eb0r6QDRGZibtoVu/pGVkg8JeMGF0mWlEeE2IlL56/hEBjC4f2Nu8XQQvTtgvpfPOhb7
         kj6SY05e/LDbasYYbIwUfqbqPoCmrQPMTleY6TE+JaKSY0QnergmXj6AlwwdzOxm3EbP
         nhReUCb2yqFcYaNeIb6XAAQ+Ksp49y/FAqsWXrdBo54BJ67lPoMxXArOJOvrf4rJFq0F
         +p/et9C9/nQLft64XKI1E1pGbyOqFK+dqneN1Cthz4Nxf3cpyE+FpUL/E38HkaPiqCIo
         HuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPEC7Z0C1S3CtWI0bKM/SzVawZ4wVR7pzA9z9+9Y4iM=;
        b=rXB8SDNHHeJn/ZlRH5yfSZtn12am/Z2BCR+pZKi4KiKYK+qelBkD7CAH3f571aVwUf
         F5sEos60z5wzgOExNw8JRPEaXgYPRVp4C2kPakYoJB6+culKXIeLrMizVNcgiXB6AoI0
         VyfqqVwbB1+1uK1KIdCJdKUYDOhG3zHwauusf2jAInhUcKEXhLYHCr0lxBcltdFYAdHP
         3GbMSb72yJ6X+5IRzD9xpRfiz7wJB8tTG6H0lduRM0i8qsVcXKdvG/C+teuX/6F2w5M5
         oh5XtQXxesGlVPSsAF2lvbXgU05UPacEaOprtZskhGCZSUualNn6Y/Ku59XSFYUHNuOs
         zOIQ==
X-Gm-Message-State: AOAM530E1G1C+pcjpHJtt+epAcURIV4lRYjGuwzX1LruezcE6w7nVyDM
        J1LOyKqE6ShC2mQ2e6u6yGHVRz7J5GdY2DRVbL9ZZ8xeoGaBEk4R
X-Google-Smtp-Source: ABdhPJwmE+Rv+h+sBNkMZQXshRB8p3H+2i1cWVJipfBKRd4UYNIZmk0m303Nqzs9u17F5vVs0OJV3jwu7pw3X0xtRqQ=
X-Received: by 2002:a17:906:190d:: with SMTP id a13mr10839476eje.330.1617697538688;
 Tue, 06 Apr 2021 01:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210406070716.168541-1-gi-oh.kim@ionos.com> <20210406070716.168541-16-gi-oh.kim@ionos.com>
In-Reply-To: <20210406070716.168541-16-gi-oh.kim@ionos.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Tue, 6 Apr 2021 10:25:03 +0200
Message-ID: <CAJX1YtZLHppqWbgOTneuhQm1jBsKpXqux-1+K5t_GoGZ-SDAJw@mail.gmail.com>
Subject: Re: [PATCHv3 for-next 15/19] block/rnbd-srv: Remove unused arguments
 of rnbd_srv_rdma_ev
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 6, 2021 at 9:07 AM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
>
> struct rtrs_srv is not used when handling rnbd_srv_rdma_ev messages, so
> cleaned up
> rdma_ev function pointer in rtrs_srv_ops also is changed.
>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Aleksei Marov <aleksei.marov@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
+ Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
