Return-Path: <linux-block+bounces-16224-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A23DA08D2E
	for <lists+linux-block@lfdr.de>; Fri, 10 Jan 2025 11:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5593A3495
	for <lists+linux-block@lfdr.de>; Fri, 10 Jan 2025 10:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332131CEAC3;
	Fri, 10 Jan 2025 10:01:39 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6D81922ED;
	Fri, 10 Jan 2025 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736503299; cv=none; b=BU8O+irkud7F185s6KsUXL+NJx1pEt2Q1VucgiPFR8Xd/kQLrV0HZ4G9PcSNNRoMwtGwisCXOzBhsXYfM7+qPEiPEnceyKVmllp4cgobNHSdsNfzWZqCret9yD0qpB+BjqKuHc0JHhkUsW5wfecHk1oUBg2dyo188uSJEcycGAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736503299; c=relaxed/simple;
	bh=uEaUjmMcNYrFO+21C150Gg9C+l3wJau8XsuF7d1MlLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9X2xQyFs4TUJfUwaN3JEbIl9enyfYHNNrrxGL4Ymg24zCSyFpiXIT3WfjYkaYUpczHrpOrfz7152X0V6Bl2X6LX1igaiddIj2N3gipxGFHbM3kY5+cYnhg4KyCfl5E2j+r2IuAF+kDrtucYB8pSlQqJwx+mnzS8vfn/Rn4MCaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 481FA68BFE; Fri, 10 Jan 2025 11:01:32 +0100 (CET)
Date: Fri, 10 Jan 2025 11:01:32 +0100
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
Message-ID: <20250110100132.GA11632@lst.de>
References: <20250110054726.1499538-1-hch@lst.de> <20250110054726.1499538-6-hch@lst.de> <79d85a4e-57c3-454e-a65b-d2a3764eaf0c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79d85a4e-57c3-454e-a65b-d2a3764eaf0c@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 10, 2025 at 09:56:35AM +0000, John Garry wrote:
>> +		lim->flags &= ~BLK_FLAG_IOSTATS_PASSTHROUGH;
>> +	return 0;
>>   }
>
> BTW, this function seems to duplicate queue_feature_store(), no?

That operates on lim->features using BLK_FEAT_* values, while
the quoted on operates on lim->flags and BLK_FLAG_*.


