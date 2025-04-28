Return-Path: <linux-block+bounces-20771-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F912A9F175
	for <lists+linux-block@lfdr.de>; Mon, 28 Apr 2025 14:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E97A3B1AD5
	for <lists+linux-block@lfdr.de>; Mon, 28 Apr 2025 12:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5791262FD9;
	Mon, 28 Apr 2025 12:52:21 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4954126B2C4;
	Mon, 28 Apr 2025 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844741; cv=none; b=M7oVVUx90DDT/uOVIh/ORmlMpVjf9kh0zEhGhZGi9rjSPTtye0yXTe1frP2QC1PI0cTxfNGC+wnKFtz+V0R7L9/uNQdyWAFFspRBfFnrg8Z2WHgMvNpcHvTs0JId9lYHnGwB1CnwMud8kb81L7u1Ubs6qRaQtoC9UczZO/nP1ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844741; c=relaxed/simple;
	bh=40ThPwpXuivqdi8Tl+p7raANpndrmO0JgQyfQV6OeZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjraPr1dwu69ujFmltckJY1Ok8O8EUv0gVcnwYvBHp15RmwfZFyHoMtqP2m7CUzW7skyRGpWvZrluqboHzCHkYWH1QmM8Zl30AyD8qxwfC+ICsIFbFEoQnjXByvYX+MWL5oA+wAEvKA6tQwwr1clqQfRIohiqaFAxtPiCskbaKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 760D368C4E; Mon, 28 Apr 2025 14:52:07 +0200 (CEST)
Date: Mon, 28 Apr 2025 14:52:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: Re: [PATCH v2 1/3] brd: protect page with rcu
Message-ID: <20250428125207.GB27794@lst.de>
References: <20250427083925.157984-1-yukuai1@huaweicloud.com> <20250427083925.157984-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427083925.157984-2-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Apr 27, 2025 at 04:39:23PM +0800, Yu Kuai wrote:
>  	page = brd_lookup_page(brd, sector);
>  
>  	kaddr = bvec_kmap_local(&bv);
>  	if (op_is_write(opf)) {
> -		BUG_ON(!page);
> -		memcpy_to_page(page, offset, kaddr, bv.bv_len);
> +		if (page)
> +			memcpy_to_page(page, offset, kaddr, bv.bv_len);

This could use a comment on why page can be NULL here.

>  	} else if (page) {
>  		memcpy_from_page(kaddr, page, offset, bv.bv_len);
>  	} else {
>  		memset(kaddr, 0, bv.bv_len);

And why the above change my if/else cascade doesn't really make much sense
any more and this should become:

	} else {
		if (page)
	 		memcpy_from_page(kaddr, page, offset, bv.bv_len);
		else
	 		memset(kaddr, 0, bv.bv_len);
 	}

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

