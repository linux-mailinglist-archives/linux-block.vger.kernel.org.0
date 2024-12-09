Return-Path: <linux-block+bounces-15079-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1DF9E948B
	for <lists+linux-block@lfdr.de>; Mon,  9 Dec 2024 13:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA68F188121C
	for <lists+linux-block@lfdr.de>; Mon,  9 Dec 2024 12:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABF322488B;
	Mon,  9 Dec 2024 12:41:52 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C298822147B
	for <linux-block@vger.kernel.org>; Mon,  9 Dec 2024 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733748112; cv=none; b=oRJyQzrW6n/mclLuaD3WhUgjDIhbz1Sp2YRtUv0bkAYBgmjHveFbmKApCEoN9XVd0ue5b5dEDu8dTw/MGoR9UACNuVHWMBnf2AsqncxWVpO9p5JXg/7BIdXJxJVYdh6QyPmvbaJ4E2MCOdHbpnYs/POPlGAa2qESB8LHm0AkLU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733748112; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVOAMLIHeE972HBe5e4P5borMe3NaIGqBIgGTnxnksvWhYGg+XJz4NjhaREIIqvdZnc0zYNT/FJik9R+FLKXMKzrwKPxGa9XmJI9YM2TcxgIRpyvvUVmAVsB0Y7aOjJ4eK/JPFig76cAKusuhEOUKmNDSo1ffP3hgAEpucAz3h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5987568D09; Mon,  9 Dec 2024 13:41:47 +0100 (CET)
Date: Mon, 9 Dec 2024 13:41:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v3 3/4] dm: Fix dm-zoned-reclaim zone write pointer
 alignment
Message-ID: <20241209124147.GB13869@lst.de>
References: <20241209122357.47838-1-dlemoal@kernel.org> <20241209122357.47838-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209122357.47838-4-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

