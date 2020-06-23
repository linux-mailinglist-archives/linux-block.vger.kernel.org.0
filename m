Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD35205479
	for <lists+linux-block@lfdr.de>; Tue, 23 Jun 2020 16:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732986AbgFWOZI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Jun 2020 10:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732781AbgFWOZG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 10:25:06 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B635E20716;
        Tue, 23 Jun 2020 14:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592922306;
        bh=WolNKP6AFb9F9+4XbRDDy9/99/EDMUqm5gJZnB0tSXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JoDTFM6WzRLRmusq17s81KEFBRc7Ne7InvHx/4dmMwGpegdnNwlxUqKE2v2lfLWMK
         ovpMMb8WX5gUmCNMLCs2tcKTM8nVSkqPuFsegIvZXb3v7ThHsrB6bDFhAGD76Cvnum
         10RCaNU6ZCIdAVZG72M9+f4ki5lcomn4Krs9zmfg=
Date:   Tue, 23 Jun 2020 07:25:03 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set
 support
Message-ID: <20200623142503.GA1288900@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <5b9af756-f99b-c1b5-ae2e-7dd2177208a1@suse.de>
 <20200623092033.GA117742@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623092033.GA117742@localhost.localdomain>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 23, 2020 at 09:20:35AM +0000, Niklas Cassel wrote:
> On Tue, Jun 23, 2020 at 08:20:23AM +0200, Hannes Reinecke wrote:
> > On 6/22/20 6:25 PM, Keith Busch wrote:
> > > From: Niklas Cassel <niklas.cassel@wdc.com>
> > > -	if (ctrl->vs >= NVME_VS(1, 3, 0))
> > > +	if (ctrl->vs >= NVME_VS(1, 3, 0) || nvme_multi_css(ctrl))
> > >   		return nvme_identify_ns_descs(ctrl, nsid, ids);
> > >   	return 0;
> > >   }
> > 
> > Hmm? Are command sets even defined for something earlier than 1.3?
> 
> According to Keith, usually new features are not really tied to a
> specific NVMe version.

Not really according to me; nvme just allows controllers to implement
features ratified after the initial version release.
 
> So if someone implements/enables multiple command sets feature on
> an older base spec of NVMe, we still want to support/allow that.

Right. We don't check the version to see if multi-command sets are
supported when we initially enable it, so we shouldn't need to check the
version later.
