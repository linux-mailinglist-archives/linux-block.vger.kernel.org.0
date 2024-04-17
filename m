Return-Path: <linux-block+bounces-6337-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D028A8A8705
	for <lists+linux-block@lfdr.de>; Wed, 17 Apr 2024 17:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4870FB26336
	for <lists+linux-block@lfdr.de>; Wed, 17 Apr 2024 15:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B5F1422B6;
	Wed, 17 Apr 2024 15:07:33 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FE51411E0;
	Wed, 17 Apr 2024 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366453; cv=none; b=Dwwtka40sSFGxnD2kvA4DDsjkmON0CVee3JuFMWf1lzDR9C/z3LaPVtz9XRIEPesI1Yb4z/Jmbrcg4ju5tFwws/trR1ExbYo2/CwaX9bwMa1jyvCPEOjeuMneXGmaF7nBGwlvg3DKne5YcItMtREPZmvPL0MJHKprEk0/r50Ae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366453; c=relaxed/simple;
	bh=kBogYfm5nOEPb+ypTh9NJYuntKX4VEdwSGzKKuCcKv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZsZsGolZS9sPNufgmMy/ttT1QNhGEDN6U7uUTTMbOmd34H9Ws2tjDZLStMBtm6LS8L2YvbW5bC2rXR8wcIWsH3amlsvTzSv6R1d14vkFExk/VgmAA7QTuEoxFLJhJkTBJF0WEQ25o1DqDWf2Yj0f3/vRmX8nXZ6XrthE0nNtFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0FD50227A88; Wed, 17 Apr 2024 17:07:28 +0200 (CEST)
Date: Wed, 17 Apr 2024 17:07:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>
Subject: Re: API break, sysfs "capability" file
Message-ID: <20240417150727.GA2167@lst.de>
References: <ZhQJf8mzq_wipkBH@gardel-login> <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info> <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com> <ZhRSVSmNmb_IjCCH@gardel-login> <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com> <ZhT5_fZ9SrM0053p@gardel-login> <20240409141531.GB21514@lst.de> <d7a2b07c-26eb-4d55-8aa7-137168bd0b49@kernel.dk> <1bf9be9a-4d05-4d3b-ab76-13a825cd1758@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bf9be9a-4d05-4d3b-ab76-13a825cd1758@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 16, 2024 at 11:26:40AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> I might have missed something, but it seems nothing has happened since a
> week. Sure, this is hardly a new regression, so it's not that urgent;

It is not a regression at all.  Userspace poked into completely internal
bits that changed frequently before and now it changed again.

