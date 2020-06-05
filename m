Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F53B1EFC19
	for <lists+linux-block@lfdr.de>; Fri,  5 Jun 2020 17:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgFEPDx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 5 Jun 2020 11:03:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41513 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgFEPDx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Jun 2020 11:03:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id r10so5227621pgv.8
        for <linux-block@vger.kernel.org>; Fri, 05 Jun 2020 08:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XYI5ojK1iaeagKwYHcWarrnc1EKuH2ivkquvOp4gBGg=;
        b=ALrdg9EfMVgxnv/ITcBuX1X0OrHLmtpRVWr+OEcca08wxyR/UGyyn7MkNo6Wkr6B5Z
         FFJWiRkhqOvIIm3sk5TUByjucCuuhKCDqiQLbmEso3ASAndCchKYekb74/kEemVZzuKG
         rcqvkcFLAu3RZEHTDzgBIIrRMMUlLvg9c8oxsZwBvDaG33ScfX6v6iUa8zUd0D1PNOCx
         pJDm1N7ZRUeaNJEFir5yjcwtBtquNtQbOY2s1EjOgQSgjlf4L8uijqshxTkX5uMMs7yL
         c82uImDxjCSfwubx1AoGpm6A9qARVgDaMXrivIKWrdb4JGxGLjc4S37HHI1cPOCkuGfy
         BEVg==
X-Gm-Message-State: AOAM5336N1gajncalmpPYTUM3Y8biRNoDIw0ecbORF+uyYSnK8sq98ic
        K+kOY8w2qgrw86Omm8mJfaA=
X-Google-Smtp-Source: ABdhPJyVOjKOSDrQnqmY6OHA7bMdUkocFte2AzveNPUDs+IKtjh6MqlioAOgcT3Fw7YstiDUO8Palg==
X-Received: by 2002:a63:1718:: with SMTP id x24mr9583537pgl.72.1591369432704;
        Fri, 05 Jun 2020 08:03:52 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id k101sm9099825pjb.26.2020.06.05.08.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 08:03:51 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D24B0403AB; Fri,  5 Jun 2020 15:03:50 +0000 (UTC)
Date:   Fri, 5 Jun 2020 15:03:50 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2 v3] blktrace: Fix sparse annotations and warn if
 enabling multiple traces
Message-ID: <20200605150350.GM11244@42.do-not-panic.com>
References: <20200605145349.18454-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605145349.18454-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 05, 2020 at 04:58:35PM +0200, Jan Kara wrote:
> Hello Jens,
> 
> this series contains a patch from Luis' blktrace series and then my patch
> to fix sparse warnings in blktrace. Luis' patch stands on its own, was
> reviewed, and changes what I need to change as well so I've decided it's just
> simplest to pull it in with my patch.

Hey Jan,

Since these patches have contexts which can affect other patches in the
series of fixes I have, if possible I'd prefer if these get addressed in
order. I was just waiting for 0-day to finish grinding on the series.
I already have a successful build results, but just waiting on the
series of other tests, part of which include blktests.

If this is agreeable, I hope to post that series later today.

  Luis
