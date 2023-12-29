Return-Path: <linux-block+bounces-1506-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B9E820055
	for <lists+linux-block@lfdr.de>; Fri, 29 Dec 2023 16:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44C01F2209F
	for <lists+linux-block@lfdr.de>; Fri, 29 Dec 2023 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79363125B2;
	Fri, 29 Dec 2023 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="M+2T/wGS"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA42125AD
	for <linux-block@vger.kernel.org>; Fri, 29 Dec 2023 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so36726639f.0
        for <linux-block@vger.kernel.org>; Fri, 29 Dec 2023 07:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703864675; x=1704469475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQjXtcB6Oq3k74ay/cs5vR/HD/xg6rvyoXPDzdeumLU=;
        b=M+2T/wGSQyR+xOT6bEIjpUQ7BX8U8lUUT/v1A1LORP9HJsxTMQ/3JNXb2zWkAp93Im
         v/+Z2OtRH2f2bZ6Zqr57bqRc3+zDX4WvJ1kVTx6PohPIDpf904MbkFPPGvqJut37njrT
         xXTPc/Pvlflq78TaaXnb0LGKKS0eXniSMMwCQRR30qW5LvKhGf7HsEr3ymKuQ32INjsU
         EAgyPjIofSEkCw3iliOn/ktT5D1jGPzyD9XjQvMF2aMfiQcr3w5zau1OLVoSuwpQbW/z
         iBHlnFL1p3OM/O5iyxpJFLhXYKMIZpi5LRa/MJVGu+8paByFfebwGsmY2lRaTKwV4O+E
         vrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703864675; x=1704469475;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQjXtcB6Oq3k74ay/cs5vR/HD/xg6rvyoXPDzdeumLU=;
        b=QvJiEHg3aHOusFU20uoImX1JI6QOtpTT9py4Yjz7HELEWL58CQ0T4ySq0Cn6zBIoh9
         xJibm+mnCp5RzSaDnMQvzE58RFBsQ8qWwzQ4TxTv5aOXBPHcpEadAhXVIOstu0MKQU9F
         jIU3vd43aK48PQVe6uP8POCKmZML1sRjUlE2saq7fYIaOR8GPJQuMCt61HNxw9mXcSHP
         LFZRzWQWRTMImdNbwPvDkY25FreKu7u7LzKB7TxIcVnfYD0qe1c8feTdLqDFjGTyNz2u
         x+Ia+9fMbz/Tio3khg+K0RKgNySWfm9IbyzxQwyZdQSFOzDWoc9KBAAAOKe0OAYs4dxe
         UwLg==
X-Gm-Message-State: AOJu0YwczPiYRAmiR18MfqNJhjlrQGeWnHeDKt+GS7iHzGrjFgdUtpzH
	fb+dH09VcQ1qQwfVMJu3ahLpGCcn3GN5nQ==
X-Google-Smtp-Source: AGHT+IHAm0ro/JYGZ86leiXTCWBYht33pHhUQxq1wRsVw6jMpELsHFapyFrv/5iAU4fxQiP4l1Rgag==
X-Received: by 2002:a05:6e02:1d13:b0:35f:da7a:3797 with SMTP id i19-20020a056e021d1300b0035fda7a3797mr22028997ila.1.1703864675229;
        Fri, 29 Dec 2023 07:44:35 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id z11-20020a634c0b000000b005ce6b79ab6asm1526889pga.82.2023.12.29.07.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 07:44:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Josef Bacik <josef@toxicpanda.com>, Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, Coly Li <colyli@suse.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, linux-um@lists.infradead.org, 
 linux-block@vger.kernel.org, nbd@other.debian.org, 
 linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org
In-Reply-To: <20231228075545.362768-1-hch@lst.de>
References: <20231228075545.362768-1-hch@lst.de>
Subject: Re: provide a sane discard_granularity default
Message-Id: <170386467352.1470147.12182761923584971917.b4-ty@kernel.dk>
Date: Fri, 29 Dec 2023 08:44:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Thu, 28 Dec 2023 07:55:36 +0000, Christoph Hellwig wrote:
> this series defaults the discard_granularity to the sector size as
> that is a very logical default for devices that have no further
> restrictions.  This removes the need for trivial drivers to set
> a discard granularity and cleans up the interface.
> 
> Diffstat:
>  arch/um/drivers/ubd_kern.c    |    1 -
>  block/blk-merge.c             |    6 +-----
>  block/blk-settings.c          |    5 ++++-
>  drivers/block/nbd.c           |    6 +-----
>  drivers/block/null_blk/main.c |    1 -
>  drivers/block/zram/zram_drv.c |    1 -
>  drivers/md/bcache/super.c     |    1 -
>  drivers/mtd/mtd_blkdevs.c     |    4 +---
>  8 files changed, 7 insertions(+), 18 deletions(-)
> 
> [...]

Applied, thanks!

[1/9] block: remove two comments in bio_split_discard
      commit: 928a5dd3a849dc6d8298835bdcb25c360d41bccb
[2/9] bcache: discard_granularity should not be smaller than a sector
      commit: 5e7169e7f7c0989304dbe8467a1d703d614c64db
[3/9] block: default the discard granularity to sector size
      commit: 3c407dc723bbf914f3744b0c2bb82265b411a50c
[4/9] ubd: use the default discard granularity
      commit: 599d9d4eab7c3d5dc6f1e0f8f052fee9eaa54e50
[5/9] nbd: use the default discard granularity
      commit: 1e2ab2e8a98c9e0629b5b8bff8ee6f2cb3e8daac
[6/9] null_blk: use the default discard granularity
      commit: 724325477f8a48ce1defc2a49998bbc19fe85c88
[7/9] zram: use the default discard granularity
      commit: 3753039def5d0d1c43af847b507ba9b782db183a
[8/9] bcache: use the default discard granularity
      commit: 105c1a5f6ccef7f52f9e76664407ef96218272eb
[9/9] mtd_blkdevs: use the default discard granularity
      commit: 31e4fac930814f2f92eb6ebac9c4d4e3b09f7aaf

Best regards,
-- 
Jens Axboe




