Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E42B3F2C2C
	for <lists+linux-block@lfdr.de>; Fri, 20 Aug 2021 14:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240458AbhHTMel (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 20 Aug 2021 08:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbhHTMek (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 08:34:40 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75449C061575
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 05:34:02 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id e18so452507qvo.1
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 05:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FxHzHqYkZIYKuBII5yJmxkfX68sHHNA5VrSWbqQXyKE=;
        b=LKWHjCeNEUlwo8stybqJCnXzWMQM7x0bGZxSQUSvDEzvNf1rR/5NIRBxcsq8j+/O1Q
         n0nUB2SGq4I944/SzVA06PgpS5TZJLAeuT0eHnupeq9B+6Ke4eApnMJzh0PSSn3USY22
         DCevWLZt6mnoLjPVwnT/B6qIy3u8gu6R9V0eYF2w1BUAXn85ddRUOkrnCFaTavga7CyB
         OHwKCMDxBA7mQeV8i9u/U1itYCfjgHgpthcASaDTqWMWWREFiEjUsvbxUeQR41p24/42
         cXB4sxzSr+JXUbmuhE4oft2wqIs67/Ai41z+4L6PkD8HA2B/GtZI5tt/EczYHI2wefxZ
         10cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FxHzHqYkZIYKuBII5yJmxkfX68sHHNA5VrSWbqQXyKE=;
        b=WwfwzqgnZ5LD9W2MfjsLcDSxzio9DML3r7K5t5SmiBo+E29gnwL9YGuxk9DU9PdzUs
         6gN6FxrdGU5snm2dt6E+NB4zgHgcbaxbUMpTzp7JJan9bKYsdJYhXHStly3x710Hw7IQ
         aYVV/lwH8ctCfNWhOzpfvgDM0eHJ91+ymEzhetQCbQPUnMRErVakspeWgLFnd8MOyev8
         M4oxL1sfdiuIY5t1qGcG93YsL3fOs85LrMXqVCTdBAiTDPcoNRY+jqAvRPymo2UZePN/
         dx3KXmBa22N3gJqpjzi5T2bsVpl9Jru8rA1V7w5a9Qcsg8Y6zSGJiQ9SV9FPVTLijnm5
         uR+Q==
X-Gm-Message-State: AOAM533xewH/EjSVDX8naNQ8rqYuInluIrmmGvJO47uGetMsACvuNiN+
        YnBv2Qu6A8La/HscrE24q7dSRQ==
X-Google-Smtp-Source: ABdhPJwGEOvhoU1c/BkmKt9S+cy9PyrWCoEZ7eevTf7BK/BVeVCzTaDTUl3qnqghNI/H9rEss9GPTg==
X-Received: by 2002:a0c:d6cd:: with SMTP id l13mr1047928qvi.24.1629462841673;
        Fri, 20 Aug 2021 05:34:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id 69sm3472288qke.55.2021.08.20.05.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 05:34:01 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mH3ii-001q0s-MH; Fri, 20 Aug 2021 09:34:00 -0300
Date:   Fri, 20 Aug 2021 09:34:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kees Cook <keescook@chromium.org>
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
Message-ID: <20210820123400.GW543798@ziepe.ca>
References: <20210818060533.3569517-1-keescook@chromium.org>
 <20210818060533.3569517-57-keescook@chromium.org>
 <20210819122716.GP543798@ziepe.ca>
 <202108190916.7CC455DA@keescook>
 <20210819164757.GS543798@ziepe.ca>
 <202108191106.1956C05A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108191106.1956C05A@keescook>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 19, 2021 at 11:14:37AM -0700, Kees Cook wrote:

> Which do you mean? When doing the conversions I tended to opt for
> struct_group() since it provides more robust "intentionality". Strictly
> speaking, the new memset helpers are doing field-spanning writes, but the
> "clear to the end" pattern was so common it made sense to add the helpers,
> as they're a bit less disruptive. It's totally up to you! :)

Well, of the patches you cc'd to me only this one used the struct
group..

Jason 
