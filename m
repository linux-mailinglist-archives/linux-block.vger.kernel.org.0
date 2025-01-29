Return-Path: <linux-block+bounces-16653-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35716A21796
	for <lists+linux-block@lfdr.de>; Wed, 29 Jan 2025 07:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99411163E55
	for <lists+linux-block@lfdr.de>; Wed, 29 Jan 2025 06:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915F814F6C;
	Wed, 29 Jan 2025 06:05:41 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1DD190072;
	Wed, 29 Jan 2025 06:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738130741; cv=none; b=UJ3Tp7hW1FCA0OiOiCDyKhDCOu54K5brW57nnYOObnuhNLtHC6soLOxt/LC2vSS5LB52VIjHuQq9w1Wgp6j/F96n+IjixWZ4fpFM5nWZXpmgUdaM462LecR1tWZqrRlB+myiHiTaOTZKETvUEe4TMui7FBhK/hupSfoz+NQySFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738130741; c=relaxed/simple;
	bh=cAcU/NMmMwccLJ32HqOy0i9+ApE+bJLVFSnoJdp1fP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4Y5cbBguwHYRrhrOrnx2vUGiS663/P6zl0q1H0VhqCHTXnosmtVkv/rZ9CLoCA0aWdEu7l1uRHYoA8eXhT16Gbv7OhX/9DmvNFi56p1J1HoqvKC02n19rchEkAq86WzmJYvmXZQs0Pnfjq2PZkGRyVWweHMPEl/uAggFPvatJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 544CB68D13; Wed, 29 Jan 2025 07:05:34 +0100 (CET)
Date: Wed, 29 Jan 2025 07:05:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] nvme-tcp: rate limit error message in send path
Message-ID: <20250129060534.GA29266@lst.de>
References: <20250128-nvme-misc-fixes-v1-0-40c586581171@kernel.org> <20250128-nvme-misc-fixes-v1-1-40c586581171@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-nvme-misc-fixes-v1-1-40c586581171@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 28, 2025 at 05:34:46PM +0100, Daniel Wagner wrote:
> If a lot of request are in the queue, this message is spamming the logs,
> thus rate limit it.

Are in the queue when what happens?  Not that I'm against this,
but if we have a known condition where this error is printed a lot
we should probably skip it entirely for that?


