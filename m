Return-Path: <linux-block+bounces-7821-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D256A8D190F
	for <lists+linux-block@lfdr.de>; Tue, 28 May 2024 12:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873591F26284
	for <lists+linux-block@lfdr.de>; Tue, 28 May 2024 10:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E8116B75E;
	Tue, 28 May 2024 10:58:43 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A0916B756
	for <linux-block@vger.kernel.org>; Tue, 28 May 2024 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893923; cv=none; b=c+DW14pnbaEO2n+ivUv+QJ1qauh27IiTwyzjN2BVbIHFTpF3nSobbwJvUtaEUtZAkcvK8Z9wFI0V96itpPMLg7MoeJEbuVWMM4tFL+c/xbdKWL/rZw7cirfymWw+RJxFfSNeT4sKVR1UvFRGMFTXDyeZaaBEasoO2Q1e+01luCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893923; c=relaxed/simple;
	bh=H4Hcx8CdYhMsJvPBck3oOGK6LE6xS2IFs6GTLz5AdJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bn3wMEx1wPnp5X/wPOmWOQ6ULhhu+vFk2gKjq9xbJqS5X5EAwl+f57vvDX90W9f/h0LwQy04aZQc6aK/Shpjhm+Ekp1UeDovxCV8akXEOwSanFD0/ocnIo6NV80wlwbBWAA6wl1inri5/Oi4qhvgXaMeMU9d9zlWB3reGSob5X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7ABD568AFE; Tue, 28 May 2024 12:58:37 +0200 (CEST)
Date: Tue, 28 May 2024 12:58:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Hannes Reinecke <hare@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@kernel.org>,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev
Subject: Re: [PATCHv2] block: check for max_hw_sectors underflow
Message-ID: <20240528105837.GA15290@lst.de>
References: <20240524104651.92506-1-hare@kernel.org> <acf3e39c-36ae-4792-b870-26d392be5241@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acf3e39c-36ae-4792-b870-26d392be5241@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 28, 2024 at 11:54:42AM +0100, John Garry wrote:
> I don't think that we ever check if lim->logical_block_size is a power-of-2 
> - but that's a given, right?

It has to be for the block stack to work.  That being said now that we
do have a single good place for sanity checks it's probably worth to
add this check explicitly.

