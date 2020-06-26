Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9569A20AEBA
	for <lists+linux-block@lfdr.de>; Fri, 26 Jun 2020 11:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgFZJHO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 26 Jun 2020 05:07:14 -0400
Received: from verein.lst.de ([213.95.11.211]:50984 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgFZJHN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 05:07:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0C01D68C7B; Fri, 26 Jun 2020 11:07:10 +0200 (CEST)
Date:   Fri, 26 Jun 2020 11:07:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>
Cc:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Message-ID: <20200626090709.GA26616@lst.de>
References: <20200625122152.17359-1-javier@javigon.com> <20200625122152.17359-4-javier@javigon.com> <b3429226-16ae-df3c-38aa-50e3a8716e71@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3429226-16ae-df3c-38aa-50e3a8716e71@lightnvm.io>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 25, 2020 at 04:12:21PM +0200, Matias Bjørling wrote:
> I am not sure this makes sense to expose through the kernel zone api. One 
> of the goals of the kernel zone API is to be a layer that provides an 
> unified zone model across SMR HDDs and ZNS SSDs. The offline zone 
> operation, as defined in the ZNS specification, does not have an equivalent 
> in SMR HDDs (ZAC/ZBC).
>
> This is different from the Zone Capacity change, where the zone capacity 
> simply was zone size for SMR HDDs. Making it easy to support. That is not 
> the same for ZAC/ZBC, that does not offer the offline operation to 
> transition zones in read only state to offline state.

Bullshit.  It is eactly the same case of careful additions to the model,
which totally make sense.

The only major issue with the patch is that we need a flag to indicate
if a given device supports offlining zones before wiring it up.
