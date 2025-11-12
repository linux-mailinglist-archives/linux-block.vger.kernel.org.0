Return-Path: <linux-block+bounces-30104-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7D5C511FD
	for <lists+linux-block@lfdr.de>; Wed, 12 Nov 2025 09:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78203AFD0E
	for <lists+linux-block@lfdr.de>; Wed, 12 Nov 2025 08:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6342DC782;
	Wed, 12 Nov 2025 08:31:13 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5222F60B2
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936273; cv=none; b=HwL/HMZ168rpSAlTd9glOnLToyX+RaEuCAdJBtPRs6vGEHE8oZp25GBfb1McygAGpbCjhb/7bbjn3SaRYOZZNPIADodQvHCC41tbAYM+SUF5sUlnQQz7L1ullabcCpudduebNMrtbUFXfhDRVOw3KoNV8nEMnRGJ2HJCQDqiIUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936273; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bf4xHxdvP7WFU7FPzmasdx8DhkBGEvRbVkMnCP3G9de4wEAQ14V6F6JCHBNAZDBIGLqsWJTRKvM3Rlzfds1Zg1v5y15rdNUHMlQ16ufCNKT4ZRJ806TOKNQkzkeP+tNjOQNiY/LPIzkyC8QEd+zQ1QV3WIe9rOY4FIVBR7S9eiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C9B58227A88; Wed, 12 Nov 2025 09:31:05 +0100 (CET)
Date: Wed, 12 Nov 2025 09:31:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2 3/3] blk-zoned: Move code from
 disk_zone_wplug_add_bio() into its caller
Message-ID: <20251112083105.GA7603@lst.de>
References: <20251111232903.953630-1-bvanassche@acm.org> <20251111232903.953630-4-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111232903.953630-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


