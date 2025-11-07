Return-Path: <linux-block+bounces-29891-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3815BC409D2
	for <lists+linux-block@lfdr.de>; Fri, 07 Nov 2025 16:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28E034EF14E
	for <lists+linux-block@lfdr.de>; Fri,  7 Nov 2025 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD0F328B71;
	Fri,  7 Nov 2025 15:35:37 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678E72D97A1
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529737; cv=none; b=ugBqZ1K5yFrlczYunXw+zOCCEZlbQjOk8e6d3PesK2u1SBZTs88AXhSxS3s5qJwtHBVN7fTq/NQwdIGjCSMCt6yML6PCn+eRqecEkluxwlZZyyJNMW0CFfiW1UZU6nCiqdsoD1JhM6SUj7oM0n5P8jdtikzpqwR08DR01otEb50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529737; c=relaxed/simple;
	bh=h56xRp6jHzq/pENHzzblIJgM27L2mQ9mf8rShySgEYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHoRScx49uUfl8EurBKkIxtVoRa9HzbrxiD1j7mxn1z03zk2XCMKtWd79AzQp3nIAKNN+tSkP9eZfIif2kgwMIZqtr56SdirOzWmHrRAmwGE5yPbAALz3+1w1CnFN+MiyOCUlIjglAWm5SE7ab9RgO+n2vLjKSZdKDjhMGUf2YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9D9BD227A87; Fri,  7 Nov 2025 16:35:24 +0100 (CET)
Date: Fri, 7 Nov 2025 16:35:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, axboe@kernel.dk,
	martin.petersen@oracle.com
Subject: Re: [PATCHv2] blk-integrity: support arbitrary buffer alignment
Message-ID: <20251107153524.GA15737@lst.de>
References: <20251107043447.3437347-1-kbusch@meta.com> <20251107131519.GA3975@lst.de> <aQ4JihZLWPrrgdCK@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ4JihZLWPrrgdCK@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 07, 2025 at 08:00:26AM -0700, Keith Busch wrote:
> Thanks! These all look good to me. If it's okay with you, I'll fold
> these in and tag you for Co-developed-by.

Please fold them yes.  I don't think I need a Co-developed-by or any
attribution for these trivial cleanups.

