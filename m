Return-Path: <linux-block+bounces-7207-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872CB8C1D9C
	for <lists+linux-block@lfdr.de>; Fri, 10 May 2024 07:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34632283420
	for <lists+linux-block@lfdr.de>; Fri, 10 May 2024 05:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A61E149C43;
	Fri, 10 May 2024 05:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jAYtvQCS"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D12152795
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715318117; cv=none; b=szAs3LHyG97/rARiSU5aOX1KBAe/ty+Q5Er9VzA3+VIy8vtPwt/jBbie9SyW5G/LCnfy7x9jWxiPLe3TE+HuXiFur7OjBgQOmtFKsshj3CvueLeoAo1ts4d5ZBNWRPxgZKG+PAn8Xv2EQLzBjc7vLcUKgArPC7G97ll9SG73m9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715318117; c=relaxed/simple;
	bh=5g9aqIrd/CSisewRoD5xcikITn2+u3Jq5S9fr5CZlsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARpg3/vAlUnY9exFoklIlicqjcFOgFbiLyTGsfFlUo5X7P2gLPVLedq3WcOjDapsn1Hw75DCkKlarcphz6Y/e/ZnsrgXuvsMjrn9C4zjBS7meDBC0db1bGjzEv8VmdxGrW/6NpULygXmWVCp+eXGAuhX4XiHGa3PTlKYRTdFfLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jAYtvQCS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ecd9a81966so19462715ad.0
        for <linux-block@vger.kernel.org>; Thu, 09 May 2024 22:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715318114; x=1715922914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wgyaaXbsvqD2LsppPxdAFhGM87M6tpgqLYTXW/9G1I0=;
        b=jAYtvQCSKlJWdnaFqFm4oNeLQoEAzIowF/acMcKaHs4OpQBRIWGiZJUEeH+ZvjeJgB
         xYZpWOX60x7zP9W/IenR4AthpIH/GQJ1zjGLFM5iA/87NR1MUNmphfBYMNWUVOI4cP5h
         fYgF1do73z6V0w0IBpWiaBUOKMzkB0Fgx61IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715318114; x=1715922914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgyaaXbsvqD2LsppPxdAFhGM87M6tpgqLYTXW/9G1I0=;
        b=SWoNS/+cSxQDgg4iiKprLm8Az0Gbpa85Sxgsj2GjeWN9XQYTNIWLFvPNFQHPDwOgG5
         t8EcKCBymA7YMpqzQRojscUgdnX5iU3mdLLSjNOVzClqk/EJCd53zDovtGS8IivXRFzm
         MBJ4XFfCR5TPUjSLnZQxROY1V3TxFMHcPltsHuJNZ49XyVDstVbukOKx5KJHBBGEwFhg
         zXLpgKUcE+I99My4tK/0bin0HaXeBb7DtU7yuHT+KHDDEP42iWfjA6ljmjZqHGrKi4cY
         MGQyY6x/2EPu2XQe8O0AyUdmDLYHltZ5XkvCd1eizKVdTQfEnPNNa5jtVcX6EwFH8Yae
         uR4Q==
X-Forwarded-Encrypted: i=1; AJvYcCURB0bh8sY4obBy/bDu11CDRJrgZ6/v1aS/71IKlEHYbvdu1jBWOVta2IvO0FB7JS/21KMR6aQu8bxW4CI6SfIrqqheL5kkC4zDdiM=
X-Gm-Message-State: AOJu0YzuxFodK1hTHRRtJlkqp9Hn120ZxDOGLQH/7s+OFMBR37oLceGL
	GxCRaDSjYnOBoEW9jkHcDl7hu+Fa1gBaj3Uc5puP0RLk2qPC8ixlqrqHrkpdGA==
X-Google-Smtp-Source: AGHT+IH7Hm/lOPljffiTQlTyKmy5eyFByNf3HR9v7FBg8O8DcfEkdnc1sFp0c5lqNAE+UzNDn6j1fQ==
X-Received: by 2002:a17:902:f68f:b0:1e0:9964:76f4 with SMTP id d9443c01a7336-1ef42e6e646mr25664035ad.14.1715318114238;
        Thu, 09 May 2024 22:15:14 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:de58:3aa6:b644:b8e9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136b2fsm23433415ad.241.2024.05.09.22.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 22:15:13 -0700 (PDT)
Date: Fri, 10 May 2024 14:15:09 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCHv3 00/19] zram: convert to custom compression API and
 allow algorithms tuning
Message-ID: <20240510051509.GI8623@google.com>
References: <20240508074223.652784-1-senozhatsky@chromium.org>
 <ZjzFB2CzCh1NKlfw@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjzFB2CzCh1NKlfw@infradead.org>

On (24/05/09 05:43), Christoph Hellwig wrote:
> On Wed, May 08, 2024 at 04:41:53PM +0900, Sergey Senozhatsky wrote:
> > 	This patch set moves zram from crypto API to a custom compression
> > API which allows us to tune and configure compression algorithms,
> > something that crypto API, unfortunately, doesn't support.
> 
> [...]
> 
> >  21 files changed, 1203 insertions(+), 111 deletions(-)
> 
> Why can't it?

Well, I asked crypto folks if that's doable and the only reply was
"did you try using compression libs directly".  And that's not a
bad response, I take it.

The handling of parameters becomes quite intrusive very quickly.
It's not as simple as just passing a new "struct crypto_tfm" to all
sort of API abstractions that crypto has, it's a little more than that.

Just as an example.  For zstd we can work in two modes
1) load the dictionary by_copy
2) load the dictionary by_ref

In (2) we need to guarantee that the dictionary memory outlives any
comp contexts, so cyrpto_tfm-s now begin to have "external" dependency.
But if we load the dictionary by_ref then what we can do is a
pre-processing of the dictionary buffer - we get CDict and DDict
pointers (specific only to zstd backend) which all contexts now can
share (contexts access C/D Dict in read-only mode).  For this we need
to have a pre-processing stage somewhere in the API and keep the
"compression's backend private data" somewhere, then somehow pass it to
context cra_init and release that memory when all context were destroyed.
In zram I just went with "we do only by_ref" and handle all the
dependencies/guarantees, it's very simple because all of this stays
in zram.

But in general case, a typical crypto API usage

	tfm = crypto_alloc_comp(comp->name, 0, 0);

should become much more complex.  I'd say that, probably, developing
an entirely new sub-set of API would be simpler.

So I implemented a simple zram comp API.  I can't tell how much effort
it'll be to handle all of this in crypto, I'm not really familiar with
crypto, and I'm not sure if crypto API folks are even interested.

> This is an awful lot of crazy code duplication just
> to pass a few parameters.

I see what you mean, but the majority of the code is unique, there
isn't too much code duplication in fact.  Params handling is unique,
dictionary handling is unique, zstd implementation is entirely
different and pretty much specific to zram (we don't handle all sort
of cases that zstd API support, we focus on things that we need),
lz4/lz4hc implementations are also different, etc. etc.  Things like
lzo/lzorle may count as code duplication, but those are like 20 lines
of code or maybe even less (which isn't that crazy).

