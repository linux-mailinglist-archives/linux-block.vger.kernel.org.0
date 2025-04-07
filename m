Return-Path: <linux-block+bounces-19229-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C93B5A7D4EF
	for <lists+linux-block@lfdr.de>; Mon,  7 Apr 2025 09:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E7816D406
	for <lists+linux-block@lfdr.de>; Mon,  7 Apr 2025 07:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167514642D;
	Mon,  7 Apr 2025 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YRumqc7u"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C6EC2EF
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744009635; cv=none; b=EQaroplhmuMq9Ieo//xsYySrGA6gwI3cMj7z5djnGsM8WlZHSlDvA6miNmlDdDzooYtp08bPyFlJCvaSTYlhrYPMYPLcCPBuYXZAJsKdpzPEJxLyQaHgXtiidGOJhfYh0uS8X7NcW5M77wwL/Hi1veg/DprOH/woUbJ9T2i/RW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744009635; c=relaxed/simple;
	bh=T6skjFJmtaRbKhsGEuSWChRCGM2woNAykpTFY2sa5QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8KyyjV0nPYvoR1OmJaFHhCjuZ6Ekm5YVdCJVjVrTLemberN9cCA96BDsiPrPGBQKNzSbim4Op0FONA0u9GGANZJze18YrrT28qi/ZsBys7aeNnvX259WGWuHAEfp/lX7pPYy1k0eYe8Iv3h4OwQd7xc0bRpXzud4sbFEp9xypU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YRumqc7u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=meueY3+mTV8WeAWqv50pjwgPHuKofYRZF+1b8YrM8wA=; b=YRumqc7u61KXUCBoVGkwVEkfAu
	qXgkbFQQuSAI4LSnsEgHtTMVAKJtlig1Ow3vAFZdSUG7fi5oruxa5oezvaSkudvrZgOd9em1P91Ps
	n95SctciyLli18P9vcF8for3DWg7jlumbwV4GzpZ4aLlXYEL4gIQUMla5KUhHmAe9GNq0o3c7iMwT
	rY3lOpJWA9nZykNOOjB9oEg9NL9gAkO+4PRnzRJf/Bpz1UQTIw0Y89IqjAc8s7ZSc8AT1MJwYS2oY
	1gayF6F6oLxKphB7dq/WGoMP6JEiomT5QoKhst8KekPwMLoUb4poPWkwUyvzSldd73nRcgHpu8hjs
	aV9F/RpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1gZb-0000000Gg4g-3afm;
	Mon, 07 Apr 2025 07:07:11 +0000
Date: Mon, 7 Apr 2025 00:07:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sean Anderson <seanga2@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	Zhihao Cheng <chengzhihao1@huawei.com>
Subject: Re: bio segment constraints
Message-ID: <Z_N5nxLDOBb5NDAM@infradead.org>
References: <8dfd97ac-59e7-ae69-238a-85b7a2dae4f1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dfd97ac-59e7-ae69-238a-85b7a2dae4f1@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Apr 06, 2025 at 03:40:04PM -0400, Sean Anderson wrote:
> Hi all,
> 
> I'm not really sure what guarantees the block layer makes regarding the
> segments in a bio as part of a request submitted to a block driver. As
> far as I can tell this is not documented anywhere. In particular,

First you need to define what segment you mean.  We have at least two and
a half historical uses of the name.  One is for each bio_vec attached to
the bio, either directly as submitted into ->submit_bio for bio based
drivers (case 1a), or generated by bio_split_to_limits (case 1b), which
is called for every blk-mq driver before calling into ->queue_rq(s) or
explicitly called by a few bio based driver.

The other is the bio-vec synthesized by bio_for_each_segment (case 2).

> - Is bv_len aligned to SECTOR_SIZE?

Yes.

> - To logical_sector_size?

Yes.

> - What if logical_sector_size > PAGE_SIZE?

Still always aligned to logical_sector_size.

> - What about bv_offset?

bv_offset is a memory offset and must only be aligned to the
dma_alignment limit.

> - Is it possible to have a bio where the total length is a multiple of
>   logical_sector_size, but the data is split across several segments
>   where each segment is a multiple of SECTOR_SIZE?

Yes.

> - Is is possible to have segments not even aligned to SECTOR_SIZE?

No.

> - Can I somehow request to only get segments with bv_len aligned to
>   logical_sector_size?

For drivers that use bio_split_to_limits implicitly or explicitly you can
do that by setting the right seg_boundary_mask.

> make some big assumptions (which might be bugs?) For example, in
> drivers/mtd/mtd_blkdevs.c, do_blktrans_request looks like:

> - There is only one bio in a request. This one is a bit of a soft
>   assumption since we should only flush the pages in the bio and not the
>   whole request otherwise.

It always operates on the first bio in the request and then uses
blk_update_request to move the context past that.  It is an old
and somewhat arkane way to write drivers, but should work.  The
rq_for_each_segment looks do call flush_dcache_page look horribly
wrong for this model, though.

> - The data is in lowmem OR bv_offset + bv_len <= PAGE_SIZE. kmap() only
>   maps a single page, so if we go past one page we end up in adjacent
>   kmapped pages.

Yes, this looks broken.

> Am I missing something here? Handling highmem seems like a persistent
> issue. E.g. drivers/mtd/ubi/block.c doesn't even bother doing a kmap.
> Should both of these have BLK_FEAT_BOUNCE_HIGH?

BLK_FEAT_BOUNCE_HIGH needs to go away rather sooner than later.

in the short run the best fix would be to synthesized a
bio_for_each_segment like bio_vec that stays inside a single page
using bio_iter_iovec) at the top of do_blktrans_request and use
that for all references to the data. 


