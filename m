Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4CC2D1315
	for <lists+linux-block@lfdr.de>; Mon,  7 Dec 2020 15:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgLGOHK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 7 Dec 2020 09:07:10 -0500
Received: from verein.lst.de ([213.95.11.211]:41998 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgLGOHJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Dec 2020 09:07:09 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8538167373; Mon,  7 Dec 2020 15:06:26 +0100 (CET)
Date:   Mon, 7 Dec 2020 15:06:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        sagi@grimberg.me
Subject: Re: [PATCH 4/4] nvme: enable char device per namespace
Message-ID: <20201207140626.GB31159@lst.de>
References: <20201201125610.17138-1-javier.gonz@samsung.com> <20201201125610.17138-5-javier.gonz@samsung.com> <CGME20201201140354eucas1p1940891b47ca0c03ea46603393c844f61@eucas1p1.samsung.com> <20201201140348.GA5138@localhost.localdomain> <20201201185732.unlurqed2kaqwjsb@MacBook-Pro.localdomain> <20201201193002.GB27728@redsun51.ssa.fujisawa.hgst.com> <20201201193823.GA3522@lst.de> <20201201204456.dt2niquyaqvuci4s@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201201204456.dt2niquyaqvuci4s@MacBook-Pro.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 01, 2020 at 09:44:56PM +0100, Javier Gonz�lez wrote:
>> Devices in subdirectories of /dev/ are very rare and keep causing problem
>> with userspace tooling for the few drivers that use them, so I don't
>> think they are a good idea.
>
> Would something like nvmeXnYc work here or your prefer something
> different where we need to implement new, dedicated filters for
> user-space? I thing you suggested nvmegXnY at some point?

I think I suggested /dev/ng*, but maybe that is to short for the modern
times, so the above would work for me.
