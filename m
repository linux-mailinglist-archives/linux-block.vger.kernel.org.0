Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AA26E9B6E
	for <lists+linux-block@lfdr.de>; Thu, 20 Apr 2023 20:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjDTSRa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Apr 2023 14:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjDTSR3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 14:17:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416E24220
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 11:17:28 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-506bf4cbecbso1067581a12.1
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 11:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682014646; x=1684606646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzocEjSvrz85xEKE5MWcbLv/boctI2KKwjYq7LHKyz4=;
        b=S2ctvNqMIvOioIiHZwWJbdVQexXnEJfkUsuEM04PMllQQAq/sE8IIOM0eDrdZYpgEJ
         xYvvOg1SKcnNSA1ne7Anfer1mqpLaVnAcBhSp+ghH7N/HQ8XDHIwRGXapE+PvHn+SSWd
         4oiG653PvBxwj57BngCB9Qxok+vr5fsaip9T4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682014646; x=1684606646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzocEjSvrz85xEKE5MWcbLv/boctI2KKwjYq7LHKyz4=;
        b=Rjc2Hih8eSLQkBQU/3aR60oaHfW+lUgVGRWnERkAmdwV5jDymbSagAmTbsv3sZ3XT/
         Lml1veap+PY7zh/pcEdJV9eJiJQ7FMgdH+5OV6a0YV0TUIpYbTeve5L1t2o4MH34eAwB
         w6pFlG39TrI0rPMT8s4+yNdQE+3Xmt9vCzYGaNdAK3BzFUitBWHDUhRUc0cnJu0MWemW
         sPUdq2NYwMbH3lSsosm9zrnh2JRyBhzRf1B8SRSyxFjn9vYmnVXYc8QrE76+gQ+NvJ8S
         JcLg4Bkn0OQ9pP2PZVliBAM6mgYI+eL1Q3jKM5KZ2BZ8nYTH7t0hdnOXuqU+p/cxtnyA
         SbAg==
X-Gm-Message-State: AAQBX9ejjU1dHdZ6ALF3A3NNbH5XewUkbZogwFcEP91oFbzgCCJKNSih
        rE2J6vc4cbrUbbfslt1NIDSlpaGXBCKe1pyiiXNjazSkXFffxJ+T
X-Google-Smtp-Source: AKy350bUbgX+6BAetL35DQRlN+iICSaVw+B/jOXdxmTlFH/Y/a2lnx/qR3DkR104XRtbf49FVqzsbMMtZaekb6roEd8=
X-Received: by 2002:aa7:c592:0:b0:508:3f08:ea0f with SMTP id
 g18-20020aa7c592000000b005083f08ea0fmr2514672edq.28.1682014646672; Thu, 20
 Apr 2023 11:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <ZEFmS9h81Wwlv9+/@redhat.com> <20230420172807.323150-1-sarthakkukreti@chromium.org>
In-Reply-To: <20230420172807.323150-1-sarthakkukreti@chromium.org>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Thu, 20 Apr 2023 11:17:15 -0700
Message-ID: <CAG9=OMO7LtYRMurR4t4P5Tcb00-ob21eg4jm0aUXry2mcgOMfw@mail.gmail.com>
Subject: Re: [PATCH v5-fix 1/5] block: Don't invalidate pagecache for invalid
 falloc modes
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch had a slight typo; fixed in the most recent patch.

- Sarthak

On Thu, Apr 20, 2023 at 10:28=E2=80=AFAM Sarthak Kukreti
<sarthakkukreti@chromium.org> wrote:
>
> Only call truncate_bdev_range() if the fallocate mode is
> supported. This fixes a bug where data in the pagecache
> could be invalidated if the fallocate() was called on the
> block device with an invalid mode.
>
> Fixes: 25f4c41415e5 ("block: implement (some of) fallocate for block devi=
ces")
> Cc: stable@vger.kernel.org
> Reported-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  block/fops.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/block/fops.c b/block/fops.c
> index d2e6be4e3d1c..20b1eddcbe25 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -648,24 +648,35 @@ static long blkdev_fallocate(struct file *file, int=
 mode, loff_t start,
>
>         filemap_invalidate_lock(inode->i_mapping);
>
> -       /* Invalidate the page cache, including dirty pages. */
> -       error =3D truncate_bdev_range(bdev, file->f_mode, start, end);
> -       if (error)
> -               goto fail;
> -
> +       /*
> +        * Invalidate the page cache, including dirty pages, for valid
> +        * de-allocate mode calls to fallocate().
> +        */
>         switch (mode) {
>         case FALLOC_FL_ZERO_RANGE:
>         case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
> +               error =3D truncate_bdev_range(bdev, file->f_mode, start, =
end);
> +               if (error)
> +                       goto fail;
> +
>                 error =3D blkdev_issue_zeroout(bdev, start >> SECTOR_SHIF=
T,
>                                              len >> SECTOR_SHIFT, GFP_KER=
NEL,
>                                              BLKDEV_ZERO_NOUNMAP);
>                 break;
>         case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
> +               error =3D truncate_bdev_range(bdev, file->f_mode, start, =
end);
> +               if (error)
> +                       goto fail;
> +
>                 error =3D blkdev_issue_zeroout(bdev, start >> SECTOR_SHIF=
T,
>                                              len >> SECTOR_SHIFT, GFP_KER=
NEL,
>                                              BLKDEV_ZERO_NOFALLBACK);
>                 break;
>         case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HI=
DE_STALE:
> +               error =3D truncate_bdev_range(bdev, file->f_mode, start, =
end);
> +               if (!error)
> +                       goto fail;
> +
>                 error =3D blkdev_issue_discard(bdev, start >> SECTOR_SHIF=
T,
>                                              len >> SECTOR_SHIFT, GFP_KER=
NEL);
>                 break;
> --
> 2.40.0.396.gfff15efe05-goog
>
