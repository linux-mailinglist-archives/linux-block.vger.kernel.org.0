Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2FA2CEAE7
	for <lists+linux-block@lfdr.de>; Fri,  4 Dec 2020 10:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgLDJ3L (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 4 Dec 2020 04:29:11 -0500
Received: from verein.lst.de ([213.95.11.211]:33892 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbgLDJ3K (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Dec 2020 04:29:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BB5C36736F; Fri,  4 Dec 2020 10:28:28 +0100 (CET)
Date:   Fri, 4 Dec 2020 10:28:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH V4 5/9] nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
Message-ID: <20201204092828.GA9208@lst.de>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com> <20201202062227.9826-6-chaitanya.kulkarni@wdc.com> <20201202091018.GD2952@lst.de> <BYAPR04MB49654267EFD18AF2A65BECB486F10@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49654267EFD18AF2A65BECB486F10@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 04, 2020 at 03:20:40AM +0000, Chaitanya Kulkarni wrote:
> On 12/2/20 01:10, Christoph Hellwig wrote:
> > On Tue, Dec 01, 2020 at 10:22:23PM -0800, Chaitanya Kulkarni wrote:
> >> Update the nvmet_execute_identify() such that it can now handle
> >> NVME_ID_CNS_CS_CTRL when identify.cis is set to ZNS. This allows
> >> host to identify the support for ZNS.
> > The changs in this and all following patches really belong into the current
> > patch 2.
> >
> 
> This and each following patch doing one specific thing for which host
> 
> side component is responsible, with one patch for backend handlers and
> 
> wiring up of the same on for admin-cmd.c and io-cmd-bdev.c seems
> 
> we are packing too much into one, unlike what we have has a nice
> 
> bottom-up flow for the implementation, why not we keep that nice flow ?

Patches should do one thing at time.  With this series patch 2
is very incomplete, which makes both review and later reading the
commit history very hard.
