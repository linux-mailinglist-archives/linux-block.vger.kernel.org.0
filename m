Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E800175D58
	for <lists+linux-block@lfdr.de>; Mon,  2 Mar 2020 15:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgCBOh4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 2 Mar 2020 09:37:56 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40470 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgCBOhx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Mar 2020 09:37:53 -0500
Received: by mail-io1-f65.google.com with SMTP id m22so5375213ioj.7
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2020 06:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fmChl07tCnnnsdQkbYOcsmPILzyShLh33qBmgjXyxkA=;
        b=jWhtjW8byNV5i6zYn7TLRszuxZRXo+KsJDCRQNqMJxy4mxFW6SnjBqFPbllWCdiz1Z
         vSZtoEf4aWL9hhjLep45IC4+bNTaq9pt5eKC+7nuCeFX4LdBjvaVVZYOKBto5dDPmc+T
         ApyO6v+VFuYhFl9pSTY5dcurg8VNvxgwjDPcQQzBC3ydlusa+PlxEggxirhemmvaspww
         fJvqe0xyjFt8IX75KsbYqUodLnB1+D7tUCfuLt7iLqbBoM1gvEDYAArmW/dIVo6votI7
         onnLTrXtd0ivQoMl0j1nvFrpMKbS4PY52CbGZ5FhNEgTkJ5KFzYSyzINWwRgMG06rjZi
         mncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fmChl07tCnnnsdQkbYOcsmPILzyShLh33qBmgjXyxkA=;
        b=uTHI0PTwBAnWc684jK5p7EQ/IjiPbhxnov2AkpPxZEKd88gIjhi9562XRBU4FleUYn
         brr7U8W2ivRhfnugzV7A0RAotmT77/5KRQOwTXeM1qkXfvlLHROhsxlCz8I52PKEj2zy
         z+zXMzi+yIPeDmNzFQDGi2BZRtJ3qvuUmfJQn9CbDwErSE/OCSEwPdY8b6o1OD20pBwN
         n3eg9OGzYtMC3QBt9Tl5spFOUMv4oSQZz3w+muQidcXcpeBtSjcIDX3uiZufylWgsaJy
         ZeBFa55F4Opxf3Vr+YPmxO/TExVZvkR+4VOjVrvcFvJPc6I5NOuOdsB0YUrsUeD1XXn6
         eJLw==
X-Gm-Message-State: APjAAAUv551Y9Kd0fpcKnlxcYBXh7iugB6mufkCfxphJUhbZQhY6gCHB
        NXNmdmproOHuLa/36Bj3eftCloJSIs/eqc4BTHmFT/l3
X-Google-Smtp-Source: APXvYqwpTrVreRlhOJstucnPx7hIH1xJIKArYs7wGfkg+h8SN/KzbOrQMY8TYI6vLJO0hKUh/OE4DxkfB83yk2X5bx4=
X-Received: by 2002:a6b:5a06:: with SMTP id o6mr12550360iob.54.1583159871960;
 Mon, 02 Mar 2020 06:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-2-jinpuwang@gmail.com>
 <8131773d-cf6e-9c1d-faad-a250f7135432@acm.org>
In-Reply-To: <8131773d-cf6e-9c1d-faad-a250f7135432@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 15:37:41 +0100
Message-ID: <CAMGffEn5tPDCsGZNMO9wZE6RGJ+VKM4mTp4ynjW13CKrv+Fh3Q@mail.gmail.com>
Subject: Re: [PATCH v9 01/25] sysfs: export sysfs_remove_file_self()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>,
        Roman Pen <roman.penyaev@profitbricks.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 1, 2020 at 1:24 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:46, Jack Wang wrote:
> > Function is going to be used in transport over RDMA module
> > in subsequent patches, so export it to GPL modules.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Thanks Bart!
