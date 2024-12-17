Return-Path: <linux-block+bounces-15415-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E39809F41A7
	for <lists+linux-block@lfdr.de>; Tue, 17 Dec 2024 05:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33613169F0C
	for <lists+linux-block@lfdr.de>; Tue, 17 Dec 2024 04:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721BA13DDB9;
	Tue, 17 Dec 2024 04:18:49 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB89145346
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 04:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409129; cv=none; b=UEzvUa8R+UaUUZEnZHIbaMNLfVYXU3LxfHIaeeHkM0A6z/QVB2t0jBgWszOKrVq+XTmilT8x6n2/8kq1V6buAvW4KeDwwyxUAsBwaTk6YVxb1MguutJmxpmzxF7LdT2NMGanQ3TAvw8UNCz45Pjoc+X5QjyJjyajdHBWRVURpsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409129; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYmOpOHAOcm9coOG0CLtmjFH/cck1Gnu3tLhtzFgNpZbpg2VZZZffWIzFRstRhFMvU0NESz1KapiX3UX1ia3QrshHzHS0YfWYHUA4oNC30Rhsl3e/NqJWBO1Q02HDVxyhSvq4PtZIkU2oXcpTvq9W32aEXsME6fIFt7mC3Jk1b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6F4EC68BEB; Tue, 17 Dec 2024 05:18:44 +0100 (CET)
Date: Tue, 17 Dec 2024 05:18:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 1/6] blk-zoned: Minimize #include directives
Message-ID: <20241217041844.GA15358@lst.de>
References: <20241216210244.2687662-1-bvanassche@acm.org> <20241216210244.2687662-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216210244.2687662-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


