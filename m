Return-Path: <linux-block+bounces-2964-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A650984ABCD
	for <lists+linux-block@lfdr.de>; Tue,  6 Feb 2024 02:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93A51C22E54
	for <lists+linux-block@lfdr.de>; Tue,  6 Feb 2024 01:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2231D56758;
	Tue,  6 Feb 2024 01:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mAxplvRZ"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7634656754
	for <linux-block@vger.kernel.org>; Tue,  6 Feb 2024 01:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707184551; cv=none; b=jpLwCFmw+lBD75IVr0+5LevLjKX4hj8AVb+8I8zFeofXOmDTwQI6hgP5rjFQDXH5mHMp6HlUVqEdH+UIxkWOCP7/nQWZAq/hnqZHU89DsbHiqFN4qb4cQlD4pYqVsxcA1CVtc0JYjkhpf58fbta52pcuoUbOZvlCfBvF4MGG9KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707184551; c=relaxed/simple;
	bh=zjqhSeU5bHrLPNJ26BVaNrbCJCjPBdE2Vajc5aa42Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeTF/W+x2/D/pS7jQYXN7RQLBQE8LWrtBl+gGM7bpX44IUV4ZoTq1DZtsQru/U+kiM1zS5oXibttOd1U5B3nAHsV+Cg9P/exOXgv2fYbdLkGfFbGXn2Qa5g/cfBWiN+kpwUoEgZpEIr2UCbkBsMcmdpSO9oIb7cHwEfIyZxhZiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mAxplvRZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e055baec89so84348b3a.1
        for <linux-block@vger.kernel.org>; Mon, 05 Feb 2024 17:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707184549; x=1707789349; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F1MmYgIIiFSm7MBjhDY3RYdnKBzOdKpnmP/HxKDxl5M=;
        b=mAxplvRZ6Koad0lLiJY2+TYz3+dRoR9BhZh5swfn9fQBCfVY1SAIvISvkTI8R5xGmW
         CU+zNboRaK+WpgRsYuDos0fL/4hRshe0SP+rBvvuxgLlwcs7ViqYo5I3Egzc/bGfnj1T
         quZY3Wztc/knFEmZpjqi54nUi5AocWRz14ie4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707184549; x=1707789349;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F1MmYgIIiFSm7MBjhDY3RYdnKBzOdKpnmP/HxKDxl5M=;
        b=EhV9os24iNnUn243XOVIN8pulRKB2EmRHnnw0VXfq/XT0YtRc+zVoBqkHVEHlWrS5v
         o5s7vzYt17SQ067fMWfQj90FbCEwkJkfFVeuF1d0fXMUjRYzr1aCYtmetAIIgWNZ536c
         UwCx6qwXFayTY5WmEoOVSn9mR0oQ5ebr5Rz1f1SLZd0JVdIcquzbVbqQvBaEOLvEU7pX
         SWvOESTJX/jtwyMNkDX51UHougqCb4iZUzpDX5KzlI3yZmBkwTJjZGDJKnj9FePcXeHn
         Y58qp7stj55y4Pcy2JuUVQD7j4ptguGtXQN8aXGBqzV7YxHV0YCdjhs5Iv0Po7w/nuwp
         jf4Q==
X-Gm-Message-State: AOJu0YzeBsEOMt33IufR8EXJwV3TnCABu2Y6NeYQITZ5reCcNZRMWWvJ
	D68qjLNeBbctlb9d5LoXnY1Cb9AosnwJOQgjmyvG0KeLGN6WJBzHIMsAYDZSovnz2VdXlxL4qSg
	=
X-Google-Smtp-Source: AGHT+IEJZHwKFKfhWsv/YJOH+FEVByjE/nUG20+E2uvsJDgNZUHiIQzkE9Fu4POV3j2ObLvkj7HHDA==
X-Received: by 2002:a05:6a00:d4a:b0:6e0:3894:998f with SMTP id n10-20020a056a000d4a00b006e03894998fmr1834728pfv.17.1707184548772;
        Mon, 05 Feb 2024 17:55:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXbQjhm2Kn5naCHuCXWbrIJf8Ikj1Jsjs+8Y2/Iee+7aY6PgKU6TOy0QKx6QMjswRZf5K8oYhPFDOyJ6YGBVSEDnST1c4WEKqfDHeZpQahCJgGercp5H0jKvDAAAhbtMrMmmamC9o6VV8UkUY+wDzVNVKNx9+BaeFXfOjXKi9K6ljRMVC/ltpONPBUPGUsSV/vt5v8Uf2p9JFe4jj/lb+UqlbWAlcytBX9HSzaUeWwKQ+A1gJbRXenfe2YjIvNpgzs=
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id n10-20020a056a000d4a00b006dd8985e7c6sm581433pfv.1.2024.02.05.17.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 17:55:48 -0800 (PST)
Date: Tue, 6 Feb 2024 10:55:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, minchan@kernel.org,
	axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] zram: easy the allocation of zcomp_strm's buffers with 2
 pages
Message-ID: <20240206015543.GH69174@google.com>
References: <20240103003011.211382-1-v-songbaohua@oppo.com>
 <20240106013021.GA123449@google.com>
 <CAGsJ_4xp7HFuYbDp3UjMqFKSuz2HJn+5JnJdB-PP_GmucQqOpg@mail.gmail.com>
 <20240115023457.GA1504420@google.com>
 <CAGsJ_4x6e7=tWVKfauJaGMRmJ3tz7GymKosYcHrxoxEnAHyX6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4x6e7=tWVKfauJaGMRmJ3tz7GymKosYcHrxoxEnAHyX6g@mail.gmail.com>

On (24/01/29 10:46), Barry Song wrote:
> On Mon, Jan 15, 2024 at 10:35 AM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (24/01/06 15:38), Barry Song wrote:
> > > On Sat, Jan 6, 2024 at 9:30 AM Sergey Senozhatsky
> > > <senozhatsky@chromium.org> wrote:
> > > >
> > > > On (24/01/03 13:30), Barry Song wrote:
> > > > > There is no need to keep zcomp_strm's buffers contiguous physically.
> > > > > And rarely, 1-order allocation can fail while buddy is seriously
> > > > > fragmented.
> > > >
[..]
> > Okay, makes sense.
> > Do you see these problems in real life? I don't recall any reports.
> 
> i don't have problems with the current zram which supports normal pages only.
> 
> but  in our out-of-tree code, we have enhanced zram/zsmalloc to support large
> folios compression/decompression, which will make zram work much better
> with large anon folios/mTHP things on which Ryan Roberts is working on.
> 
> I mean, a large folio with for example 16 normal pages can be saved as
> one object in zram.
> In millions of phones, we have deployed this approach and seen huge improvement
> on compression ratio and cpu consumption decrease. in that case, we
> need a larger
> per-cpu buffer, and have seen frequent failure on allocation. that
> inspired me to send
> this patch in advance.

May I please ask you to resend this patch with updated commit mesasge?
E.g. mention cpu offlinig/onlining, etc.

[..]
> > > > I also wonder whether Android uses HW compression, in which case we
> > > > may need to have physically contig pages. Not to mention TLB shootdowns
> > > > that virt contig pages add to the picture.
> > >
> > > I don't understand how HW compression and TLB shootdown are related as zRAM
> > > is using a traditional comp API.
> >
> > Oh, those are not related. TLB shootdowns are what now will be added to
> > all compressions/decompressions, so it's sort of extra cost.
> 
> i am sorry i still don't understand where the tlb shootdowns come
> from. we don't unmap
> this per-cpu buffers during compression and decompression, do we ?
> 
> am i missing something?

No, I guess you are right.

