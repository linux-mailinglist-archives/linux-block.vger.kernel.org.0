Return-Path: <linux-block+bounces-3607-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744F5860AEE
	for <lists+linux-block@lfdr.de>; Fri, 23 Feb 2024 07:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 155A0B23AB7
	for <lists+linux-block@lfdr.de>; Fri, 23 Feb 2024 06:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7C0125D9;
	Fri, 23 Feb 2024 06:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="siIxltYv"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57144414
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 06:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670605; cv=none; b=qCQ+50PWlGUatblnLgvXaGTL2gTYNq7qVLYHy/VTnE0G/jPrA5NUrWp9Tb6wB5qeW06IJR+8nbkttEIjh9ILYaSGC828tE+1ywtr9QPgupCZ5VKwap2GKS8GTBWbWNJ6Chd89NYW+relqgTEBxQiFSQUPRER1+aUNhdAyRwvwPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670605; c=relaxed/simple;
	bh=SNUG1QSN5yL1QTc1bj4peYsaLuFcAnQjVZLATRHxdWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpvFdxTKu+MsXGGNRXm0T7vliyldiAlJuzK2d/Izcb1wbDvNKz0oY2fyuxTfcpvgfV1FYfBxL8fuFfZ0rT4XbBX+Rs3HQji+uKB4HBjjBeqGg2usvXAjFBQJmvfGB6YNXKJ6k6x78fExhS5F1abNMy0DfPE5yfNzHHnycYWZMeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=siIxltYv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SNUG1QSN5yL1QTc1bj4peYsaLuFcAnQjVZLATRHxdWI=; b=siIxltYvp2ou6quh2X4Kv1uExU
	VbXgOm1yCPyDdvAWJymUoBHR96+lwaSlyZwVpYXewOp63v5u/FXoojP6kzxHixed4XJyMGbC0R/Kw
	Ii5vHjECDxNSo7tmzP5ys5BvDXo5g9Z2yQRxmzb4FI0zrZzhkCkQBcMz2JWZdJr1rqgnjdJrj35l1
	bXipmT3jBelIeyc/jQVZ9Qq0KwCTQReHbxigkiK2WhUxMi6he+Ec7nwBTHXEEbeNxCqPiza2k/y8k
	UIFVHP5FcZ6hXj368Ro94thPxvL2RoYf4A8oluC1pk/1fQu8fdtsvLcv6jpzfB83AcUQQAW6mQYye
	Tn5PGuBw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdPHF-00000008D6M-3yfn;
	Fri, 23 Feb 2024 06:43:21 +0000
Date: Thu, 22 Feb 2024 22:43:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.org, ming.lei@redhat.com,
	nilay@linux.ibm.com, chaitanyak@nvidia.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 3/4] block: introduce io wait hang check helper
Message-ID: <Zdg-iav78mfWUKjo@infradead.org>
References: <20240222191922.2130580-1-kbusch@meta.com>
 <20240222191922.2130580-4-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222191922.2130580-4-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(ven better would be a task state to not trigger the hang check, but..)

