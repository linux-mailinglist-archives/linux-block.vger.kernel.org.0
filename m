Return-Path: <linux-block+bounces-8179-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBE68FA93C
	for <lists+linux-block@lfdr.de>; Tue,  4 Jun 2024 06:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B2E1F24069
	for <lists+linux-block@lfdr.de>; Tue,  4 Jun 2024 04:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C8013D638;
	Tue,  4 Jun 2024 04:31:49 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC53D13D639;
	Tue,  4 Jun 2024 04:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717475509; cv=none; b=shUbwzMFeCdYAbv2PFjDx/2JkLd1/X84M5pZD56Tn0OOD7WahsUdBbnc7r4zZX8jV1v/rB+5CW43U0cdDx88CaPEMA1X7UjcKxyH9+NzmLcjBtauE5ocmQ3X+cEk/GcuF32wMmQvs1CDibThBlbQmlcQB8He9qn5Sb2RDTczoeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717475509; c=relaxed/simple;
	bh=+P6lCzxMtgkTSM7bfvrnPizzmdH3bqAUPXp7C4X6W4g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lHg/lI1wmHaeo3EueASAirCMGtHqoODqEA5Jh7Xe8P+656+6g9GLEfWKqKgWCm3SGJ+/ADjFf384ONT4vQ8BI/6rNUDgHqHxrUfxqe37/AqnLJvoU1OVXL2WHV72uu0+Wy0uRvNs/zgXNOBCYc2+Bpm613KU/AVFeUZzlQHue7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2831268D12; Tue,  4 Jun 2024 06:31:43 +0200 (CEST)
Date: Tue, 4 Jun 2024 06:31:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
Message-ID: <20240604043142.GB28886@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 03, 2024 at 06:43:56AM +0000, Nitesh Shetty wrote:
>> Also most block limits are in kb.  Not that I really know why we are
>> doing that, but is there a good reason to deviate from that scheme?
>>
> We followed discard as a reference, but we can move to kb, if that helps
> with overall readability.

I'm not really sure what is better.  Does anyone remember why we did
the _kb version?  Either way some amount of consistency would be nice.


