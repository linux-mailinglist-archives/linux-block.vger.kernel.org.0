Return-Path: <linux-block+bounces-5720-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C85289785A
	for <lists+linux-block@lfdr.de>; Wed,  3 Apr 2024 20:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6511C22F8B
	for <lists+linux-block@lfdr.de>; Wed,  3 Apr 2024 18:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996FC153810;
	Wed,  3 Apr 2024 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aHZAKSuQ"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBB63D60;
	Wed,  3 Apr 2024 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169609; cv=none; b=X+5s3LUgijZ3+giboivTlkoJzVB4Axzv/wtAQHcRerD3lrUt7IPCDv/+4CaIvwBb2aV9wctigDpeNykQHlXkNEE+6DwtK7diYDwgFyD5SqRBvRL49CTnGI7IzPE7XVGK4yPKC9ExzpwEu3hC4i7sVcLjl1rtd9fQT2Z/KujfbXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169609; c=relaxed/simple;
	bh=mKkzeEBBqz/gTib0prGhwYPBjEjT54fc9L8qJ/6eNa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnI9BfYzaeYnXjGeLMqgOwVtYKkyRymfFZUPA7Hl0pQ3goHEnRyIUdVGppK7UtHWFfBluCsC0aVWJjjrrcvH3SpDm2UbPtt1nNcdjg0YrtVrSCVIReMsU/34WjgQyVSN9+jqsuRpmqdKvhK2rvZVfuOvi5sbFDkNytST5z65K0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aHZAKSuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9DBC43390;
	Wed,  3 Apr 2024 18:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712169608;
	bh=mKkzeEBBqz/gTib0prGhwYPBjEjT54fc9L8qJ/6eNa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aHZAKSuQLrIMeawocgg7tTb81IdEGpoLVz2877APmYB6mWEaK/+7np/LYaTVDWZ0P
	 5lJVwlG/isNM3Xpc2E/EngdydGC/JakmnkqCQZMptz/L9LctvaWGyFycnQdd2IwDh+
	 MoDjVrNlb95usgW8HiCH/Uc8erJaxCiFzrcsyoGM=
Date: Wed, 3 Apr 2024 20:40:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: hch@lst.de, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, sashal@kernel.org, stable@vger.kernel.org,
	Francis Ginther <francis.ginther@canonical.com>
Subject: Re: [v5.15 Regression] block: rename GENHD_FL_NO_PART_SCAN to
 GENHD_FL_NO_PART
Message-ID: <2024040306-putdown-grain-daf7@gregkh>
References: <924449dc-9b1f-4943-afe3-a68c03aedbb5@canonical.com>
 <2024040329-unstopped-spelling-64c8@gregkh>
 <a0819f54-7469-4c94-b567-71f634c84ac1@canonical.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0819f54-7469-4c94-b567-71f634c84ac1@canonical.com>

On Wed, Apr 03, 2024 at 02:06:28PM -0400, Joseph Salisbury wrote:
> 
> 
> On 4/3/24 13:54, Greg KH wrote:
> > On Wed, Apr 03, 2024 at 01:50:09PM -0400, Joseph Salisbury wrote:
> > > Hi Christoph,
> > > 
> > > A kernel bug report was opened against Ubuntu [0].  This bug is a regression
> > > introduced in mainline version v5.17-rc1 and made it's way into v5.15 stable
> > > updates.
> > > 
> > > The following commit was identified as the cause of the regression in 5.15:
> > > 
> > > c6ce1c5dd327 ("block: rename GENHD_FL_NO_PART_SCAN to GENHD_FL_NO_PART")
> > How is renaming a define a "regression"?
> The "regression" is experienced after upgrading to the kernel to the version
> that introduced this commit.
> The v5.15.131 kernel works as expected, upgrading the kernel to v5.15.132
> breaks behavior that worked in a prior kernel version.
> Reverting commit c6ce1c5dd327 in v5.15.132 allows the experience to be as
> before in v5.15.131.

What "experience" are you talking about here?  Please be specific.  What
exactly "broke", what is the build error that happens?

> > > I was hoping to get your feedback, since you are the patch author. Is the
> > > best approach to revert this commit, since many third parties rely on the
> > > name being GENHD_FL_NO_PART_SCAN in kernel headers?
> > External kernel modules are never an issue.  Is this a userspace thing?
> > 
> > >   Is there a specific need that you know of that requires this commit
> > > in the 5.15 and earlier stable kernels?
> > Yes.  And Christoph did not do the backport, so I doubt he cares :)
> > 
> > Again, what in-kernel issue is caused by this?
> 
> Third party code that relies on the kernel-headers will no longer compile
> due to the name change.  Should we not care if we break things, even in
> userspace?

Is this userspace, or is it kernel drivers?

If kernel drivers, you know that there  s no stable kernel api, we
rename and change things all the time, even in stable kernel trees, for
good reasons (see the set of patches that were applied that contained
this change.)  Do you want to have unfixed security issues, or do you
want a secure kernel that happens to rename variables at times?

If userspace, please point me at this and why hasn't it broken in newer
kernel releases where this change came from?

thanks,

greg k-h

