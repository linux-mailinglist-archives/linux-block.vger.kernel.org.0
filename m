Return-Path: <linux-block+bounces-7963-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3C98D53E5
	for <lists+linux-block@lfdr.de>; Thu, 30 May 2024 22:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED9B1F220DD
	for <lists+linux-block@lfdr.de>; Thu, 30 May 2024 20:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DF125634;
	Thu, 30 May 2024 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="H4aK/BD3"
X-Original-To: linux-block@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB4A18641
	for <linux-block@vger.kernel.org>; Thu, 30 May 2024 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717101260; cv=none; b=SnvO5BbI1Hwir6+YBPdbEDSx+X/fBSNiTLjjoDNizheP6x1mDP3fyIqOzJKGOtw34UtCR43Rduj+9fcUf9UyVCtpjBuGNT7F4nDhrVowspRvnHpUohLGZJ33BddR3abDoJj990Rrj4gcN1vS3GCwasc3xtGN7QmktZ3sT8mZ4R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717101260; c=relaxed/simple;
	bh=6swfumZTmGUzGhK6u/hystDqXB6Y8MqBLf+yfnuQlGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j4NzDdKmbqx/2m0ct/+H2SP21sY8BPbBJucgMeuAh8xuDSwHXs8C1f5ga2+eULfRbWCb0GzHxDof9g+ah4T6wxu6ngyCK52PY3jKoLIyqUeP9ecR656ZjfXvbq58xNHOD2RAKV6UYujpPjxmyE4DrSg4gSHdts35p3quFXh7HBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=H4aK/BD3; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Vqyf06xgCzlgMVV;
	Thu, 30 May 2024 20:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717101255; x=1719693256; bh=r5g6a4UvrpBD9yWXi3DqvJD2
	NLP6PVhHVK/DAC4rU/M=; b=H4aK/BD34pt+bstQWjzoJwm2k71GDr+0wHqQ28fJ
	Z3nrlnJ8c6u93FHrCosjnVCsKLs9vJg9cJAptmJTweRV2DNpfKwoja41xLJAoU1z
	oAXr0p6R/ev5ZFyG9egx0w1Z93Zo276LZUDtihjSmy5g6NPJeVv1i+IB0jeIKn+B
	PfXuAxS8Az7MHMAQxzYwawoaOJWC8I6YSRZrjGy6ITIS97iLMZJgHsOfT6/L3pmn
	xNxXYEnh0OEuVhRtTH2jnPZWUWPMwayDqn/dpLjmQ7lEtTilUXUm9eh5x9qyejwp
	2aa4PFH/OWESkuz1UMiQ+Yz7+cvq/HjW5e4NsyiwfL6lTg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id kVOOPgHbmz9a; Thu, 30 May 2024 20:34:15 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Vqydy4pG1zlgMVW;
	Thu, 30 May 2024 20:34:14 +0000 (UTC)
Message-ID: <64dd6d71-ac7e-4e5b-b8f0-8cce371a8d32@acm.org>
Date: Thu, 30 May 2024 13:34:14 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] null_blk: Do not allow runt zone with zone capacity
 smaller then zone size
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
References: <20240530054035.491497-1-dlemoal@kernel.org>
 <20240530054035.491497-2-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240530054035.491497-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 22:40, Damien Le Moal wrote:
> A zoned device with a smaller last zone together with a zone capacity
> smaller than the zone size does make any sense as that does not
> correspond to any possible setup for a real device:
> 1) For ZNS and zoned UFS devices, all zones are always the same size.
> 2) For SMR HDDs, all zones always have the same capacity.
> In other words, if we have a smaller last runt zone, then this zone
> capacity should always be equal to the zone size.
> 
> Add a check in null_init_zoned_dev() to prevent a configuration to have
> both a smaller zone size and a zone capacity smaller than the zone size.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

