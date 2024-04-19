Return-Path: <linux-block+bounces-6393-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE748AB062
	for <lists+linux-block@lfdr.de>; Fri, 19 Apr 2024 16:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DFA281377
	for <lists+linux-block@lfdr.de>; Fri, 19 Apr 2024 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CADD12FB34;
	Fri, 19 Apr 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OgRlcTBz"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A8C12D759
	for <linux-block@vger.kernel.org>; Fri, 19 Apr 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535684; cv=none; b=pAqRMWC/E4xf3LXS/F85Simosl0R4m58V/WqA1MLzs8N8myrMNpw4yN5Pnu3TOIl8tw4SoYUlV2fgJIa90AP0RrOpo/vW9yuKKzTmydj48FtXxetrysLD33qs8/kbLkQFce6axJkKnTSHYYkatfTz7ycC4t6y1qkx9WU47qhto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535684; c=relaxed/simple;
	bh=xyu03HDQ5HqUivNlWzij0bKqi/bLZ6SmDe0+HX8RqMo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d98yrPU8nRZJr4T5+Af+Gk6cl4DL0hVDmZsWkAxD4FuFp5wZhEt7W9MXV+FnoevjmupVR/WVO4UZyNyfuChVWYL6hem81jZ0dYDjCTpbiEMOPfPrkeuTPktDKPNqEC52NRRAdNpl4RhsfyurYlXA3AG8kDw77eDGli+dmy9LjTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OgRlcTBz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e825c89532so2050925ad.2
        for <linux-block@vger.kernel.org>; Fri, 19 Apr 2024 07:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713535681; x=1714140481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSDKTiByg68gLYMeDYGEiSgE2cD3L++faVxv3kdVgt4=;
        b=OgRlcTBzvFxJSkSv9T9WJe4Rjc1Bp014KuSuZFS5tKt6EaZdRrb7uIQrnFCKAqjDRr
         Y6XcLiqT4hRCfnPP3hMo2vEzylfikAFg75VHOhhIlJ+QNIkYIuPwNV3gslciIPwPLFiz
         lXacW/5XE/mcJZgP9XXWwl2nGxcvYzCw7YqR74xsPjnkNtDxO3LHmDpPAYNBJtK9w6fJ
         vXjnKP2yLMpV9lGk1M9VolZNNi0A1TLrwyvrHTK0zPCjzjwR2f6Hm9kUF9U35yLkhV4u
         nkhiDQ9RSAYvtYrFw5PylVndPGK/rP5SmwB66IN2zAnjx3M/MgOCsdeOgIVzaCGD1d4t
         UV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535681; x=1714140481;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSDKTiByg68gLYMeDYGEiSgE2cD3L++faVxv3kdVgt4=;
        b=CpohhMcvmfy6bG+c7i6xTPY7fIHMK2yBaWtzeuuzfRgt1hqWMUWNXUJECr0G2ABcHT
         qwfL+s8XVHYQQqbX2MRMaZXK3J/g94kJvpQTCwKEjzivlEJs1Dl4JN1t8+wbjI3Jgk6/
         DdN/fPij3F6R+KVRpLFzCZ70W5lxOwVzPJAXhn4qAzsrwzWFmLPkLbks1rXzFD5hNAVU
         tVIYC+d1Sa0Y9EvTaerFUAIdKWbT8UXFwBT6+eE8x5JEpZ+Fn7OrOlrd0wpNH5VMoY9t
         +9vxitDlrCpJPb+zHjjiCYYz751M0myw5FSdEbABLKfdstkl0oSfBi9P3pg7Yg5ars1Y
         oCJg==
X-Forwarded-Encrypted: i=1; AJvYcCUrwTqq+oInklubhYsn/JA3MuaN/lLG2HNuECbKGdRBug1j8fpMeYPIgQBpIqLvpItx3OhhtDm45JgU5c75X9t6YR92B1ND6Imdu+I=
X-Gm-Message-State: AOJu0YwGagygrXMGnCgFmx7ZDq4yackVsutmgl9ov059UO3Iyg82nWAJ
	+3XVDlEB+4QfED6dd4cbnAhpsalXyNrlMUfLnYsgYl9D0rZCUTHrj8/Uqmmcez0=
X-Google-Smtp-Source: AGHT+IE9KKSYVwG72VSDmoU2t2kLvppf7ICd7Pg14moTxUpcllBJ1abOnSOdZ8iLgrSUhwkRCTMeHw==
X-Received: by 2002:a17:902:ec84:b0:1e8:4063:6ded with SMTP id x4-20020a170902ec8400b001e840636dedmr2404122plg.1.1713535681289;
        Fri, 19 Apr 2024 07:08:01 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id jj1-20020a170903048100b001e2526a5cc3sm3365406plb.307.2024.04.19.07.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 07:08:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, linan666@huaweicloud.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 houtao1@huawei.com, yangerkun@huawei.com
In-Reply-To: <20240419093257.3004211-1-linan666@huaweicloud.com>
References: <20240419093257.3004211-1-linan666@huaweicloud.com>
Subject: Re: [PATCH v2] blk-iocost: do not WARNING if iocg has already
 offlined
Message-Id: <171353567968.448662.8909505678465861389.b4-ty@kernel.dk>
Date: Fri, 19 Apr 2024 08:07:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Fri, 19 Apr 2024 17:32:57 +0800, linan666@huaweicloud.com wrote:
> In iocg_pay_debt(), warn is triggered if 'active_list' is empty, which
> is intended to confirm iocg is avitve when it has debt. However, warn
> can be triggered during a blkcg or disk is being removed, as
> iocg_waitq_timer_fn() is awakened at that time.
> 
>   WARNING: CPU: 0 PID: 2344971 at block/blk-iocost.c:1402 iocg_pay_debt+0x14c/0x190
>   Call trace:
>   iocg_pay_debt+0x14c/0x190
>   iocg_kick_waitq+0x438/0x4c0
>   iocg_waitq_timer_fn+0xd8/0x130
>   __run_hrtimer+0x144/0x45c
>   __hrtimer_run_queues+0x16c/0x244
>   hrtimer_interrupt+0x2cc/0x7b0
> ps: This issue was got in linux 5.10, but it also exists in the mainline.
> 
> [...]

Applied, thanks!

[1/1] blk-iocost: do not WARNING if iocg has already offlined
      commit: 01bc4fda9ea0a6b52f12326486f07a4910666cf6

Best regards,
-- 
Jens Axboe




