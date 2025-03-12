Return-Path: <linux-block+bounces-18270-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1324A5D780
	for <lists+linux-block@lfdr.de>; Wed, 12 Mar 2025 08:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323AD3B920B
	for <lists+linux-block@lfdr.de>; Wed, 12 Mar 2025 07:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E741F4E59;
	Wed, 12 Mar 2025 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HsyLaFLw"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFC7202C33
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765395; cv=none; b=Rh6mL97L+ruamoxuWmqv3TUu2cS9fi/c2RuZQPco3dhlCSNL9f4070zdi2WJRzk1CHfv3yWoNBlrpr2ahRX7OQHwNpqlXIdpBD9oToBc44OpZkuQrJkzJOfVpB6nTpGH+YFKRv17V7nJUWAjY/pvbow1LAQKoemsHf/E0BeMFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765395; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnx02ogUiVM99I5KTiQx17IXNhH1ytwQMRnELsB7J+0KUgEwZ12R9AtwQj4139VyQB/I+IIFU6ysCkiehhzc4bkeCP4g2aY70ElwPWa/H5BE8AftOznECttC0cuTn/IddKPXz+YWGRgDfYQiZAQX+ch6RoIugtAHOHy9gFf2to4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HsyLaFLw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=HsyLaFLw6Ka6YQpLV0Ze/6ptwY
	k/OZUsvAdZN//HvkUnLegNRHxUoq5RSiXNSbSu/7nxb1fuagmYmB2r1+faYPI028IFpxWP0eWQt63
	D0IFMbnVoZN/4SJHGSiYZ2LNluh0zmLDiGsJGFdYUhLtIb4bQI29jQWmVmNcHvXBYArVNQKQpcH6i
	UjeyiNJdQZpPVWzCm6okYVN5IvxNNZxiJa9260Jz3ohYrHYEtak2vTb3cHkMdCtlV64teb6/Mgv4r
	jMw42wQHWyf9WKqGahuKyzrq+7Kxqpvr5H9JZQyLiz2QjEJy7TlJVUbMgGoP1aS2lioGVgapehMwF
	O4tGhhyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsGkD-00000007jWJ-49AK;
	Wed, 12 Mar 2025 07:43:13 +0000
Date: Wed, 12 Mar 2025 00:43:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: improve kerneldoc of blk_mq_add_to_batch()
Message-ID: <Z9E7EX8wLt4G87SS@infradead.org>
References: <20250312072712.1777580-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312072712.1777580-1-shinichiro.kawasaki@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


