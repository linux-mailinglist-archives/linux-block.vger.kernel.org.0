Return-Path: <linux-block+bounces-6765-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1D58B7BE9
	for <lists+linux-block@lfdr.de>; Tue, 30 Apr 2024 17:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12EE1B292D3
	for <lists+linux-block@lfdr.de>; Tue, 30 Apr 2024 15:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07B7143722;
	Tue, 30 Apr 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VaTFp0P2"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B8A1CFB6;
	Tue, 30 Apr 2024 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491411; cv=none; b=ia+wMA/+LtCZDCfb7gE3FmbM643u36HgJeLJ7ry2gbiXymFJJoQXGE+oU4wQfFnVi17TZok6gCEEjrXRc7aqew2LyVJOkX+BjXKHJh/MX0fVzrTGldvHwAq25z0K0e8NSvVyXhfswGTkl3qTcQTUbRE7f6FRmm6SXVXHP6R9aro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491411; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5781dmgEi9z4xec6985gQSS3qfbDNQ4nnS3bXaw2ahFR+wuedRQcTI0WX5/uEcKx+lECaIPK+fr4ejupEFY164pZ/aQN+Twu3Xe6mkXDw9nH8cHaPPGLzKgvnV00aHw2wnGWvezMXMlLy47WTMoB/10fuyG1KtXteB/JI+zChs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VaTFp0P2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=VaTFp0P2XQR326H+nzkV1wt4k6
	t+n32xAQCEaInSYEX1xJb6vlTVem4n0YGQxxAwrNyffcYSR6WlMnWV+SAhBCmdl2UzzVecfJP/hXk
	2SHQVLbUvmZYParS333TrHDhUX9sBEOHkAqPMfmi7HkxSNLT1oMgBxDnuzNUyzPKiSn6cVOpZqoZi
	LJ0PANeyqwUlnvJ8IEd1phdsFO5SiAlv+uTDPQToGSP+EgOBh0sMOlU9+nWvSWDn+sK7XPzIFNjnK
	3YlvB810cMpNPXmuFB6D+Ha77yH8nVSW62CnD/LIoA6fGwbhFBebfbRshy+PURQzpquQL1bx7k64n
	J7j0uDBQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1pXG-000000074fH-0YvK;
	Tue, 30 Apr 2024 15:36:50 +0000
Date: Tue, 30 Apr 2024 08:36:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 13/13] block: Simplify zone write plug BIO abort
Message-ID: <ZjEQEn7Pd9iXA2xR@infradead.org>
References: <20240430125131.668482-1-dlemoal@kernel.org>
 <20240430125131.668482-14-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430125131.668482-14-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


