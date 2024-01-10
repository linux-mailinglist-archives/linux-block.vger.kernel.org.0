Return-Path: <linux-block+bounces-1637-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24854827300
	for <lists+linux-block@lfdr.de>; Mon,  8 Jan 2024 16:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5031C21014
	for <lists+linux-block@lfdr.de>; Mon,  8 Jan 2024 15:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C456F4C625;
	Mon,  8 Jan 2024 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XstsQf/e"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5436A4C624
	for <linux-block@vger.kernel.org>; Mon,  8 Jan 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7ba9356f562so19533139f.1
        for <linux-block@vger.kernel.org>; Mon, 08 Jan 2024 07:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704727607; x=1705332407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jKBszmdO+GFMl2fHINscvTxwqYrGI6Zn86c3J1Yhu2w=;
        b=XstsQf/e/AK3K3YYQ7/RdeeOce/DDT0IzrckK+djVFhSSVZ7Phzkq31wIYjUU688R0
         sGHPuP0fOi4pGW39wjJVnhKpRZhThLXl5F1N59UL0rCGexSKVPWe5HZQx2Np6Pji4IOa
         JcmJbq0E//OGAgBq1gd4KxF7OiHxbHfffADooPJ2iebHd6C0VAyjtElEwwbBYwrL+eca
         m2KHhDLC7/ZN8sMkoqfASnZUDPSkyipZdlUj4SOdRJUy5s3gMqKoPLCiELFmGI8S7ibO
         8taAT0BbLwQW+XLLxaXifRwED3IxDrG/nkj+uuiN+Kb7O4g9KoxFFXZqGpoJ+c5ZDy0s
         hfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704727607; x=1705332407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKBszmdO+GFMl2fHINscvTxwqYrGI6Zn86c3J1Yhu2w=;
        b=i8h8K1KQN9XntLWwyCIq7nRP1N/eWo8fDPkxysajWZ/6uUgtdTrxDdjYbCRtoKleJ/
         rvst5RcxBOcJMFnjyENiCC4q2hxEnDmpTHg3KIaMKHfgCyjc1L9IZ6Tcn187vIrGvH+E
         aI4iQhpaUKJd/oG/6ItwNkoN2HSOVk/0P5Aw92K2NY14OH6FEpJsh+Zv/cNRrHhNR62+
         PXCm3B3yRWqxHxEjDnV6i5YW9wVLX4PZ08HeCLJvtfBVRTF9Ph/BwAW2ngKOUyb57HUL
         4G4jkEZpJ7Etj1HZ+o0/FlTOKxA3B5z/7ZM2KR183D6UVgd6Lq8epGMWzDn5eGX/gSFw
         E8NA==
X-Gm-Message-State: AOJu0Yx/SjDd1lzW/j4LeL1K2w0AzlE3mV1GY3X3g0RitoThS9UVbPR0
	ZOKcNqkJ1KoVIbCynbduiU5HWC2Y0w8ICw==
X-Google-Smtp-Source: AGHT+IGdW9CJgcvJ2Uthw69BnC49HL+xr8afbYNDsiCuyMlQghag6fjOJBvE4n2UC5gZBoA6TG5KjQ==
X-Received: by 2002:a05:6602:4f42:b0:7bc:2c5:4f6a with SMTP id gm2-20020a0566024f4200b007bc02c54f6amr5641129iob.1.1704727606891;
        Mon, 08 Jan 2024 07:26:46 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bp15-20020a056638440f00b0046d6b3edd2asm9666jab.132.2024.01.08.07.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 07:26:46 -0800 (PST)
Message-ID: <1a4f6e1e-9981-4e2d-bacf-3e387addfa47@kernel.dk>
Date: Mon, 8 Jan 2024 08:26:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: remove another host aware model leftover
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org
References: <20231228075141.362560-1-hch@lst.de>
 <20240108082452.GA4517@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240108082452.GA4517@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/24 1:24 AM, Christoph Hellwig wrote:
> Jens, Martin,
> 
> can you take a look at this?  It would be great to finish the zone
> aware removal fully with this for 6.8.  Thanks!

Looks fine to me and I can queue it up. I'll do so preemptively, Martin
let me know if you have concerns and I can drop it from top-of-tree.

-- 
Jens Axboe


