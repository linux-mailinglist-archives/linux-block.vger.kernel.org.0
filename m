Return-Path: <linux-block+bounces-22750-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 150BBADC0FC
	for <lists+linux-block@lfdr.de>; Tue, 17 Jun 2025 06:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC757A3BD2
	for <lists+linux-block@lfdr.de>; Tue, 17 Jun 2025 04:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2212E1C2324;
	Tue, 17 Jun 2025 04:43:49 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AC3188A3A;
	Tue, 17 Jun 2025 04:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750135429; cv=none; b=dJecCYnU3xQk6NoxLcu0Ka+6k7eeLfOSISaFx7SQfptBgHj68+Uu8rx/GZJutacAPDj/GwuZiDuiVYF804MlCkAM0Za5Dp59Is9v4d9uliwOsftWOZThZoCBQNYmoA43UEX4UWWNmq+FreFCxSPT6IeuYmTEC6T+RsUGECd/owI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750135429; c=relaxed/simple;
	bh=AaHAcR4uEX+JHu87/G/l9HjeirgUKvMWYxA8nlhDi+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LafL7gYhZoTIS8lJYca8YslKpf8YdrHTE+xJdQ9ZBAp2XW1IjZyi0MJSU1hCiNKy4KN7ChkEh6ph3+fLIaBxZ0cdVrNp7GJwhPpVXBMKwYH5fT9NkhtYlXPpx3TYSazBuijsJApety7jKTV0vlB9JRUQRPhiH0pFS769i+4RZxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2AED468D05; Tue, 17 Jun 2025 06:43:43 +0200 (CEST)
Date: Tue, 17 Jun 2025 06:43:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Christoph Hellwig <hch@lst.de>,
	"Ewan D. Milne" <emilne@redhat.com>,
	Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH] scsi: storvsc: set max_segment_size as UINT_MAX
 explicitly
Message-ID: <20250617044342.GB1824@lst.de>
References: <20250616160509.52491-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616160509.52491-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 17, 2025 at 12:05:09AM +0800, Ming Lei wrote:
> Set max_segment_size as UINT_MAX explicitly:
> 
> - storvrc uses virt_boundary to define `segment`
> 
> - strovrc does not define max_segment_size
> 
> So define max_segment_size as UINT_MAX, otherwise __blk_rq_map_sg() takes
> default 64K max segment size and splits one virtual segment into two parts,
> then breaks virt_boundary limit.
> 
> Before commit ec84ca4025c0 ("scsi: block: Remove now unused queue limits helpers"),
> max segment size is set as UINT_MAX in case that virt_boundary is
> defined.

Drivers should not have done this.  If you need this someone (probably
me) broke the block layer code ensuring it's not needed, and that
affects all drivers using virt_boundary.


