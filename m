Return-Path: <linux-block+bounces-9745-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0515A928159
	for <lists+linux-block@lfdr.de>; Fri,  5 Jul 2024 07:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC3F1F246E3
	for <lists+linux-block@lfdr.de>; Fri,  5 Jul 2024 05:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EB7136E17;
	Fri,  5 Jul 2024 05:05:58 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4215E41A81
	for <linux-block@vger.kernel.org>; Fri,  5 Jul 2024 05:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720155958; cv=none; b=ZOz0nAKbtE8wnhQB7gk2LH7M6i9E3upyWpqyMxRu3fICs3eliKiR+biFg5aqBQFMFa5qhIquccY0lBViUWbyLMHkNk0XAzYpGHDUJ/N+/JpnBzK/gScqnyf+iNaWTPBpgyoa8xDA/tUruW4QrEa6PelUSEOeNklnXfUJBFw66Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720155958; c=relaxed/simple;
	bh=ybsoLyS2pWJykWyr0XiR+uzWptCqLdWmj6yp+RqafSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuEeYwGtQRqq507ry4jon6612ZInnnWJJtAoLWpDZYCEIT6WjwbwWrCWVpsaYO8mJT4rnWfZzmm+wCzVBEAIYyuPC14vI2tMdoJ42Jsu9wF1Aki9PiB4jXi6d7mkMZ6zMW0+Z0ARzvwN8+XAVjBL9X+WxOP8hYKgezA5iXwykXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ECF8368AA6; Fri,  5 Jul 2024 07:05:50 +0200 (CEST)
Date: Fri, 5 Jul 2024 07:05:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] block: t10-pi: Return correct ref tag when queue has
 no integrity profile
Message-ID: <20240705050550.GA11379@lst.de>
References: <CGME20240704062234epcas5p1dd4ae6e7c91555b9573418d618086c1e@epcas5p1.samsung.com> <20240704061515.282343-1-joshi.k@samsung.com> <20240704062649.GA21024@lst.de> <20240704063242.GA21732@lst.de> <yq1y16g8q1s.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1y16g8q1s.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 04, 2024 at 11:49:56PM -0400, Martin K. Petersen wrote:
> I had a couple of drives which supported the feature and several OEMs
> were requesting it. However, it turned out that using 512e drives was a
> much more elegant solution to this particular problem.

So should we just drop the internval_exp member for now?  It would
simplify things a bit, but more importantly we wouldn't have to fix
the !BLK_DEV_INTEGRITY case for strip/insert.


