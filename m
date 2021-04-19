Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D345C3649B8
	for <lists+linux-block@lfdr.de>; Mon, 19 Apr 2021 20:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240156AbhDSSVX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 19 Apr 2021 14:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240096AbhDSSVW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 14:21:22 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52935C06174A
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 11:20:50 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso19397035otm.4
        for <linux-block@vger.kernel.org>; Mon, 19 Apr 2021 11:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXRcipxB0g/YkNP+zUJKHMJKNLy+Z2cSEPqRQaNlD0o=;
        b=WX2T8vXeEesLKvdJysC3KPGA0tjCwe1DMYOc+PqlJBBN3O+pqldLvIuATn4UIegM0/
         nXqj6b5v+WkM622NPydhWJ0RfVKxFta+RZm+L+tseRtTLLXmrzX1p3LdGkLmpo3qW9BR
         0RLs8QcgFoVE1FcfPjid/R+fI+7WDZtSn0s7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXRcipxB0g/YkNP+zUJKHMJKNLy+Z2cSEPqRQaNlD0o=;
        b=B20hZlJ6Ibhl6fpNlCXNy//h6z0hUvMufwd9wB5NX6PModQD957O9n/oLOlM8a1bd1
         aSEA8iLYJ6iyF6mbxq+t0rdwJ+yQaGO0WPYkyOyOQVXy+jbttc9Ez3+pfxqe0LhHBkjy
         J5EomV+Klgo8TfG9LYN+2ek0+pp749XOqiACHpIYHiKgKnk04Q8+XqtBPGiWEKmTkzgf
         CX+VKTiphgskU7EKH90zpStKD43sQ7eM2bo0/qgihEIPEmePIDJXVR74PREd06OX0jEc
         4B+8CsCE4EzEvQRQnrlQOf/eDG4vSNeZqzEfsTukZ+O4ODrM+UdUUlFMFkuw0BtXy7B4
         5zBw==
X-Gm-Message-State: AOAM530yLEHIYhsAkxtFCmvqp7+buCzQfu4fgipA/MSPY07rVgqO+Z35
        6g71PrvOzZvStKn8Rrra3VYZMpBif1JaeZ/s9oDWwg==
X-Google-Smtp-Source: ABdhPJyRvI19wiTwpBH09wdf8iIumYNu5PFfQCGk4jAyQyZoJ9fpX/fhd4owoBzG8SbHmVU2e34zWBY//YIdNnHKvvw=
X-Received: by 2002:a9d:7a53:: with SMTP id z19mr15247923otm.40.1618856449368;
 Mon, 19 Apr 2021 11:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210416165353.3088547-1-kbusch@kernel.org> <20210416165353.3088547-2-kbusch@kernel.org>
 <CA+AMecG=8TTdsdYtaV=H+hKm2poKYhyh_Tvf0Tc0PZvbVXf_iA@mail.gmail.com>
 <20210416171735.GA32082@redsun51.ssa.fujisawa.hgst.com> <20210419071605.GA19658@lst.de>
 <20210419151437.GA12999@redsun51.ssa.fujisawa.hgst.com> <CA+AMecFXLCm3zsrfGdjT5hW4fvvgDxJxGEZvxOEA0bJT3X11wg@mail.gmail.com>
 <20210419174800.GA3130441@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210419174800.GA3130441@dhcp-10-100-145-180.wdc.com>
From:   Yuanyuan Zhong <yzhong@purestorage.com>
Date:   Mon, 19 Apr 2021 11:20:39 -0700
Message-ID: <CA+AMecF6CODiR3sze-PAjhJ37YsjEGzM4CdKSBHxVUCMi=KwvA@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: use return value from blk_execute_rq()
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 19, 2021 at 10:48 AM Keith Busch <kbusch@kernel.org> wrote:
>

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b57157106cac..a0fb9ad132af 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -949,6 +949,9 @@ static void nvme_end_sync_rq(struct request *rq, blk_status_t error)
>         struct completion *waiting = rq->end_io_data;
>
>         rq->end_io_data = NULL;
> +       if (error && !nvme_req(rq)->status)
Is setting nvme_req(rq)->status for each error return in ->queue_rq()
going to gradually roll out, and eventually skipping the fallback here?

> +               nvme_req(rq)->status = blk_status_to_errno(error);
Casting int negative errno to u16 will get 0xfff., meaning NVME_SC_DNR is set.
Is that always right?

--
Regards,
Yuanyuan Zhong
