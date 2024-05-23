Return-Path: <linux-block+bounces-7676-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5178CD91C
	for <lists+linux-block@lfdr.de>; Thu, 23 May 2024 19:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B07EB21650
	for <lists+linux-block@lfdr.de>; Thu, 23 May 2024 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140FD1CFBE;
	Thu, 23 May 2024 17:19:30 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F9208C3
	for <linux-block@vger.kernel.org>; Thu, 23 May 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716484770; cv=none; b=TxzZQEE5iv8JCaD5tv8lKmK0dxqPx34EycIhlc+bnf5/f9ZYX8OcOuZKPP187ycmdiqORk+g2wHlWA8fCgoIG9+jGJI+o2UKD5gtNZjt3fuLFGRTNG7+IZxHuPRg35yynR/C2/vkK6nqHNLFuHksUWVF+z8cWQEBF52sP6SEQuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716484770; c=relaxed/simple;
	bh=rzjBZ+ZqzZ3pgcSSzYavvdnHHXUmc0wo0KrHLoClF/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i37QFLjppxbMRLEYsaURKwT5GAUQPcv+4PB2uyeV3+xGR8Dvb4vZcMZs3Jz5eSL/f5TzCXc3FA6qNlHdU3zhco6sY/SZxnhwub1GuXHbRpmw3xmZlpjpEGCD5OUmxQl/qBFU6tBVhR+SEL1ny1dvaTTIM/mI1zwN97TAXjQ1lds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3014068CFE; Thu, 23 May 2024 19:19:23 +0200 (CEST)
Date: Thu, 23 May 2024 19:19:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>,
	Anuj gupta <anuj1072538@gmail.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2 v3] block: change rq_integrity_vec to respect the
 iterator
Message-ID: <20240523171922.GA5892@lst.de>
References: <a1d8771a-70ad-9eed-476c-af696d2f9ac2@redhat.com> <d27da881-e615-b081-d8db-17ac9b91d4be@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d27da881-e615-b081-d8db-17ac9b91d4be@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 23, 2024 at 06:54:47PM +0200, Mikulas Patocka wrote:
> 
> However, the function rq_integrity_vec has a bug - it returns the first
> vector of the bio's metadata and completely disregards the metadata
> iterator that was advanced when the bio was split. Thus, the second bio
> uses the same metadata as the first bio and this leads to metadata
> corruption.
> 
> This commit changes rq_integrity_vec, so that it calls mp_bvec_iter_bvec
> instead of returning the first vector. mp_bvec_iter_bvec reads the
> iterator and advances the vector by the iterator.

mp_bvec_iter_bvec does not advance the bvec_iter, it just uses the
iter to build a bvec for the current position in the iter.

Also please fix the commit log to not use more than 73 characters,
as-is it will be unreadable in git show output or email replies.

> -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> +static inline struct bio_vec rq_integrity_vec(struct request *rq)
>  {
>  	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
> +		return (struct bio_vec){ };
> +	return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
> +				 rq->bio->bi_integrity->bip_iter);

The queue_max_integrity_segments check can go away now.  Once you
use the bvec_iter the function works just fine for multiple
integrity segments and always returns the one at the current iter
position.   That should preferably also documented in a comment.

(I'm also pretty sure I've already written this in reply to Anuj's
version of the patch)


