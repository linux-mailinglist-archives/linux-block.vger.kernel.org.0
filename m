Return-Path: <linux-block+bounces-5280-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F4D88F6BF
	for <lists+linux-block@lfdr.de>; Thu, 28 Mar 2024 05:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 763FBB2112C
	for <lists+linux-block@lfdr.de>; Thu, 28 Mar 2024 04:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7D52C1AC;
	Thu, 28 Mar 2024 04:51:52 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AC012E78;
	Thu, 28 Mar 2024 04:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711601512; cv=none; b=L79ql4hdlodhuOnecCLxLkZlLdA2IGkdVBs8xr1lH3EWPqMstd8UPxcNPcVW7rgg+RvL/+qHnmjDmD6ii9GzNeNRK+n9Q2cIF4SkTpG03uOQAqm5K3m1zGHToz3VmVVz3ytZPmk3ID7fHXGGrpA4bL6SM/hc0GNR+RviI0AKmvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711601512; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTaIVMDrou97o8p6WmY+17GqxjU9Td0EQ7VC1YBHW8RSY5+3nLGN4x3vu6XwCRxjJxRqTWNwjNodG+X8HNONB+W8UJXJrv0h4byAKrBnZGxXyuRj6y7Hq21tuVKG2y0KQc5fexmfKWWgaSe8gLTlFT8jECHeqM1mafCoLvdAiOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C105E68B05; Thu, 28 Mar 2024 05:51:47 +0100 (CET)
Date: Thu, 28 Mar 2024 05:51:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 18/30] null_blk: Introduce zone_append_max_sectors
 attribute
Message-ID: <20240328045147.GH14113@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org> <20240328004409.594888-19-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328004409.594888-19-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

