Return-Path: <linux-block+bounces-5274-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AC488F6A8
	for <lists+linux-block@lfdr.de>; Thu, 28 Mar 2024 05:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054C01C283A3
	for <lists+linux-block@lfdr.de>; Thu, 28 Mar 2024 04:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17B53D387;
	Thu, 28 Mar 2024 04:49:52 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8261BF58;
	Thu, 28 Mar 2024 04:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711601392; cv=none; b=NpPVoHGg/aa4hjSJnAtrFqVBWuvNikMjrIaC3iU2PuexPgO28WxTl6D6Esz+/IA0xOtxDu5YzJI0OrXDTNnhJ8LvhOmXp9rA5oSKZfZ69GWdPbUCN4cLDW/zCaDqSy5D40Ep3xDKd46aI/1qyEDtLyq1urtN4/VuAN1ynS7Wzvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711601392; c=relaxed/simple;
	bh=mHB3T9nRALK8TzF3uU7lqnCT+S9O8I1GoxjejVW74Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sk0ozk1+354s+7NRcZuMuXISNpbGi5Lskg3TdeBMsMfMjz1bgkk9mwh8GA/WC1YlGU7RTwg1Yd3gG0TwLFfJk7OP+KBTwnrDDbXrMnpPTi7U4r0k3VrcMlym40NuRddzk8BivK42T38+UMwD2K3tFCt7Tu0hGL6uSqSBuGucMxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F3A8268B05; Thu, 28 Mar 2024 05:49:47 +0100 (CET)
Date: Thu, 28 Mar 2024 05:49:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 10/30] block: Fake max open zones limit when there
 is no limit
Message-ID: <20240328044947.GB14113@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org> <20240328004409.594888-11-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328004409.594888-11-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 28, 2024 at 09:43:49AM +0900, Damien Le Moal wrote:
> For a zoned block device that has no limit on the number of open zones
> and no limit on the number of active zones, the zone write plug free
> list is initialized with 128 zone write plugs. For such case, set the
> device max_open_zones queue limit to this value to indicate to the user
> the potential performance penalty that may happen when writing
> simultaneously to more zones than the free list size.

Setting max_open_zone needs to go through the queue limits API and
be done on a frozen queue (probabaly my merging it into the other
assignments done later in zone revalidation that are done with
the queue frozen).

