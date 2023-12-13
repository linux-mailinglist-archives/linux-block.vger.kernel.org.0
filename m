Return-Path: <linux-block+bounces-880-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D9B8092F1
	for <lists+linux-block@lfdr.de>; Thu,  7 Dec 2023 22:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 844B8B20C30
	for <lists+linux-block@lfdr.de>; Thu,  7 Dec 2023 21:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94C650267;
	Thu,  7 Dec 2023 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QoRiMK/Z"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DC31708
	for <linux-block@vger.kernel.org>; Thu,  7 Dec 2023 13:04:27 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7b37a2e6314so12107639f.1
        for <linux-block@vger.kernel.org>; Thu, 07 Dec 2023 13:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701983067; x=1702587867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXvEzGNamUbqRrEd+8gPXXWIOewwxYDCIMTlohmAGFI=;
        b=QoRiMK/Z9M/7bpN7wxJeH9Ytn/rFh9dfmJgdszH4KaB0TTvLJSTxXTkOisNZgsyGWG
         dkIadtkDAkS4b9TZfSm45P5Z7AMva6+YYUeqTeb1VvehYUkU6A4/zbB9bwQUqGUWOAVj
         o8o7THEjtHTFqUeWe29SdFzEvuoPrEGT3wVafZ08RT5KpFO79TSFLQgher4E8KlS40YZ
         MpqSEFg0qIW80NWGPHasXaJdP9/PNbLKyj2CgQFZGRKXV3bpbqZiOB/8YiamKAsQRXy9
         Bp/f6M8S6bFuXSz8FhApnN3yaPzIc1Ng6BrVPTJlsfk9/pdvU5Bg8R6aKzPaABakFv0A
         gmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983067; x=1702587867;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXvEzGNamUbqRrEd+8gPXXWIOewwxYDCIMTlohmAGFI=;
        b=OBbZD57I42wVgQGiqpleiPClZg4aCumz/r7+4eIPhRjRoVBkbswb3SROeZwpjsJdYf
         qIbjVpuYTPsr2VTo8t/dzH7do10xZ3yNqBHBbKDK91od/h40DmtYy+wE1RB1YkqbOUfT
         c3ITeCbEZVJDMcG9vm4f4ejQ5xx9mMBRdu6JIQ6rKI41kLCeP5LDG/F/CNZzRl+WPmrV
         8DOerOcfobDDRX4AlBD1TuJtkOtyMn5lnUi4MPbPOYFp5KwsRTNNOVzKF6PLji7alYp3
         iV3sGwwrZh4PFh4UrdvsMUi0v8siAD4IW8mT86YzhL8VlurLd+XEHs8RhLNYPhseL5f2
         0OMg==
X-Gm-Message-State: AOJu0Yy1oqBodnjRmglwHfMLBJ4wdSnQsiOzbWPzrJ7ft3MrSS4waRkz
	UzmcQFFJB8JBOWOaD75HOq0SrA==
X-Google-Smtp-Source: AGHT+IHD6Hl71ge/A3HXgZbYEah2+7DDoF0+51S3+Ha7PvHo1MdC6v1kljCPHJ00TvAeoRdBNPUd1g==
X-Received: by 2002:a6b:f105:0:b0:7b6:fb5d:fe4d with SMTP id e5-20020a6bf105000000b007b6fb5dfe4dmr2666390iog.2.1701983067233;
        Thu, 07 Dec 2023 13:04:27 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f10-20020a056638118a00b0043a1b74a0e3sm115951jas.90.2023.12.07.13.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:04:26 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
 Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20230814144100.596749-1-willy@infradead.org>
References: <20230814144100.596749-1-willy@infradead.org>
Subject: Re: [PATCH] block: Remove special-casing of compound pages
Message-Id: <170198306635.1954272.10907610290128291539.b4-ty@kernel.dk>
Date: Thu, 07 Dec 2023 14:04:26 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Mon, 14 Aug 2023 15:41:00 +0100, Matthew Wilcox (Oracle) wrote:
> The special casing was originally added in pre-git history; reproducing
> the commit log here:
> 
> > commit a318a92567d77
> > Author: Andrew Morton <akpm@osdl.org>
> > Date:   Sun Sep 21 01:42:22 2003 -0700
> >
> >     [PATCH] Speed up direct-io hugetlbpage handling
> >
> >     This patch short-circuits all the direct-io page dirtying logic for
> >     higher-order pages.  Without this, we pointlessly bounce BIOs up to
> >     keventd all the time.
> 
> [...]

Applied, thanks!

[1/1] block: Remove special-casing of compound pages
      commit: 1b151e2435fc3a9b10c8946c6aebe9f3e1938c55

Best regards,
-- 
Jens Axboe




