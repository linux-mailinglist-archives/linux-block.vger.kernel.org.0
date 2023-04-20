Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100626E879D
	for <lists+linux-block@lfdr.de>; Thu, 20 Apr 2023 03:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjDTBs6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 Apr 2023 21:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjDTBs5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 21:48:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4D810C
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 18:48:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-506767f97f8so490564a12.1
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 18:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681955333; x=1684547333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//w2KpKliRFtK58d1EJmwfMo5BWc/3hlHccBcm4S1F0=;
        b=T4aYEuMlSEdNozgrlSVeBk9a8VTbE/hdg0lImsnFKDRnHtBGYo9rd9UsL8V3TmnHa/
         tg31i41rPZhwfEzQB1YmXPWmX2NVZPYMqNbc50NAL8Gqx375htrV2VxNRfmtA3wABGEL
         ZVkM5EYlmpXAZqANasp8MWa7JSR0u9cUcpkaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681955333; x=1684547333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//w2KpKliRFtK58d1EJmwfMo5BWc/3hlHccBcm4S1F0=;
        b=jPDGqNWMq++/9VpQ0WW2YBvDDHbQbbb0olrhUaHSf1CwxZos3yFqtutjvkmGdDalyQ
         uTdwvT4xam/F2Ga4/pdawt1bAth/nbSe0jp0z7qjqd9M7knotbQl4e1DCLsH8KJWLLl9
         21x41cjDqt7p/SqHItDoGqpgvWdV6kUx+tGyRy8jHubjr/sJI2i9uOSSNujNYpaK+ryk
         kHvMzAonvKGIhzWDjs+L1gUBdS8c8xC0E3N5wVt0sZCV17PGowUlJGBDk5rkooKzV61Y
         XamFCCVkHAhyEI/20zZxlLryFILIWv4gINqyoAwGoHSKfprb/qsL/r6wWBfJeaTmY/+J
         Eo0g==
X-Gm-Message-State: AAQBX9cFH8IEsFTNQ5Uh5ENdWC9taSiNdZqtz4s+KHvRB34mLDxUixQf
        epcaAEFWbFpbjpyyefYKzwIHhdHEiwsjAdFOZftpbTXTKVRTeDZI
X-Google-Smtp-Source: AKy350Z2wHZXrdLmCljCXZmXuQtTIZ6kMfErfzcZVLiPXa6Vv3hJOhOQDnwXcad0AaOBHDbgGBaLGi1H8St8LWJSs6w=
X-Received: by 2002:aa7:d60a:0:b0:506:833c:abcf with SMTP id
 c10-20020aa7d60a000000b00506833cabcfmr7313519edr.42.1681955333496; Wed, 19
 Apr 2023 18:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230414000219.92640-1-sarthakkukreti@chromium.org>
 <20230420004850.297045-1-sarthakkukreti@chromium.org> <20230420004850.297045-2-sarthakkukreti@chromium.org>
 <20230420012243.GO360895@frogsfrogsfrogs>
In-Reply-To: <20230420012243.GO360895@frogsfrogsfrogs>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Wed, 19 Apr 2023 18:48:42 -0700
Message-ID: <CAG9=OMMqm6AsdxbGBJJs7DRH-AUtQj8ocC+UJmvVTMMKdVQDnw@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] block: Don't invalidate pagecache for invalid
 falloc modes
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
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
        Daniil Lunev <dlunev@google.com>
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

Sorry I tried to be too concise :) Updated with a fixed up patch!

Best
Sarhtak

On Wed, Apr 19, 2023 at 6:22=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Apr 19, 2023 at 05:48:46PM -0700, Sarthak Kukreti wrote:
> > Only call truncate_bdev_range() if the fallocate mode is
> > supported. This fixes a bug where data in the pagecache
> > could be invalidated if the fallocate() was called on the
> > block device with an invalid mode.
> >
> > Fixes: 25f4c41415e5 ("block: implement (some of) fallocate for block de=
vices")
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  block/fops.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/block/fops.c b/block/fops.c
> > index d2e6be4e3d1c..2fd7e8b9ab48 100644
> > --- a/block/fops.c
> > +++ b/block/fops.c
> > @@ -648,25 +648,27 @@ static long blkdev_fallocate(struct file *file, i=
nt mode, loff_t start,
> >
> >       filemap_invalidate_lock(inode->i_mapping);
> >
> > -     /* Invalidate the page cache, including dirty pages. */
> > -     error =3D truncate_bdev_range(bdev, file->f_mode, start, end);
> > -     if (error)
> > -             goto fail;
> > -
> > +     /*
> > +      * Invalidate the page cache, including dirty pages, for valid
> > +      * de-allocate mode calls to fallocate().
> > +      */
> >       switch (mode) {
> >       case FALLOC_FL_ZERO_RANGE:
> >       case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
> > -             error =3D blkdev_issue_zeroout(bdev, start >> SECTOR_SHIF=
T,
> > +             error =3D truncate_bdev_range(bdev, file->f_mode, start, =
end) ||
> > +                     blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
>
> I'm pretty sure we're supposed to preserve the error codes returned by
> both functions.
>
>         error =3D truncate_bdev_range(...);
>         if (!error)
>                 error =3D blkdev_issue_zeroout(...);
>
> --D
>
> >                                            len >> SECTOR_SHIFT, GFP_KER=
NEL,
> >                                            BLKDEV_ZERO_NOUNMAP);
> >               break;
> >       case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
> > -             error =3D blkdev_issue_zeroout(bdev, start >> SECTOR_SHIF=
T,
> > +             error =3D truncate_bdev_range(bdev, file->f_mode, start, =
end) ||
> > +                     blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
> >                                            len >> SECTOR_SHIFT, GFP_KER=
NEL,
> >                                            BLKDEV_ZERO_NOFALLBACK);
> >               break;
> >       case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HI=
DE_STALE:
> > -             error =3D blkdev_issue_discard(bdev, start >> SECTOR_SHIF=
T,
> > +             error =3D truncate_bdev_range(bdev, file->f_mode, start, =
end) ||
> > +                     blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
> >                                            len >> SECTOR_SHIFT, GFP_KER=
NEL);
> >               break;
> >       default:
> > --
> > 2.40.0.634.g4ca3ef3211-goog
> >
