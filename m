Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB0BB5322
	for <lists+linux-block@lfdr.de>; Tue, 17 Sep 2019 18:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfIQQgV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Sep 2019 12:36:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51216 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbfIQQgV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 12:36:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so4314339wme.1
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 09:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZ5ZTEmaTIYuHEPVaWnnIRDnM1ExQsI9I+rDX1pKJz8=;
        b=GK/UJUraSZrbI1Lrp0bAU5iDgY0SxP7ZBolbRWrNz0P64V7oibEZuEsHfPeEk7Q9rp
         xhKWgfwpDAv9qYOVv6Lu65MVkEs9ocMl4F8rzRMcf4TAMZXseKp5mUfkpdh52L+D24fd
         Zw3UoMsuMTG1cFp2itr1rAVedM4yrpQicL+poeScKS4ldGYiEciH3AdcO38PP7cVzQ0p
         Mf8KYDaR+d/5Lc91n2Q5RZF3NnYoEVuQQkGAS7Sl3VZcMwR5VjQ531kNfvT/JqP3T2P/
         DpiF1/Oeke/GK4IBiRrKuJR3aRd3fnYslFM2HN5xTwAO/PwnU3hattLWrkS+zPAbdC40
         Ax9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZ5ZTEmaTIYuHEPVaWnnIRDnM1ExQsI9I+rDX1pKJz8=;
        b=TTAXdrGZNFIUEEjKhu22C3WrXBS9GzajDDmtnaWywTVPc+kQZr5GxasA9BMz+n2l14
         07JztCHQErQGqi158K7gkcsNMFFNqEb5cFQhZ+Eid2wsChjU8zQze/Aaqz60n53JN2ce
         q9Vi6wIAf0IC9UT6BKx53KE7tRcy6OIghF7pBevtq4QX48T6gbyRRPRRCySC6Hq+Ilnd
         8xW7qesKp5RfJ6Mb6UNSnmBBG7b+gyEfxFQ7CUQQuJ2XUpP5qoEY0gH8i6cPzwYViXQB
         7XnO2RgejVy0p4qz3c/XcKc+mmQKBcZHjNH36FcTnHUckW8lgbaGjxZvxTL6AXEXvmL+
         lzww==
X-Gm-Message-State: APjAAAWIs0D32amtVEKxuAKpDNkvzJl1XCAJnzKg7YXCu9vpxtRyJ1In
        AM3nouE6rh/5Y9ElahYwUwPBffpdObMm9/VRBMlD2A==
X-Google-Smtp-Source: APXvYqxbdK26SIM0+biFH4klJsQGXwbZHmXVpxC2DveOR4YNrg/laGGIb5lVHSsJE4/ZW9VCG2Bm4wm72MQy8yubuPw=
X-Received: by 2002:a1c:4485:: with SMTP id r127mr4048388wma.59.1568738179087;
 Tue, 17 Sep 2019 09:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-17-jinpuwang@gmail.com>
 <7d11d903-7826-8c1a-bef8-74ea4cf5f340@acm.org>
In-Reply-To: <7d11d903-7826-8c1a-bef8-74ea4cf5f340@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 17 Sep 2019 18:36:08 +0200
Message-ID: <CAMGffEmZdqJ2Nw1KX=DirMp4e89i-G4ut24qNSVYRy0eG=v8sg@mail.gmail.com>
Subject: Re: [PATCH v4 16/25] ibnbd: client: private header with client
 structs and functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Sep 14, 2019 at 12:25 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 6/20/19 8:03 AM, Jack Wang wrote:
> > +     char                    pathname[NAME_MAX];
> [ ... ]
>  > +    char                    blk_symlink_name[NAME_MAX];
>
> Please allocate path names dynamically instead of hard-coding the upper
> length for a path.
>
> Bart.
Hi Bart,

ok,  will dynamically allocate the path and blk_symlink_name as you suggested.

Thank you
Jinpu

--
Jack Wang
