Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 698951945A4
	for <lists+linux-block@lfdr.de>; Thu, 26 Mar 2020 18:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgCZRjD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Mar 2020 13:39:03 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:41100 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgCZRjD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 13:39:03 -0400
Received: by mail-il1-f194.google.com with SMTP id t6so2580241ilj.8
        for <linux-block@vger.kernel.org>; Thu, 26 Mar 2020 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l9VlMqQJZeVcn8IoMEaxy5bkPD/Ux5xQRqNE1NVF3R0=;
        b=Dp444ANU62jImLMqkt9yQd75irovRZcsSA89vDWhKt/Ko9+4+z7EvAFvc+yANHSnpw
         dWKxFwJ+Z9gQ+ZEDmrPpAMLe48zGkXW9/6VxhVbSgppOvxO7smCiatn0hEPPy0+DqGas
         pLNPQRb9N1imDRC2MfjoIZplsKVNOfnCIZYB/gqbyh0Emv6Iw1B9+bEta8BDGDBAaI4x
         J8IchKM4X4p2C9wGrt8OhkZ3LmCiAGulwfgKkLl3l81fubMHBcp+rwfz61mTPRz89Bp3
         QU4QFyk/I5nj6SfVZnfH18nX6BlyWEJJQHN+Ne6yyWAvcam7j95ljhOlgV2wwh+WWugt
         TmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l9VlMqQJZeVcn8IoMEaxy5bkPD/Ux5xQRqNE1NVF3R0=;
        b=sbl73JRtCmhKKVpnLMT04VaOiSOyouwou6bcMggVqhcjL0quuBAQtRxSwppx3K8bMh
         fLNhCjnjvheJUVg/YYpXZQW/a5X5JFEzwng74l76Ji3jEEofqaR+czabEBA5aZAI4pDc
         QBbLrKDWWouHs/1uxGWU9URX41Fu9YJ6eC9EOSsCZc+O+L5FxVGhhnNtJvLs5hz2Shpf
         z+MQUQeLAgWgrHet7S0Mezdifkh1hKOLqwAGNijxH0I/B9fxWIYfdpsDb4RaSjpcME80
         duPom5Gmzo4b5b+OJX4aqea5mbjQguAz+xE3fXdWYRmKKrHa1v+oEIuwuFZYoZhdRQEG
         HAlg==
X-Gm-Message-State: ANhLgQ3zQADO0kli62PnLzqEAsGuVG5vdCq80EyICZTIRm9VhX66mQWh
        nmbQlXmhRPWBK8QvzsewaLbO3rn6Yk2diRAwua7mOoO5t9I=
X-Google-Smtp-Source: ADFU+vumTp6WQgFjLE/tOHjYN4PcxcqP8AnB3KOjWU/UgBtb8h6x2RL2Jbi6kr14q4tim36/GsDLknDHExxH4oTQldI=
X-Received: by 2002:a05:6e02:543:: with SMTP id i3mr10421869ils.223.1585244342076;
 Thu, 26 Mar 2020 10:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
In-Reply-To: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 26 Mar 2020 18:38:51 +0100
Message-ID: <CAMGffEnHWPoJSgy4RVMfC6yzBdnhgYGvRsY=bP7CFy5u_31uLw@mail.gmail.com>
Subject: Re: [PATCH v11 00/26] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 20, 2020 at 1:16 PM Jack Wang <jinpu.wang@cloud.ionos.com> wrote:
>
> Hi all,
> Here is v11 of  the RTRS (former IBTRS) RDMA Transport Library and the
> corresponding RNBD (former IBNBD) RDMA Network Block Device, which includes
> changes to address comments from the community.
>
Hi Jens, hi Jason, hi all,

ping! Do you think rnbd/rtrs could be merged in the current merge
window?

Thanks!
