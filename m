Return-Path: <linux-block+bounces-29430-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1D0C2B8BD
	for <lists+linux-block@lfdr.de>; Mon, 03 Nov 2025 12:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87473A2CF5
	for <lists+linux-block@lfdr.de>; Mon,  3 Nov 2025 11:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFBD306483;
	Mon,  3 Nov 2025 11:52:13 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6783064B3
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 11:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170733; cv=none; b=HjySqfO2jxFGC8nebuB1LknE67kae8spGKpyunAq7uJhLSAUgmyc6Uh2O97AEmervC7hI0q+mosv2b9Taik5QMpETsiH5VSiq3HIZQ+Ep9sdKCemvHmd6KSSHGcRH5CuNs0lArW6aUGQ4c6w1vBm6EKaMMXLaasWDW/K/9f7AmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170733; c=relaxed/simple;
	bh=RTRUkdQ4RUhT2OiWSqkaSBcFO6zLm+lAJJgZPml69NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfjeL3OMJeZz3i8Z+5PSL+mLFtAZyoJThhjQahmqek4jIWoAUzj4JGfiHOp/GaaCqFB7W9w637pW8TPHh0Nj6FNqoJLW7fbZcUDmMCw3GbSEbftvKqw6af5zuWGlQDnKlBz6g7IcXS/z654/p5tV7m7Oi3Yj1JBSN/TmpkgevQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 56AAA227A87; Mon,  3 Nov 2025 12:52:07 +0100 (CET)
Date: Mon, 3 Nov 2025 12:52:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: blocking mempool_alloc doesn't fail
Message-ID: <20251103115206.GA15538@lst.de>
References: <20251103101653.2083310-1-hch@lst.de> <20251103101653.2083310-2-hch@lst.de> <65386bdd-6cd9-44ff-9c43-2e9343f6ced9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65386bdd-6cd9-44ff-9c43-2e9343f6ced9@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 03, 2025 at 11:26:56AM +0000, John Garry wrote:
> Is the original error handling code correct?

Does it matter given that it was never called and is removed now? :)


