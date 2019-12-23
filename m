Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7633129299
	for <lists+linux-block@lfdr.de>; Mon, 23 Dec 2019 09:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbfLWIEm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Dec 2019 03:04:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:60688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfLWIEm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Dec 2019 03:04:42 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BFA0206B7;
        Mon, 23 Dec 2019 08:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577088282;
        bh=12Lem5kTP0ACozOQWuKJKgKhBPPaTf/FkiLbh5f4WmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ATYeaKn2CYuJO9zEtqq5BRF7+VSGzvTRjtACEsMMpqvNtBHaBPCb+/84KjXxErHCY
         6hJm7ok0GhPPBNFAC78qg1vOrlZgPGWhJiGbwSZvj9El2xm3Uv5bAoChnzijitgigJ
         QTZPr4R+1wkMDQPNNI1ZecsilVYH9yHCizhn3/SU=
Date:   Mon, 23 Dec 2019 10:04:38 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de
Subject: Re: [PATCH v5 02/25] rtrs: public interface header to establish RDMA
 connections
Message-ID: <20191223080438.GL13335@unreal>
References: <20191220155109.8959-1-jinpuwang@gmail.com>
 <20191220155109.8959-3-jinpuwang@gmail.com>
 <20191221101530.GC13335@unreal>
 <CAHg0HuxC9b+E9CRKuw4qDeEfz7=rwUceG+fFGfNHK5=H2aQMGw@mail.gmail.com>
 <20191222073629.GE13335@unreal>
 <CAMGffEn9xcBO0661AXCfv0KDnZBX6meCaT07ZutHykSxM4aGaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEn9xcBO0661AXCfv0KDnZBX6meCaT07ZutHykSxM4aGaQ@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 23, 2019 at 08:38:54AM +0100, Jinpu Wang wrote:
> On Sun, Dec 22, 2019 at 8:36 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Sat, Dec 21, 2019 at 03:27:55PM +0100, Danil Kipnis wrote:
> > > Hi Leon,
> > >
> > > On Sat, Dec 21, 2019 at 11:15 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > Perhaps it is normal practice to write half a company as authors,
> > > > and I'm wrong in the following, but code authorship is determined by
> > > > multiple tags in the commit messages.
> > >
> > > Different developers contributed to the driver over the last several
> > > years. Currently they are not working any more on this code. What tags
> > > in the commit message do you think would be appropriate to give those
> > > people credit for their work?
> >
> > Signed-of-by/Co-developed-../e.t.c
> >
> > But honestly without looking in your company contract, I'm pretty sure
> > that those people are not eligible for special authorship rights and
> > credits beyond already payed by the employer.
> >
> Hi, Leon,
>
> Thanks for the suggestion, how about only remove the authors for the
> new entry, only keep the company copyright?
> > +/* Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
> > + * Authors: Jack Wang <jinpu.wang@cloud.ionos.com>
> > + *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > + *          Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> > + *          Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
> > + */
>
> The older entries were there, I think it's not polite to remove them.

From our point of view, this is brand new code and it doesn't matter how
many internal iterations you had prior submission. If you want to be
polite, your company shall issue official press release and mention
all those names there as main contributors for RTRS success.

You can find a lot of examples of "Authors:" in the kernel code, but
they one of two: code from pre-git era or copy/paste multiplied by
cargo cult.

Thanks

>
> Regards,
> Jack
