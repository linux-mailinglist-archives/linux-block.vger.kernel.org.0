Return-Path: <linux-block+bounces-24553-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222CCB0BDCC
	for <lists+linux-block@lfdr.de>; Mon, 21 Jul 2025 09:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788EA3AC391
	for <lists+linux-block@lfdr.de>; Mon, 21 Jul 2025 07:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D1C1E9B0B;
	Mon, 21 Jul 2025 07:37:17 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A77DA7F
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083437; cv=none; b=awQjaAmrWefvSrbd4lVzYrSUbE9tDiw7miQSvCTDIP9zgVmKHOmDIQhkXNOxDmMmzLBJxtA4+ldrENtNxpsa08Sn7y+R4tBrH91nXLUSsQQ9Q+C+MIKIO6qOg3A71m/mGYwQU0u9bs3xIPl5Vua34Uov1ZejayKFBPeShSdIV4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083437; c=relaxed/simple;
	bh=u30zCFle/hoisH6j5rIQi/9g0EX2xe8+r+fm3No35J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wg7+dnobR23h+C5+iS20yH7qoc94hPWs6atgnEKWbbbMBngQnlbGPQMxH+puzvp1QzwAHV78bAOcTzCIuvIxkpGSzIXcCNifD0dbnDks541deQsbyyLZz83ohIOUBn51Vr4Xgu2lJbqj6LHHN3Y3RjaKy21o96OAEk2Rz0IDsgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D35D068B05; Mon, 21 Jul 2025 09:37:10 +0200 (CEST)
Date: Mon, 21 Jul 2025 09:37:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/7] blk-mq-dma: move the bio and bvec_iter to
 blk_dma_iter
Message-ID: <20250721073710.GA32034@lst.de>
References: <20250720184040.2402790-1-kbusch@meta.com> <20250720184040.2402790-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720184040.2402790-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jul 20, 2025 at 11:40:34AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The req_iterator just happens to have a similar fields to what the dma
> iterator needs, but we're not necessarily iterating a bio_vec here. Have
> the dma iterator define its private fields directly. It also helps to
> remove eyesores like "iter->iter.iter".

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


