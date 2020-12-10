Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4702D5F53
	for <lists+linux-block@lfdr.de>; Thu, 10 Dec 2020 16:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgLJPQj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 10 Dec 2020 10:16:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387481AbgLJPQf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 10:16:35 -0500
Date:   Fri, 11 Dec 2020 00:15:51 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607613354;
        bh=wZ0fhXkz4eYhyDN6W2nvKxllZUC9st97abBTE3rinAM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Amne4wUYqSTUh6m1H2fsbq3Bo492mSIS2YCUa1Su+2RHqTmluhjJwTFXzJDyKOGHx
         HUBcs1SzTgN9CF5Im+lG82IfbWaJZwcFCMCTslwgKYpnpqjLDNJQl/POBc0UpQqoG7
         k4A8XYZOalcmA0o7Su3uKWUHb9/teAdX4cg/NYHQgtnApldDSb5bbiV1VCxoY9XntI
         ia9cIbutAsyiYRLcxTMd18bLqc3O8mFVQAJh3ecevIwruwphG7YA2pPL54Iup5vZaD
         DZjymLAVBGS94lZ9ZXiaJPc8CX9wQdTUlwInTGCQcN1B3ObdtlBGpJzWFEGoFb5/WQ
         WGWm5D637vWAw==
From:   Keith Busch <kbusch@kernel.org>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V4 0/9] nvmet: add ZBD backend support
Message-ID: <20201210151551.GC3645@redsun51.ssa.fujisawa.hgst.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
 <20201202092019.GA3957@lst.de>
 <BYAPR04MB496565EF0AF026C16225792C86CB0@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB496565EF0AF026C16225792C86CB0@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 10, 2020 at 03:07:32AM +0000, Chaitanya Kulkarni wrote:
> I think something like following (totally untested) will help to avoid the
> scenarios like this for ZNS drives so we can rejects the buggy controllers
> early to make sure we are spec compliant :-
> 
> # git diff# git diff
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d9b152bae19d..7b196299c9b7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2166,6 +2166,11 @@ static int nvme_update_ns_info(struct nvme_ns
> *ns, struct nvme_id_ns *id)
>         nvme_set_queue_limits(ns->ctrl, ns->queue);
>  
>         if (ns->head->ids.csi == NVME_CSI_ZNS) {
> +               if (!(NVME_CAP_CSS(ns->ctrl->cap) & NVME_CAP_CSS_CSI)) {
> +                       pr_err("zns ns found with ctrl support for CSI");
> +                       goto out_unfreeze;
> +               }

I think you want to use nvme_multi_css() for the 'if()' check, but
otherwise this looks like a valid sanity check.
