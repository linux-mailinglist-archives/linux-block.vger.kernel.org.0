Return-Path: <linux-block+bounces-11482-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F41974C25
	for <lists+linux-block@lfdr.de>; Wed, 11 Sep 2024 10:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BE81C215A6
	for <lists+linux-block@lfdr.de>; Wed, 11 Sep 2024 08:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A76143878;
	Wed, 11 Sep 2024 08:06:44 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF8B1422BD;
	Wed, 11 Sep 2024 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042004; cv=none; b=bDdJENErIAhM26pngmgM+n5Mggg7MuUcz7015oqwNOY/KB8zs+G9RvrN2N/ezKjWd/kzbGYvGRPdderLVr1GuRtCjp5Y9NZu0e8okkU0Bl0zMWld5lOnG5LTRbK5LOqkf1U8cEpgrnncyqXMl5qJ6KePcupyxOGjGxjgfrl0LaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042004; c=relaxed/simple;
	bh=zVpFzYnPiRvKOCePHg4PPR19a0o9+bDk4MfRlNYN0pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3GnZX+6B4CkORz9QkfqswTSoHP1hfISaF5JXIC+Lf3b+B3RE3vbQuAHNibV0Vm0gEyup2bo/sy3uOtYST9D5lGZ9wNa7CZ+JXD+i3cJhKD74pN9isaIj618ux+sU69ohOe7RAggi+hLoPlIL3g/rPRysnmlspskx0T9HqeRZj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3EAAF227AB6; Wed, 11 Sep 2024 10:06:38 +0200 (CEST)
Date: Wed, 11 Sep 2024 10:06:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	axboe@kernel.dk, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, sagi@grimberg.me
Subject: Re: [PATCHv3 03/10] scsi: use request helper to get integrity
 segments
Message-ID: <20240911080638.GA7245@lst.de>
References: <20240904152605.4055570-1-kbusch@meta.com> <20240904152605.4055570-4-kbusch@meta.com> <20240910153217.GC23805@lst.de> <ZuDP-ncB0EXrS9Xg@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuDP-ncB0EXrS9Xg@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 10, 2024 at 05:02:18PM -0600, Keith Busch wrote:
> Right, I actually have more follow up's doing that. We just need to
> change blk_rq_map_integrity_sg() first to take a request instead of a
> request_queue + bio. I thought I might be getting carried away with the
> "cleanups" though, so was saving that for later. I can definitely add
> that into the series now though.

Well, it seems like the metadata code really needs a lot more attention
:(

And it seems like we really need the io_uring passthrough support to
be able to fully exercise it.

