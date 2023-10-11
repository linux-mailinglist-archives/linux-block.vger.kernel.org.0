Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4037C5EB7
	for <lists+linux-block@lfdr.de>; Wed, 11 Oct 2023 22:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjJKUvV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Oct 2023 16:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbjJKUvU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2023 16:51:20 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE17C90
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 13:50:31 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-66d12b3b479so929626d6.1
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 13:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697057431; x=1697662231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxitJBHCJQdxtXEDgm6njCHvQtKMi09+y/v+pbWOwa8=;
        b=NeeE3bmqN7XH7FM8GDomawgr21zYnCEk8zZhO7xW2JjN5UvFD1IHARKndtsn++1TNm
         0buj9nwD/9ox5YZsWTFdm7dZCtGoUNI14qrQvWZEu6nRtYsYL3sz+8/GLkJw44Y3Ky2s
         89zzywgX+e3Hg4kVER6IPdgKBk2QWYaJsf3z6LjNOvHHgBFKVD2G7Ta9sD7foZio2mT+
         kDpX3R2nwCWzM0y7NwMcdF8PAGQ4dzheb8oGqTsWDNtP77/wduIZ0EqbPX8eFWCibzrj
         QTM07z8R8eoO5IlyQ2esbX/g9Q0Sm68OtUd7h4/rviQXjr+m11LrbCUrMgiHCFGEEK2H
         UWuA==
X-Gm-Message-State: AOJu0YyRz0R1oV3szLnXRYRHk1606sAwVw2rCMcyJ9QebKpbTDBfBtZk
        t93SO1KSGN8wJiwd1SGx2Cei8hBS3qPnu0yAIw==
X-Google-Smtp-Source: AGHT+IEPs1rkK6QoPv6JwQx1Izxget+/aeE937zAia+e+WpczjixBU7iH+92tXrTfK7ySbtA2Cgb4A==
X-Received: by 2002:a05:6214:43ca:b0:64f:5261:55e9 with SMTP id oi10-20020a05621443ca00b0064f526155e9mr26910718qvb.41.1697057430888;
        Wed, 11 Oct 2023 13:50:30 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id 24-20020a05620a06d800b00774830b40d4sm5474922qky.47.2023.10.11.13.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 13:50:30 -0700 (PDT)
Date:   Wed, 11 Oct 2023 16:50:29 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        stable@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: block: Don't invalidate pagecache for invalid falloc modes
Message-ID: <ZScKlejOlxIXYmWI@redhat.com>
References: <20231011201230.750105-1-sarthakkukreti@chromium.org>
 <b068c2ef-5de3-44fb-a55d-2cbe5a7f1158@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b068c2ef-5de3-44fb-a55d-2cbe5a7f1158@kernel.dk>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 11 2023 at  4:20P -0400,
Jens Axboe <axboe@kernel.dk> wrote:

> On 10/11/23 2:12 PM, Sarthak Kukreti wrote:
> > Only call truncate_bdev_range() if the fallocate mode is
> > supported. This fixes a bug where data in the pagecache
> > could be invalidated if the fallocate() was called on the
> > block device with an invalid mode.
> 
> Fix looks fine, but would be nicer if we didn't have to duplicate the
> truncate_bdev_range() in each switch clause. Can we check this upfront
> instead?

No, if you look at the function (rather than just the patch in
isolation) we need to make the call for each case rather than collapse
to a single call at the front (that's the reason for this fix, because
otherwise the default: error case will invalidate the page cache too).

Just so you're aware, I also had this feedback that shaped the patch a
bit back in April:
https://listman.redhat.com/archives/dm-devel/2023-April/053986.html

> Also, please wrap commit messages at 72-74 chars.

Not seeing where the header should be wrapped.  You referring to the
Fixes: line?  I've never seen those wrapped.

Mike
