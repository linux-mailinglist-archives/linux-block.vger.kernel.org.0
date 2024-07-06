Return-Path: <linux-block+bounces-9824-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EB19291B1
	for <lists+linux-block@lfdr.de>; Sat,  6 Jul 2024 10:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C30A1F21E20
	for <lists+linux-block@lfdr.de>; Sat,  6 Jul 2024 08:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F7E21350;
	Sat,  6 Jul 2024 08:03:29 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E086612E71
	for <linux-block@vger.kernel.org>; Sat,  6 Jul 2024 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720253009; cv=none; b=IZiqsrhDaJzckP6POwZJAgX9ToXFTvFABnHaqN0SpNMNf2hFJV2Zq0KdmjQq/ulrG4zPrsIoZe24IQ7Hn88YqTfOGOh8blgeVTuo3yHc+uB+zSn/3MSYCSjiDC6Ny6S+L3KQH9f+1vDqoAuB37hwP2HTisLErM/uvrAzgLf16og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720253009; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOhouPEicyaU+RleaAhlBdC78SlxSzgX+Ov/c9kI20lzo5122hduEjVU0f8sgXucnYyOv65jjtK5tXx/OiCiUI1Lb6bGdzdnXeAp/srZKJNtFdef4OiwjpbDq6IJqWhplrgC6Y5vKqrZkyQkcAQ9kFpZ+wzaNevdrxcJKRl1NTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EB68B68AA6; Sat,  6 Jul 2024 10:03:24 +0200 (CEST)
Date: Sat, 6 Jul 2024 10:03:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v7 3/4] block: introduce folio awareness and add a
 bigger size from folio
Message-ID: <20240706080324.GA15556@lst.de>
References: <20240704070357.1993-1-kundan.kumar@samsung.com> <CGME20240704071130epcas5p131b210c30237386f2c786e81c88355f6@epcas5p1.samsung.com> <20240704070357.1993-4-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704070357.1993-4-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

