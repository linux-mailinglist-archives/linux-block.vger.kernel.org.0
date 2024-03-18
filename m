Return-Path: <linux-block+bounces-4704-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE5687F3E8
	for <lists+linux-block@lfdr.de>; Tue, 19 Mar 2024 00:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA8E1F21BF3
	for <lists+linux-block@lfdr.de>; Mon, 18 Mar 2024 23:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F2C5DF1A;
	Mon, 18 Mar 2024 23:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eF8eBOSK"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83C5DF13
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 23:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710803917; cv=none; b=SLWkMyYrjmrTb5zzgBD9PMBO1P1IgEyhVcQgAYvEfSkK/dZ8p0W28YCa45vYPiDHrhuII/cr4//u+fBrk4nMLbMonZhIHHD0pqkW99zZLSRaT6HSLd0AdMExaAVrYrBRORgU1gy0q11YLqshP/JTNL7dPLhqzWj/uime8ncLEsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710803917; c=relaxed/simple;
	bh=nZ1NiGSQ071EQIlkO+d2E1vpEXQOeqkJAG3gjE33Eb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AH0KKU5qDskvhApH2rjj22+BbXUu/x+93yEdxi9b7J0LgVvXNIjNjb2Wg6VNbasoHOJ55zP2/Wptv6m2jaKzDii99RRPSfmMsgpGMoD+P+KzGSTTT9BDOyPcrmPlpWcJJ2joDWavyYqsJ/nvshAbabWjOgzstokQolzCCRrsKkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eF8eBOSK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nZ1NiGSQ071EQIlkO+d2E1vpEXQOeqkJAG3gjE33Eb4=; b=eF8eBOSK7dXhbiy4mufJiIkEf1
	wSzAHJ0U2+7hT15B+X09IDE7oaxfqZIytN/FjIX7FVk0Xbs906BTQR5y+aAaybDf9emsDKcInYtKC
	hkbbLwCMFE+tCI0pI2wdhaK+Lwdu3xzxZ8iHWS7SjM/QDiokAbLrKzXFgcYs6RjlCVfKcGhIZ7fUz
	vXLXX3/iSFBCydCgXjAk34cw/GcQcHPzTvIrUm3Syq2jdmifCzJ4gc7gMS68dzwwjdVX1XkJqsNFO
	qCk7dGUDJBBc/ienhL4Y9EEonbOOXC4nEuS5HWI31uEoo/SQ3TN+zFPayIxzWIeUbSpDHLJEXJNuG
	fsaUUyWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmMFV-0000000AWOy-3TcS;
	Mon, 18 Mar 2024 23:18:33 +0000
Date: Mon, 18 Mar 2024 16:18:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
	axboe@fb.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Gregory Joyce <gjoyce@ibm.com>
Subject: Re: [Bug Report] nvme-cli fails re-formatting NVMe namespace
Message-ID: <ZfjLyfptPVT7wa0_@infradead.org>
References: <7a3b35dd-7365-4427-95a0-929b28c64e73@linux.ibm.com>
 <Zfekbf0V5Dpsk_nf@infradead.org>
 <1a37aea5-616c-445c-a166-e2dc6fa5b8f5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a37aea5-616c-445c-a166-e2dc6fa5b8f5@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 18, 2024 at 10:26:23AM +0530, Nilay Shroff wrote:
> I have just tested the above patch and it's working well as expected.
> Now I don't see any issue formatting NVMe disk with the block-size of 512.
> I think we should commit the above changes.

Unfortunately I think it's going to break splitting the bios for real
multipath setups where the capabilities between the controllers are not
identical, i.e. another symptom of the problem of what limits we should
actually inherit.

I'll go backto the drawing board and will send out another patch.

