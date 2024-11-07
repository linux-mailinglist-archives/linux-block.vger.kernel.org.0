Return-Path: <linux-block+bounces-13667-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 828C09BFE9E
	for <lists+linux-block@lfdr.de>; Thu,  7 Nov 2024 07:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E990B224A4
	for <lists+linux-block@lfdr.de>; Thu,  7 Nov 2024 06:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A5218A926;
	Thu,  7 Nov 2024 06:43:38 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E715B0F2
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 06:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961818; cv=none; b=Eh41y0dxpSrJVFORMDjOiQu64TWgRM3TCp7y9HGWG0MRJ8tsUzgV3ewo5ZL8uqyPZMCZjNxknvYO5QhCPijrtr8SeQLusoYzmdjkOTgPQ4DYzxH3eNVEa+f2dpOzCLvPtyS1WzIJkgJ0mD5voRZ24WfgOIQu6zjYjCqGHXwiOVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961818; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3imgg3YyLKJHkFW35op3cUo23U3cPrb6SKW/hIH0MVfaFMxY0zNepCHrnbJZuxVxEiq+xDbHmrltALo5hbMuvSxPozIqd5yR+iGBZyet9fOuirDuPbD1iLGQT9mEZbAib26i0JrfxgwcXKcCcoIChJxu4eTdY4LolPWOYfKDjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A8101227A87; Thu,  7 Nov 2024 07:43:32 +0100 (CET)
Date: Thu, 7 Nov 2024 07:43:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/2] block: RCU protect disk->conv_zones_bitmap
Message-ID: <20241107064332.GA3458@lst.de>
References: <20241107064300.227731-1-dlemoal@kernel.org> <20241107064300.227731-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107064300.227731-2-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


