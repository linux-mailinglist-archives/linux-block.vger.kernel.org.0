Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF5E3F3054
	for <lists+linux-block@lfdr.de>; Fri, 20 Aug 2021 17:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241359AbhHTP5K (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 20 Aug 2021 11:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241261AbhHTP5J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 11:57:09 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D4FC061756
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 08:56:31 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so7535352pjl.4
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C3a7vVBUf0KW7MXt4FnTeXqGlzkeA3TVHAyOaxNZlwQ=;
        b=mWy+dsfzuC4WR7e/bELnLc1DBewBd+6uqLCiUlPpSL/hR3JFjiFZGkc64dOnkcT9C9
         qDMRqhN9IlO5CQXHcgzIx3Y2JRqX6MsEMYyUkp08whfolpRdd2uxh73eqsjx32WZPMfY
         SPWC7Ec8QNUjnKmK0pksWV2GR2YpxIveB+TMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C3a7vVBUf0KW7MXt4FnTeXqGlzkeA3TVHAyOaxNZlwQ=;
        b=aSBi+S9Qv8ebx6H/zrhwi8Qw/ngzM6l3wuLxqXJ1whN4dGgM0sK70BLZl2CovRnMPC
         s262xFRe0MhxFyGONN5Nk8YHoJ8KQ2qM8YlD8QFf1f+R30mW1r+42HwdExYSwCIU91rV
         c/7SR8RKR/YisIGrFppPfojDlcNbKHERKUFwwEtALNDKohmgTNk5cUqhB4CJFG9VhuMK
         ggfbM0R84oGhJvkUqq4pAxfWLbNE/BMFVM7oJjcPtZ8wzuxuxcsU92O8NjEFqyxyiwfe
         R9pq33iakWTmds7SXcW990ZTxgWV6JTHZHwJveYXl5eLobu6mWkuQQJqh++2DlvdO5pN
         WD7g==
X-Gm-Message-State: AOAM530TOBCcEMbKdEnh8CJTouibnZJIw6MPP2eixivO/ER4OcP2ZqaJ
        7JqCi05EJrDddQkL9gLrjk+8HQ==
X-Google-Smtp-Source: ABdhPJyhg05jtv2sdt7XrLbWPk8JBbrR41kaovvHCcwZtOZ4P7Cf6Qg2VrCTEpx9+rp1igwyJ9xLVA==
X-Received: by 2002:a17:902:f704:b029:11a:cdee:490 with SMTP id h4-20020a170902f704b029011acdee0490mr17049722plo.37.1629474990741;
        Fri, 20 Aug 2021 08:56:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 21sm7304926pfh.103.2021.08.20.08.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 08:56:30 -0700 (PDT)
Date:   Fri, 20 Aug 2021 08:56:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 56/63] RDMA/mlx5: Use struct_group() to zero struct
 mlx5_ib_mr
Message-ID: <202108200856.E0E8711CB@keescook>
References: <20210818060533.3569517-1-keescook@chromium.org>
 <20210818060533.3569517-57-keescook@chromium.org>
 <20210819122716.GP543798@ziepe.ca>
 <202108190916.7CC455DA@keescook>
 <20210819164757.GS543798@ziepe.ca>
 <202108191106.1956C05A@keescook>
 <20210820123400.GW543798@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820123400.GW543798@ziepe.ca>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 20, 2021 at 09:34:00AM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 19, 2021 at 11:14:37AM -0700, Kees Cook wrote:
> 
> > Which do you mean? When doing the conversions I tended to opt for
> > struct_group() since it provides more robust "intentionality". Strictly
> > speaking, the new memset helpers are doing field-spanning writes, but the
> > "clear to the end" pattern was so common it made sense to add the helpers,
> > as they're a bit less disruptive. It's totally up to you! :)
> 
> Well, of the patches you cc'd to me only this one used the struct
> group..

Understood. I've adjusted this for v3. Thanks!

-- 
Kees Cook
