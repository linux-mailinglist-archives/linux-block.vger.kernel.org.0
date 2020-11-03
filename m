Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D2C2A4ECD
	for <lists+linux-block@lfdr.de>; Tue,  3 Nov 2020 19:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgKCSZu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 3 Nov 2020 13:25:50 -0500
Received: from verein.lst.de ([213.95.11.211]:38575 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbgKCSZu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Nov 2020 13:25:50 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9B2886736F; Tue,  3 Nov 2020 19:25:48 +0100 (CET)
Date:   Tue, 3 Nov 2020 19:25:47 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        Logan Gunthorpe <logang@deltatee.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH V3 6/6] nvmet: use inline bio for passthru fast path
Message-ID: <20201103182547.GB23300@lst.de>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com> <20201022010234.8304-7-chaitanya.kulkarni@wdc.com> <9ba9c9ba-7caf-e24c-1471-62c199cfcd4a@deltatee.com> <BYAPR04MB4965980B745F28E069B8460186140@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965980B745F28E069B8460186140@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 29, 2020 at 07:02:27PM +0000, Chaitanya Kulkarni wrote:
> > I still think it's cleaner to change bi_endio for the inline/alloc'd
> > cases by simply setting bi_endi_io to bio_put() only in the bio_alloc
> > case. This should also be more efficient as it's one less indirect call
> > and condition for the inline case.
> >
> > Besides that, the entire series looks good to me.
> >
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> >
> > Logan
> >
> Sagi/Christoph, any comments on this one ?
> 
> This series been sitting out for a while now.

I think the suggestion from Logan makes sense.
