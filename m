Return-Path: <linux-block+bounces-8495-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EE6901BC2
	for <lists+linux-block@lfdr.de>; Mon, 10 Jun 2024 09:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966061C215F2
	for <lists+linux-block@lfdr.de>; Mon, 10 Jun 2024 07:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83D4224F6;
	Mon, 10 Jun 2024 07:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fs0e1StG"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09BD225A8;
	Mon, 10 Jun 2024 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718003971; cv=none; b=H/zbpwYHToFw/raJQ4lfwxVV5oOD7GT+0qPf4fcLkW1NpE6p/R3+Ec1EOeuD6bVQm4JhM6co2pRIWAUBmVTzCKWMk5jQ10VwTRmORxrcYfr5JsCc0P9/biGqoVHIC6YKCgZJSc7iu3izMuM4Y5OhIqR0Fj0Q5DYdoGYi2QqB64c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718003971; c=relaxed/simple;
	bh=+3+8pvYoKswsMyqno+45ZQJVj65+3T8XwHUjOR/lutE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8PNY0vkCuyXEpekEw1eganCKKC+IsxQ+lK8H/QrEX/WqGVXAZI9K9Hydtbdf1/jvtaXMC17doepsYwlmmHnGBL9dfU3YnuuEs38mtx4qIEqTCnbw8yvq38nV/B7l7ExeXKP8JmrGuY2B+3t3V6ndfF6hO5vwsdpGmPE6XNto9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fs0e1StG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805C8C2BBFC;
	Mon, 10 Jun 2024 07:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718003970;
	bh=+3+8pvYoKswsMyqno+45ZQJVj65+3T8XwHUjOR/lutE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fs0e1StGB+Qgq9IZnQ+mC3pqmBk7Pq4yg5ngQGpXl9163oWf8kURAS6foOVO8T3EX
	 2T+MQuR4P9N73Isy2dwk2kgkuIqq4ToVdrDdHFIuvCbmtxLVmTfTBEyoGO4i/w1BaO
	 Jtp/FS/Yvs7BMbS/1ieBp9hboDVkYJKxdvrrNDR5hCm8oBrjc1WB07B8KvQJmI60BP
	 86oTIuHianVSesK5Ygz7eiiW27wg+CaHQEheVilqtvtevG9Y/qwCI6slZ/QR1FQQ2K
	 Gt+ajDCml6nNOdyy8N08ttQCEhj48Ad0EdbOeZPm6rCrGCzFkIemqf4YaEJ5xAuAIx
	 YayHhCgrrJdGw==
Date: Mon, 10 Jun 2024 09:19:25 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Benjamin Marzinski <bmarzins@redhat.com>
Subject: Re: [PATCH v6 4/4] dm: Remove unused macro DM_ZONE_INVALID_WP_OFST
Message-ID: <Zmao_ZvcsRECgE42@ryzen.lan>
References: <20240606082147.96422-1-dlemoal@kernel.org>
 <20240606082147.96422-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606082147.96422-5-dlemoal@kernel.org>

On Thu, Jun 06, 2024 at 05:21:47PM +0900, Damien Le Moal wrote:
> With the switch to using the zone append emulation of the block layer
> zone write plugging, the macro DM_ZONE_INVALID_WP_OFST is no longer used
> in dm-zone.c. Remove its definition.
> 
> Fixes: f211268ed1f9 ("dm: Use the block layer zone append emulation")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Benjamin Marzinski <bmarzins@redhat.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

