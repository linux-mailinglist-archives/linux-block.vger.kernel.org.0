Return-Path: <linux-block+bounces-4966-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE3E88964E
	for <lists+linux-block@lfdr.de>; Mon, 25 Mar 2024 09:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8121F3176D
	for <lists+linux-block@lfdr.de>; Mon, 25 Mar 2024 08:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1BC137903;
	Mon, 25 Mar 2024 05:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="2Jz0jA0+"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E633B210860
	for <linux-block@vger.kernel.org>; Mon, 25 Mar 2024 02:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711334252; cv=none; b=CNiB2DwCEzR4o/SzATHtBceocFNCVCMvvZKMoWG364mCQQpQkkNYhTISpq149lZIf2cjSanQX/T9TLUMAGXbRCVNq2IL/srMeqZ3E9G0ERtcyovLrhREKQUISOvVQNQnxwG3TqTVPA2lFPbnUv8HfnqZXem9sTq85IWVVh11NGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711334252; c=relaxed/simple;
	bh=CUhu4fcoHxot+obl+L/lIB2mjnnCYJgKXU5JhtEOyz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ad7kJKBcXn4QdR4ijfcLoN000P4n/CNxk6mPmYLpu/jl1zHv5un8mD+w4UjheeookQx0idjU78/vvmPklO8h0zyu1Dd5pwiho1+BuwCusUor4R6Fcfg0qaD1ou+pr1+XpV1ICbHP8Kg0K7f0LVf/wq1mRl35xufE/Tg0QixsEsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=2Jz0jA0+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-341c7c8adf3so776930f8f.0
        for <linux-block@vger.kernel.org>; Sun, 24 Mar 2024 19:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1711334248; x=1711939048; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OmGpqFfHYwDGnVVZ3jzAGoFdzesxBNnjTqhjXueHYVY=;
        b=2Jz0jA0+gY0hPyGeZZI/SS29mN7sv/9v/HpfhXgWqXrc9xBobiybpkROmw1LG7IR6n
         SD07nDUS2Nu1c8sz/xv+BGN8p9T9xHQLUZd5p0WVk8MOb6hJvau5X8rd2I0T5BenOE+U
         yedEE1zb2ySqyWfEPZlOfoAyZV5Wh3/MoOLmRNnfVb6lZpD3UMeIRj6JY3ZlTiaOeO6v
         GROdaPeZVy4uCnbht1zSMf9RKkSXPxkkWm503kszhbMEkS7oT6qH7VUFO66YxFLOR4Gb
         ELbzWQ+3C28ehNmvr+GwfFsPPhnkQOVVe/qZ9intuoj33pShgVlyIhXq2+E59QbtOnfc
         //7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711334248; x=1711939048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OmGpqFfHYwDGnVVZ3jzAGoFdzesxBNnjTqhjXueHYVY=;
        b=fj/90PUBvAD5H6H1VfowmAQ+1koDkEtGhweqDUio50gZotpBdYh8Yr0btsg7pKKo1H
         PvOY1ZaZlL9758HGwTufDEErEJPb7uiwPZBbqEKUDXkCPJrUFSOcw+qmZ0t0MatI6DD5
         cKAkas9PtP/x2y/a2wy2buapRnaZHdWMLX2e44201j0Y3Wl2dRZl0V3SzfQdy4Pd0+Yk
         uJvJKEtQj2p8TQWhURT85JevJKe7t/HHLSBNQ0mlKpIPY0K58IN0ZmtILSlelSnrIEVJ
         E6ykxS5CWy4r71csdqv/Gvj41RJmwLdFMyWa1AyLief2jZkaV6b8K4QFhj5DvDyyCFcY
         +6lg==
X-Forwarded-Encrypted: i=1; AJvYcCUvF2x4HWhTWg0+hHOEqzMfDBuyAaZi24oUS1QBmI5oUDw98lk7v6LsVYRolKWhKtlrpiakpgNCYBLwvjm0O321/o1zykVQJCjvJ6s=
X-Gm-Message-State: AOJu0YwZzDBSiCPic9jeglreSyKdmermzfja0BG/85+lsHi1M/cDEHc8
	6HHCbCQ1/SKJ4BMvM4nHhurPij4hGonpYMU6WzYhaN1YPA5gZHXj7zigvzDUx58=
X-Google-Smtp-Source: AGHT+IEjg0Dx2wC73NkBfmUP1gPclrGptZkf2D1z3neuXuajn9j5XqsQLarLqd/JDV0rW21mR1/m4A==
X-Received: by 2002:a05:6000:1d85:b0:341:c9d1:eae5 with SMTP id bk5-20020a0560001d8500b00341c9d1eae5mr2379711wrb.27.1711334248259;
        Sun, 24 Mar 2024 19:37:28 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ck19-20020a5d5e93000000b00341c6440c36sm3898009wrb.74.2024.03.24.19.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 19:37:27 -0700 (PDT)
Date: Mon, 25 Mar 2024 02:37:26 +0000
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	juri.lelli@redhat.com, mingo@redhat.com, dietmar.eggemann@arm.com,
	vschneid@redhat.com, vincent.guittot@linaro.org,
	Johannes.Thumshirn@wdc.com, adrian.hunter@intel.com,
	ulf.hansson@linaro.org, andres@anarazel.de, asml.silence@gmail.com,
	linux-pm@vger.kernel.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] cpufreq/schedutil: Remove iowait boost
Message-ID: <20240325023726.itkhlg66uo5kbljx@airbuntu>
References: <20240304201625.100619-1-christian.loehle@arm.com>
 <20240304201625.100619-3-christian.loehle@arm.com>
 <CAJZ5v0gMni0QJTBJXoVOav=kOtQ9W--NyXAgq+dXA+m-bciG8w@mail.gmail.com>
 <5060c335-e90a-430f-bca5-c0ee46a49249@arm.com>
 <CAJZ5v0janPrWRkjcLkFeP9gmTC-nVRF-NQCh6CTET6ENy-_knQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0janPrWRkjcLkFeP9gmTC-nVRF-NQCh6CTET6ENy-_knQ@mail.gmail.com>

On 03/18/24 18:08, Rafael J. Wysocki wrote:
> On Mon, Mar 18, 2024 at 5:40 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > On 18/03/2024 14:07, Rafael J. Wysocki wrote:
> > > On Mon, Mar 4, 2024 at 9:17 PM Christian Loehle
> > > <christian.loehle@arm.com> wrote:
> > >>
> > >> The previous commit provides a new cpu_util_cfs_boost_io interface for
> > >> schedutil which uses the io boosted utilization of the per-task
> > >> tracking strategy. Schedutil iowait boosting is therefore no longer
> > >> necessary so remove it.
> > >
> > > I'm wondering about the cases when schedutil is used without EAS.
> > >
> > > Are they still going to be handled as before after this change?
> >
> > Well they should still get boosted (under the new conditions) and according
> > to my tests that does work.
> 
> OK
> 
> > Anything in particular you're worried about?
> 
> It is not particularly clear to me how exactly the boost is taken into
> account without EAS.
> 
> > So in terms of throughput I see similar results with EAS and CAS+sugov.
> > I'm happy including numbers in the cover letter for future versions, too.
> > So far my intuition was that nobody would care enough to include them
> > (as long as it generally still works).
> 
> Well, IMV clear understanding of the changes is more important.

I think the major thing we need to be careful about is the behavior when the
task is sleeping. I think the boosting will be removed when the task is
dequeued and I can bet there will be systems out there where the BLOCK softirq
being boosted when the task is sleeping will matter.

FWIW I do have an implementation for per-task iowait boost where I went a step
further and converted intel_pstate too and like Christian didn't notice
a regression. But I am not sure (rather don't think) I triggered this use case.
I can't tell when the systems truly have per-cpu cpufreq control or just appear
so and they are actually shared but not visible at linux level.

