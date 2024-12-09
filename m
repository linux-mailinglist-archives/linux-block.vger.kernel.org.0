Return-Path: <linux-block+bounces-15061-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D889E8DA5
	for <lists+linux-block@lfdr.de>; Mon,  9 Dec 2024 09:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04054164490
	for <lists+linux-block@lfdr.de>; Mon,  9 Dec 2024 08:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9741E86E;
	Mon,  9 Dec 2024 08:39:44 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A4B12CDAE
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733733584; cv=none; b=M5vAGTuhBllPrEDnMmivi4ckLYc6HpD8ovPRlZzqx6a9raB0xKOicuEaaRwxUbjhnSOJscRjNf5vw4zJ/OexpTIEp0hUa0bmnmpxwj4xfP6lrTlI6PPjlLcN/kXiyWS2vW91k45X1XKgA2lqh4SjSH+ckfU+NbBiAtgaPINfP9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733733584; c=relaxed/simple;
	bh=SdKByV1OrkA0r/x7DWPqeCfXiE8mmQ4wms4zU/ptbTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmzqGZFNjc0NZSXrl+lDOIrvm+rS/QNyNOAJkiQeZDaGk/d5oOq3ORU0b1GdCA9r8wB5MuCW1H8kmk2Va5/SavxvFfDzhfXFzPL2MdQmFCzj/+2ZPSjQv5w29JFi9k48g5R6UP1rUJ/lkkWq2R3PG/XWKcNvQGojXmfXjIun9lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7C46868AA6; Mon,  9 Dec 2024 09:39:38 +0100 (CET)
Date: Mon, 9 Dec 2024 09:39:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 4/4] dm: Fix dm-zoned-reclaim zone write pointer
 alignment
Message-ID: <20241209083938.GA27113@lst.de>
References: <20241208225758.219228-1-dlemoal@kernel.org> <20241208225758.219228-5-dlemoal@kernel.org> <20241209074408.GA24323@lst.de> <56ee11bb-0dbc-4498-a529-b2f47e92e934@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ee11bb-0dbc-4498-a529-b2f47e92e934@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 09, 2024 at 05:38:40PM +0900, Damien Le Moal wrote:
> 
> The problem with doing that is that there is absolutely nothing to patch/fix
> before the previous patch, since the "recovery/report zones" was done
> automatically. So if anything, maybe I should just squash this patch together
> with the previous one to be consistent against bisect ? That does make sense
> since this patch is needed *because* of the previous patch change.

But it's also harmless to do the extra zone report.  So just state that
in the commit log.


