Return-Path: <linux-block+bounces-6346-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EA98A8904
	for <lists+linux-block@lfdr.de>; Wed, 17 Apr 2024 18:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674AF1C22FCA
	for <lists+linux-block@lfdr.de>; Wed, 17 Apr 2024 16:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8468C16FF4A;
	Wed, 17 Apr 2024 16:38:54 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4780517107D;
	Wed, 17 Apr 2024 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371934; cv=none; b=hqlaWuKve20SdblGrboivwrRCjy9qKU3dxgqoKXKUCub/7QGV8+aFbHQOjl6RV4qjDYslHWkBYsn2P08p2Z/10ORPOlPugHlHCv8FoM55odFeGtcviPEY2VfZqXceNUZKdFcjZO5H2xqllO/ufVVyLroRUppKarIoiso5fxZfF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371934; c=relaxed/simple;
	bh=pWWsGIa+qqlCPys+lIXlj1pGncTOA9qcCb+9ZHTfLLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=As0vSaBZAMjMyIDH7HEYRS5Kuo/2nOB+FQ6Ty1MzZTBeNyRTE6hW/x2UDsGJ/GD9fnVJi1AtEPy8HX1MbMBs3uovz4f1Mk8R2agXJdeoaz8au16SsYepaU8hjQdrFNkFJ1hF2KuYAlnbZFvGqHS0Zt6vmpKKEDPBcd1ObzLDfcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 33FB268CFE; Wed, 17 Apr 2024 18:38:48 +0200 (CEST)
Date: Wed, 17 Apr 2024 18:38:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: API break, sysfs "capability" file
Message-ID: <20240417163848.GA8345@lst.de>
References: <ZhT5_fZ9SrM0053p@gardel-login> <20240409141531.GB21514@lst.de> <Zh6J75OrcMY3dAjY@gardel-login> <Zh6O5zTBs5JtV4D2@kbusch-mbp> <20240417151350.GB2167@lst.de> <Zh_vQG9EyVt34p16@gardel-login> <20240417155913.GA6447@lst.de> <Zh_0bfqBsJFyJKgT@gardel-login> <20240417162257.GA8098@lst.de> <Zh_4UbT0m12EAFc3@gardel-login>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh_4UbT0m12EAFc3@gardel-login>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 17, 2024 at 06:26:57PM +0200, Lennart Poettering wrote:
> Hmm, so you want to generically allow toggling the flag from
> userspace? I mean that'd be fine with me, but it would feel a bit
> weird if you let's say have a partition block device, where you'd
> toggle this, and then you have two levels of part scanning, and then
> you toggle it on one of the part block devices there and so on, and so
> on. Could that work at all with the major/minor allocation stuff?

Oh, no - I do not want to allow toggling it on the device for
partitions.  That would always fail.

> But let's say you add such a user-controlled thing, if you'd add that
> I figure you really also need a way to query the current state, right?
> which is basically what I originally was looking for...

Yes.


