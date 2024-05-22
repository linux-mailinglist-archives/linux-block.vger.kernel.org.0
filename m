Return-Path: <linux-block+bounces-7613-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D98F8CC335
	for <lists+linux-block@lfdr.de>; Wed, 22 May 2024 16:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52C1B2177E
	for <lists+linux-block@lfdr.de>; Wed, 22 May 2024 14:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353381411FA;
	Wed, 22 May 2024 14:25:06 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7551411CA
	for <linux-block@vger.kernel.org>; Wed, 22 May 2024 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387906; cv=none; b=RC9dZhjldupJqSpCrS/DCeL8pPT8lM/KYbeQwIeEDYpB6cyBCWauqcDOniVMr2vEYkQBUQf1YMi6a4CTnLl1ngqNCnQwaGlWaEzs8HlsB1IBh5aPvb7B9AsMeU9C1Qo7TWYjavHgBco8lr0tjwHF5IMz4+13XBqTpk+hAqogZrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387906; c=relaxed/simple;
	bh=jGkNM8PNzc8L/4cZlVygWeGJw13aAYtwIqd49Vly4IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aneyLS5a4ct8STaKu218xRHSVgT+1+gGYLirLv//I16FjBJ/I38f0jfh7qDh3BuMnTdq2sxaqAn0T8Hl9q09Vp2qjq4hCxEFIeo9mn/oZS2/jYZVW0o1bycPQ6P4ij5LbDsdbuiNvgUI21MnNhR6/KhcSSNTJfFktk93BQ+dexc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8725A68BFE; Wed, 22 May 2024 16:24:58 +0200 (CEST)
Date: Wed, 22 May 2024 16:24:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org, hch@lst.de,
	Marco Patalano <mpatalan@redhat.com>,
	Ewan Milne <emilne@redhat.com>
Subject: Re: [PATCH] dm: retain stacked max_sectors when setting
 queue_limits
Message-ID: <20240522142458.GB7502@lst.de>
References: <20240522025117.75568-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522025117.75568-1-snitzer@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 21, 2024 at 10:51:17PM -0400, Mike Snitzer wrote:
> Otherwise, blk_validate_limits() will throw-away the max_sectors that
> was stacked from underlying device(s). In doing so it can set a
> max_sectors limit that violates underlying device limits.

Hmm, yes it sort of is "throwing the limit away", but it really
recalculates it from max_hw_sectors, max_dev_sectors and user_max_sectors.

> 
> This caused dm-multipath IO failures like the following because the
> underlying devices' max_sectors were stacked up to be 1024, yet
> blk_validate_limits() defaulted max_sectors to BLK_DEF_MAX_SECTORS_CAP
> (2560):

I suspect the problem is that SCSI messed directly with max_sectors instead
and ignores max_user_sectors (and really shouldn't touch either, but that's
a separate discussion).  Can you try the patch below and maybe also provide
the sysfs output for max_sectors_kb and max_hw_sectors_kb for all involved
devices?

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 332eb9dac22d91..f6c822c9cbd2d3 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3700,8 +3700,10 @@ static int sd_revalidate_disk(struct gendisk *disk)
 	 */
 	if (sdkp->first_scan ||
 	    q->limits.max_sectors > q->limits.max_dev_sectors ||
-	    q->limits.max_sectors > q->limits.max_hw_sectors)
+	    q->limits.max_sectors > q->limits.max_hw_sectors) {
 		q->limits.max_sectors = rw_max;
+		q->limits.max_user_sectors = rw_max;
+	}
 
 	sdkp->first_scan = 0;
 

