Return-Path: <linux-block+bounces-17202-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588F6A33804
	for <lists+linux-block@lfdr.de>; Thu, 13 Feb 2025 07:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0974F166E28
	for <lists+linux-block@lfdr.de>; Thu, 13 Feb 2025 06:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958B61FA15E;
	Thu, 13 Feb 2025 06:38:20 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DCF8489
	for <linux-block@vger.kernel.org>; Thu, 13 Feb 2025 06:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739428700; cv=none; b=Gx749qZsGpvEaMz+9bTB8hS90cmUnbj8rwD0+w1E0F87Wi3UI2IL1G/QGkgg4eKu3Br2t1bZlLpKhMsCKhT8WtScUaekWHUn9gNYeKXcIrfvTM7jQ1qtOl+yI3MA4PUnpmwhpDEPLzmUE1o3v1ZAmr4itqxQAzWjr24ejxifQl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739428700; c=relaxed/simple;
	bh=Y6Wh/g11k2+wmcYqzGyMJHsCCUNEet1Hv1pRT2YsyqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/CfRutbE5KUsudWdXyxHVMFQ78A8Ps/263rPh+A5gpmwEscrdFQopJebSNqVOl+s/amvQZH38w52EE+oCoTeAdhQjEfuezh3S7HB2J21abCU/C9qoRAcEAh8VlasNhkvWKzvFHN3WpGMAyljRRQgL+87tJJZ90HEvCcbN9J43g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 63B3867373; Thu, 13 Feb 2025 07:38:14 +0100 (CET)
Date: Thu, 13 Feb 2025 07:38:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Cheyenne Wills <cheyenne.wills@gmail.com>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: BUG: NULL pointer dereferenced within __blk_rq_map_sg
Message-ID: <20250213063814.GB20402@lst.de>
References: <CAHpsFVeew-p9xB9DB52Pk_6mXfFxJbT8p14h5+YRTKabEfU3BQ@mail.gmail.com> <Z6s-3LndN-Gt5sZB@fedora> <Z6tss9YS98AEIwQy@fedora> <CAHpsFVcMnSJgJbGrqiBDmYkHyneJdby4DMkOKQKAuicA0kgJQA@mail.gmail.com> <Z61LEUdHI2Hx3bue@fedora> <20250213063214.GA20171@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213063214.GA20171@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 13, 2025 at 07:32:14AM +0100, Christoph Hellwig wrote:
> On Thu, Feb 13, 2025 at 09:29:53AM +0800, Ming Lei wrote:
> > Yeah, turns out oops is triggered in initializing req_iterator for
> > discard req, and the following patch should be enough:
> 
> How do we end up in blk_rq_map_sg for a discard request here?
> dma-mapping doesn't make sense for a non-special pyaload discard
> as used by xxen-blkfront, and xen-blkfront also only calls
> blk_rq_map_sg from blkif_queue_rw_req and not blkif_queue_discard_req.

I think we're probably dealing with a flush command, as that's the
only request that doesn't have a bio except for empty passthrough
commands.  xen-blkfront is a bit weird in calling into these data
transfer helpers despite not having data to transfer, but I guess
something like your patch to safeguard against it should be fine.
But add a comment as well please.

