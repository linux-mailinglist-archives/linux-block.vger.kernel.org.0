Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2DB5B8772
	for <lists+linux-block@lfdr.de>; Wed, 14 Sep 2022 13:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiINLq7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 14 Sep 2022 07:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiINLq6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2022 07:46:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532DA7A530
        for <linux-block@vger.kernel.org>; Wed, 14 Sep 2022 04:46:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h8so18288574wrf.3
        for <linux-block@vger.kernel.org>; Wed, 14 Sep 2022 04:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=R0+X/Vt8U/YJmmqx4EaockLsNUJKMLE86zCLujidRXk=;
        b=x896VLq/0T8z+7Ik2gVEyES3l8Hvh2btFLNkRDkyFPILpk8pTXgwHjASSECXNYjAWz
         /4nzKNwpCXNTkvMp3wIXm+yfyMEvJgbc0MMk3D9eqte3BBV33uNDi2zp5DN9H7jUKXIY
         QXvEQyfRrTQbfi9CRmk38OQyufCqNJxtBsi780ZltRwyVkT9bfkauohtiuVyIg+158uh
         +dFEzwIdSyjmXHrCx/K924lHgmJPmWJYLsCwaV9AGTR61qVUxaiMSZ2OhTc/JpkYvAPH
         4lWJuFbIHC8bixWnUFa+49kysfkp6O/h1VUzL+fvL4Iut0DY7EPkgG7OYYgpkJLQBkQf
         Dppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=R0+X/Vt8U/YJmmqx4EaockLsNUJKMLE86zCLujidRXk=;
        b=Zg0ue9LGZF6fH/OLtYqG3LkWtjm2Tmr28eZtcCyyz0dG6NFSXBRpMfba/Pspriyslo
         CI4QXS6yHTXg4JkcmDf/ct1Ki9BLK0bnC7geLAWSeZ+3tgJtbR86tTECQ2GU3iI4B+AB
         Ju+VmABTov6Vw4LLL56kJMLhk4BUeqvAQE+kweD7ZmmlvfieYjoN/ADDELj5/u+TQ95Q
         CAHlQ/gjgRKhHw6yyCujKt6+FcTGkGqOsch4CBk225bmAB6rWKm93tC+LxjuovnA2ZA6
         b6AKHNpv8M2J+XA5t8RJVqikIYSiCWZMf1nFXbsmgHEQuLmkXVKrrO87bi4Ge9K6Rxk1
         lA7w==
X-Gm-Message-State: ACgBeo3vzrlO0QvgLQVMAuy+I37p2rM9lfXXLA5QDK1kGE/aP8iGsH/m
        N1WusA9qSWAOGAqhgIbcnC50hg==
X-Google-Smtp-Source: AA6agR5rGXGDLe/tOLWmuZc+R9A3yuqUfg5LeZ1FohTf0HB09NHH8ytKek+mH6dzb5U83k4gaIwQ1A==
X-Received: by 2002:a5d:47aa:0:b0:226:dbf6:680c with SMTP id 10-20020a5d47aa000000b00226dbf6680cmr21226454wrb.581.1663156014968;
        Wed, 14 Sep 2022 04:46:54 -0700 (PDT)
Received: from localhost ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id y25-20020a05600c365900b003b483000583sm11359663wmq.48.2022.09.14.04.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:46:54 -0700 (PDT)
Date:   Wed, 14 Sep 2022 12:46:54 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/5] btrfs: add manual PSI accounting for compressed reads
Message-ID: <YyG/LlF7TbdHSCsm@cmpxchg.org>
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910065058.3303831-4-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Sep 10, 2022 at 08:50:56AM +0200, Christoph Hellwig wrote:
> btrfs compressed reads try to always read the entire compressed chunk,
> even if only a subset is requested.  Currently this is covered by the
> magic PSI accounting underneath submit_bio, but that is about to go
> away. Instead add manual psi_memstall_{enter,leave} annotations.
> 
> Note that for readahead this really should be using readahead_expand,
> but the additionals reads are also done for plain ->read_folio where
> readahead_expand can't work, so this overall logic is left as-is for
> now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
