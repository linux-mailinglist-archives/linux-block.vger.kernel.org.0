Return-Path: <linux-block+bounces-13202-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 402299B5B03
	for <lists+linux-block@lfdr.de>; Wed, 30 Oct 2024 06:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B371F2272E
	for <lists+linux-block@lfdr.de>; Wed, 30 Oct 2024 05:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61C182899;
	Wed, 30 Oct 2024 05:04:01 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23BBBA4A;
	Wed, 30 Oct 2024 05:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730264641; cv=none; b=FJfiEn+gbsOwY3E+EgLYfuI/muC1XfIkoXtuba9eGTxIGUxPvJtLYBf9zddv9NjKlxJA48CSaCqOGZ7GeUsNb5kiBtfF5lQe18qpeJNlwd+8dA4eiFxMEroj4Q/a+P3hMTBngZNFApr+KyFjcPbYRpqOl7qE5Tu3B7sU+si8uXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730264641; c=relaxed/simple;
	bh=WAqX+01zIHrDhPlHLoX/wCeTUGQMElqDZRCizLconsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObSpvYLD7NR9U5aF/7yqi9t3O7qCGH++kFY2wrQ90HfJbIrvv4wyeG+L6XvA6gEj6w3VUducGciL9VH5tR37k+4PMQW33DR6mthZmYwY70I6RWuJwn/r6Bd95S4D4KUywSvF9I+DMgA8HKTLSJeAmCO/qP9k+XHsPilwPuQqpSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E8D5768AA6; Wed, 30 Oct 2024 06:03:55 +0100 (CET)
Date: Wed, 30 Oct 2024 06:03:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v5 04/10] fs, iov_iter: define meta io descriptor
Message-ID: <20241030050355.GA32598@lst.de>
References: <20241029162402.21400-1-anuj20.g@samsung.com> <CGME20241029163220epcas5p2207d4c54b8c4811e973fca601fd7e3f5@epcas5p2.samsung.com> <20241029162402.21400-5-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029162402.21400-5-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 29, 2024 at 09:53:56PM +0530, Anuj Gupta wrote:
> +/* flags for integrity meta */
> +typedef __u16 __bitwise uio_meta_flags_t;
> +
> +struct uio_meta {
> +	uio_meta_flags_t	flags;

.. this is a bitwise type

> +/* flags for integrity meta */
> +#define IO_INTEGRITY_CHK_GUARD		(1U << 0) /* enforce guard check */
> +#define IO_INTEGRITY_CHK_REFTAG		(1U << 1) /* enforce ref check */
> +#define IO_INTEGRITY_CHK_APPTAG		(1U << 2) /* enforce app check */

.. but these aren't.  Leading to warnings like:

 CHECK   block/bio-integrity.c
block/bio-integrity.c:371:17: warning: restricted uio_meta_flags_t degrades to integer
block/bio-integrity.c:373:17: warning: restricted uio_meta_flags_t degrades to integer
block/bio-integrity.c:375:17: warning: restricted uio_meta_flags_t degrades to integer
block/bio-integrity.c:402:33: warning: restricted uio_meta_flags_t degrades to integer

from sparse.  Given that the flags are uapi, the it's probably best
to just drop the __bitwise annotation.


