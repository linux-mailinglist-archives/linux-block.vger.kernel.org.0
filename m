Return-Path: <linux-block+bounces-24557-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E207B0BDE1
	for <lists+linux-block@lfdr.de>; Mon, 21 Jul 2025 09:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58226189032F
	for <lists+linux-block@lfdr.de>; Mon, 21 Jul 2025 07:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00C42820B2;
	Mon, 21 Jul 2025 07:40:11 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB28DF49
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083611; cv=none; b=CHmF8z1LZY7UFx+frH6Rnm38Z0LDd5l0UhuBBJbCLiK9+qFBRR5Vm7l+CTXv4sf3+cG/8K4fGDoAxhlcAXjA7VvMnZz4TVZFvIcjTuylnLJA4faL244arFkxoY9hSjQxNLC057uztF0xlrwU0dV8X2MikXctMtF2MYhKJyGU2EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083611; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T17BiQRzRl7LHpEmLQMnYBo1CBWz3YLxFo5p3oHoOzOqpsdBCozsBDt0eEHaca3RuhBqfpozdJgkAcWAYvyRgkWRxHluMqYjH0EoJgjn9SH+JPTnqxzHb6b9VzXQKwLxp0AAu7dCNLmXu9fLmkbzbI6k5NRW+yeeqJ5M8QogsfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A321268B05; Mon, 21 Jul 2025 09:40:06 +0200 (CEST)
Date: Mon, 21 Jul 2025 09:40:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 5/7] blk-mq-dma: move common dma start code to a
 helper
Message-ID: <20250721074006.GE32034@lst.de>
References: <20250720184040.2402790-1-kbusch@meta.com> <20250720184040.2402790-6-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720184040.2402790-6-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

