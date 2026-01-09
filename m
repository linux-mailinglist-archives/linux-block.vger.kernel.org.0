Return-Path: <linux-block+bounces-32771-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4648ED0746D
	for <lists+linux-block@lfdr.de>; Fri, 09 Jan 2026 06:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2471304BBDA
	for <lists+linux-block@lfdr.de>; Fri,  9 Jan 2026 05:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26162367CF;
	Fri,  9 Jan 2026 05:51:42 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F389822423A;
	Fri,  9 Jan 2026 05:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767937902; cv=none; b=rk93kOujcuEz0H7rW+eWoIzzLV59MeGf027GWL2YEB6WMi4fkzZo6FefKZ96h1zZ24hGufGG+oHDIxILJGiXMqJ8/UZfdroAJe15EePj0zDbub+tTWE3gziUWKTMp+L64NyuxnKaQbtRNkf/E7S4JKNy2F8v6lgB02QnwKDMX0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767937902; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERX7oDixVm0X9zSu5bdlbKUSqpKg4rj6lNpdv6M8LjIlwL2YwB2paT+FDMYOuZHJs4TS1Y6thOlfotomkru6NkabnY/v6A0YKt5C5XQSzvaNlRffO++xXRXK57WPeoQck6vAqaK2SMyZ3XH8686Nctwm+kxBQRW7JL+Q2b+nvLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 268E767373; Fri,  9 Jan 2026 06:51:36 +0100 (CET)
Date: Fri, 9 Jan 2026 06:51:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/3] block: zero non-PI portion of auto integrity
 buffer
Message-ID: <20260109055135.GA4949@lst.de>
References: <20260108172212.1402119-1-csander@purestorage.com> <20260108172212.1402119-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108172212.1402119-2-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


