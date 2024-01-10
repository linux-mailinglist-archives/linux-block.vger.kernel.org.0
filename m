Return-Path: <linux-block+bounces-1525-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 138CC821EF6
	for <lists+linux-block@lfdr.de>; Tue,  2 Jan 2024 16:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3C21F2104F
	for <lists+linux-block@lfdr.de>; Tue,  2 Jan 2024 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0CF14A9A;
	Tue,  2 Jan 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="g+7V6rb3"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300FF14A82
	for <linux-block@vger.kernel.org>; Tue,  2 Jan 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so67769739f.0
        for <linux-block@vger.kernel.org>; Tue, 02 Jan 2024 07:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704210040; x=1704814840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yW0MzlHZomB+YZkCH4YUGFwdNBjbNMVw3h7xePuFXBw=;
        b=g+7V6rb325AFmpTlqSiVivdwOPOxWNLVGaKNgSHKHel/AJSnOsAHM/KPm/gIzpAKuw
         7laqVF+hsZt3L+E8ttCOG+8QXdmXyPsseaAS+vCjOUkoVw22tIdAtLuDreRAnGMKtHNS
         rX1hK38+R2H2Y4lwoqqujXQMenHMoNT5/ntTkSSkE5BwYByOLs5IEEhHNV7idpG2EC/+
         yKJo2RxIH8XnkK0ROAbUeoZfHr3TE9PJL36i/1K9pQkxG0GHMhOQm59+AIGp2nDgZpV6
         8ra9DcpGgqZy+GMJV8cbTBagUO5YB1nEA4zsa/9laxV0l/upQzFm0SekXkdD2VJm6TTL
         9gGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704210040; x=1704814840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yW0MzlHZomB+YZkCH4YUGFwdNBjbNMVw3h7xePuFXBw=;
        b=hm9Nf67WtfKLSyvbbjSwf0/92nW6Tpd7AaBz5PetwuI9DHM9IJUZRWWbIV/0ZHVl3S
         LBnBHvEILyz/uVtvN9bFdqrbH86gT9NCZ1HeHx6HvZt87Rwow7HbZYcdhES0xM1lc3mi
         Ak0WrX5tAyddugVmPPsaaRC9JC9fK5bjHVP7jdw1P34wKy1ANMDg8p3c86+nFzf5oJPm
         Kt+kUR+PDSMU55au8S99OY9xADUqbXCiIvYbQkfEgb9+DZbJI6p2IQuJr9+LE+CsUsPZ
         coMRR1XmgDFD7zU3fvw5v+UwR+TKTa66sUiEZZNjQn5UevhskGuD7T6wETmTxVhE1638
         i5IQ==
X-Gm-Message-State: AOJu0YwAXxWC2Xo5yYrlbkbPHZoxH7gNfR19LwyTzKSOXKVCVqjZ3TQG
	Z1iHW5BRQ8s69uD+R6Hqi1Rbi+gCQXIAfg==
X-Google-Smtp-Source: AGHT+IEwoDpWa3DPCL2q3LLo73FXUxeDnS1RhrchV5t+VIVuVtSvXaa44wpnDuL6ftiaSS1FPUs3jg==
X-Received: by 2002:a05:6e02:20c5:b0:35f:ff56:c40a with SMTP id 5-20020a056e0220c500b0035fff56c40amr22286643ilq.0.1704210039707;
        Tue, 02 Jan 2024 07:40:39 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f12-20020a056e020b4c00b0036002c8127asm5354004ilu.5.2024.01.02.07.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 07:40:39 -0800 (PST)
Message-ID: <400dbdbf-e99e-4747-94db-54fb6674fdd5@kernel.dk>
Date: Tue, 2 Jan 2024 08:40:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] zram: use the default discard granularity
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Josef Bacik <josef@toxicpanda.com>, Minchan Kim <minchan@kernel.org>,
 Coly Li <colyli@suse.de>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-um@lists.infradead.org,
 linux-block@vger.kernel.org, nbd@other.debian.org,
 linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20231228075545.362768-1-hch@lst.de>
 <20231228075545.362768-8-hch@lst.de> <20240102011543.GA21409@google.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240102011543.GA21409@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/1/24 6:15 PM, Sergey Senozhatsky wrote:
> On (23/12/28 07:55), Christoph Hellwig wrote:
>>
>> The discard granularity now defaults to a single sector, so don't set
>> that value explicitly
> 
> Hmm, but sector size != PAGE_SIZE
> 
> [..]
> 
>> @@ -2227,7 +2227,6 @@ static int zram_add(void)
>>  					ZRAM_LOGICAL_BLOCK_SIZE);
>>  	blk_queue_io_min(zram->disk->queue, PAGE_SIZE);
>>  	blk_queue_io_opt(zram->disk->queue, PAGE_SIZE);
>> -	zram->disk->queue->limits.discard_granularity = PAGE_SIZE;

Yep, that does indeed look buggy.

-- 
Jens Axboe



