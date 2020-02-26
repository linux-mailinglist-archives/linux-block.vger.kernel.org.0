Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69117170688
	for <lists+linux-block@lfdr.de>; Wed, 26 Feb 2020 18:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgBZRt0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 26 Feb 2020 12:49:26 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46018 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBZRtZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Feb 2020 12:49:25 -0500
Received: by mail-lf1-f67.google.com with SMTP id z5so2624551lfd.12
        for <linux-block@vger.kernel.org>; Wed, 26 Feb 2020 09:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fRPyRG8072H5Sezzifc28IJW7If3nwtOvcWNfr1pDDA=;
        b=gEFNGuVmVn91+YXMWkxUV4UPweNXXNVgT2p0ldNq/8U48hI3364GWZz73CaeFrYqc8
         m9Me3shfjZOZ39oT0shjaLQkxPYGCUxRVGlIt76FN1l8alqzJdr0d6sYPaMUCOnky0jt
         Fla7VGcoyd50aCqSPSUaAn/xh0wlIAFjVGW4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRPyRG8072H5Sezzifc28IJW7If3nwtOvcWNfr1pDDA=;
        b=U+pf+mTIa58PPcsznNaCYpx+0bEvfXGnayxONQKvOLYAofiax0zc+ZjJuV116kreld
         LrHNo1xCKuzN7WrviskidVayFHK8IySneOx6TgKMb1NyJJb+ONEQ3sdH0QV1PqqKcvPa
         CyjaN3MQtb13UV1cKXD0PHtAskRnqgsey+NL1G+Xf8api4FXM8P2Pn3YDAa/TiHCR7tR
         epNU2eZi8LV0snOvURgs/QSfKY9PYzWyeLMXRczzP4xVhaGd8DU7AVAwGB5nOxkUvZAw
         L8a6aaSv9wPcudB+j6n/wFp8CgD3JYwuKhtFjzqfm4gHQzggGaLyeNSpmYIKCS7/OidK
         lzhw==
X-Gm-Message-State: APjAAAXF9AGSOJpNlx+4TLcvkz+PIHmyVULFMMvgsGUWHf5Msc1I8FPQ
        yDus0fmfGs5JODJc+DyKLpP5vgY1W+s=
X-Google-Smtp-Source: APXvYqwvfy9e5LBxF6WXZvX9Z3LYDHUFmFu/kLN1zrl4TTPgwU9zm7oUMy9m4FmscRPN0PzqZ2FDaA==
X-Received: by 2002:a05:6512:108a:: with SMTP id j10mr911911lfg.35.1582739363358;
        Wed, 26 Feb 2020 09:49:23 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id s22sm1621651ljm.41.2020.02.26.09.49.21
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 09:49:21 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id b15so2659238lfc.4
        for <linux-block@vger.kernel.org>; Wed, 26 Feb 2020 09:49:21 -0800 (PST)
X-Received: by 2002:ac2:58ec:: with SMTP id v12mr3099702lfo.31.1582739361104;
 Wed, 26 Feb 2020 09:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20200224212352.8640-1-w@1wt.eu> <0f5effb1-b228-dd00-05bc-de5801ce4626@linux.com>
In-Reply-To: <0f5effb1-b228-dd00-05bc-de5801ce4626@linux.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Feb 2020 09:49:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whd_Wpi1-TGcooUTE+z-Z-f32n2vFQANszvAou_Fopvzw@mail.gmail.com>
Message-ID: <CAHk-=whd_Wpi1-TGcooUTE+z-Z-f32n2vFQANszvAou_Fopvzw@mail.gmail.com>
Subject: Re: [PATCH 00/10] floppy driver cleanups (deobfuscation)
To:     Denis Efremov <efremov@linux.com>
Cc:     Willy Tarreau <w@1wt.eu>, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 26, 2020 at 6:57 AM Denis Efremov <efremov@linux.com> wrote:
>
> If Linus has no objections (regarding his review) I would prefer to
> accept 1-10 patches rather to resend them again. They seems complete
> to me as the first step.

I have no objections, and the patches 11-16 seem to have addressed all
my "I wish.." concerns too (except for the "we should rewrite or
sunset the driver entirely"). Looks fine to me.

                Linus
