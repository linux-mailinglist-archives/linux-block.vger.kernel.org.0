Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95D61148FD1
	for <lists+linux-block@lfdr.de>; Fri, 24 Jan 2020 21:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgAXUzB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Jan 2020 15:55:01 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:34824 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbgAXUzB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jan 2020 15:55:01 -0500
Received: by mail-il1-f195.google.com with SMTP id g12so2693665ild.2
        for <linux-block@vger.kernel.org>; Fri, 24 Jan 2020 12:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0n9u51frLq42YXKsunChQaFJhmu3sf5UYr42H8mSzXw=;
        b=e2WK6xepBBB4EtzGMwqE4iZ6I7TEZG6kivlxfnbRGABVPMUeWRhbk7sJ0AlQ41+rwW
         vr1XSWWVZdvAF3Rojw/D/uXTMD4I9pCKZyz2nb4FihBVr1vt7Yc0kPqo9S01F0T38ccl
         aWE+KB8nHY/+RMJmIcnPv01KZmjNozGnfIcZtQPrGNDqEm4i1hIF2rmJEiyqzRVGjwV4
         zvhgVw4r2a9mpveyXRTc826jwOTNOGzlScBbwPP83droAePq/8fq6Egg4fSECRXFl+/X
         xTfoRvvzDUTc9Ge8gfR2JEcBx8nhLKZyt3aovXRWuz94FwZ7E6SgvfGuu9/FWs3tn5/1
         oeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0n9u51frLq42YXKsunChQaFJhmu3sf5UYr42H8mSzXw=;
        b=caBN5Zp+w7Cq+ZAVRw2IJcXnZUyxB46UO4rdT+rLUGIvfFnI/AaZ3JDOJTeB5dMegv
         EhXa2muj50cWf6JElas1bc0in+gauiDg2ykq0Qv8u1WqZUtQgViHGCe579wmDzkQitBw
         ina508uacEY7S3S9K3MWdkJgbj2oL1ObuUGpegK+kMTqyCCt87U28h5Wu3fF/lYYmHoj
         DyP6c+0Eeyo06vgVw9hIm8tX1Ng+YXzV5GWd0R+usci3mJRXhL8r7zTbeZGfuCBLCjsI
         Bfj609rEhWTwECFzHY0+66ztn3H/UyXoHpZtK1mxY4FGDAmNrN/RXrGK5q7B7/MKYcqO
         o6nA==
X-Gm-Message-State: APjAAAX0Vinq8rtisufwFgGQrUnjSlosi9UacLu1gCkOJ+px0t4gneA6
        eqKSe6X3IBBtZL+IaLWARvFXk5zfN/NcrmDqql26cA==
X-Google-Smtp-Source: APXvYqz0AtvAHedtY5gehru+dAerzBiUAXq+YrmyX+8ObY9I8Jr7SyNAQggbUfCicKDPQDc9yHO3tH/caNLRJkwTvuo=
X-Received: by 2002:a05:6e02:f0f:: with SMTP id x15mr4685344ilj.298.1579899300670;
 Fri, 24 Jan 2020 12:55:00 -0800 (PST)
MIME-Version: 1.0
References: <20200124204753.13154-1-jinpuwang@gmail.com>
In-Reply-To: <20200124204753.13154-1-jinpuwang@gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 24 Jan 2020 21:54:49 +0100
Message-ID: <CAMGffEnKMZ1=KeEjTgm2K-JdMkfQnVHCNHCU+HtzzW6SjOUD9Q@mail.gmail.com>
Subject: Re: [PATCH v8 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
To:     Jack Wang <jinpuwang@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 24, 2020 at 9:47 PM Jack Wang <jinpuwang@gmail.com> wrote:
>
> Hi all,
>
> Here is v8 of  the RTRS (former IBTRS) RDMA Transport Library and the
> corresponding RNBD (former IBNBD) RDMA Network Block Device, which includes
> changes to address comments from the community.
>
> Introduction
> -------------
>
> RTRS (RDMA Transport) is a reliable high speed transport library
> which allows for establishing connection between client and server
> machines via RDMA. It is based on RDMA-CM, so expect also to support RoCE
> and iWARP, but we mainly tested in IB environment. It is optimized to
> transfer (read/write) IO blocks in the sense that it follows the BIO
> semantics of providing the possibility to either write data from a
> scatter-gather list to the remote side or to request ("read") data
> transfer from the remote side into a given set of buffers.
>
> RTRS is multipath capable and provides I/O fail-over and load-balancing
> functionality, i.e. in RTRS terminology, an RTRS path is a set of RDMA
> connections and particular path is selected according to the load-balancing
> policy. It can be used for other components beside RNBD.
>
> Module parameter always_invalidate is introduced for the security problem
> discussed in LPC RDMA MC 2019. When always_invalidate=Y, on the server side we
> invalidate each rdma buffer before we hand it over to RNBD server and
> then pass it to the block layer. A new rkey is generated and registered for the
> buffer after it returns back from the block layer and RNBD server.
> The new rkey is sent back to the client along with the IO result.
> The procedure is the default behaviour of the driver. This invalidation and
> registration on each IO causes performance drop of up to 20%. A user of the
> driver may choose to load the modules with this mechanism switched off
> (always_invalidate=N), if he understands and can take the risk of a malicious
> client being able to corrupt memory of a server it is connected to. This might
> be a reasonable option in a scenario where all the clients and all the servers
> are located within a secure datacenter.
>
> RNBD (RDMA Network Block Device) is a pair of kernel modules
> (client and server) that allow for remote access of a block device on
> the server over RTRS protocol. After being mapped, the remote block
> devices can be accessed on the client side as local block devices.
> Internally RNBD uses RTRS as an RDMA transport library.
>
> Commits for kernel can be found here:
>    https://github.com/ionos-enterprise/ibnbd/commits/linux-5.5-rc6-ibnbd-v7
Sorry, forgot to update the link:
https://github.com/ionos-enterprise/ibnbd/tree/linux-5.5-rc7-ibnbd-v8
