Return-Path: <linux-block+bounces-9148-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77419104E2
	for <lists+linux-block@lfdr.de>; Thu, 20 Jun 2024 14:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596C82862FD
	for <lists+linux-block@lfdr.de>; Thu, 20 Jun 2024 12:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E761AD3F2;
	Thu, 20 Jun 2024 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s4Aic17J"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A871AC79E
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888165; cv=none; b=VAMp34fReeDiN3gfTWsNtOXXd32Zm9OdpSZMBFYET5lEoQe1Y/zcFQlecgjaaKBSc1HAQTbCmv4rBh+0t6cBM8zmN6pKP2S4wJU/lpMdHH6nKYfijy8bdB/rHDbwZ7xGmOQvQZUf6Xa5E29rUozxBNQfB2v2lJJ7yvt17PguXA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888165; c=relaxed/simple;
	bh=RuJyc/vh7rRo84AoGK79y+sVnZDtFtSGukVmP5Nu3Mg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=thWhLkje1DdNhCwlTQplwH/LIQZezSYSxyVKJhfbE7un1hUe0tpdREXExkA9F1GAeUI98Z3jHSY+I/QEKU1t7rZSFOXCalG0/ImZA5nopI4bc7RX1QCaV0dm/NddRP/tQKAOgCJ02AsAbU2foUdeCAsW7aJUs/8noJhWfcUV3xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=s4Aic17J; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7119502613bso121828a12.2
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 05:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718888163; x=1719492963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+GpvSy/VWf2OfE/fuIXNKg0MDOOI+VCks5t0p/pcdM=;
        b=s4Aic17JGwtSch1sGqAGQb4YJhknw18r8r4NSw8u+6elAp3u3dDa6taWd/nNYKMKoJ
         sxeR8BAJUTMMlvtmN49Nb8YNlG2/hJRSbOGmyAt+7/Zfx5RKgkzSIjzohp05JDGeRLWs
         XLTl7ApNBwni0Ijr7soq82r16w8NCu7n+o8qG3eB/ayCHm62C0W7VxuYTMIndNjbaoCr
         i6/N4CikULg+lBFcB4K7MptsGbrF584J27WNAzUYcaNHxq3ohC9nTq9OP0KGGxEWxqbf
         Cczf4Ik3IrYqRi5KqIuGEQqTvVO/izLEgcgFMDNHEcL4eLyNbn9jbPoNCgWto+FvojkD
         IO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718888163; x=1719492963;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+GpvSy/VWf2OfE/fuIXNKg0MDOOI+VCks5t0p/pcdM=;
        b=Ku3UobK7UK1g60qRdvgPm9kJhtxGC9rw5Gl//p97JYo1KUohHU3xnKv9R/0+kdpCa/
         hT16X+FywRvq4xU98tTXySzuavBMCpG0yoXp5Oy3smh5yrjMr86vvYOZVpUy4vujIAV9
         Prt7wCP9hx2UXu9roIv5y3zdlvqDBqt+vVABk1ztlNGfh+OTMO2q7l4WD9Z6ET69KGN4
         HNU++lMqr5VCBiJKoDP2615oz3a1zqhY10IwM+gJ2XN/mpLzlEHTCdOOuyBevFcWqn6w
         Fvfk4MtYvxADyyA4v0LrZex1nDBznGZVkPD5TnlXg6qj7xWfbaZstI5IsHSJYDxCL4hR
         iwCg==
X-Gm-Message-State: AOJu0YxKmJ4xJE6D/Roi7f3gwAFUThh4E9NuSvY3NNXsAEqHJK9anZwb
	dwFUCST5wtD7AaZMIBDIqt6JCYPaei8gsa4IyUZpPXV3OeZ1oxg7ysqrExwm4RI=
X-Google-Smtp-Source: AGHT+IGaFjmmqS8/vXfhaKJBvkqfuC0AIKhlPKIXJ/sieoz+3d1tNx2iS4ZjGF0ndyA+Z+pRDmp3zQ==
X-Received: by 2002:a05:6a20:3c9e:b0:1af:aeb7:7a10 with SMTP id adf61e73a8af0-1bcbb586da9mr5418200637.1.1718888162785;
        Thu, 20 Jun 2024 05:56:02 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb8eeb4sm12207576b3a.205.2024.06.20.05.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 05:56:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org
In-Reply-To: <20240619154623.450048-1-hch@lst.de>
References: <20240619154623.450048-1-hch@lst.de>
Subject: Re: misc queue_limits fixups
Message-Id: <171888816188.139187.12750497286159297974.b4-ty@kernel.dk>
Date: Thu, 20 Jun 2024 06:56:01 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Wed, 19 Jun 2024 17:45:32 +0200, Christoph Hellwig wrote:
> this series is a mix of a few fixups for the last round of queue_limits
> fixed that I had prepared for a rev of the queue limits features series,
> and a bunch of imcremental conversions that I didn't want to bloat that
> series with.
> 
> Diffstat:
>  Documentation/block/writeback_cache_control.rst |    6 ++--
>  block/blk-settings.c                            |   34 +++++++-----------------
>  block/blk-sysfs.c                               |    6 ++--
>  drivers/md/bcache/super.c                       |    4 +-
>  drivers/md/dm-cache-target.c                    |    1
>  drivers/md/dm-clone-target.c                    |    1
>  drivers/md/dm-table.c                           |    1
>  drivers/md/raid5.c                              |    2 -
>  include/linux/blkdev.h                          |   25 +++++++----------
>  9 files changed, 29 insertions(+), 51 deletions(-)
> 
> [...]

Applied, thanks!

[1/6] block: remove the unused blk_bounce enum
      commit: f6860b6069b92559f5cdb65f48e2d82051eaebca
[2/6] block: fix spelling and grammar for in writeback_cache_control.rst
      commit: 4e54ea72edd68d074be2403f3efc67ff0541e298
[3/6] block: renumber and rename the cache disabled flag
      commit: bae1c74316b86c67c95658c3a0cd312cec9aad77
[4/6] block: move the misaligned flag into the features field
      commit: 5543217be468268dfedf504f4969771b9a377353
[5/6] block: remove the discard_alignment flag
      commit: 4cac3d3a712b5c76d462b29b73b9e58c0b6d9946
[6/6] block: move the raid_partial_stripes_expensive flag into the features field
      commit: 7d4dec525f5fd555037486af4d02dd3682655ba1

Best regards,
-- 
Jens Axboe




