Return-Path: <linux-block+bounces-1604-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46841824BB7
	for <lists+linux-block@lfdr.de>; Fri,  5 Jan 2024 00:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88AC287060
	for <lists+linux-block@lfdr.de>; Thu,  4 Jan 2024 23:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42242D633;
	Thu,  4 Jan 2024 23:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JdEeKHis"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1889E2D61E
	for <linux-block@vger.kernel.org>; Thu,  4 Jan 2024 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d410fce119so1879135ad.1
        for <linux-block@vger.kernel.org>; Thu, 04 Jan 2024 15:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704409857; x=1705014657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRATUcam2DsKzgw19J8wJ+c2TYQe0YbaTJEl3/WnLC0=;
        b=JdEeKHis3xk2cQIIagub5j2RUebBdCyaF2V8zWoeYIZwzbpWGD83SFa27b9MPKbyDb
         CA8rGjhc1KJkoG+h3cQkyyJ1aRvyR1TKfgJ33ivbs0Le1sTfOxJpjvpbehokFEB6lv65
         gRatr80IVSslehGYSdj/n/VEVmn0z4Ar+F0H0QT8gAVZ5kXgeU4Mnx1yhJCLvLAlAcwi
         uuKQRhbRHDEir2xfgfkmRJ6QKQ94YblE9qblFYggn7uB5eDeXOIcWjoAOQb/xO8QNazq
         DyHHjZR444wx6dv2/KOnRIXX7rsLi5EAfvotBkAws0VgdpX6V4kgQEzsu/QQ43jmkJJ+
         cW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704409857; x=1705014657;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRATUcam2DsKzgw19J8wJ+c2TYQe0YbaTJEl3/WnLC0=;
        b=asl3N+r0B9lsGL/k7D3oQlF1D1uF+oDaa7f9ej4BbEy0QA3hhrLTN4/i26bK85SfKf
         +7R1nqz+Ce8CqwQCRnFUK0i4qULCdWdyP+dxMbRSY6BTdTN8tDy9t+0yN4aCY0O4Xuch
         4qBj2x+RK6ceaUPEnNWVAaKakyfSraMpyFTzGx2eqJ6I/B3V6cSyMDQAX1o9+iu/ga1g
         XvmON0C+NkS9K7jasGWmmSdmUrW0CoMxmhSlDCmqqhu62rssfp0ni0UFWojrDipvwS/o
         OPJCnhyofaoB6Up8pjuRWVYkA319elDzTOhGlUClbIqhbrzQZ0OgCVC6c4EQnx7xSPYh
         jc2w==
X-Gm-Message-State: AOJu0Yz+IF0pX5urUlBBABt4wawJBKKDvWiYdoze8yZ//3r705BWTXsm
	r36/Gpr1yxyssioU0q2c9ls9WIzAgz0G+r8CO350WLILWX3UTA==
X-Google-Smtp-Source: AGHT+IGorl9bAvLp72x4XJJpPTrI40bt9+r0/TDSYg4iITJ+Fvwng5Di1+1+UdUTZ+I8+TPzWx2DvQ==
X-Received: by 2002:a05:6a20:1048:b0:196:d709:4cfc with SMTP id gt8-20020a056a20104800b00196d7094cfcmr1974527pzc.6.1704409857342;
        Thu, 04 Jan 2024 15:10:57 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id lo2-20020a056a003d0200b006d9bdc0f765sm179484pfb.53.2024.01.04.15.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 15:10:56 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: jgross@suse.com, YouHong Li <liyouhong@kylinos.cn>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 k2ci <kernel-bot@kylinos.cn>
In-Reply-To: <20231226095701.172080-1-liyouhong@kylinos.cn>
References: <20231226095701.172080-1-liyouhong@kylinos.cn>
Subject: Re: [PATCH v2] drivers/block/xen-blkback/common.h: Fix spelling
 typo in comment
Message-Id: <170440985586.724469.11218716472152091154.b4-ty@kernel.dk>
Date: Thu, 04 Jan 2024 16:10:55 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-f0463


On Tue, 26 Dec 2023 17:57:01 +0800, YouHong Li wrote:
> Fix spelling typo in comment.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: liyouhong <liyouhong@kylinos.cn>
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Link: https://lore.kernel.org/r/20231226095701.172080-1-liyouhong@kylinos.cn
> 
> [...]

Applied, thanks!

[1/1] drivers/block/xen-blkback/common.h: Fix spelling typo in comment
      commit: e3d7581cb13b3f2a415e5cd92769b7f4b7d14ed0

Best regards,
-- 
Jens Axboe




