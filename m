Return-Path: <linux-block+bounces-3871-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8B986D36C
	for <lists+linux-block@lfdr.de>; Thu, 29 Feb 2024 20:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537FD1F22A6D
	for <lists+linux-block@lfdr.de>; Thu, 29 Feb 2024 19:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5F613C9F8;
	Thu, 29 Feb 2024 19:40:38 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C47313C9F5;
	Thu, 29 Feb 2024 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235638; cv=none; b=rT66LxPMkgZVlD6ns9i+XmQXSgcNo4aewSwHbFgzs1u+6cFuQIGHE7gP5FajeC7IIrvMLrotHNQW94PaJPU7zFlnJ7payPArX0SNQlELC57Hy5PDafd6UxHwnRT1+r3vL3qYNk+pZAWoOEPCla1gsZX83j/7E25t3iLukV+JN4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235638; c=relaxed/simple;
	bh=yK00L6WE5qS4GGI5HzxMo9ImkeiKQDvanPpfN7irD08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vxys+S4bI9rZQZ8nUJZpRUtcW+wPTIMy3JaxwdBHvN4gZxxtO9QsWKNZ3au7XXVWh9VS3v5NF8hbcV6P+n1WBC19C4zL2QU1GHNI/NSIUVNswKhjD/5q3XPrerH4vPA9x+fsnxwrpGTlQOpxUPa5Xal9OWw0eMjf4RgVUVmYVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A8C6D68D08; Thu, 29 Feb 2024 20:40:31 +0100 (CET)
Date: Thu, 29 Feb 2024 20:40:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: Re: atomic queue limit updates for stackable devices v3
Message-ID: <20240229194031.GA15191@lst.de>
References: <20240228225653.947152-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228225653.947152-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 28, 2024 at 02:56:39PM -0800, Christoph Hellwig wrote:
> I've run the mdadm testsuite, and it has the same (rather large) number
> of failures as the baseline, and the lvm2 test suite goes as far as
> the baseline before handing in __md_stop_writes.

When I pull in all the pending fixes, the lvm2 test suite works for
the baseline and this series, and shows no regressions.

