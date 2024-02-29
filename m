Return-Path: <linux-block+bounces-3857-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4724486CB52
	for <lists+linux-block@lfdr.de>; Thu, 29 Feb 2024 15:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7FC1F246B8
	for <lists+linux-block@lfdr.de>; Thu, 29 Feb 2024 14:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363CD12F58D;
	Thu, 29 Feb 2024 14:21:54 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9E37D077;
	Thu, 29 Feb 2024 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216514; cv=none; b=dke7rShamkI6qtKAy2C8NPyoyKPFvravWxhpNN8U/UXZRMUtJqH7fnovuvDBZQXDJVQiM3lWZkFTS8cvBEXq/mvNfNQph02ukiVX6KCsAnMw1GBfcw3GzuNEPWbXdOqahl5nN0lRit9+PlddkU1SSkwrVTdyC/NTM2bH2WfeFV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216514; c=relaxed/simple;
	bh=N10oLqVylLcwJnu9X0idj5h2ETN8EPMR4Q/8eWomANU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9CMRcxZ7+ynfUiZ+f7ucI11VBHHYlZ5+TE5ifg4cx8v+j9N0LrChgZCW0lqrAj2Bwe2vmoG2X9/rRxgbp1/nRQvcmK6nJ3hC4wfZXuFhEzt4RjxUalRQThDZO20yMoA/h22tXUPhpaWbrSnjjcBIhgvrHzEAr90igLmSX9tDFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1352068BEB; Thu, 29 Feb 2024 15:21:45 +0100 (CET)
Date: Thu, 29 Feb 2024 15:21:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>, lkft-triage@lists.linaro.org,
	open list <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: WinLink E850-96: WARNING: at block/blk-settings.c:204
 blk_validate_limits
Message-ID: <20240229142144.GA8348@lst.de>
References: <CA+G9fYtddf2Fd3be+YShHP6CmSDNcn0ptW8qg+stUKW+Cn0rjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtddf2Fd3be+YShHP6CmSDNcn0ptW8qg+stUKW+Cn0rjQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 29, 2024 at 07:44:01PM +0530, Naresh Kamboju wrote:
> The arm64 WinLink E850-96 Board boot failed with 16K and 64K page size builds
> Please find the below warning log on Linux next-20240229.
> First noticed on the next-20240220 tag.
> 
> This issue arises only when one of these Kconfig options is enabled.
>   CONFIG_ARM64_16K_PAGES=y
>   CONFIG_ARM64_64K_PAGES=y

That means this device doesn't set a max_segment_size, or one smaller
than the page size.  This configurtio has never been supported by
Linux (Bart has some patches to try to make it work), but with the
new block limits API we now actively catchthis and warn.

