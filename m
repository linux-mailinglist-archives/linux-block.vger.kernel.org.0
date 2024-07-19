Return-Path: <linux-block+bounces-10130-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C77E937A13
	for <lists+linux-block@lfdr.de>; Fri, 19 Jul 2024 17:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08565281418
	for <lists+linux-block@lfdr.de>; Fri, 19 Jul 2024 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE45E145A09;
	Fri, 19 Jul 2024 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hGRntHaX"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F4A1E4AD
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403695; cv=none; b=BZK69KkQrn7SezFElqWM3IBnp7IqK+hM1PmQuUlAVpM3YjsmNt4VwUK9NQALbIu2YlaO164nCiOiJ3SszdwL3YqoZOy3MsmqcSNZ+JFXCW5P4/gmWz2EuMgj6ggPV4QspaEAG3j7r98Y/YECAfTFBP4y7vYrYTYgVUrQyjORLqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403695; c=relaxed/simple;
	bh=QQoq6N067yrt/y8qeQyfNuF0R8Ry1rABV4f6knZiZqQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S/LPxMOohgX0qRv5zzJRaNLfzAlUuHm3bAxNIe+2+zm7mVI7LW+rJtebvNPa2sUKejPHLYU3mWo5SBSTEW+1FaNHVKIora9TJ8CSMlNDULnX9LrAABIrgrEG8gxl76j+dUsrtbYFKDh/dTrpNA1yqvPtJ6jBvsHg96eLKLs7Brw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hGRntHaX; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70afb93cfe9so51744b3a.0
        for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721403694; x=1722008494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZWKVNt73AG90ek9S3k9hOscFljMGUkenJRmULy2xfM=;
        b=hGRntHaXYutPqYCtAEtV0MjB+bYk2bSQROLetr+74/u0D+L6GqYahFe8vHA3J/1m7U
         G+9uxy4s2qJ5wCDcyCPY2aTj3UahlyRWO1CuvwX7HVqssL+pw/bJpoLEoE3SYxmpNNrU
         vJnsQm7Ego3P7Daw+nd0aIeaI9LMVfL7LXAzruv1Lsg18GO3DR9t/VIKOzf2SnlPX8iZ
         wdW1nidNNNT2RfjdjavxywUWVd/tUWWu4vdyO8gQMz4I7upBQyg9DrNapWoaiGBjn0HA
         YIsWlfWGu2uE8D621g2VqiuHIU2/4HY2R3k3KmkiQlEyi5l3X3dbuY6xxOJg2DyHjBNG
         f3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721403694; x=1722008494;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZWKVNt73AG90ek9S3k9hOscFljMGUkenJRmULy2xfM=;
        b=d58YhJNIQeBF+H2Ai24Wg1FAyzl1d91jRTy5YWdLyEMEJp3J6xXhIR05UC6fTLeik8
         wng3vLcuWSklQgJVrqyY84BVI/ATZnpTC4c3irX0UvDUU/rMHC77heamiPtxpKOchSrt
         s7WEdXjUR80CZ7tczvxd322jxW5wtQ44hgm+118JX6vum3LmiwEHYUD4UPyJwobCyDhN
         8Hc0Op3VoYZQhgxrNONjiXoPOz7S/4zmPRGhCYVGqFvVD3JGuPqF1Zvm/1WnqngY0mMj
         QtyM4+sYwMTe1HAwdF01L+3aQmIrkeihLGCvy1ClteShz7lTDJ5o1knly+efoLK1Ckl8
         hWgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg5B3iOXmLEDibANAfZA1jD8Tc75sQwHuRchdOITFbcB4cglztlaiNr9Ih4yzun++LnODG5aQ/kkw8TdF5rgbuVcFv7G6wkSJNqAw=
X-Gm-Message-State: AOJu0Yzs2yGobrlbpc6zLwCRmyALfybmXJ88G2EHFWPEgjgSmY0QSHE8
	JePm/8eevh6gxVYj0j7V4T10++xBCWy9KaHam/5eD1R1noXWZg4RZ6Kd2Kb0dN4=
X-Google-Smtp-Source: AGHT+IGCPJf4uACUKwnddKZTp8XxBr73j8zaLpJGjhGEWSOurNMxyXPvSNi6Rqi6ya+v0VPj3gPgvw==
X-Received: by 2002:a05:6a00:391b:b0:704:173c:5111 with SMTP id d2e1a72fcca58-70d08635b76mr242254b3a.3.1721403693595;
        Fri, 19 Jul 2024 08:41:33 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff49164bsm1380338b3a.18.2024.07.19.08.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 08:41:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, lizefan.x@bytedance.com, 
 hannes@cmpxchg.org, mkoutny@suse.com, Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240716133058.3491350-1-xiujianfeng@huawei.com>
References: <20240716133058.3491350-1-xiujianfeng@huawei.com>
Subject: Re: [PATCH v2 -next] blk-cgroup: move congestion_count to struct
 blkcg
Message-Id: <172140369204.12552.9366107896766797330.b4-ty@kernel.dk>
Date: Fri, 19 Jul 2024 09:41:32 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Tue, 16 Jul 2024 13:30:58 +0000, Xiu Jianfeng wrote:
> The congestion_count was introduced into the struct cgroup by
> commit d09d8df3a294 ("blkcg: add generic throttling mechanism"),
> but since it is closely related to the blkio subsys, it is not
> appropriate to put it in the struct cgroup, so let's move it to
> struct blkcg. There should be no functional changes because blkcg
> is per cgroup.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: move congestion_count to struct blkcg
      commit: 89ed6c9ac69ec398ccb648f5f675b43e8ca679ca

Best regards,
-- 
Jens Axboe




