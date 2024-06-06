Return-Path: <linux-block+bounces-8318-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 057878FDDE9
	for <lists+linux-block@lfdr.de>; Thu,  6 Jun 2024 06:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E1C285D23
	for <lists+linux-block@lfdr.de>; Thu,  6 Jun 2024 04:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B57F1F954;
	Thu,  6 Jun 2024 04:50:54 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB76C241E7;
	Thu,  6 Jun 2024 04:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717649454; cv=none; b=jgJWa7V+Axmkb5nOoPDWxzlOHUsggbVuADC0aenwIVMPrbWmi9/w29hO4ZNj/JYNKiebqvyxJ3Zk28WwqY+HecPDsn6UpU1lsfnVOm87Yl/4p+PlEDmBiaBFVQy6Oq2o1Tjg3ofpkSfxuLxV7onnMrCLDUKTws9pmY3U0ZbOt+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717649454; c=relaxed/simple;
	bh=HckcIFsbry+oQ/FDC79HLbcfm+ZlnIaV7Bm4duozhIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYIk0o272TF+bCSVLULa57ta+hpIpScUS3TppIR1AGeyb0VhlvSQoaq8soXF/LgYZctbQ/j9xyfGrOHOKs8iCm/ihtEjwGT7PPmHitLA6M2XmN5wkcLPZg0Y1Jfh9LCIPu79upJJ9Qrv1aZI/FELQ45DoSEsOPvlheUv5bLs/oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3713968CFE; Thu,  6 Jun 2024 06:50:49 +0200 (CEST)
Date: Thu, 6 Jun 2024 06:50:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
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
Subject: Re: [PATCH 04/12] block: remove the blk_integrity_profile structure
Message-ID: <20240606045048.GC8395@lst.de>
References: <20240605063031.3286655-1-hch@lst.de> <20240605063031.3286655-5-hch@lst.de> <fee6338e-4aae-456c-90a3-228a19fae58a@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fee6338e-4aae-456c-90a3-228a19fae58a@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 05, 2024 at 10:31:27AM -0600, Bart Van Assche wrote:
>> +	case BLK_INTEGRITY_CSUM_CRC64:
>> +		if (bi->flags & BLK_INTEGRITY_REF_TAG)
>> +			return "EXT-DIF-TYPE1-CRC64";
>> +		return "EXT-DIF-TYPE3-CRC64";
>> +	default:
>> +		return "nop";
>> +	}
>> +}
>
> Since bi->csum_type has an enumeration type, please leave out the "default:"
> and move return "nop" outside the switch statement. This will make the
> compiler issue a warning if a new enumeration label would be added without
> updating the above switch statement. Otherwise this patch looks good to me.

For that to work you'd need to make csum_type the enum type and not an
unsigned char, which would bloat the block limits.  You'd also need to
keep the return "nop" where it is, but use the explicit case instead of
the default.


