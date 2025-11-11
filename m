Return-Path: <linux-block+bounces-30010-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5E2C4C2C7
	for <lists+linux-block@lfdr.de>; Tue, 11 Nov 2025 08:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67793B4A3C
	for <lists+linux-block@lfdr.de>; Tue, 11 Nov 2025 07:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790FF23EAB2;
	Tue, 11 Nov 2025 07:50:12 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B54C221FBF
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847412; cv=none; b=e2XZKdeAZIdGWIo3aY6xE2BT1cRZ5Ddbl+GpM+VLyFNDl9mxD/S4YRJZeqZ41jpYC/+mE7TPgNGUF/KAhKJvNiioF6WQi8iWn+2y5UKGZIz3XUF/zF2fJtPZIGL6xQ3CmtIFPeX59Cd3Ba59T1jqHbB4xln2rV11zdapNxjfYkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847412; c=relaxed/simple;
	bh=InCzRd/yQh84Sn1ujTH6njMkrk1OhFv8xOEotBbyfdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbyszUg4osFQLFBiCx6qg+LXuOj1OKf+j05sJnyqPyQrb65DcFCqx4s+0zxue1g26yhaOQWW4vmtrrP6ZidUys1F/vWqUdjerR++0EGnRIbZeQby7uEY2EKziHvAY2Df6oqqWeZ1AJNue81QHYsf3rrplCs2q/7YEf6GgshO7SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C8314227A87; Tue, 11 Nov 2025 08:50:06 +0100 (CET)
Date: Tue, 11 Nov 2025 08:50:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/4] blk-zoned: Split an if-statement
Message-ID: <20251111075006.GC6596@lst.de>
References: <20251110223003.2900613-1-bvanassche@acm.org> <20251110223003.2900613-4-bvanassche@acm.org> <5c264096-2bc1-42b7-91af-739f4ca1916b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c264096-2bc1-42b7-91af-739f4ca1916b@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 11, 2025 at 04:09:10PM +0900, Damien Le Moal wrote:
> On 11/11/25 7:30 AM, Bart Van Assche wrote:
> > Split an if-statement and also the comment above that if-statement. This
> > patch makes the code slightly easier to read. No functionality has been
> > changed.
> > 
> > Cc: Damien Le Moal <dlemoal@kernel.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> Though it feels like this should be squashed with patch 4/4.

Yes, please.


