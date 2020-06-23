Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16EE20523D
	for <lists+linux-block@lfdr.de>; Tue, 23 Jun 2020 14:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbgFWMRZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Jun 2020 08:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732579AbgFWMRX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 08:17:23 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DACC061795
        for <linux-block@vger.kernel.org>; Tue, 23 Jun 2020 05:17:23 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v19so12690919qtq.10
        for <linux-block@vger.kernel.org>; Tue, 23 Jun 2020 05:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JQks5GACh6h541Q4/8Hm5GmMAEZUeSD84PZv2UopM/E=;
        b=RcxTddjfivtvB0c2KkiouO8M3/NGfoDAq3NPrsye30sgY8dXjoA1iY3Pahy3rz+yxl
         /FaqkWMOaH2mLilfoiOpON9yMjHZP9qMpEspz72HPCQ9Fsy5GpXESQjDwcSJmYyA3G8z
         fdRxhBOZIQqYUOCBsa+bMK1w788G9i1vnJ+fLDaT6y4K/K56hAypHtluBzexm6z3Xwf3
         NGRsQ0G+sgodVXs4liklYhgpQfbS1txItvV/KdRicsvDf5YA1rgkeb2WY3pX5JmFvhSI
         BRpiK0LAGVtkvRxYXL1J1wTyVhBr6zaOiTOSPl5GryNECC9LjrmInXYRr+C48n1GfoAr
         cwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JQks5GACh6h541Q4/8Hm5GmMAEZUeSD84PZv2UopM/E=;
        b=T2bygRCgf5pAj/KJx7kRCYfTIhaLiN/iZcp6RgYGDw0+/FLNqBy3KaWcSmG27doXil
         jHtJ95HCwzRkzVAR0h1xMHO16hxoLvUCs1X4uHjyne7XxLbGWb//ivgiCyPB4nFvH8UY
         /s2k//SalDmMvQUYLzHwLs5fOk5pVQaG86Au7OrbltYXmFChVFHY4Z2aDFBAl9qPxnth
         ug9MoJxH00STYFYbFh8K90b9oPkh59NNUTz/01sXHWZoDqEO+69P99CtBCvmdt+SJGDW
         qOH34Ci9J9M7H1XqfGttxApz9rzvieprzEgO2cZapXLvjS89gI1MyaHNyvgNM9U6Vb69
         jptQ==
X-Gm-Message-State: AOAM530HsmAH6Z4WBKrhM1hNGq+mauMWacPAxArB2EBFeDff1c/fh8/5
        jt++9+ec1jEeRI3xADQPe4Qz7A==
X-Google-Smtp-Source: ABdhPJxpvHZg05zq1sHVCRcAfBK2AS4+Yo42wJ5elF26d9x1yYHzPS6gha1KxMvEO9Vc8ehpziFWoQ==
X-Received: by 2002:ac8:7182:: with SMTP id w2mr21482791qto.115.1592914643025;
        Tue, 23 Jun 2020 05:17:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id v45sm437419qtv.47.2020.06.23.05.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 05:17:21 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jnhrd-00CUHe-5g; Tue, 23 Jun 2020 09:17:21 -0300
Date:   Tue, 23 Jun 2020 09:17:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Haris Iqbal <haris.iqbal@cloud.ionos.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>, dledford@redhat.com,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH] Delay the initialization of rnbd_server module to
 late_initcall level
Message-ID: <20200623121721.GZ6578@ziepe.ca>
References: <20200617103732.10356-1-haris.iqbal@cloud.ionos.com>
 <20200617112811.GL2383158@unreal>
 <20200617182046.GI6578@ziepe.ca>
 <20200617190756.GA2721989@unreal>
 <20200617192642.GL6578@ziepe.ca>
 <CAJpMwygeJ7uaNUKxhsF-bx=ufchkx7M6G0E237=-0C7GwJ3yog@mail.gmail.com>
 <CAJpMwyjJSu4exkTAoFLhY-ubzNQLp6nWqq83k6vWn1Uw3eaK_Q@mail.gmail.com>
 <CAJpMwygqz20=H7ovSL0nSWLbVpMv-KLOgYO=nRCLv==OC8sgHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpMwygqz20=H7ovSL0nSWLbVpMv-KLOgYO=nRCLv==OC8sgHw@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 23, 2020 at 03:20:27PM +0530, Haris Iqbal wrote:
> Hi Jason and Leon,
> 
> Did you get a chance to look into my previous email?

Was there a question?

Jason
