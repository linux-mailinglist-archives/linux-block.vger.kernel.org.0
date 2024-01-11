Return-Path: <linux-block+bounces-1749-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33DD82B305
	for <lists+linux-block@lfdr.de>; Thu, 11 Jan 2024 17:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D90B20A63
	for <lists+linux-block@lfdr.de>; Thu, 11 Jan 2024 16:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E641051013;
	Thu, 11 Jan 2024 16:34:12 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5875100A
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7831ed13d39so410653485a.0
        for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 08:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704990850; x=1705595650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2esTMRQCzcCE33PwQuXk2vauR9yVH94MN9kiOCQ9tzs=;
        b=OJxYcT0rIVAa6EGLXiiumf1RX12IQw2aVhIoXxOqIxZcJp0GtOf7kxE/FYhfsU8IDo
         bGGi5vRAfvTuEt/sKX2bqe2Ai69V//Khys3vjGpfJ+UxDYo3iG13R44E9KOo7uj8KyYt
         JK0ukrB9WZjP4M/41yJKgo0PbkjQAOgCSFIpj85FhFntchTRGLb8cXh6Y6uQvuEwzywL
         NekRU59ENiVmzuDNYGLB1NWCAXZsQNfehZyHrv0QYxtQLpohnRl+nX9TxDtATundo5b7
         CVQpvfUE8fR26xk42mS6YF56C4qeSkFV14W8FxAVfGShE6/3CJGE9zedSD3hQsAzDcyF
         UM2w==
X-Gm-Message-State: AOJu0YwW5uTUfC9hc9Nq2De+SDSUQAp/nBtnGJto7OCrZjydrZ5VEWMY
	hfQacM+gbH3q+Ry7yPdgBrOAeHOJ/jUw
X-Google-Smtp-Source: AGHT+IGAh+m+cNuLkjQr5nL2ko+JrU4YzyDesGitRYonCpP3ZLibLfsaD9Pfaqk12FGIoWeW6hVhbw==
X-Received: by 2002:a05:620a:2fb:b0:783:14df:3d2e with SMTP id a27-20020a05620a02fb00b0078314df3d2emr32292qko.151.1704990850136;
        Thu, 11 Jan 2024 08:34:10 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id q9-20020a05620a038900b00783237b3330sm444937qkm.31.2024.01.11.08.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 08:34:09 -0800 (PST)
Date: Thu, 11 Jan 2024 11:34:08 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel@lists.linux.dev
Subject: Re: [PATCHSET 0/3] Integrity cleanups and optimization
Message-ID: <ZaAYgJ+xK6c5p1/L@redhat.com>
References: <20240111160226.1936351-1-axboe@kernel.dk>
 <ZaASdg+NkFFy8Khx@infradead.org>
 <yq1o7dr6e09.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1o7dr6e09.fsf@ca-mkp.ca.oracle.com>

On Thu, Jan 11 2024 at 11:24P -0500,
Martin K. Petersen <martin.petersen@oracle.com> wrote:

> 
> > Bw, can someone help with what dm_integrity_profile is for?
> > It is basically identical to the no-op one, just with a different
> > name.  With the no-op removal it is the only one outside of the pi
> > once, and killing it would really help with some de-virtualization
> > I've looked at a while ago.
> 
> No particular objections from me wrt. using a flag.
> 
> However, I believe the no-op profile and associated plumbing was a
> requirement for DM. I forget the details. Mike?

I'll have to take a closer look.. staking device always complicates
things.

But the dummy functions that got wired up with this commit are suspect:
54d4e6ab91eb block: centralize PI remapping logic to the block layer

Effectively the entirety of the dm_integrity_profile is "we don't do
anything special".. so yes it would be nice to not require indirect
calls to accomplish what dm-integrity needs from block core.

Mike

