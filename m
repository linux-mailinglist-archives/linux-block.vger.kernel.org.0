Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF354C711D
	for <lists+linux-block@lfdr.de>; Mon, 28 Feb 2022 16:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbiB1QA0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 28 Feb 2022 11:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbiB1QAZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 11:00:25 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478CE31523
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 07:59:46 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id lw4so25668412ejb.12
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 07:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=udUUwQMYZOQdeQeu7KJflNOXp5UljA8CQOPQlhHKm+Y=;
        b=Ps2g3Rmx7y+RxaExNigUlAShr8r9n4HJx4jXh3jX3l48QN2GGz17bPjHQGFh/RPT/a
         Xe3Y302EzQSNvW7VzbwzWaqmO5xMMVqpxy+XXofnecS/u0ED0x+tbYTlqkSLsLRhSciu
         N6rSkzsDR47sLeOm/7rAJXCL4mb6S7A5gjjMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=udUUwQMYZOQdeQeu7KJflNOXp5UljA8CQOPQlhHKm+Y=;
        b=t30Z3U+o56x2kBGln4unHUmXgLdpzI+h3bDaoxNAn3SzWNSKkSdB7DvIbGgZQ2c+aV
         JZ8a9hxhk2TsIgPIVkWWV9oho37EDnsfi3CEE1Yt94xfZcqQM5eODhnOYW1F4h0b9K1i
         3LikMBWYHrPVxw4f8ZlzGEUXQySdWpvaLqO6V0M0KOWggStlu2GlT+k9n+wDAmpTAGmu
         2h3Bb5upPspjDy77WLLj9qR2e5ofxYfc10WosWLZDpkLim8JoROk2i+TtsLufqrwDFnZ
         QCCVq0st6ZSwEpvTV7eINg1ZMks6FP06yJqgbulRX7pQLXiSJaj8Iy/4flnYI7REm7jP
         sttA==
X-Gm-Message-State: AOAM532Flt8eKlKe6odNtGilCKWrXkXEZDRRFNDmadidl4N9h2L9n7So
        G8uYE2KbhL+flWPAW+NpeIp7qLGlbImft2BnMadFpQ==
X-Google-Smtp-Source: ABdhPJzFuwC4cXK43NRFP1CzDPmxJHkeyiho2pckN/boPKiQ0vuUKSn6l1ZxMqIRvXXEFW5bhRCbL2ZNT2f45sLUzvo=
X-Received: by 2002:a17:907:76fc:b0:6ce:a836:34a1 with SMTP id
 kg28-20020a17090776fc00b006cea83634a1mr16312616ejc.663.1646063984879; Mon, 28
 Feb 2022 07:59:44 -0800 (PST)
MIME-Version: 1.0
References: <20220227093434.2889464-1-jhubbard@nvidia.com> <20220227093434.2889464-7-jhubbard@nvidia.com>
In-Reply-To: <20220227093434.2889464-7-jhubbard@nvidia.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 28 Feb 2022 16:59:33 +0100
Message-ID: <CAJfpegsDkpdCQiPmfKfX_b4-bkkj5N5vRhseifEH6woJ7r0S6A@mail.gmail.com>
Subject: Re: [PATCH 6/6] fuse: convert direct IO paths to use FOLL_PIN
To:     jhubbard.send.patches@gmail.com
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 27 Feb 2022 at 10:34, <jhubbard.send.patches@gmail.com> wrote:
>
> From: John Hubbard <jhubbard@nvidia.com>
>
> Convert the fuse filesystem to support the new iov_iter_get_pages()
> behavior. That routine now invokes pin_user_pages_fast(), which means
> that such pages must be released via unpin_user_page(), rather than via
> put_page().
>
> This commit also removes any possibility of kernel pages being handled,
> in the fuse_get_user_pages() call. Although this may seem like a steep
> price to pay, Christoph Hellwig actually recommended it a few years ago
> for nearly the same situation [1].

This might work for O_DIRECT, but fuse has this mode of operation
which turns normal "buffered" I/O into direct I/O.  And that in turn
will break execve of such files.

So AFAICS we need to keep kvec handing in some way.

Thanks,
Miklos
