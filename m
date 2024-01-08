Return-Path: <linux-block+bounces-1628-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE63826959
	for <lists+linux-block@lfdr.de>; Mon,  8 Jan 2024 09:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719AA1F21108
	for <lists+linux-block@lfdr.de>; Mon,  8 Jan 2024 08:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198119463;
	Mon,  8 Jan 2024 08:21:54 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A349465
	for <linux-block@vger.kernel.org>; Mon,  8 Jan 2024 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9998668AFE; Mon,  8 Jan 2024 09:21:42 +0100 (CET)
Date: Mon, 8 Jan 2024 09:21:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: Treat sequential write preferred zone type as
 invalid
Message-ID: <20240108082142.GA4277@lst.de>
References: <20240107072212.1071080-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240107072212.1071080-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jan 07, 2024 at 04:22:12PM +0900, Damien Le Moal wrote:
> With the removal of the support for host-aware zoned devices,
> blk_revalidate_zone_cb() should never see the zone type
> BLK_ZONE_TYPE_SEQWRITE_PREF (sequential write preffered zones). Treat
> this zone type as being invalid.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

