Return-Path: <linux-block+bounces-1516-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E5D82161B
	for <lists+linux-block@lfdr.de>; Tue,  2 Jan 2024 02:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EF8281690
	for <lists+linux-block@lfdr.de>; Tue,  2 Jan 2024 01:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A6C62F;
	Tue,  2 Jan 2024 01:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jBkzpQnE"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C9638F
	for <linux-block@vger.kernel.org>; Tue,  2 Jan 2024 01:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dc36e501e1so2042832a34.1
        for <linux-block@vger.kernel.org>; Mon, 01 Jan 2024 17:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704158150; x=1704762950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AiGwSYUXI9fxcYVwvEl26RBkMK69KBi7r4UwJQYgdE4=;
        b=jBkzpQnExLpXDqhM2pYHoDe9Usm1Xl2Z0BJJkMf9Bdp2yf3WjZDoTLWNfyb/ETj5ac
         yA+VMXeBGEl2GXXVW5J1JBdcl7qUrTk7FGrI5AtaYNywz7NWu7QPsa+P/JaDMbbm24Z9
         5SjYjjUxm0127Kfr5vsSbAMyh1UP+cs97muus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704158150; x=1704762950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiGwSYUXI9fxcYVwvEl26RBkMK69KBi7r4UwJQYgdE4=;
        b=BHoK8xtlFNeW8LqFgjiMfX+xnlri/e5VIxLfiEBmw3kGjJkIvc/DVUjX83ZxnrLDhp
         hwJqDnjQYV+R4qtnpsX7ug/AUtpp0udnhh7Ab5ynBiUVb+mH5Gmfs08qzSVWKJcbqqJd
         +ik4scnu9yAjwE/933XAvzTNl8dsrGrmSiNd5Jb6fD8XFTRc3HYIbKsTiaQg5gdYLfuw
         LT3XEsE94leDM8KOgh3ZEJBQK1yxy3lYd9qLV0yub/x320F3vKhTIjyAEzt42Gm++RqN
         rw4yKH2kU+u3ZmKAPQCpzZwh3YORB3FE1wW7NjDIIq4w9TwL1C/Uor+Nay3W/hSJOmyW
         H7Jg==
X-Gm-Message-State: AOJu0YzHc2l29yhwJg/tX2604jSIR+STLIYp45HriecNB/HDmNb7nCVV
	sWldwCIusBL9qkF8HfYG4Cc+CW/lIinY
X-Google-Smtp-Source: AGHT+IH9S0eoxCJzaBceLRCqYyMLMz41Ex8ouKxN6Dp7H2vys3Lzl953E5tC2NyCU5dsGbkan5tlDA==
X-Received: by 2002:a05:6871:8983:b0:204:5246:eda6 with SMTP id tj3-20020a056871898300b002045246eda6mr19443277oab.69.1704158150228;
        Mon, 01 Jan 2024 17:15:50 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id si6-20020a17090b528600b0028b5812c477sm25447407pjb.35.2024.01.01.17.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 17:15:49 -0800 (PST)
Date: Tue, 2 Jan 2024 10:15:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Coly Li <colyli@suse.de>, Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-um@lists.infradead.org,
	linux-block@vger.kernel.org, nbd@other.debian.org,
	linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 7/9] zram: use the default discard granularity
Message-ID: <20240102011543.GA21409@google.com>
References: <20231228075545.362768-1-hch@lst.de>
 <20231228075545.362768-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228075545.362768-8-hch@lst.de>

On (23/12/28 07:55), Christoph Hellwig wrote:
> 
> The discard granularity now defaults to a single sector, so don't set
> that value explicitly

Hmm, but sector size != PAGE_SIZE

[..]

> @@ -2227,7 +2227,6 @@ static int zram_add(void)
>  					ZRAM_LOGICAL_BLOCK_SIZE);
>  	blk_queue_io_min(zram->disk->queue, PAGE_SIZE);
>  	blk_queue_io_opt(zram->disk->queue, PAGE_SIZE);
> -	zram->disk->queue->limits.discard_granularity = PAGE_SIZE;

