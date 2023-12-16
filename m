Return-Path: <linux-block+bounces-1209-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9400815BC0
	for <lists+linux-block@lfdr.de>; Sat, 16 Dec 2023 21:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFCA2B23642
	for <lists+linux-block@lfdr.de>; Sat, 16 Dec 2023 20:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3D31E498;
	Sat, 16 Dec 2023 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="p7hZXBtq"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F19A1E48F
	for <linux-block@vger.kernel.org>; Sat, 16 Dec 2023 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ce6f4d3dafso432818b3a.0
        for <linux-block@vger.kernel.org>; Sat, 16 Dec 2023 12:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702759880; x=1703364680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UUxs9NMgV2od0wAPMGRXIqwkmFJ7SC5aOaZmQ30f1bI=;
        b=p7hZXBtqilk8a9Eo8gkmtxg0UZ6L2XB6ixBpI+aJs+DdnmyagfOqc+U1PcR/jbF8wD
         hwmmXv4Fce6qUIPfdnisRTnBUM9uiZRiouUpRG5qeO3pXcARGNiseYpdC1dFr8LGsxhT
         DR7LhPJgrKoLQucrfMXt57TbBGEZnmg1MssbFaiYDy86KoNXpNFcntGGZnlEPsO87XCR
         bgpBUToqUfWjJLHXZ+MzxqMffQ45nO7Qh6kWtXugW9tahIBQSc5SHHx86pkDHilUQ2Aa
         8J15zdChSGfWiNTRLM+p+zw90Pg8aHln/Q/hXj7K8q9hjAnMh1Wz+qGeWoXSwajPFlqh
         PO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702759880; x=1703364680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUxs9NMgV2od0wAPMGRXIqwkmFJ7SC5aOaZmQ30f1bI=;
        b=Ec4dlNa37vX4HaOegUACPWA6KrH7MwkfmIwvCoDU0rCiU0kVhuIqQeDzIfbAcpwIvf
         +09JKeQ1VuEqnTPG2GyaUji8MknfxzSaNfonP3nq1Nbm0RPApGSiS7+RmhHzscRkR1It
         Z0iuJeN2zSItwNEjUC4pKrfJ80ExxlCb6+bIog/oUOg4yAHv/E4K04yL7hrMW+xp2wq6
         c6gs/gVI+G7UdT1fEBya8xw9IcWJcH5PBl8nbKVjT1BeL/Huet82kHZfZVlIYy+/4cAo
         793RwIeXSF9/GEXi51RNinq+jT904Xq/vwfNR/ynHtA5UxrE9fonX81J+uxpPQlVkcNe
         +elw==
X-Gm-Message-State: AOJu0YyY30pPne0gB/05UU2B4hLgKlWLBh3nu8KQ52ZBpVhU3rG4mfXj
	uf0shN4OSfhLn/6fFFuMQ4ddRw==
X-Google-Smtp-Source: AGHT+IFM41eA1W6KpzXbrZaSAx+vtqUc15fi/kSiO5Tuskzb7LXFKv1+yQZanPIuUHcpd55ejgIsVg==
X-Received: by 2002:a05:6a00:460c:b0:6cd:dfff:19b6 with SMTP id ko12-20020a056a00460c00b006cddfff19b6mr29929295pfb.2.1702759879797;
        Sat, 16 Dec 2023 12:51:19 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id x6-20020aa784c6000000b006bd26bdc909sm15575923pfn.72.2023.12.16.12.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 12:51:18 -0800 (PST)
Message-ID: <226bdceb-e981-4a76-8912-bb5ec819ab78@kernel.dk>
Date: Sat, 16 Dec 2023 13:51:17 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] Clean up the writeback paths
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20231215200245.748418-1-willy@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231215200245.748418-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/23 1:02 PM, Matthew Wilcox (Oracle) wrote:
> I don't think any of this conflicts with the writeback refactoring that
> Christoph has kindly taken over from me, although we might want to redo
> patch 13 on that infrastructure rather than using write_cache_pages().
> That can be a later addition.
> 
> Most of these patches verge on the trivial, converting filesystems that
> just use block_write_full_page() to use mpage_writepages().  But as we
> saw with Christoph's earlier patchset, there can be some "interesting"
> gotchas, and I clearly haven't tested the majority of filesystems I've
> touched here.
> 
> Patches 3 & 4 get rid of a lot of stack usage on architectures with
> larger page sizes; 1024 bytes on 64-bit systems with 64KiB pages.
> It starts to open the door to larger folio sizes on all architectures,
> but it's certainly not enough yet.
> 
> Patch 14 is kind of trivial, but it's nice to get that simplification in.

Series looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



