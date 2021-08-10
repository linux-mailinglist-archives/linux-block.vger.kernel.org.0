Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906323DFCC5
	for <lists+linux-block@lfdr.de>; Wed,  4 Aug 2021 10:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbhHDI0c (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 Aug 2021 04:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236261AbhHDI0b (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Aug 2021 04:26:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B913C061798
        for <linux-block@vger.kernel.org>; Wed,  4 Aug 2021 01:26:19 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b128so684847wmb.4
        for <linux-block@vger.kernel.org>; Wed, 04 Aug 2021 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wshwpEouxlj43w/LQBqY2ZUR+r5ng5wTSfjhEdV7ZQ8=;
        b=REbwzykdm7OHhYkHKTa4GjtmoAm/i/ozHj6HEKSDN2l8DI9yMhJjoD3frpiGcgtfuf
         B6k4/3bLIv/vNdP6tho5LYyF0rZUupRmPJCOued8whJH/JUG2rWSdfbelUmXEH/ZI/v+
         2SflUax0cVIuf5qFUmtGeSjNmD177hOaOC1u31X3/1MZEBQLCJRSwk6AwezncWp08aGl
         Rz6HuxNepkU8dv72WwgMjJnDtKHfA1zczbGIhz4JCvDjHDc/zxSFeRsjxGheGvW8bTGG
         jsYxYwMJy8H34keULSi4tRMVafjaS+eTGn93fl/EP8YVVkhsVZxL9hp4Hl8UgT+5kuWC
         DtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wshwpEouxlj43w/LQBqY2ZUR+r5ng5wTSfjhEdV7ZQ8=;
        b=uX3wfL2MBBDdsEWwFN3dsGK6D4oeA9soLS4MCKItCrAar+mYqVKvKyzC26fCDQK/u6
         CRDhir2AHyklWxxet8sqm0N2fX2SlSGYcwp7VJ9W8wEG04oiE1xYtSC+gbpPeDmvJPUo
         rO104MowpDtdt7CEjA/5crCfpeb9kA/1Y26B2izHIZy0k+c9jhfOTef8JFB0AyaFmW6b
         Z/pW4bwMFG+HM9mK3vlAw3zMquh4scrgI7y5DUImqgPgvCUkoDeqd49WWWcHZ+W40Z/q
         NhzJtUsdGBb2f7pacI9WEndEbIpZEOiJwW8vmXewPLjXtGqo2jho5bpnfl4R2YcpM1oV
         Btvw==
X-Gm-Message-State: AOAM531fqmrlmurOzsU47SEBoUQDW/1AuorQqQLFo0SISHX1ppd7oH26
        PElfIpFhRjo3eYKM+2neJ603VQ==
X-Google-Smtp-Source: ABdhPJxSza4YTAHvrQmEe3o94FSosfOKLqFVTx3EseeNpvxzLFtyvsyQMNLyS8I4Tj4Yqe7BtrbYsA==
X-Received: by 2002:a7b:cb44:: with SMTP id v4mr26665661wmj.169.1628065578184;
        Wed, 04 Aug 2021 01:26:18 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id j6sm5060494wmq.29.2021.08.04.01.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 01:26:17 -0700 (PDT)
Date:   Wed, 4 Aug 2021 09:26:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Satya Tangirala <satyat@google.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v9 0/9] add support for direct I/O with fscrypt using
 blk-crypto
Message-ID: <YQpPJ8To7NN2AIuq@google.com>
References: <20210604210908.2105870-1-satyat@google.com>
 <CAF2Aj3h-Gt3bOxH4wXB7aeQ3jVzR3TEqd3uLsh4T9Q=e6W6iqQ@mail.gmail.com>
 <YPmFSw4JbWnIozSZ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YPmFSw4JbWnIozSZ@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 22 Jul 2021, Eric Biggers wrote:

> Hi Lee,
> 
> On Thu, Jul 22, 2021 at 12:23:47PM +0100, Lee Jones wrote:
> > 
> > No review after 7 weeks on the list.
> > 
> > Is there anything Satya can do to help expedite this please?
> > 
> 
> This series is basically ready, but I can't apply it because it depends on the
> other patch series
> "[PATCH v4 0/9] ensure bios aren't split in middle of crypto data unit"
> (https://lkml.kernel.org/linux-block/20210707052943.3960-1-satyaprateek2357@gmail.com/T/#u).
> I will be re-reviewing that other patch series soon, but it primary needs review
> by the people who work more regularly with the block layer, and it will have to
> go in through the block tree (I can't apply it to the fscrypt tree).
> 
> The original version of this series didn't require so many block layer changes,
> but it would have only allowed direct I/O with user buffer pointers aligned to
> the filesystem block size, which was too controversial with other filesystem
> developers; see the long discussion at
> https://lkml.kernel.org/linux-fscrypt/20200720233739.824943-1-satyat@google.com/T/#u.
> 
> In addition, it was requested that we not add features to the "legacy" direct
> I/O implementation (fs/direct-io.c), so I have a patch series in progress
> "[PATCH 0/9] f2fs: use iomap for direct I/O"
> (https://lkml.kernel.org/linux-f2fs-devel/20210716143919.44373-1-ebiggers@kernel.org/T/#u)
> which will change f2fs to use iomap.
> 
> Also please understand that Satya has left Google, so any further work from him
> on this is happening on a personal capacity in his free time.

Thanks for the update Eric.  I'll push this to the back of my queue
and check back with you at a later date.  Hopefully we see some
interest from the other maintainers sooner, rather than later.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
