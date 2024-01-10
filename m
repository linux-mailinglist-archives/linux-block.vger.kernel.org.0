Return-Path: <linux-block+bounces-1600-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88214824BA9
	for <lists+linux-block@lfdr.de>; Fri,  5 Jan 2024 00:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9ED1B22308
	for <lists+linux-block@lfdr.de>; Thu,  4 Jan 2024 23:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4262D046;
	Thu,  4 Jan 2024 23:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dXzU8xE1"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D002D041
	for <linux-block@vger.kernel.org>; Thu,  4 Jan 2024 23:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso13969639f.1
        for <linux-block@vger.kernel.org>; Thu, 04 Jan 2024 15:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704409608; x=1705014408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b3dqk0Ff5KxkGnHBKa5j/udiyY23Ohwl6jdUCl4DaB4=;
        b=dXzU8xE1lqQl2K7qBNp3a3sUpSqmuTJxjsd4bnp3v497vyejefnaPCwiohBtsBc/0f
         FKWeuorH/FAvl5raJJYxDNmer4qPEFy2AV6asWQm+8kSLhQd6WXxCsw8tDboeKaHz7jT
         A0p2zzkqyZW3j5Dktq5cHhtZ0nrEpOe1cGZDtaAUsqffDykLlILtJ5a4WOr3AKvvdiId
         dBx1NWOhTFBO6WHzD4rJlDEKdKNhWWTEsnbQWKKYrYd5XjTmhREOmqo/kHaZsJCw13OB
         pmDkJubfmaPu+BMU32t7bz4J3XdVTp1F0DBRe6g6GFU6QmJqDuWphshDVGmNuZ+Yurbk
         gzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704409608; x=1705014408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3dqk0Ff5KxkGnHBKa5j/udiyY23Ohwl6jdUCl4DaB4=;
        b=WJAHZ6hAskQuWrOBaiYGZRyGJDOgFX4zQU9dUq1MnX1xvhI0/+xSBYp4BF90//ABao
         PHIZxqCSmhWrrVvWqljsiomwD+t/iyqLRAKwg8x2uYbs8tdXchJfw7wTkH/xaAaWfVZk
         w7KoA/iqeGC3JXvk6u8P6FIuc3gty/7x9RYuEo6CfMv2yxUHcdDL7LCG1jEleJOvhH0b
         6cUeeCdIipFiA9onnvTgVkBSJTXz2cFChNSOLrwUJg4VkttDUnY/1oXHhssXqjS7bFLE
         HKRKmbF6Qmi0jWLLU8i6L8b1+Vd1YaEHKpw90U95Lq3tbE3jc3PAJMyVHQUKCQfle6fi
         jeag==
X-Gm-Message-State: AOJu0YxzFebHb+Ha4TEtbFr6tNqhKo0hikIO5szaOTFHTu0OOpMGxqTv
	fTbMnY26mtK0Pu1zjfIGQ6fhDciBaTjM4A==
X-Google-Smtp-Source: AGHT+IGgccmdncGNoX+25kh9DYA4Gbp7Q5ZjvFowunHoL6hvtLSnc3FlWD4tNyBMo/lEb+prYIa2fA==
X-Received: by 2002:a92:c56a:0:b0:35f:b1d8:433f with SMTP id b10-20020a92c56a000000b0035fb1d8433fmr2502382ilj.3.1704409608642;
        Thu, 04 Jan 2024 15:06:48 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id b1-20020a63eb41000000b005aa800c149bsm199646pgk.39.2024.01.04.15.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 15:06:47 -0800 (PST)
Message-ID: <3de0c147-0a6e-47ad-90dd-cc624da6200b@kernel.dk>
Date: Thu, 4 Jan 2024 16:06:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-cgroup: clean up after commit f1c006f1c685
Content-Language: en-US
To: Daniel Vacek <neelx@redhat.com>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240104180031.148148-1-neelx@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240104180031.148148-1-neelx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/4/24 11:00 AM, Daniel Vacek wrote:
> Commit f1c006f1c685 moved deletion of the list blkg->q_node
> from blkg_destroy() to blkg_free_workfn(). Clean up the now
> useless variable.

I'll fix up your commit this time, but please take a look at
your title and tell me if you think it's a good one? Not
very descriptive, is it.

-- 
Jens Axboe



