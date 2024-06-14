Return-Path: <linux-block+bounces-8870-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDF1908FA2
	for <lists+linux-block@lfdr.de>; Fri, 14 Jun 2024 18:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36761C20A97
	for <lists+linux-block@lfdr.de>; Fri, 14 Jun 2024 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDD116D4FC;
	Fri, 14 Jun 2024 16:07:16 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261CF15ECD0;
	Fri, 14 Jun 2024 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381236; cv=none; b=oKioUgnEdrtRdp8OYT2zW/4LMRG6keDUDgvFZvsIPLxXAA1/79lWUAHrd0YZXIZSoUSML3Cc2lfyG1eQcW6U7KJydqqYkDDnwCUY1ut8cSAjTprBSOc9yy+CVrW4Jqs0am5B6xLffUfB9HL7PrwzCfocTcEX0JWPeHWwi5TinL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381236; c=relaxed/simple;
	bh=gtWdNUMMJkGswz7dhMRos+MYTW8VtwOQ0Mtb+La5PbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rndCMg1PrHVVNlnqfyuYO7eNnGMP0DkakYX4UFKDa1EWgvdZ+SMzSWyk6p2nKjOSQISBgFT3TAPxnUVZDkerxqAgih4glTPuYBJXKtkebbbQYIcYOWrER24e7+zoqEJpdo42pMwAAEFME1oNBoCMnVnCD3nys/f7UxRaMswW46I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AF31B68CFE; Fri, 14 Jun 2024 18:07:08 +0200 (CEST)
Date: Fri, 14 Jun 2024 18:07:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: move integrity settings to queue_limits v3
Message-ID: <20240614160708.GA17171@lst.de>
References: <20240613084839.1044015-1-hch@lst.de> <f134f09a-69df-4860-90a9-ec9ad97507b2@kernel.dk> <20240614160322.GA16649@lst.de> <af0144b5-315e-4af0-a1df-ec422f55e5be@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af0144b5-315e-4af0-a1df-ec422f55e5be@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 14, 2024 at 10:04:28AM -0600, Jens Axboe wrote:
> > That sounds like you didn't apply the above mentioned
> > "convert the SCSI ULDs to the atomic queue limits API v2" series before?
> 
> That might indeed explain it... Surprising it applied without.

Also as mentioned a couple weeks ago and again earlier this week,
can we please have a shared branch for the SCSI tree to pull in for
the limits conversions (including the flags series I need to resend
next week) so that Martin can pull it in?


