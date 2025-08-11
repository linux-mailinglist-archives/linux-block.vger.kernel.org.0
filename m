Return-Path: <linux-block+bounces-25466-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D8FB2065F
	for <lists+linux-block@lfdr.de>; Mon, 11 Aug 2025 12:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B763AA3AA
	for <lists+linux-block@lfdr.de>; Mon, 11 Aug 2025 10:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935A72253FD;
	Mon, 11 Aug 2025 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g8SAFBFU"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F726529E;
	Mon, 11 Aug 2025 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909536; cv=none; b=fFeBBY56Y7cWJa1vakS+wQ3aTWMsdeRvFAKU1rYHjzd5i5mqHh/R/P212alUXhG+P8KcqLeg/lTNsEu6iwBArrhEUScgQvj5hPyDgq9byC+eGDd9B4dk9pGgbZE3Znub72Ohpa+DYygXRLHaN/zhi9Wpmvl/IFNJEGrTZ4pSwy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909536; c=relaxed/simple;
	bh=nNhBGgfo5UDY3UdB7sNOLf/9518M0X6GiNtIAdmbeFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AClfWHe19Fnsv1u4x4EjvSQQ3d326iS5HWr6WtGKbtjWwPb/e4NvYfIDvKO86vwCewODK2Rn8iZV/uyf6Pr+0wpDMDPHAW43Hhs55trz05F3tTgTWvk0ocnYyKUjk6ChYSMNkkWi3V3au/PajX+ZhLyO1aNzfXBLX0ssdOpGVVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g8SAFBFU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r0kNG01CA6dOzzsRnPvIcMq2oWocxxH3LcP8Ljz9034=; b=g8SAFBFU7m+GF+PrkhLKmFMoVv
	aTlPYoUoQxhawI1WRbb6rB+6ky+vo+mzcKjFCLYDo2Wlx3Jn5gnBP9JhbBdUWweYbEkgm7ZXkQeC0
	rRRJtqtfZPc49dnFElvG6m0stugCZWJbxnbsdjzlVLhly1tqCHHiY5guJcTS8a5eqVs5SncvdE5WP
	SkmGvWu9/bUKB8MtNWxlURk1WhT3ykWhV7WPjfGlfEcGVCs5cbgTaglajbm7SUd30A3qQxD1OTBSm
	o+un9nWU4NtNbgZEPj5Gy/hl9qLx/Fyn/pfIP0/RcLPalLad9zGGNh0Hq7XIqGPB322mXb2bvJH3x
	AKzFzeiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulQ8U-00000007PQj-3cIg;
	Mon, 11 Aug 2025 10:52:14 +0000
Date: Mon, 11 Aug 2025 03:52:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: introduce flush_policy sysfs entry
Message-ID: <aJnLXmepVBD4V2QH@infradead.org>
References: <20250807034838.3829794-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807034838.3829794-1-chao@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Aug 07, 2025 at 11:48:38AM +0800, Chao Yu wrote:
> This patch introduces a new sysfs entry /sys/fs/f2fs/<disk>/flush_policy
> in order to tune performance of f2fs data flush flow.
> 
> For example, checkpoint will use REQ_FUA to persist CP metadata, however,
> some kind device has bad performance on REQ_FUA command, result in that
> checkpoint being blocked for long time, w/ this sysfs entry, we can give
> an option to use REQ_PREFLUSH command instead of REQ_FUA during checkpoint,
> it can help to mitigate long latency of checkpoint.

That's and odd place to deal with this.  If that's a real issue it
should be a block layer tweak to disable FUA, potentially with a quirk
entry in the driver to disable it rather than having to touch a file
system sysfs attribute.


