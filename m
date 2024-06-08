Return-Path: <linux-block+bounces-8470-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F72900F9D
	for <lists+linux-block@lfdr.de>; Sat,  8 Jun 2024 07:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A069B1F228B2
	for <lists+linux-block@lfdr.de>; Sat,  8 Jun 2024 05:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC82A176254;
	Sat,  8 Jun 2024 05:08:44 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1650016D4CA;
	Sat,  8 Jun 2024 05:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717823324; cv=none; b=gtkdFACv590MeMa3eVYFWr32V8FT1G0v38km7XuOD59msI1HyFjg8tvqtW7pfqL5ruRWOIw8VRDElfIzCE6hCh96W2V0xqK2FoWkDXaK218zhkb3JDdOxL32FCWqSE/YknOkyffsO9j2nkhO5KDBp3r6iiUHYZuGOMO7MNjW6TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717823324; c=relaxed/simple;
	bh=EoIlWBjsYw8WZFhnH6+JX8WF6nZVCYR/44OHPzQhs+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggy6/542QmLS6wvb9ymsYKyA5hZjCHMn6iYIKlndhfYTyNjo9UWF/MIB74cXbB9uzmxrbFyNQ2QCX0cOwjBdJVs8Rm3+QJEw2pdIcJ2u0ElYRTNhtKmZbhS8++Hb58i+mlgCOaIsMu6/zWy6igIvDwCx7lCVg6S5oxorpOrd2bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 72C1F68AFE; Sat,  8 Jun 2024 07:08:36 +0200 (CEST)
Date: Sat, 8 Jun 2024 07:08:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 04/11] block: remove the blk_integrity_profile structure
Message-ID: <20240608050836.GA23942@lst.de>
References: <20240607055912.3586772-1-hch@lst.de> <CGME20240607060043epcas5p1a6d4d8c3536fe3b6e43ad34155803fc2@epcas5p1.samsung.com> <20240607055912.3586772-5-hch@lst.de> <8d26d133-6fac-531c-d300-5b99678f1cbd@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d26d133-6fac-531c-d300-5b99678f1cbd@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Jun 08, 2024 at 12:01:43AM +0530, Kanchan Joshi wrote:
> > +	if (!bi || bi->csum_type != BLK_INTEGRITY_CSUM_NONE) {
> >   		ti->error = "Integrity profile not supported.";
> >   		return -EINVAL;
> 
> I'd rename BLK_INTEGRITY_CSUM_NONE to BLK_INTEGRITY_CSUM_NOP. Overall.

Well, we don't do any checksumming here, and not a no-op checksum.
So in terms of the checksum field I think the name is correct.  But
it is indeed confusing vs the format string, but that is an ABI
we can't change..


