Return-Path: <linux-block+bounces-16866-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D244A26B28
	for <lists+linux-block@lfdr.de>; Tue,  4 Feb 2025 05:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451561887A42
	for <lists+linux-block@lfdr.de>; Tue,  4 Feb 2025 04:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771528635C;
	Tue,  4 Feb 2025 04:58:21 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9BB86358;
	Tue,  4 Feb 2025 04:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738645101; cv=none; b=MwoUMwWP3R+vBmSiXnHHMyR2uIHCFnPSMR2sZU+FlM3hwtzWv68mrriP0GQdzKNcr2q/2bApIMDKVujst9hL6/xrIpkkZrUDZzkZ6ha7O0XToXtdcs2Ga1ITwv/yI3eO2d9VTdFJEHl0kUZD6B3DbuBSQZW/k31+Yv3jbk/Gqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738645101; c=relaxed/simple;
	bh=1t/g6Uk+qig640YUAcNpyPl15PF0UTdDfXmlhW5+L+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbCG8DeN2SLhAVXIb/zXPVpmv/4+TgywR/tfLJ09r//5TE1WgvHo89mSQud53AyHRNPWqGCkEACAJ2YGc/fqydN3GdetZTr//BQ2vt4DWp/00Pcwjb3G81Asu4q4LjgOrL7TWuSBs932yai0IcOa8T/dAR9PcaGXAvz9tlGBEWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8D94568AFE; Tue,  4 Feb 2025 05:58:14 +0100 (CET)
Date: Tue, 4 Feb 2025 05:58:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/7] iomap: add bioset in iomap_read_folio_ops for
 filesystems to use own bioset
Message-ID: <20250204045814.GD28103@lst.de>
References: <20250203094322.1809766-1-hch@lst.de> <20250203094322.1809766-4-hch@lst.de> <20250203222326.GE134507@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203222326.GE134507@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 03, 2025 at 02:23:27PM -0800, Darrick J. Wong wrote:
> > Allocate the bio from the bioset provided in iomap_read_folio_ops.
> > If no bioset is provided, fs_bio_set is used which is the standard
> > bioset for filesystems.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> I feel like I've seen this patch and the last one floating around for
> quite a while; would you and/or Goldwyn like to merge it for 6.15?

I think Goldwyn posted it once or twice and this is my first take on
it (I had a similar one in a local tree, but I don't think that ever
made it out to the public).

But until we actually grow a user I'd rather not have it queue up
as dead code.  I'm not sure what the timeline of iomap in btrfs is,
but I'm 6.15 is the absolute earliest that the PI support for XFS
could make it.


