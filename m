Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB6F20BFF1
	for <lists+linux-block@lfdr.de>; Sat, 27 Jun 2020 10:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgF0IAZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 27 Jun 2020 04:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgF0IAY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Jun 2020 04:00:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41803C03E979
        for <linux-block@vger.kernel.org>; Sat, 27 Jun 2020 01:00:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so11568111wrj.13
        for <linux-block@vger.kernel.org>; Sat, 27 Jun 2020 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4saGZCbwrf/WxrEzwiwMcrJYbJDxT5Ey9q2FfXo7kP4=;
        b=bXFzvc9bqsNSpmFQpkJcqHLIiuXkJtsPyydr9tl/IzKsi2TpjI4t+LV3i9DmSwFbNa
         OgoDYute85IpKFLHsnoZl5WZHPIuO1W+Z/Am1lwXVoiwCFZhOUgP4gaXjftAhDg0TW4E
         ArCVwvXOaMyrb0MmrZX7mkxkIvjUZ1aZFldyRjWvaVf+wMb11AIE/B7O5/Ig5nG8sd9A
         5KUPR4UiC7r223ua8gc1VM5BH6oYuVEWmgxKNj9zn7iYlr6k03vSlgTVBUfeypCsQqsD
         Z/6iG6j0SKV5dqcvNnluA202WK3uK29XiTpWlW000m5REtsz+liS+fHfDYd0mNwzNw2R
         QPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4saGZCbwrf/WxrEzwiwMcrJYbJDxT5Ey9q2FfXo7kP4=;
        b=QMiNrXlwnOL2GxqBUDdTBOShgOmxHEHhEqVBKTqEzxFqlFHTDKSX7mJjDLyrMJxqXX
         9Ri3AfTwiMkY5DVkY8jEM7Fh7bqbRgZJfLU3iNKgiPOXkok3wtVCOqhEJUkgECoIuBkE
         VWq0A0k62wJIhXTKss0bcaLq964zip9voQosi+t/oSCWj/HTiQzT3aj8zMbk4cgzQYwT
         d1OOOqhqgc6lISdGicllTce27E+HvPUzyIeiZvZmev1zgFCd3r+/oX6N4xtHYQiuya9p
         I1N2VCRbtfDq4NT0k0uQPK0Lr2MVsRzTpOi5Ggt9TC+0wXdiBoGlvyxHqnmbVxcnKswj
         yOhw==
X-Gm-Message-State: AOAM532tahL4hdSDMeotwQbtBweEBG8qMzIIT7iGBVfFkA+kX/qbzvVT
        cu37x0Rphr9rd1BEwUiHrrxIWsEFM35GUonyLao=
X-Google-Smtp-Source: ABdhPJxNCGHvVWfgY2RBPgXebDYhhLVJbaFqTCwFZzJdCA3n0+Ig2Qt699FUbCrVAbZnRdA/eraA+WqT5kkHWkFq2Kg=
X-Received: by 2002:adf:ef89:: with SMTP id d9mr8023746wro.124.1593244822940;
 Sat, 27 Jun 2020 01:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <bdef634a3a41dbecfd3d74f6bd25332445772902.camel@mail.ru>
In-Reply-To: <bdef634a3a41dbecfd3d74f6bd25332445772902.camel@mail.ru>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sat, 27 Jun 2020 16:00:11 +0800
Message-ID: <CACVXFVObNuK=Uii_Tm2pSEEm2RAeECeha97-q=+XkDsuD6Vmsg@mail.gmail.com>
Subject: Re: [PATCH] block: Set req quiet flag if bio is quiet
To:     Aleksei Marov <alekseymmm@mail.ru>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jun 27, 2020 at 2:12 AM Aleksei Marov <alekseymmm@mail.ru> wrote:
>
> The current behavior is that if bio flagged as BIO_QUIETis submitted to request based block device then the request
> that wraps this bio in a queue is not quiet. RQF_FLAG is not
> set anywhere. Hence, if errors happen we can see error
> messages (e.g. in print_req_error) even though bio is quiet.
> This patch fixes that by setting the flag in blk_rq_bio_prep.
>
> Signed-off-by: Aleksei Marov <alekseymmm@mail.ru>
> ---
>  block/blk.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/block/blk.h b/block/blk.h
> index b5d1f0f..04ca4e0 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -108,6 +108,9 @@ static inline void blk_rq_bio_prep(struct request
> *rq, struct bio *bio,
>
>         if (bio->bi_disk)
>                 rq->rq_disk = bio->bi_disk;
> +
> +       if (bio_flagged(bio, BIO_QUIET))
> +               rq->rq_flags |= RQF_QUIET;
>  }

BIO_QUIET consumer is fs code, and RQF_QUIET consumer is block layer,
so you think
the two consumers' expectation is same?

-- 
Ming Lei
