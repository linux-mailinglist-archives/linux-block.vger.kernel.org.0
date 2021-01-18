Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E092FA8F4
	for <lists+linux-block@lfdr.de>; Mon, 18 Jan 2021 19:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407618AbhARSf2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 Jan 2021 13:35:28 -0500
Received: from verein.lst.de ([213.95.11.211]:49203 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405557AbhARSfU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jan 2021 13:35:20 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B3AB767373; Mon, 18 Jan 2021 19:34:37 +0100 (CET)
Date:   Mon, 18 Jan 2021 19:34:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V9 8/9] nvmet: add common I/O length check helper
Message-ID: <20210118183437.GB11556@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com> <20210112042623.6316-9-chaitanya.kulkarni@wdc.com> <20210112073503.GC24288@lst.de> <BYAPR04MB4965136E54EA80910B9ED43986A90@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965136E54EA80910B9ED43986A90@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 13, 2021 at 05:07:16AM +0000, Chaitanya Kulkarni wrote:
> On 1/11/21 23:35, Christoph Hellwig wrote:
> > I can't say I like this helper.  The semantics are a little confusing,
> > not helped by the name.
> >
> Is it because of the name of the helper ? if so can you please suggest a
> name.
> Because all it has a same code repeated in the three backends and it really
> bothers me to see duplicate code, but that just me :P.

Also because it does two rather unrelated things.  Or in other words:
I don't think the helper helps the readability of the code.
