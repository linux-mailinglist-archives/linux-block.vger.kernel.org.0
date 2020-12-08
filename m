Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3822D34BA
	for <lists+linux-block@lfdr.de>; Tue,  8 Dec 2020 22:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgLHU70 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 8 Dec 2020 15:59:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbgLHU70 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Dec 2020 15:59:26 -0500
Date:   Wed, 9 Dec 2020 04:03:35 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607454221;
        bh=L8FM559sr2mI1V2XQXd6cRw/SUcIbxs3FHy79RWrxTE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=mqPFzsO3ZAtKrz8wPFVBeXJWaALpK+sQlNZl72bJMa9iLYWRjbuzLOfizW2hm2/SJ
         /GxpttTauDDzrD+AsLik6KleNnr4jHdL9tPX5msR2OWc6XMSz3/NP56qHaD7GBI96A
         f7ZTH1H81h67nKMNI8eXpaGX7UtkNXSPhk+rpcz4N8n+Sv5Ud02zxROSs4q3vtcDkX
         LOhDMtuumT61HLjeHsUrsGbQPVAx20DMxFieilInWQZdsVJHs94zWkNkOMlVemX8k7
         mn1MduOAHj+/kNYum19CYda/IFmia3A8Dv6qqGTG5NYpWlWchuPffh67rbl6DbwlIW
         uG+7uEPkZ0vBA==
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     javier@javigon.com, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, sagi@grimberg.me,
        minwoo.im.dev@gmail.com,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V2] nvme: enable char device per namespace
Message-ID: <20201208190335.GC27155@redsun51.ssa.fujisawa.hgst.com>
References: <20201208132934.625-1-javier.gonz@samsung.com>
 <20201208142151.GA4108@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208142151.GA4108@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 08, 2020 at 03:21:51PM +0100, Christoph Hellwig wrote:
> > +	sprintf(cdisk_name, "nvme%dn%dc", ctrl->instance, ns->head->instance);
> 
> And the most important naming decision is this.  I have two issues with
> naming still:
> 
>  - we aready use the c for controller in the hidden disk naming.  Although
>    that is in a different position, but I think this not super intuitive.
>  - this is missing multipath support entirely, so once we want to add
>    multipath support we'll run into issues.  So maybe use something
>    based off the hidden node naming?  E.g.:
> 
> 	sprintf(disk_name, "nvme-generic-%dc%dn%d", ctrl->subsys->instance,
> 		ctrl->instance, ns->head->instance);

+1 for this naming suggestion.
