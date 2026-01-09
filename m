Return-Path: <linux-block+bounces-32773-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DB1D0746A
	for <lists+linux-block@lfdr.de>; Fri, 09 Jan 2026 06:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9AEDF3004602
	for <lists+linux-block@lfdr.de>; Fri,  9 Jan 2026 05:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870B223F40D;
	Fri,  9 Jan 2026 05:53:12 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F214127FB0E;
	Fri,  9 Jan 2026 05:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767937992; cv=none; b=AAQz09W4/2dY61+cFO+yzDb2lJUgmkZ2OmSTJRefIiaTe4kiYd2Hv5guI0nMslW+NygWqkjTuWlf/HJQsDmsR2sJjLBQu2K6e5nIj5Vx+z3bL/KtbCZfe6tSJ14Yuj9cjLY60cqmNkJ46vImoCT07LYoibNE7CGY2BJXUJHh+Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767937992; c=relaxed/simple;
	bh=2qjJZHa+BDt9DBpRTfl+6LYrDHAHEJJCem5LPgT48F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mH8ULmxPD5shdCY6oLNjvDzOie3p/F3tuIa4Vy4YYaXN9n95+2VTGF1STh2G//1Cyyz2rlHfD8jrCrAODySqS36AFE/igqW+MKVPYUlY/yeOtEFmijotkKxefDu/+JqI4HXAyvjwqOdZxxP2ZDkreofQ8Gdb7H/oUoGcdHrneis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2E49367373; Fri,  9 Jan 2026 06:53:08 +0100 (CET)
Date: Fri, 9 Jan 2026 06:53:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 3/3] block: use pi_tuple_size in bi_offload_capable()
Message-ID: <20260109055308.GC4949@lst.de>
References: <20260108172212.1402119-1-csander@purestorage.com> <20260108172212.1402119-4-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108172212.1402119-4-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 08, 2026 at 10:22:12AM -0700, Caleb Sander Mateos wrote:
> bi_offload_capable() returns whether a block device's metadata size
> matches its PI tuple size. Use pi_tuple_size instead of switching on
> csum_type. This makes the code considerably simpler and less branchy.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


