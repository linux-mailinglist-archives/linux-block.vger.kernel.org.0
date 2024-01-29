Return-Path: <linux-block+bounces-2534-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407EE840B0C
	for <lists+linux-block@lfdr.de>; Mon, 29 Jan 2024 17:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF4E28DC40
	for <lists+linux-block@lfdr.de>; Mon, 29 Jan 2024 16:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A98155A20;
	Mon, 29 Jan 2024 16:14:09 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAF1155A31;
	Mon, 29 Jan 2024 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544849; cv=none; b=bJq+5G5NZt8uW5YSkP+8TwakZLqpk5Jb3rmMHhEvmAnaeexTDqBlUotFAB/NMZnajaYkiX/IsPnC2lky7qsH8waKxKIarO8fqfuiKQyoBsTDZK92bCsE4v+d1En3KEyYZXltEV8n+zURtnqfvYLRRVFpAR4jDgWUAwPu47Z3mYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544849; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwvCTWdIdwm8ihuTB9l3G+FIDUIHMdzvC7hT+FHy2b8lWTiw8Z8LH/JGLQiKYE//qKnNEDzk3kOENSPC08sDOHf+DzMRRfFEjtzJ74ljAgV9risGrJESkuaIYnbHsGlvPhLJJ8WPNELPpvNFgRb/gvIFcBjZa2H8pfa0d0pbZx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D7DBD68C4E; Mon, 29 Jan 2024 17:14:02 +0100 (CET)
Date: Mon, 29 Jan 2024 17:14:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 02/34] block/ioctl: port blkdev_bszset() to file
Message-ID: <20240129161402.GA3416@lst.de>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org> <20240123-vfs-bdev-file-v2-2-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-2-adbd023e19cc@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

