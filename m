Return-Path: <linux-block+bounces-3767-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E680869AF6
	for <lists+linux-block@lfdr.de>; Tue, 27 Feb 2024 16:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5463B1C21C89
	for <lists+linux-block@lfdr.de>; Tue, 27 Feb 2024 15:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59838145B09;
	Tue, 27 Feb 2024 15:46:33 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FA814534A
	for <linux-block@vger.kernel.org>; Tue, 27 Feb 2024 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048793; cv=none; b=egoerQytztOECCuLKtyNT3gbBfz779BBvqhBTNP/RnvAtJS1wXe2QePEI+fU3x7ptXitqqHMtne0uf9MnG3anGinAJBjhq+9yoQOLygSbuvxiCWmt0/K6hDIqJKhFRBCah5Tcp+dobyHu66Qm/m75K9TyTaz9eLBHsPGy7Z5904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048793; c=relaxed/simple;
	bh=TumqUVjTWQtGU6oefhr7Ygap/uDe8NxEVKYU0xae154=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E93ykR8BqIARKI2jCYlGYB1QiGEQZkHmMWimALpEP77HDh9kejSC1d5VaMqMtlImLA/3cBsS7AWmfUy9wlni79AmxvL4PtWmOi/wRn5OpDNTlCMFeB7m3MXyLtg/JG5v7St8YlzYFQbVCkelMNRZeQb72sA7zrx9oPc47w1QFT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9F0FA68C4E; Tue, 27 Feb 2024 16:46:27 +0100 (CET)
Date: Tue, 27 Feb 2024 16:46:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Subject: Re: convert xen-blkfront to atomic queue limit updates v2
Message-ID: <20240227154627.GA15446@lst.de>
References: <20240221125845.3610668-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221125845.3610668-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Jens,

can you pick this up with the Xen maintainer review in place?


