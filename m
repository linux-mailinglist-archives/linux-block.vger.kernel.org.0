Return-Path: <linux-block+bounces-21994-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD7AAC2093
	for <lists+linux-block@lfdr.de>; Fri, 23 May 2025 12:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91A0507FFF
	for <lists+linux-block@lfdr.de>; Fri, 23 May 2025 10:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2CA1B4F1F;
	Fri, 23 May 2025 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f1rsqm0+"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D8D22539E;
	Fri, 23 May 2025 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747994726; cv=none; b=emqtLAGCh66zflOqkH2jhDw4MamM4q2K0KvOR6XoCJBc1PpPLQ2roz2e4hLXLqpN0xF4zVNxfrQjCAKkThHIG4sDILKUHzj66LmxEhJPBNGRsQHPyRQWemvMUPyXrdrUJQbBOZz6L3eScRDYEA3SewihDtW1yvT/wwuPoeQVDEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747994726; c=relaxed/simple;
	bh=9lMxXj8MKwZ4Er7DcvrrfhgATIRziyEK8+4buQTdATc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQwwgOV01rVJctjZCPysv2YBcHetj4odken52qWnNaQuFnLVf4xJJjR+K/TNrDGlajeq+YUk3HvVjpWbO22xC6OkRUx8T6u2LkOav3bM3JoUgJFK1Nn9afrva5J5NJZ3kXwfy08BUUH5ev41YhmlQmWY90bkuiOT4Im6gXm7jT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f1rsqm0+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9lMxXj8MKwZ4Er7DcvrrfhgATIRziyEK8+4buQTdATc=; b=f1rsqm0+rB0ZwLkryWWb0PP2hZ
	HsUtbe4YZIyuNKDNsf6Zi0losUgLgcJV7NaPAr0mJ98bzCaTH14Cv6QyqgIeaEhho/ndfquP5OKg+
	vG7soKXzsaM/4vTAa8vY4pm0EzUav2Ib0ob5eCf4fG8qvYpjzucn+iHyoGfd8eE3hMjKAY3+7uQu2
	1Hbs9MVPSypzRV4tHe5pFCk0oI9PnAzSyGCJB+mDpbSSfZjsgfjZ2BJLOPG7LbQksqR64Rg+nbTks
	oKrGixWVzqK/fruVpc+o9sW2Wz3PsRvN4Ky/mYfjoAPS/b85NqpCffgQIhHvfkFg5mNi/fUQW4VT1
	BYWkSMow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIPHG-00000003X8P-1oxy;
	Fri, 23 May 2025 10:05:22 +0000
Date: Fri, 23 May 2025 03:05:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ye Chey <yechey@ai-sast.com>
Cc: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drbd: fix potential NULL pointer dereference in
 drbd_md_sync_page_io
Message-ID: <aDBIYqS8rS9AVRI5@infradead.org>
References: <20250523085529.85368-1-yechey@ai-sast.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523085529.85368-1-yechey@ai-sast.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 23, 2025 at 04:55:29PM +0800, Ye Chey wrote:
> Under memory pressure, bio_alloc_bioset() may fail and return NULL.

No, not with the GFP_ flag passed here.


