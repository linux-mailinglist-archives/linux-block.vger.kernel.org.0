Return-Path: <linux-block+bounces-28588-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A89BE1D91
	for <lists+linux-block@lfdr.de>; Thu, 16 Oct 2025 09:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F3D188B24B
	for <lists+linux-block@lfdr.de>; Thu, 16 Oct 2025 07:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C144F24A05D;
	Thu, 16 Oct 2025 07:01:57 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451AC222566;
	Thu, 16 Oct 2025 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760598117; cv=none; b=YbkX8+Ef5YKCaC4HaBA6BLa/PmZ03xrQ07izVtyZfMlASU7otCyPG8nakzIYK7C1qXtzLYIcUk2U2d73Pzwv1Ik37c8coYRvHjhCh6MLdgNm1Dc9EJo1KPi20oq2NBf1rETMHZwcfs3YZyYjHQWbV9B9RdlLgFpmU0Cn1UiIyDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760598117; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nENZEGKwDutzJWbgKLIMZY3uBxeIeC6RLUiUOCSPUKPq8iIb2QsDe15w4LqEOzjwVvY+PkKJM5MY836O6vvi057dub5LW5bcdmvgAIVfovGVWkScRBau22ISEczL2qy9fbLsx8g1TQtRCiRuHmDWLx/62lCtsK3rIQYc3LHpB0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3279E227A87; Thu, 16 Oct 2025 09:01:49 +0200 (CEST)
Date: Thu, 16 Oct 2025 09:01:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: axboe@kernel.dk, chaitanyak@nvidia.com, dlemoal@kernel.org,
	hare@suse.de, hch@lst.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-btrace@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	martin.petersen@oracle.com, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org, naohiro.aota@wdc.com, rostedt@goodmis.org,
	shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH v3 06/16] blktrace: split do_blk_trace_setup into two
 functions
Message-ID: <20251016070148.GA995@lst.de>
References: <20251015105435.527088-1-johannes.thumshirn@wdc.com> <20251015105435.527088-7-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015105435.527088-7-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


