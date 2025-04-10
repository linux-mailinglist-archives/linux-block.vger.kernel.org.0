Return-Path: <linux-block+bounces-19407-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DABCA83CBC
	for <lists+linux-block@lfdr.de>; Thu, 10 Apr 2025 10:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F9B3AD069
	for <lists+linux-block@lfdr.de>; Thu, 10 Apr 2025 08:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCBA20B7F1;
	Thu, 10 Apr 2025 08:17:10 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2409020B812
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273030; cv=none; b=h8yYtGeUS+lUU89yE4RJUmwH1EqYHNXaH/1A8+MCPGguUI7syn66JrtYNDTiEgTsHxMBIj78/dgjzISDEc24uFTtS8JA1/Di089jNSzxVkipQpdBgy4/wKMM74yukqtWxj4bGHm+wm4908F3XKJjuSTcytmN6b1SuYMjWhwRWFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273030; c=relaxed/simple;
	bh=WcdcMeCd686FALRLWfHwz6E2VqoL5Zvq55cz2p6Yhjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrSEsoKusV24NUfK2EKQTcuvI6b4wlthYPVUx2T/bNDpETWMhUbHDhALDIIWmKUOv9Pg3Y7lH+aM+MP3hLdks/kS/SR9B3wCm/1q6FifTWa+CKBgfWVxbHbwHOY/QTCgXFjkmWTOu2Hm+4MVaiw/v8UKAY6J0C6Rboom0Dkd0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 675EE68B05; Thu, 10 Apr 2025 10:17:04 +0200 (CEST)
Date: Thu, 10 Apr 2025 10:17:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chanho Min <chanho.min@lge.com>
Cc: Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	gunho.lee@lge.com
Subject: Re: [PATCH] block/dm: add early_lookup_ready_bdev to ensure ready
 device lookup
Message-ID: <20250410081704.GA1573@lst.de>
References: <20250410080056.43247-1-chanho.min@lge.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410080056.43247-1-chanho.min@lge.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Once again: no.  You need to stop abusing the early lookup infrastructure
for anything not directly dealing with finding the root device
in init/.  Stop messing with it to paper up the mistake of dm even
adding this code without proper review.


