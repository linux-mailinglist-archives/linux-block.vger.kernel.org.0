Return-Path: <linux-block+bounces-3228-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738D8854871
	for <lists+linux-block@lfdr.de>; Wed, 14 Feb 2024 12:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282271F280AF
	for <lists+linux-block@lfdr.de>; Wed, 14 Feb 2024 11:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C481CA9E;
	Wed, 14 Feb 2024 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwcGMGCl"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558F41CA86
	for <linux-block@vger.kernel.org>; Wed, 14 Feb 2024 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910370; cv=none; b=oEVZme/AR2/8TvRSSaBNzlBRH6VRAf45SuAg8ajADGFgMOsU5JujcBe9nKmTlEkTfA2QsY+jcxZ2TVABMN0aDfiOvK5w3YS3r8vW7pta1yp/t+1/aLspobNyXBr7Vg7DytWsVXFzTgotAVae4HlDIv0AFxKf/LIPwmeMYt+v1DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910370; c=relaxed/simple;
	bh=hW5I/Ir+d46s9Ohf6XOV2MX7kI5E51Zbh3Rykkfl+pU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/3NFZolDv4GzvIWu2VDzV+O/RWtN5tJ0XfXImQaanKarphMlcYoWHyrXKjqR4WuuN12mq0Vmg/0Tf4dFNvrNcuIKP6cWjD6oJfe/Xb6Z8vS1JSUsPD6ou/D3XOvsl/ODCUKhz8Buf58hQyUeJKAZkCNJF4cvTPlCtLDsbsVoXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwcGMGCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784F6C433F1;
	Wed, 14 Feb 2024 11:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707910370;
	bh=hW5I/Ir+d46s9Ohf6XOV2MX7kI5E51Zbh3Rykkfl+pU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rwcGMGClMbRgGbLkOY5WBcOMDJ/UuHBXdU9GQl31W9HF9pgg4EeJb6fmu/usE7NAx
	 T9W3QL4iPIvPkQjMbgcxs+yomMhzy4cJbyezuPLTRInF/v3n3ZA9S1epgQ+wksbErq
	 XqQw3yuvuqkZJzUtb5qvAKsTsYoj0qcCFimL678kOb6kl5IW1p3ugwAWp7ioV/SFyc
	 52jqB3wKMXefTvn5IT5qf8jb+Or1OsLqnOm4njqzH9NxMigXeF3xkUMgfQ8LiRub9C
	 sZGUjhQ0xAo1Aq9h+fuszfpfEHY+jJbCfBEtD6Kh61FSPGvTSMf6wFVo22szrRSp2Q
	 /ZD3JxBxiLe5w==
Message-ID: <3156a69e-796d-4513-950e-963cb54647ab@kernel.org>
Date: Wed, 14 Feb 2024 20:32:47 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] null_blk: pass queue_limits to blk_mq_alloc_disk
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20240214095501.1883819-1-hch@lst.de>
 <20240214095501.1883819-6-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240214095501.1883819-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/24 18:55, Christoph Hellwig wrote:
> Pass the queue limits directly to blk_mq_alloc_disk instead of
> setting them one at a time.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


