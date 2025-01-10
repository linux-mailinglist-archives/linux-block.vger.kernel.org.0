Return-Path: <linux-block+bounces-16216-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346F1A08B86
	for <lists+linux-block@lfdr.de>; Fri, 10 Jan 2025 10:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD12F3AB78D
	for <lists+linux-block@lfdr.de>; Fri, 10 Jan 2025 09:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4285B20C003;
	Fri, 10 Jan 2025 09:19:08 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F21720B81E;
	Fri, 10 Jan 2025 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500748; cv=none; b=JOvF7v9rVJQKfztPulOMfMLM6sOlnluuxtbQSECZ73WPYgvcn0ZUZwbSt0SWUQ7iEe6PFvZgGhvlDpO3emsxu/+UDzgDOVbtm/Hdpm1VFgxD9Cf1lo3/odhNXCSD7p1lqNSRW11O+DtB9hfQfxMCG87Yj/DoFOSC3HWpdET5OW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500748; c=relaxed/simple;
	bh=VkSn3ai9dtaOIbhO+9p4BPmGJErlJ3zM0pj0oadhzk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeFsmYDqmCt6BvAoaFgqTRNkP+fkdiz+LdtEvv6oC3bjtBdd9JYv84sj82BQHJa+rMPoIJN4jQnC6R4w6+ad+lhex7u5bAv4JTQYk1eTd0bN+RbCEjO7AonCi/kBqQJJim5whZoKUT79hFgqb1fQ50Dx33lTQPOEMkfDfd8QPG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C6A268BFE; Fri, 10 Jan 2025 10:19:00 +0100 (CET)
Date: Fri, 10 Jan 2025 10:18:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 05/11] block: add a store_limit operations for sysfs
 entries
Message-ID: <20250110091859.GA8373@lst.de>
References: <20250110054726.1499538-1-hch@lst.de> <20250110054726.1499538-6-hch@lst.de> <e7177a33-aebd-4828-87b0-f790b4fb1306@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7177a33-aebd-4828-87b0-f790b4fb1306@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 10, 2025 at 09:15:09AM +0000, John Garry wrote:
>> +	int (*store_limit)(struct gendisk *disk, const char *page,
>
> I don't really see why this returns an int, while the queue features 
> callback methods return a ssize_t. I know that the res variable in 
> queue_attr_store() gets mixed with an int for updating the queue limits, 
> but I don't see that as a reason to use int here.

The normal store methods have the annoying calling convention where
they return the parsed string length on success.  ->store_limits uses
the simpler and harder to get wrong convention of returning 0 on
success.


