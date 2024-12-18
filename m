Return-Path: <linux-block+bounces-15565-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9A99F5F00
	for <lists+linux-block@lfdr.de>; Wed, 18 Dec 2024 08:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC43166FA4
	for <lists+linux-block@lfdr.de>; Wed, 18 Dec 2024 07:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F631531F2;
	Wed, 18 Dec 2024 07:00:53 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3C845005
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734505252; cv=none; b=NC/MIbXv4Jd+v2KYtXIUU5zFwTZOZcrBdjthEc25ciz4I3LSNFSOA4C5cXMU8WgsItqMiyJVyWa1pao/WCKRwod9FDW9ombQVjLPMAlKvYXqP6T6fOGCY5JHwpczH1ssm+DJrbJKwp2CsqzWsEf6iRjBc7fCtBcuAQws7vAfCzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734505252; c=relaxed/simple;
	bh=Ne/bItqY06LF4JhWQsGH1hGttQL9RxkE49DVHALC+wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mr0qrZD4MJJ3Z8bfCE4oZUjHWShN+uwWEqZjF8z7BSmg1JJiQ/b9cwCADoTqxtUY60XY+oouB/LgOWz1Q6nci2aG+ctFqur521j6BKljkLYdeVoie9CPZoAiAE274VgdTms1p2uR2H7JMJYfmzFufPtR2qfU2eCGKBjH+WjKNQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 97D1368D15; Wed, 18 Dec 2024 08:00:47 +0100 (CET)
Date: Wed, 18 Dec 2024 08:00:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 2/2] blk-mq: Move more error handling into
 blk_mq_submit_bio()
Message-ID: <20241218070045.GC25215@lst.de>
References: <20241216201901.2670237-1-bvanassche@acm.org> <20241216201901.2670237-3-bvanassche@acm.org> <20241217041819.GB15286@lst.de> <b17872ef-46ad-4a6a-9a6b-17edc4a25630@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b17872ef-46ad-4a6a-9a6b-17edc4a25630@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 17, 2024 at 01:06:12PM -0800, Bart Van Assche wrote:
> It seems to me that there is a typo in the above code? Unless if you tell 
> me otherwise, I will assume that this is what you meant:

Yes.


