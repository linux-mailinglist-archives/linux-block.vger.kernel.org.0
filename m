Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC3E13CDCE
	for <lists+linux-block@lfdr.de>; Wed, 15 Jan 2020 21:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgAOUKz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Jan 2020 15:10:55 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35002 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbgAOUKy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 15:10:54 -0500
Received: by mail-lf1-f67.google.com with SMTP id 15so13742941lfr.2
        for <linux-block@vger.kernel.org>; Wed, 15 Jan 2020 12:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V37Vo/FBhU5kltccCSOcOaOV/u6sTU75u7lgAerRHWk=;
        b=OrYEwmU6lkXsGZWCHNNhtVtpsE6fs3wEj0m6dC3WrtWTeidQt6E9H+zSvKowaPh1ec
         ugRczy3F4djq+5tAM9KSePUrrGy8RTZj+3Nsfw0drc5nlDq0wGY+b9DTqALVC2112QUl
         PU4s1hiA953qkOxsAyvqyWsjNb5gpuGJJ8PeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V37Vo/FBhU5kltccCSOcOaOV/u6sTU75u7lgAerRHWk=;
        b=cn+k7Mas97C+np3VCOCR6XYJRJvvXJsVe1+JptozXt8xWXSUrXAVITv9TWT0I8/Rab
         Z6YQ48y9QsZtwEAOskJEelQWvT+83sPMaoG+8ehRXrbtmOlhfFefBBfI8mdEizP2l1nZ
         3mxJyzMnD9PMpbqRxjnfGMltKcZoIJ3Ybbm6bu2Y8K2iwOZOrwrCN3VEUy1x9J6vqTEp
         5ePtxwdItL8TaPVQybwNon5u89DRW/XWQB3N+mAqu+cqnvNEXUy1AQ/fRJJnZnpMPYgD
         fNtASIiLi8Bcft8jPxGiymn5oZUxvz5BRIpdXPxUv8opuG5m24hkIlBC0aWGt8ArQhl0
         NFSw==
X-Gm-Message-State: APjAAAUyq1NCP85mrk9lUKvu0YDkWsLALi8o1wDvy9ea2FIUQVRF9/Na
        B/wxfmrnoJRkvg86NhhdGExuKTaXNdk=
X-Google-Smtp-Source: APXvYqxR++wUApb6NUxnn2ryntn2FUDTQ13kVKlSwroM6j+uIM1KvnJOdpkd5ZK/sHB1G8BH8n8S4Q==
X-Received: by 2002:a19:a408:: with SMTP id q8mr378139lfc.174.1579119051361;
        Wed, 15 Jan 2020 12:10:51 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id w71sm11240782lff.0.2020.01.15.12.10.48
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 12:10:49 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id a13so19961484ljm.10
        for <linux-block@vger.kernel.org>; Wed, 15 Jan 2020 12:10:48 -0800 (PST)
X-Received: by 2002:a2e:990e:: with SMTP id v14mr74215lji.23.1579119048131;
 Wed, 15 Jan 2020 12:10:48 -0800 (PST)
MIME-Version: 1.0
References: <157909503552.20155.3030058841911628518.stgit@warthog.procyon.org.uk>
In-Reply-To: <157909503552.20155.3030058841911628518.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jan 2020 12:10:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjrrOgznCy3yUmcmQY1z_7vXVr6GbvKiy8cLvWbxpmzcw@mail.gmail.com>
Message-ID: <CAHk-=wjrrOgznCy3yUmcmQY1z_7vXVr6GbvKiy8cLvWbxpmzcw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] pipe: Keyrings, Block and USB notifications
 [ver #3]
To:     David Howells <dhowells@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So I no longer hate the implementation, but I do want to see the
actual user space users come out of the woodwork and try this out for
their use cases.

I'd hate to see a new event queue interface that people then can't
really use due to it not fulfilling their needs, or can't use for some
other reason.

We've had a fair number of kernel interfaces that ended up not being
used all that much, but had one or two minor users and ended up being
nasty long-term maintenance issues.. I don't want this to become yet
another such one.

                 Linus
