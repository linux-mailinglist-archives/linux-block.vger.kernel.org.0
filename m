Return-Path: <linux-block+bounces-23242-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A40AE8A35
	for <lists+linux-block@lfdr.de>; Wed, 25 Jun 2025 18:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812EB1C2109F
	for <lists+linux-block@lfdr.de>; Wed, 25 Jun 2025 16:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7A52D8DBD;
	Wed, 25 Jun 2025 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="phNmOFzd"
X-Original-To: linux-block@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE5A2D5436
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 16:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869748; cv=none; b=tFt86ZDPLXWniBdMv6XVoSuGVNOmzLX6oKOEGIocJFK8pu3H5yykHS8+C4ZRRndvN77MBw5aDqcdUmEF8ZIL9g4W9VkpQjA9Q6xMaHA2hHp10DBJjX3l0D0EycbH8CBL7xTwUv9Ote7bQV59uglhmy+8V0z5rFPqkMEwsutNNbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869748; c=relaxed/simple;
	bh=Vs+aa4gJBkLb003tTeHsMHpeR6ie6rbTwrPUl+a/bDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kNzBBIN1CBfNRipYyWKIb+3PZNaHQWrmeDguET7Ck9+KaMzPP1UohKVb+JQ7/iPDgXaTayJZU3kbretAmtfe+vlExSFKA4W3/tA75seL5H3MqNUYRbaCsdMssKn4txLJUJ3O7c2SE1cKYAS0JQaZFCwsh/9Bsag0L/btQpCdQqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=phNmOFzd; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bS7012PLqzm0pK4;
	Wed, 25 Jun 2025 16:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1750869743; x=1753461744; bh=UDD0vMX18jwFgJtkFla1A7Lk
	hKWY1E4DqsARkQZpma0=; b=phNmOFzdLYmEz2qImXmfH3DEpYui3Rj6/9SdKAIf
	D98kZLL1sIae3iZG5+tTe9WETfD2eEEpEriJHiB+2fPm1NgEgQuaMHU0UWG/Ngyo
	hLhFxyNGpy2iLV1gY6ZoHxvDbgp9xA/7O/FSElNzDE+myAli6OAOUFS1T47xM8rU
	yfpTBEtPLTuI19HaEuqx3Ps9hPG97r+Mi2P0KqXHSuuLbuJ180MHEmRsPRE+JaRb
	NN40on4oTzvPNBzLw1bZFFa6z4Nf8Z20G5ulncnaYuoVxa6/YgPTCrtVR73EtRUz
	zWyArfAO12pXRwWoE2TfJebMkZ88auoqTNcQZ8H2S1Dybw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id VntgxNwd3UIN; Wed, 25 Jun 2025 16:42:23 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bS6zv5XtKzm0jwB;
	Wed, 25 Jun 2025 16:42:18 +0000 (UTC)
Message-ID: <e9a291a0-a8d5-4358-a28b-4c8f91d45942@acm.org>
Date: Wed, 25 Jun 2025 09:42:17 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] dm: dm-crypt: Do not partially accept write BIOs
 with zoned targets
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
References: <20250625093327.548866-1-dlemoal@kernel.org>
 <20250625093327.548866-5-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250625093327.548866-5-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/25 2:33 AM, Damien Le Moal wrote:
> Fix this by modifying get_max_request_size() to always return the size
> of the BIO to avoid it being split with dm_accpet_partial_bio() in
                                           ^^^^^^^^^^^^^^^^^^^^^^^
Two letters got swapped in this function name ...

Otherwise this patch looks good to me.

Thanks,

Bart.

