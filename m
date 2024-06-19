Return-Path: <linux-block+bounces-9082-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6182990E555
	for <lists+linux-block@lfdr.de>; Wed, 19 Jun 2024 10:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEA41F21D23
	for <lists+linux-block@lfdr.de>; Wed, 19 Jun 2024 08:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD397757F5;
	Wed, 19 Jun 2024 08:16:08 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF678224D4;
	Wed, 19 Jun 2024 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718784968; cv=none; b=NWXu+bvQUxYoCa/o8Pq4JW4yzWGplZJXsJJHRikj0cTn+gGBBTiCLwYx9ShHiKb+AbLeknyPatGu+NzrD+jfUBdYXVdaufjxZaPCZQUaVZVMItosRSkQkPG3J15P3iW45hylY1OyUkowNygq0KGpZVHqs0pANEwRZh9ELBThkR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718784968; c=relaxed/simple;
	bh=Jra3PJoBmA923wqVcsykpgVc1tWRAmL9k918Hs5+dzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tG1N1S2ooZ7Avi59OmXXfIULWBSjfLvmh9fYw5Wtb3phjx+SCFeWwByMoVt4IW23FddeOOq/4JrBT5FQDDTQMOGyRDxUye0eUkeasc7xRPXP4wE0FBF7N/joooiYXgKuliPKFCMRCiBxx18Nf3GWLhQpYSx3pbz2jXMKWEs2zuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A0CD668BEB; Wed, 19 Jun 2024 10:16:01 +0200 (CEST)
Date: Wed, 19 Jun 2024 10:16:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com, hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Message-ID: <20240619081601.GA5434@lst.de>
References: <20240618164042.343777-1-gulam.mohamed@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618164042.343777-1-gulam.mohamed@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Do we need the re-addition of the open method to fix the ltp test
case?  I kinda hate it, but if that is what it takes:

Reviewed-by: Christoph Hellwig <hch@lst.de>


