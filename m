Return-Path: <linux-block+bounces-7215-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FC28C1F71
	for <lists+linux-block@lfdr.de>; Fri, 10 May 2024 10:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0701C21396
	for <lists+linux-block@lfdr.de>; Fri, 10 May 2024 08:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A55715F3F4;
	Fri, 10 May 2024 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c1qDH0mI"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EA015F3E0
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715328514; cv=none; b=pOI5xbivPlIcS+52ydS5M+DNVBw6PXN7rrmriXhy75wWMBVnw8R1jYwulbjCimRrqSrHEtrCRUGUN0MH2rlAXzcZzHTtEr1vURq4MkX1YGAORNnVnVdBLBIYt08Fk36INkc2yZK2Z1fQLPtHaaCyncdAhu9fmDSLRdCr1dtGzi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715328514; c=relaxed/simple;
	bh=m6CNW1vzSFZnIXgo/outHema5VQcOQ9NfttAJQqepG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iz43Tks6/h6ZWgUq8Dbhvrna07B2i8Rfd46ClLlH9p7YcOuDbpKjuczOigZqsqE0eVdkHX7oaG3oGseenM6R3k9c9ZjxpAZrDCYN/byjr4GXOS3tQkwKOaXi0CSnBfTXoA5Sn5AoNojZJWaqTtIvwNHfjhgES1w9BWi/lj9iqdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c1qDH0mI; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5f415fd71f8so1372686a12.3
        for <linux-block@vger.kernel.org>; Fri, 10 May 2024 01:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715328512; x=1715933312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kDvy7RxW/LonWTZxzU2RUlA0pAezoq7eGEcfDQs78AM=;
        b=c1qDH0mI5YQIk0RrEGkbQP/mHFonuaFjoX6J654DuPYy7+FR1CmwnyErsSMO22GfoW
         49238ovGQj/WVsNdZV0qddvVKfkmGj40enUeIM8aG7muVgzT9f+ScI8W5xiSC5lPfB/c
         /mvQL2d3fMbdP0IKKKZJ/GtRxsmYnnQ1OpkCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715328512; x=1715933312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDvy7RxW/LonWTZxzU2RUlA0pAezoq7eGEcfDQs78AM=;
        b=VcV6ZRaqCAiijI6Vb4SEQyFQGHBQsW0LNExWlfIrhTbWNudQOYzY3ZbHDt0KYni0rr
         Zwx1g5zUIywwBOY4qiygnfTEVnewT+d+K/xgvd3kErqo8QIspIPqLo1M7cGsqBbN8hwC
         q1GeY+9FxGtVFgBy8EkriFEzK/rvAk/Ayu+t6hcmvY73RyaMTA6cvDYtbLhlVHb9PVlx
         LA9tH5CR6xtHdmHv27IiucqrGaWkqwOXqAMVKwehLjNV/B15+Aj/qyne54/UhlOzM13T
         KdhSSN4vzV9I7mot6VmC+eoYGua3r+QOzSi1sBbCyBP8jPEz2r5PDTjne92TigTu9aao
         CFEA==
X-Forwarded-Encrypted: i=1; AJvYcCUb46TEhewx22d3n/AwscIymjDAzEzhFjDp9DX1tPs9eYL5h+iCMmWYwSDxXlREl/1w4OwaPAp/Bok5njqtzfevLJfg3vxi0rSrH7Q=
X-Gm-Message-State: AOJu0YzyquCmwgihHeYjZwgUChGcyoaVdshgwPH7+k3fy5PbheC7DlYc
	wn0lBBgeqraTxyFok9nUcEi5ZHpNqXHk89VTIJB1tuQaXWgq2pDx9ViDdFozwg==
X-Google-Smtp-Source: AGHT+IGF9ORRzj0zxrGo3FoBlciFZ8EHoE3IlRHjAu66C1+oKe6HASpREkCdE5EuIu6X0J44WBKW9A==
X-Received: by 2002:a05:6a20:394e:b0:1ac:4219:b817 with SMTP id adf61e73a8af0-1afde0dc405mr2403310637.16.1715328512565;
        Fri, 10 May 2024 01:08:32 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:de58:3aa6:b644:b8e9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b671782dcesm2930793a91.53.2024.05.10.01.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 01:08:32 -0700 (PDT)
Date: Fri, 10 May 2024 17:08:27 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCHv3 00/19] zram: convert to custom compression API and
 allow algorithms tuning
Message-ID: <20240510080827.GB950946@google.com>
References: <20240508074223.652784-1-senozhatsky@chromium.org>
 <ZjzFB2CzCh1NKlfw@infradead.org>
 <20240510051509.GI8623@google.com>
 <Zj3PXKcpqUPuFJRu@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj3PXKcpqUPuFJRu@gondor.apana.org.au>

On (24/05/10 15:40), Herbert Xu wrote:
> > But in general case, a typical crypto API usage
> > 
> > 	tfm = crypto_alloc_comp(comp->name, 0, 0);
> > 
> > should become much more complex.  I'd say that, probably, developing
> > an entirely new sub-set of API would be simpler.
> 
> We could easily add a setparams interface for acomp to support
> this.  The form of parameters would be specific to each individual
> algorithm (but obviously all drivers for the same algorithm must
> use the same format).

For some algorithms params needs to be set before ctx is created.
For example zstd, crypto/zstd calls zstd_get_params(ZSTD_DEF_LEVEL, 0)
to estimate workspace size, which misses the opportunity to configure
it an way zram/zswap can benefit from, because those work with PAGE_SIZE
source buffer.  So for zram zstd_get_params(ZSTD_DEF_LEVEL, PAGE_SIZE)
is much better (it saves 1.2MB per ctx, which is per-CPU in zram).  Not
to mention that zstd_get_params(param->level, 0) is what we need at the
end.

And then drivers need to be re-implemented to support params.  For
example, crypto/lz4 should call LZ4_compress_fast() instead of
LZ4_compress_default(), because fact() accepts compression level,
which is a tunable value.

