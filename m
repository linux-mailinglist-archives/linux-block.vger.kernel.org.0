Return-Path: <linux-block+bounces-2654-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5798437D5
	for <lists+linux-block@lfdr.de>; Wed, 31 Jan 2024 08:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2881C2604E
	for <lists+linux-block@lfdr.de>; Wed, 31 Jan 2024 07:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B445024D;
	Wed, 31 Jan 2024 07:22:38 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4664E1D6
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685758; cv=none; b=gjnZYBh7FHT5uHIUMjAAqiK//NyzKcV68iOX6oHYvavz7By+8tA3fTVEDKCwR8jqlOY+i28J+/CFv9HJ4H3iP4/DQv+0LImx+M7+OmKPrv/YOWt4V4pXGGoNRTLf0ViM2Y9WhHaRMlF0Qk4Qflmu8EapGq/XxJ6daBzzYd6Xj84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685758; c=relaxed/simple;
	bh=4pM6GWGtNDtMpacb+sLezo6XGvlmLSsNYuV4gIyCHss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxfhTUOhzHwDrIOTxx40UrTG5T2etiUm8i3SCkN4afON5trFeFBu9mJrLWCNS3+OjJCRK+4G6J8uoB6N0XnzqutfuSRDlCQZJFbOsntIdwo4rjkJVrInIuHPdYGliuOY1PT0zBPgU3xsdKQLU/H4NOp/d2E/QKznxBa1a5tPt+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7325F68B05; Wed, 31 Jan 2024 08:22:33 +0100 (CET)
Date: Wed, 31 Jan 2024 08:22:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH 3/3] nvme: allow integrity when PI is not in first bytes
Message-ID: <20240131072233.GC17498@lst.de>
References: <20240130171206.4845-1-joshi.k@samsung.com> <CGME20240130171929epcas5p24f6c25d123d3cd6463cbef1aaf795276@epcas5p2.samsung.com> <20240130171206.4845-4-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130171206.4845-4-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 30, 2024 at 10:42:06PM +0530, Kanchan Joshi wrote:
> NVM command set 1.0 (or later) mandate PI to be in last bytes of
> metadata. But this was not supported in the block-layer and driver
> registered a nop profile.
> 
> Remove the restriction as the block integrity subsystem has grown the
> ability to support it.

I think it makes sense to mention that the by far most usual
configuration is metadata size == PI tuple size and you're adding
support for additional less common setups.

