Return-Path: <linux-block+bounces-31986-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 062C8CBEB11
	for <lists+linux-block@lfdr.de>; Mon, 15 Dec 2025 16:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40AF73020170
	for <lists+linux-block@lfdr.de>; Mon, 15 Dec 2025 15:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551DD29E11A;
	Mon, 15 Dec 2025 15:35:48 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1C4309EE3
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765812947; cv=none; b=UyiVIRFBP2pMfkCbSILWyIW/FC3ikK2HB7QYFKl8s4ANSxIELO92hiFdnBSzqt973OdVQTF5XcePaUuaM2Zmzy1RLW7zlYLVnQGNczpjGL8ZEOYpxkOJhSmXsUpY6iwcLkRjd8pU/N+oi32jEIgjXcm5zspReGESRmelbT0Pdao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765812947; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfZEVn9prCx6d9q2aGJG8/ZnqIaNpMv8JEgRe7Jje3e2yqHAdWQpcGS2YmqL8uSnrn4e/Nqf+ZGvzkfqkH0kQlxrcfVU5+ochKhBa9+gAe3kXjA2UI51BaZxcscz/BqfFKkqsqBpMWuEd3Ipem/le9gYWPeU9fIgr+z535uyl20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4FD83227A8E; Mon, 15 Dec 2025 16:35:39 +0100 (CET)
Date: Mon, 15 Dec 2025 16:35:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Yongpeng Yang <yangyongpeng.storage@outlook.com>
Subject: Re: [PATCH v4 1/2] loop: use READ_ONCE() to read lo->lo_state
 without locking
Message-ID: <20251215153539.GA3326@lst.de>
References: <20251215152104.6679-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215152104.6679-2-yangyongpeng.storage@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


