Return-Path: <linux-block+bounces-7701-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E13CA8CE3F2
	for <lists+linux-block@lfdr.de>; Fri, 24 May 2024 11:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12BC0B20F9D
	for <lists+linux-block@lfdr.de>; Fri, 24 May 2024 09:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573686EB4B;
	Fri, 24 May 2024 09:58:24 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B113185277
	for <linux-block@vger.kernel.org>; Fri, 24 May 2024 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716544704; cv=none; b=fJFiEmMn4YFL27wQpHMSsxI2qtUl6poZxmNv43pfEBJMNnw1X7a/HwhCqXwOKjNlVifqtpKx76ME8cxaZnWJ9FWT+61Q1fihNKivjOiB3Mp2tQ7XN0VFrpuZHXw5KRSNpNxHBMDIdJNNz0o+7yFQsMHSXrvgOy1/1BmsgF7e0R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716544704; c=relaxed/simple;
	bh=obs/0dbhs32AHfM+jUANDeGLMhqO2cqtwm3azYdtQaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liIRL6n/SnDAQvypinB+nP6+XZyO85WWo27LvXj5cAh5CBVz7etj2cbUNru16OXf918cSkz31Kt7aFuNxzY+BwMgvg2f2/4SFh9/SiBXNbLeRkaQtqrRFKao65vHtYQLAtQBNWV26LaAGCJdRYyaaOEOKQnPVxhA7YtjjNwXnY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 95B2968B05; Fri, 24 May 2024 11:58:17 +0200 (CEST)
Date: Fri, 24 May 2024 11:58:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev
Subject: Re: [PATCH] block: blk_set_stacking_limits() doesn't validate
Message-ID: <20240524095817.GA26791@lst.de>
References: <20240524062119.143788-1-hare@kernel.org> <20240524073957.GB16336@lst.de> <6658470a-fce2-4570-ab2d-6eb28f2fc421@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6658470a-fce2-4570-ab2d-6eb28f2fc421@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 24, 2024 at 11:56:17AM +0200, Hannes Reinecke wrote:
> I just found it weird that a simple 'memset' for the initial device 
> configuration and then calling blk_set_stacking_limits() will lead to a 
> failure in blk_validate_limits() ...

You don't need a memset before calling blk_set_stacking_limits as
blk_set_stacking_limits already does the memset for you.  But as
implied by the name and documented in the kerneldoc comment,
blk_set_stacking_limits is indeed intended to prepare for stacking
in other limits and is not supposed to be directly applied.


