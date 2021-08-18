Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079783F0E80
	for <lists+linux-block@lfdr.de>; Thu, 19 Aug 2021 01:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhHRXHR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 18 Aug 2021 19:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbhHRXHR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 19:07:17 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22B6C06179A
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 16:06:41 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 17so3956646pgp.4
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 16:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6LXlTnktuLXOSEatHkAd9iidtx/DlqNXw6t+P+U3BQc=;
        b=QDNt5PHgo+7rFQ5/N15pMYx2nigmnDuCuJ+bOuvXfS72zqVl8vZRlj8bX+wFTjLeE1
         +cWdQw4DYXF54Bu3mpVNecT17rymK4/4HID0NO8YPAsOH71eiDyu8sN6XAFVcXLqPAMH
         GiSiCnGqiMI57DyQ0LAdNhljzGxXXxsfxTLco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6LXlTnktuLXOSEatHkAd9iidtx/DlqNXw6t+P+U3BQc=;
        b=jcVjzfkAjAG5Kp8JPk7OE+zQuZ0kh6ubd4GZChfrLsAAihM6oB+2zrn8uPukGkDAL5
         FoGc6JV0DUpDmEhmPz6haQVXNZNVbqY3v5/KpIKMSvKQy7dHr/cxoP08gJEgbgg9tEL4
         M2/+n0WRzGePV9B8EEXJDf6OOyNalIuCdbiYvSQBNujSb8jjpF7HAVWqelITf6XjcMep
         3+mJhH2L1fqME6++hizULdBnVuxOTj9hvrzwdDFUmQ/zLF2pTsvM5mt5N9HxzOTMpaVN
         1aVzsxfFgQ2PkZhnl260p7RKYvpcLzPHPiUsJ365W65Y/9x67qAhUciW4/Q7TVCmq2dy
         SZ+w==
X-Gm-Message-State: AOAM530XNEc+xHNnIyr7wIVThCpiBUA4gho7LiCYnsX7CFjrwtMv2zoF
        gmMoIVfz6Tq8eJvOliZV4C2j+g==
X-Google-Smtp-Source: ABdhPJyUYId4jZehTEC5dWKrbyuUEowd9b0WCT527H1rHej12/Bkc/D16VHqxCGKKKhtIhB0IMVa/w==
X-Received: by 2002:aa7:8242:0:b0:3e2:97eb:d6e8 with SMTP id e2-20020aa78242000000b003e297ebd6e8mr9677080pfn.66.1629328001407;
        Wed, 18 Aug 2021 16:06:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 143sm916287pfz.13.2021.08.18.16.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:06:40 -0700 (PDT)
Date:   Wed, 18 Aug 2021 16:06:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 53/63] KVM: x86: Use struct_group() to zero decode
 cache
Message-ID: <202108181605.44C504C@keescook>
References: <20210818060533.3569517-1-keescook@chromium.org>
 <20210818060533.3569517-54-keescook@chromium.org>
 <YR0jIEzEcUom/7rd@google.com>
 <202108180922.6C9E385A1@keescook>
 <YR2PhlO3njPcFOkg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR2PhlO3njPcFOkg@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 18, 2021 at 10:53:58PM +0000, Sean Christopherson wrote:
> On Wed, Aug 18, 2021, Kees Cook wrote:
> > On Wed, Aug 18, 2021 at 03:11:28PM +0000, Sean Christopherson wrote:
> > > From dbdca1f4cd01fee418c252e54c360d518b2b1ad6 Mon Sep 17 00:00:00 2001
> > > From: Sean Christopherson <seanjc@google.com>
> > > Date: Wed, 18 Aug 2021 08:03:08 -0700
> > > Subject: [PATCH] KVM: x86: Replace memset() "optimization" with normal
> > >  per-field writes
> > > 
> > > Explicitly zero select fields in the emulator's decode cache instead of
> > > zeroing the fields via a gross memset() that spans six fields.  gcc and
> > > clang are both clever enough to batch the first five fields into a single
> > > quadword MOV, i.e. memset() and individually zeroing generate identical
> > > code.
> > > 
> > > Removing the wart also prepares KVM for FORTIFY_SOURCE performing
> > > compile-time and run-time field bounds checking for memset().
> > > 
> > > No functional change intended.
> > > 
> > > Reported-by: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > Do you want me to take this patch into my tree, or do you want to carry
> > it for KVM directly?
> 
> That's a Paolo question :-)
> 
> What's the expected timeframe for landing stricter bounds checking?  If it's
> 5.16 or later, the easiest thing would be to squeak this into 5.15.

I'm hoping to land all the "compile time" stuff for 5.15, but
realistically, some portions may not get there. I'll just carry this
patch for now and if we need to swap trees we can do that. :)

Thanks!

-Kees

-- 
Kees Cook
