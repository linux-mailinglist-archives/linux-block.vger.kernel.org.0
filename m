Return-Path: <linux-block+bounces-29677-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7B9C36307
	for <lists+linux-block@lfdr.de>; Wed, 05 Nov 2025 15:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF1B44F3A5A
	for <lists+linux-block@lfdr.de>; Wed,  5 Nov 2025 14:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92707239562;
	Wed,  5 Nov 2025 14:53:15 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EFA2DC332
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354395; cv=none; b=cwTgoGLIspZS7wzSaFCeJibTmX2Jg5v71Ykgaub6xOLhrj/81LlRhOYZSKSmBx5+S3juaTo1A+vnKG0MdICzz9HpLO/ZmZsWsaqbbLvWlCrLZodEsV9+844uRrjHpoWQ9/8t+l37O6q1OzGlW9UCDBmXvsCsz2MWWZhqTi38pxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354395; c=relaxed/simple;
	bh=nlkOGnSxulbLF2POFUoDKR9joA3LvWAMf6UXkbS5NMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgb2dAqq9zPnw9h3GHrB/0tFjl0zqSLAlSNCjQ61X240IYXwz6+DQU6cxKdUrMPxYIkXY1dsLlppw3qcPHFl/sHNhoOHpRNX7noDryHDFl4T1B26G0wTi34Ojd9bzV39Je9eR9ecm0hrrrQXNbT/EibtO23glxdFzCMBrBgsS7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 66876227AAA; Wed,  5 Nov 2025 15:53:09 +0100 (CET)
Date: Wed, 5 Nov 2025 15:53:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, martin.petersen@oracle.com,
	axboe@kernel.dk
Subject: Re: [RFC PATCH] blk-integrity: support arbitrary buffer alignment
Message-ID: <20251105145309.GA26042@lst.de>
References: <20251104224045.3396384-1-kbusch@meta.com> <20251105141504.GC22325@lst.de> <aQtiYd69E-3G_PC4@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQtiYd69E-3G_PC4@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 05, 2025 at 07:42:41AM -0700, Keith Busch wrote:
> This generally does pass 'void *' to contiguous protection data. If the
> actual protection payload is spread across multiple segments, though, we
> don't have contiguous data, so we have to bounce it through something.
> Declaring the union on the stack provides this memory for that unusual
> case. If the bip segment is big enough, we point the 'void *' directly
> at it; if not, we point it to the temporary onstack allocation. Using
> a union ensures that it's definitely big enough for any checksum type.

The union contains pointers, which are always 8 bytes.  But I guess
I can see now how this didn't blow up, assuming this was only tested
on classic PI, as the tuples are just 8 bytes and you just used the
pointer as storage?  I.e. these aren't supposed to be pointers, but
values?


