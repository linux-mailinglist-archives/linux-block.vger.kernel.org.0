Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7893E4E98D0
	for <lists+linux-block@lfdr.de>; Mon, 28 Mar 2022 15:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243553AbiC1N7e (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 28 Mar 2022 09:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243547AbiC1N7d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Mar 2022 09:59:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C8E5D678
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 06:57:51 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id j15so28824104eje.9
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 06:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9XsGPVM3OBI1o2wqhHoOEJxIfzU6g7lXxBVU0mjG/Y=;
        b=Ez6cMtRVxjy3WSMB1qzvx3cy4spCXTGzgPZr10+KtI8BzuENmAwZYO3QRxO8apwhdk
         Gx/OwzAq56twYuJHbSNRr/ynrf8UZv8nZabgjguaaYtLEw14dRILVPlAIb3NWcfCIEFz
         R0vs6suuVg8txAujwrRo9eCsP66vuNCyg3q/7Hl5rhtiFGcLBnBlVW0XK6WRDQXGQpo9
         P98aIYsAcPHmRmHhZT5GEmhehUmAo5sskD4IVNthqt4MCA4hYgDq5DFudsoiPiOVmqz3
         ObFCsBjvY+rUifYfspBCrmsYiRbQMQJGHN3WmpiWJ6enDYObilCHWxEJh02YvmEBZDCV
         1jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9XsGPVM3OBI1o2wqhHoOEJxIfzU6g7lXxBVU0mjG/Y=;
        b=CLcpr2oInvWo745Vn0/HpzMCCa4VDda93Vm/2NJLKIcYtyAtda+F5T0JnLJNf82UVg
         2qS9LBKj/0ZIYmSsi7DuhT0XpsqKZJ4gzdjp2WG4CBF7t0AoYVNC3h25RzzFsnCJJBVG
         2+pLSgERfZmU9A+sfVhBcGYo2pW3vgQRwRIlLqi9XQnhyMYkbGit9h1BX5ZusOcQHVJw
         cZnpMFucvAMNY3gIoWdIOSs5VnscaJ0efbRtRdG8iSlgEU7P3879iaEyDY3/+xwtx1NB
         FKAPgjeisnunEafxo0spZsl8KxdghQfX2EWYiJSnmPzDuzXBH9NBhd2KdHmUjzFvZF27
         bfLw==
X-Gm-Message-State: AOAM531NcmNK578nXplxQByTHl7rIYgaLy4PsnAIl/MJACTiYp8cJsYR
        W9ncD7COKvInGmK51ToCkLPsxeLnOV+3wuZCqL12kA==
X-Google-Smtp-Source: ABdhPJx8IAzAnugQilvYszPqbwu/kHCCuyCQG5aZa/oDfoRHr1M15AxQcxiJNiHW7Pkc4FoojrnBeCiC5WtixX+3oUs=
X-Received: by 2002:a17:907:3da9:b0:6db:f3f:33c2 with SMTP id
 he41-20020a1709073da900b006db0f3f33c2mr27321704ejc.735.1648475869953; Mon, 28
 Mar 2022 06:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <42165d3f9dfc7abb54542d34a4e33ea8e83b101c.1648379172.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <42165d3f9dfc7abb54542d34a4e33ea8e83b101c.1648379172.git.christophe.jaillet@wanadoo.fr>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 28 Mar 2022 15:57:39 +0200
Message-ID: <CAMGffEkVEWTcpK9ntx15xmvdiXtm+uwyz8Wr-AhAjwCcFLVOqg@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: Fix the maximum clt_device_id value in init_dev()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Jack Wang <jinpu.wang@ionos.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 27, 2022 at 1:06 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> ida_alloc_range(..., min, max, ...) returns values from min to max,
> inclusive.
>
> So, '1 << (MINORBITS - RNBD_PART_BITS)' is a valid value for ret, which is
> then saved in 'dev->clt_device_id'.
>
> This value is used in rnbd_client_setup_device() and passed to
> rnbd_clt_setup_gen_disk().
> There we have:
>     dev->gd->first_minor        = idx << RNBD_PART_BITS
>
> So a possible value for 'gd->first_minor' is '1 << MINORBITS'
>
> This is an issue because:
>     rnbd_clt_setup_gen_disk()
>     --> add_disk(dev->gd)
>       --> device_add_disk(NULL, disk, NULL)
>
> And there we have:
>    ddev->devt = MKDEV(disk->major, disk->first_minor);
>
> So, should 'gd->first_minor' be '1 << MINORBITS', MKDEV() would overflow.
>
> Fixes: f7a7a5c228d4 ("block/rnbd: client: main functionality")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> #define MKDEV(ma,mi)    (((ma) << MINORBITS) | (mi))
>
> This patch is completely speculative.
>
> I think that:
>         if (disk->first_minor + disk->minors > MINORMASK + 1)
>                 return -EINVAL;
> in device_add_disk() handles this corner case.
> Anyway, if I'm correct, handling the error earlier can't hurt (at least I
> guess so :)).
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
looks good to me, thx!
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index b66e8840b94b..db900c3786a3 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1454,7 +1454,7 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
>                 goto out_alloc;
>         }
>
> -       ret = ida_alloc_max(&index_ida, 1 << (MINORBITS - RNBD_PART_BITS),
> +       ret = ida_alloc_max(&index_ida, (1 << (MINORBITS - RNBD_PART_BITS)) - 1,
>                             GFP_KERNEL);
>         if (ret < 0) {
>                 pr_err("Failed to initialize device '%s' from session %s, allocating idr failed, err: %d\n",
> --
> 2.32.0
>
