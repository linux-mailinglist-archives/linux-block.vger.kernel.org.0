Return-Path: <linux-block+bounces-23231-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0C7AE8881
	for <lists+linux-block@lfdr.de>; Wed, 25 Jun 2025 17:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6384A5A02
	for <lists+linux-block@lfdr.de>; Wed, 25 Jun 2025 15:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A7327F183;
	Wed, 25 Jun 2025 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xUaNPyb1"
X-Original-To: linux-block@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42CF267721
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866285; cv=none; b=YLlkHoimEFexdH7b5wbrCSTEy7QzFW+SZnojd36aYwpeGavXhRJYsiu1WXmVcMTG0PFVdfVR4xn7q6/FTcNXWlDJrBdVFAJSDPhv0pszRhJmas2WQ1N26cwMRNQKk9/fGuk48LYrjTntQyReuYNfZ6H2VYSxwSiaE7HgCb/mMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866285; c=relaxed/simple;
	bh=QU8cHm865PG8GZW+E8YHEqNkO3X9mENbFeBL4EsQr8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=be2F77kwJbZ4+KroWOKf/yX1gHek6nwfen4KC/I+KiATcnjc+J+id2d+lgspFT45YJN3GmzijMY0go8SlKyqQXv2b529tIkJJ+oMJv/pnmMNFThvPfRDXCLFRI4+SQKiGalwbsH+CIuPjj8WaVG5pU0P/nC/ASOIGNCZGK+3gi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xUaNPyb1; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bS5jP6ZKWzm0yTt;
	Wed, 25 Jun 2025 15:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1750866280; x=1753458281; bh=Lu2nFeaQG5lrfoWQUO09INdN
	C2XEYIo8kBq9/G6fMiE=; b=xUaNPyb10dpURwEX0y0MaOyjHzB2jjn65Tj+19gP
	N4ubSRZGtsw36Kb4XI1EKODMwIsp8lekBoWJl0CeDHMPkxqQiNUACGKmx6BfJtHu
	8ihUyNO56Pempj3WBHDCRoGPkXXf60/xvJthiiErl+7UQiRQJai+6PUblFCKkHZh
	cc52x9O7yPhXqOZhjAbosf0j9RZz9AS2kbP0YHOD8N7nqpaciRy1ME5e+ISjeurS
	oFri6nNLBZKvg8IwwSG40uMvP1LmOeiBsNQflRh731YZiHxRt/a6eb5wiz2WxSwc
	sLbZOw1xebhEb+sRnReeG2yJCh5xLeOZPiKcalMt3EBTUA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id SeNUzO14Yv0R; Wed, 25 Jun 2025 15:44:40 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bS5jH2vwHzm0yQQ;
	Wed, 25 Jun 2025 15:44:34 +0000 (UTC)
Message-ID: <169f32b4-4009-48c0-acdf-bb7d82f93a0a@acm.org>
Date: Wed, 25 Jun 2025 08:44:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] block: Make REQ_OP_ZONE_FINISH a write operation
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
References: <20250625093327.548866-1-dlemoal@kernel.org>
 <20250625093327.548866-2-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250625093327.548866-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/25 2:33 AM, Damien Le Moal wrote:
> REQ_OP_ZONE_FINISH is defined as "12", which makes
> op_is_write(REQ_OP_ZONE_FINISH) return false, despite the fact that a
> zone finish operation is an operation that modifies a zone (transition
> it to full) and so should be considered as a write operation (albeit
> one that does not transfer any data to the device).
> 
> Fix this by redefining REQ_OP_ZONE_FINISH to be an odd number (13), and
> redefine REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_ALL using sequential
> odd numbers from that new value.
> 
> Fixes: 6c1b1da58f8c ("block: add zone open, close and finish operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   include/linux/blk_types.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 3d1577f07c1c..930daff207df 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -350,11 +350,11 @@ enum req_op {
>   	/* Close a zone */
>   	REQ_OP_ZONE_CLOSE	= (__force blk_opf_t)11,
>   	/* Transition a zone to full */
> -	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)12,
> +	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)13,
>   	/* reset a zone write pointer */
> -	REQ_OP_ZONE_RESET	= (__force blk_opf_t)13,
> +	REQ_OP_ZONE_RESET	= (__force blk_opf_t)15,
>   	/* reset all the zone present on the device */
> -	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)15,
> +	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)17,
>   
>   	/* Driver private requests */
>   	REQ_OP_DRV_IN		= (__force blk_opf_t)34,

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

