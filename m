Return-Path: <linux-block+bounces-7702-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A863C8CE3F3
	for <lists+linux-block@lfdr.de>; Fri, 24 May 2024 11:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468C01F21507
	for <lists+linux-block@lfdr.de>; Fri, 24 May 2024 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C38285636;
	Fri, 24 May 2024 09:58:47 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9D785277
	for <linux-block@vger.kernel.org>; Fri, 24 May 2024 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716544727; cv=none; b=htK0dv2ZYY+KjcIjLpEEbJJAyhaCvKiBl9CHqOa7eVbGtWz6yHz4XL6Inx3CGCkLYshpMwsy2J4OF6vyJn0GHj3gupPtoBK+OgeuAqbDpF3Ss0oeafKGzoFIbXPWq5y/0crVXjS5QLGf2EsZBSurzJbMayVuHdnnTeC9jQEBl9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716544727; c=relaxed/simple;
	bh=atbyVCWPrVnobLD3U8q1ykOOe59jhvRtO3jZ4Op3e5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LupUh+RT7IlOJ2PWa/SZwzTm+yTzajotKfxOFApPl4yPf90shkOQ/M58EELKcXQN+Q6PttlF+YW4oCxSXlezSU3ooH79bNOhiDcpckkHW6/39uX1zvAd4zyLMsU8zB9h0dM0wjXL52+1m3OJ/hx1x1nKUTgHYuOQ2oxZmKcRJRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E263E68B05; Fri, 24 May 2024 11:58:42 +0200 (CEST)
Date: Fri, 24 May 2024 11:58:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev
Subject: Re: [PATCH] block: check for max_hw_sectors underflow
Message-ID: <20240524095842.GB26791@lst.de>
References: <20240524095719.105284-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524095719.105284-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 24, 2024 at 11:57:19AM +0200, Hannes Reinecke wrote:
> +	if (WARN_ON_ONCE((lim->logical_block_size >> SECTOR_SHIFT) > lim->max_hw_sectors))

Please avoid the overly long line.


