Return-Path: <linux-block+bounces-1815-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB4382D31E
	for <lists+linux-block@lfdr.de>; Mon, 15 Jan 2024 03:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315891C20A51
	for <lists+linux-block@lfdr.de>; Mon, 15 Jan 2024 02:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC011186A;
	Mon, 15 Jan 2024 02:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WhpEtCzP"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B622A32
	for <linux-block@vger.kernel.org>; Mon, 15 Jan 2024 02:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bd81436a5dso49438b6e.0
        for <linux-block@vger.kernel.org>; Sun, 14 Jan 2024 18:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705286103; x=1705890903; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NGPrP85irDsGWFe70TUihAZuFbLk81immVZNahh9t4E=;
        b=WhpEtCzPpEeSvXkUTLwOwv1V04MRh4v4V9jx6rGL6uiegvpqQwbc8Qs0RsXtRrgUTN
         qRF51wwqJ+yGkitd5++rOxp+UuQCxjUXsVKG9ygcxvqTt+XSbNu5p6XVy5FxUSWbQDQF
         /sXsSz0+L6vzpQug7iF62OGrGPhkGjs8k05hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705286103; x=1705890903;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGPrP85irDsGWFe70TUihAZuFbLk81immVZNahh9t4E=;
        b=io8FE8D2avfu0sUZXBCBrGISlLlXPM3UqeFvb4mv2U1ERtNBBdaGzUcY8Mhu/kqjM2
         SQBTpr8+hUxpHxvWMvDnesM+4fzttizR2Vit/JSFKICN3avotYfzeS7rHZ0OH762BHez
         bVxHI25Rk+30VQpuVvO2OmKf0RTkEj2Ss+R/09kClivIdUrJCmUxw1Fk0MGIQeXemiTn
         vUnOHCpeRyxrtQUWjUY6q7hNi5bl2hOIzy/MlV9nUuLPqJ66zU/bTVq+HVhmpuwOcNK7
         gKPyQGpPQZeSG2mVQSSTZUzXimGxy9suCzyLeasRCpvCLDBysZ/x5ZaUL/TEi+5xa6Yu
         1nUw==
X-Gm-Message-State: AOJu0YxkEm1OmXwjFQapDTSkRwvK0FxlaB2cEvy1rICemflShCeDJVlu
	tRBu75W7EOXTh0tXvo5MPN6S/8/5BV50
X-Google-Smtp-Source: AGHT+IFRv0AmoFvgwlkkyp85zuO26TKlaEUoD5VXtzgftfHYB8FPUF8Ah1DQeJR85v80fBf0JBJ+HQ==
X-Received: by 2002:a05:6808:11c5:b0:3bd:5b4d:3e30 with SMTP id p5-20020a05680811c500b003bd5b4d3e30mr5318468oiv.81.1705286103273;
        Sun, 14 Jan 2024 18:35:03 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id b6-20020aa78106000000b006d9b31f670esm6840339pfi.143.2024.01.14.18.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 18:35:02 -0800 (PST)
Date: Mon, 15 Jan 2024 11:34:57 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, minchan@kernel.org,
	axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] zram: easy the allocation of zcomp_strm's buffers with 2
 pages
Message-ID: <20240115023457.GA1504420@google.com>
References: <20240103003011.211382-1-v-songbaohua@oppo.com>
 <20240106013021.GA123449@google.com>
 <CAGsJ_4xp7HFuYbDp3UjMqFKSuz2HJn+5JnJdB-PP_GmucQqOpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4xp7HFuYbDp3UjMqFKSuz2HJn+5JnJdB-PP_GmucQqOpg@mail.gmail.com>

On (24/01/06 15:38), Barry Song wrote:
> On Sat, Jan 6, 2024 at 9:30 AM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (24/01/03 13:30), Barry Song wrote:
> > > There is no need to keep zcomp_strm's buffers contiguous physically.
> > > And rarely, 1-order allocation can fail while buddy is seriously
> > > fragmented.
> >
> > Dunno. Some of these don't sound like convincing reasons, I'm afraid.
> > We don't allocate compression streams all the time, we do it once
> > per-CPU. And if the system is under such a terrible memory pressure
> 
> We actually do it many times actually because we free it while unplugging and
> re-allocate it during hotplugging. this can happen quite often for systems like
> Android using hotplug for power management.

Okay, makes sense.
Do you see these problems in real life? I don't recall any reports.

> > then one probably should not use zram at all, because zsmalloc needs
> > pages for its pool.
> 
> In my humble opinion, 1-order allocation and 0-order allocation are different
> things, 1-order is still more difficult though it is easier than
> 2-order which was
> a big pain causing allocation latency for tasks' kernel stacks and negatively
> affecting user experience. it has now been replaced by vmalloc and makes
> life easier :-)

Sure.

> > I also wonder whether Android uses HW compression, in which case we
> > may need to have physically contig pages. Not to mention TLB shootdowns
> > that virt contig pages add to the picture.
> 
> I don't understand how HW compression and TLB shootdown are related as zRAM
> is using a traditional comp API.

Oh, those are not related. TLB shootdowns are what now will be added to
all compressions/decompressions, so it's sort of extra cost.
HW compression (which android may be doing?) is another story.

Did you run any perf tests on zram w/ and w/o the patch?

> We are always passing a virtual address, traditional HW drivers use their own
> buffers to do DMA.
> 
> int crypto_comp_compress(struct crypto_comp *comp,
> const u8 *src, unsigned int slen,
> u8 *dst, unsigned int *dlen);
> int crypto_comp_decompress(struct crypto_comp *comp,
>   const u8 *src, unsigned int slen,
>   u8 *dst, unsigned int *dlen);
> 
> In new acomp API, we are passing a sg - users' buffers to drivers directly,
> sg_init_one(&input, src, entry->length);
> sg_init_table(&output, 1);
> sg_set_page(&output, page, PAGE_SIZE, 0);
> acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, dlen);
> ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req),
> &acomp_ctx->wait);
> 
> but i agree one-nents sg might have some advantage in scompress case

Right.

> after we move
> to new acomp APIs if we have this patch I sent recently [patch 3/3],
> https://lore.kernel.org/linux-mm/20240103095006.608744-1-21cnbao@gmail.com/

Nice.

