Return-Path: <linux-block+bounces-9202-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BCD911A33
	for <lists+linux-block@lfdr.de>; Fri, 21 Jun 2024 07:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011481C20F0E
	for <lists+linux-block@lfdr.de>; Fri, 21 Jun 2024 05:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0962A8FE;
	Fri, 21 Jun 2024 05:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="apOb4rvH"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A82A47
	for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 05:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946935; cv=none; b=Ydria0GH7RHu7x8RTjqPWeQLxTlvepjW9xdPFkDUQLVBn5yGJzylaNmgHkjCBTYLmFfJCcy126KtM/DsJtSf9CfFVgfUPOUF0A0hj1eVkTJcY6zgWA7yXeXq+ODwQfUf8CXwywLJYcrXNu2BnHVbwl2ykUMR/+OwHy8SLgb4Xz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946935; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jR9XODKoVxtUVspXfeNY99dR9MtQ/d++NeuNfPWzEIbHtvubsF9QE1WkfYorWiaT037c0Hz1f9HcSdM8D23vLtjom4yFvMQEF8ellAdTXDAp1ooAiwFh+kIvpTJ8FnxmtIezVVCJ9EzgDGcX2AEbFNR3QmP3+LbP8By7xyohmk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=apOb4rvH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=apOb4rvHaFO6sYgtyK7P0ZKBI5
	0Z40VIu8yQRpkzl4L7XTwOJDKHUkLQloxCnP2j03bDiRYWLN8mx6PKBTSs2HUSj9g6+SEmijNv7NF
	wrrIdAWXAR42SLZf0j8FD6YYPHxHkbefS6VAWFa8RmOHHN98shu9FegYN9uZY4E0wVusgGdG9/DQ1
	2oED2u6ydqU4KctVeyONrgjxP1jGJ1aKFrb8/5lOR/7oXtMA3ERx0C5N7B7ZZJFZlrSzKOsuJitfC
	vTg/p4fSTz+vYtqeWRkTEx9a74AYX8WeorH0fA7RO04CG0jR+YLYWV2SagJRGKo1lAD2ee2mcvNmd
	zIrpcXVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKWcY-00000007kTZ-1wmB;
	Fri, 21 Jun 2024 05:15:34 +0000
Date: Thu, 20 Jun 2024 22:15:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block: Cleanup block device zone helpers
Message-ID: <ZnUMdkmLDDDvrIEE@infradead.org>
References: <20240621031506.759397-1-dlemoal@kernel.org>
 <20240621031506.759397-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621031506.759397-4-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

