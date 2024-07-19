Return-Path: <linux-block+bounces-10142-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AA3937D43
	for <lists+linux-block@lfdr.de>; Fri, 19 Jul 2024 22:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7EE1F22007
	for <lists+linux-block@lfdr.de>; Fri, 19 Jul 2024 20:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ED91487DF;
	Fri, 19 Jul 2024 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TRA1j8ck"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDCA1474BC
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721420491; cv=none; b=Cvw5UFbKRnYv1hjsozz8eWIuAWa2g//tkOYIAZu42lSuY798mYydVOY2yNIBIYXNCP5gNSwkm6s898n5HFVF6tbrQLSUgcur2diP9Ol+9OTDUFDsnPqbK7miP2/cFSxNIq90/6XXjcCkhEw1kyVeYqk/A+sEiuxY4/hJ012gJ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721420491; c=relaxed/simple;
	bh=2bdZRPhF5gtq5KfiHg0howVDk4CBQylJ5J6dEvTrmyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtMtAnWFF4QAexLKP3ygdeVg9d1s2b2ROqaHTOtqggZZfr6ZDt4j3pDSfoujkCiBkkjbzUY4odleh+ZuUJHNqzmNDziBwuZ48f7oQN4siZ6VRh8Ul1kjP+/oGiYn2PXgRqvtXz+In93SuvA3GmYhyYVTsq8sRU7E1x7YotD5zjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TRA1j8ck; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fb3460b416so3033515ad.0
        for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721420489; x=1722025289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7TdICET9y2kBW1nT7B+XzjYYxpouKddOEs+h65MAYd8=;
        b=TRA1j8ckik8ax/Q1BwONUZwzcAG2ha8D7/6KofXQVTWrFpt8uPd34O2EbQGdfD/V8w
         bP6KYG0Ki+X6Gm5rNIfwauAqo4ozwLDHtkhHIShri+wTc+TiwfnAkTPqBrRkHaWH7FLI
         cMpPPDy+472BJSGfioMP7P7m7lkQ/Us+7Sct4Bf+JTLFeq4U7k922e1t3GE+V6G+wNGV
         KP7FRCBmmN9KmCe8hIhOzrnUvoHcaTkbllRTzNjhVAKcpUlY7eGzDQ+k63VUyyxt/1zz
         we9+m0E4z93IUyoxvu37nyeL8HptzMSHSY8EbPPprbiFUSeuB2H2N96MODsfU43uOzjK
         46Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721420489; x=1722025289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TdICET9y2kBW1nT7B+XzjYYxpouKddOEs+h65MAYd8=;
        b=DGUoZ1vAdzph2XtLtw6VkYaZ4wTvAmiM0nfvG/6og0QAhgHH2Bmluosy/5DJZX7J4K
         HHn6CIeM/8GG//ohJFhFZfjjINdbyQAInMpPkmk5/AHFBIVAOwkKxN3yZP3KW8Hm4CuZ
         QyAhQViSbwjtKiSQ3C7GCPEIWKe/ptUiGPiy8tGOL70SlsOc6l8NhWYn2AyiAQNR7cSO
         yxx2uquydLablzi7x+ERto+tzF8vovrxKp+F+Q8PrOVLT//2r0n1fRjbRpNYw3DwtRt5
         lFmhPx4qtyb0r4bUtBWUsR3KkNyGLHtXmM8LxRppAFwVSw+TfFUKJinOdIShuCK3Wtms
         9YPg==
X-Forwarded-Encrypted: i=1; AJvYcCWZluFNpbLC17VWKehdCG72qZBVRhf+tyrvkRIK7tcC5ck58+iBzXMRgvErQ/HohnwPH0v8Vnq21Z5wjxE173K0QD88Vt4wUwUUTXY=
X-Gm-Message-State: AOJu0YxCVHeBVnc6U6e5qUzE6FHQ8bmaLX78dwjk0+Omp5Bk0K6Mc583
	yxPS2Q7grpa7Y9Wf83eLbQhDYbL2QqdEFBlRj0wunhFz+991bzbv9zfgyEYwOqQ=
X-Google-Smtp-Source: AGHT+IFBmO+K7zL/agidVg2Z92TSxmmwPsuaZhiJ7FdU+invzsnYzP+ED6r48gQMg6agGpkBHJtLpw==
X-Received: by 2002:a05:6a21:6e4b:b0:1c3:b106:d293 with SMTP id adf61e73a8af0-1c42287e800mr783432637.3.1721420488617;
        Fri, 19 Jul 2024 13:21:28 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff552c39sm1565712b3a.136.2024.07.19.13.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 13:21:27 -0700 (PDT)
Message-ID: <173c7d32-2fae-40e4-a1d8-490cee3bba15@kernel.dk>
Date: Fri, 19 Jul 2024 14:21:25 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Slow down of LTP tests aiodio_sparse.c and dio_sparse.c in
 kernel 6.6
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, linux-block@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
 fstests@vger.kernel.org, Jan Kara <jack@suse.cz>,
 David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>,
 Amir Goldstein <amir73il@gmail.com>, Cyril Hrubis <chrubis@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.com>, Avinesh Kumar <akumar@suse.de>
References: <20240719174325.GA775414@pevik>
 <a59b75dd-8e82-4508-a34e-230827557dcb@kernel.dk>
 <20240719201352.GA782769@pevik>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240719201352.GA782769@pevik>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/19/24 2:13 PM, Petr Vorel wrote:
> Hi Jens, all,
> 
>> On 7/19/24 11:43 AM, Petr Vorel wrote:
>>> Hi all,
> 
>>> LTP AIO DIO tests aiodio_sparse.c [1] and dio_sparse.c [2] (using [3]) slowed
>>> down on kernel 6.6 on Btrfs and XFS, when run with default parameters. These
>>> tests create 100 MB sparse file and write zeros (using libaio or O_DIRECT) while
>>> 16 other processes reads the buffer and check only zero is there.
> 
>>> Runtime of this particular setup (i.e. 100 MB file) on Btrfs and XFS on the
>>> same system slowed down 9x (6.5: ~1 min 6.6: ~9 min). Ext4 is not affected.
>>> (Non default parameter creates much smaller file, thus the change is not that
>>> obvious).
> 
>>> Because the slowdown has been here for few kernel releases I suppose nobody
>>> complained and the test is somehow artificial (nobody uses this in a real world).
>>> But still it'd be good to double check the problem. I can bisect a particular
>>> commit.
> 
>>> Because 2 filesystems affected, could be "Improve asynchronous iomap DIO
>>> performance" [4] block layer change somehow related?
> 
>> No, because that got disabled before release for unrelated reasons. Why
>> don't you just bisect it, since you have a simple test case?
> 
> Jens, thanks for info. Sure, I'll bisect next week and report.
> 
> The reason I reported before bisecting is because it wouldn't be the
> first time the test was "artificial" and therefore reported problem
> was not fixed. If it's a real problem I would expect it would be also
> caught by other people or even by fstests.

Didn't look at the test cases, so yeah may very well be bogus. But it
also may not... And a bisection may help shine some light on that too,
outside of just highlighting what commit made it slower.

-- 
Jens Axboe


