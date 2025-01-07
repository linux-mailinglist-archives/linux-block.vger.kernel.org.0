Return-Path: <linux-block+bounces-16000-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F848A038E2
	for <lists+linux-block@lfdr.de>; Tue,  7 Jan 2025 08:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8C53A54AA
	for <lists+linux-block@lfdr.de>; Tue,  7 Jan 2025 07:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2681DE8BB;
	Tue,  7 Jan 2025 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="PWBJOlhH"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C11662F1
	for <linux-block@vger.kernel.org>; Tue,  7 Jan 2025 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736235501; cv=none; b=h9PohSFwb7o3RCvkxzVmW3JTnlzjErVbbfBSeKzDC5Y0xITwY1+m2LWVihXla1Tn4U0pUTSugA25HvqxTpKds7M/U8aqYvcoqoLmk6kti6OGxuwqYi691KOX+ys2ZIMRF1JA+sJLOFqDJxC/ASpFge6gSXTZnJA4ETZNtcWm6lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736235501; c=relaxed/simple;
	bh=MeHjwlmHyRYJwqF55zIqyHrTafSLhdOwEGgkfNw2/cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJOUt8QImfgRPoMwVjEfpCz+fzTKiFs2AedB8LdUEzSzEO/pxQIroJSv9M7eGQCjdpbJVhlD+cyZ4QVIX5lfVv4n65e7/9rZb5XJnVP26t6KIYuGpKAxZa5+83T0aJkHesYQqT+7Wx3LVnKQT3NP7lCnox6emMpCVHWHEKBZy6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=PWBJOlhH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3cd821c60so3505441a12.3
        for <linux-block@vger.kernel.org>; Mon, 06 Jan 2025 23:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1736235495; x=1736840295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+K5NTtkkHH0F4j1K3TcqwFsH8+ooT4rladtnvSGOOpM=;
        b=PWBJOlhHnrza5YuqS+/eAUU/E7AJYPJNX5NTjD4Jq2xbCGX9xjRHThB2uleP/MMWRb
         /uDWgRg+DmWDNfxN7jScC6fQ4X962sGfiWe8CwAQGm1i/4l4U8C7xyuKTCtPzbbo2Flg
         Ntg7KSCogu7U6uz8wOOHuKcYxTTR5ZShdc4f2yKUZYS1awUmzoLEb9cGOUP/749qxlPf
         WMfF42Q/nraqjamWDz/Ao9kYAwUFOX98dRqPTzyoDnRuvzRyQc1AfpLbdwnrG7/qAEPA
         lJkMTsjcS7f71L+OuyUEr1dmK/9b2wsByl18SqlIesLK5HXDw0Dm52A75CJbWNiO6Cwu
         +Smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736235495; x=1736840295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+K5NTtkkHH0F4j1K3TcqwFsH8+ooT4rladtnvSGOOpM=;
        b=Z3pNEfQxIafTuYEc+Q79WBM1h+J6RhRLvaQkeVyPifpW4yY8qOBABQOlcrMnbUcagj
         pMeRWuy2Tl03iYPaFVIxufZq1sWMCoTS+84pRTTxHHEaKAZlwVZOBszqxWYgoKy91bCU
         Md0RmxT77CAgKWaoqvo26uEX7UFRG9/9P/yIguB6GTI/VbUJ+giAyQ8PQoiq8Y7R77f/
         ucBghrZ3VwHflmF0+JKdPEymrxAoK+u0BsyfyK+9c0kDhSAFgKwTw96st6sd31GIuByn
         TUMoFAx8RjP/53QeMAcLWJXoArtEX3C58sIbMpr9X/iMkZsSHY8joRFcwQulN3BxHqAW
         2EKg==
X-Gm-Message-State: AOJu0YyNjgEjeFQ9uDIk8RGjROXD1K2wA6U577cnF2r59JZVupAGHK3w
	GI8T2dVn34qd/waJeT1+uEXd3hK74XJjSSWwTVd/kvYNEVBOW4zQKXQQwO7rNmptalD5hQ2c/ro
	zmXPYTCbJz1z7R5tw5foW/bWlVRl8IULDwyzOBw==
X-Gm-Gg: ASbGncu23TeTJdBJ7xDPA81ArlEy0ut9zOFxO2pez8/tk+SVhPcO3RkgYWlskyhkQd4
	06QBC0EcrqCMO8hLoxuwMvWOrKJAu+V1Az7ZbickVeBHxECEpaUh2k/KQfiZYle53Yxx/zcQ=
X-Google-Smtp-Source: AGHT+IH0yHgQYI52xxhkAl+Pv+y2nSjW7oz6dhILeey3Yd3VP16wJofS2RwX7ROj0q0KGDxt7BeW9iSgKHibBj84w+w=
X-Received: by 2002:a05:6402:5187:b0:5d0:bf79:e925 with SMTP id
 4fb4d7f45d1cf-5d81de07d1dmr19780495a12.6.1736235495597; Mon, 06 Jan 2025
 23:38:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107060810.91111-1-lizhijian@fujitsu.com> <20250107060810.91111-2-lizhijian@fujitsu.com>
In-Reply-To: <20250107060810.91111-2-lizhijian@fujitsu.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Tue, 7 Jan 2025 08:38:05 +0100
Message-ID: <CAMGffEnkqZSEts7Cu9pCUmi9uYtP-vgjQ4qPYkDdkZpG=A_HNw@mail.gmail.com>
Subject: Re: [PATCH blktests v4 2/2] tests/rnbd: Implement RNBD regression test
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com, 
	linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 7:08=E2=80=AFAM Li Zhijian <lizhijian@fujitsu.com> w=
rote:
>
> This test case has been in my possession for quite some time.
> I am upstreaming it now because it has once again detected a regression i=
n
> a recent kernel release[0].
>
> It's just stupid to connect and disconnect RNBD on localhost and expect
> no dmesg exceptions, with some attempts actually succeeding.
>
> rnbd/002 (Start Stop RNBD repeatedly)                        [passed]
>     runtime                   13.252s  ...  13.099s
>     start/stop success ratio  100/100  ...  100/100
>
> [0] https://lore.kernel.org/linux-rdma/20241223025700.292536-1-lizhijian@=
fujitsu.com/
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Thx for the patch, LGTM
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> ---
> V4:
>   - Fix a typo and update the passed condition # Shinichiro Kawasaki <shi=
nichiro.kawasaki@wdc.com>
>   - rename test_start_stop() to test_start_stop_repeatedly()
>
> V3:
>   - Always stop the rnbd regardless of the result of start
>
> V2:
>   - address comments from Shinichiro
>   - minor fixes
>
> Copy to the RDMA/rtrs guys:
>
> Cc: Jack Wang <jinpu.wang@ionos.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
> ---
>  tests/rnbd/002     | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/rnbd/002.out |  2 ++
>  2 files changed, 49 insertions(+)
>  create mode 100755 tests/rnbd/002
>  create mode 100644 tests/rnbd/002.out
>
> diff --git a/tests/rnbd/002 b/tests/rnbd/002
> new file mode 100755
> index 000000000000..7d7da9401974
> --- /dev/null
> +++ b/tests/rnbd/002
> @@ -0,0 +1,47 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
> +#
> +# Commit 667db86bcbe8 ("RDMA/rtrs: Register ib event handler") introduce=
d a
> +# new element .deinit but never used it at all that lead to a
> +# 'list_add corruption' kernel warning.
> +#
> +# This test is intended to check whether the current kernel is affected.
> +# The following patch resolves this issue.
> +#  RDMA/rtrs: Add missing deinit() call
> +#
> +. tests/rnbd/rc
> +
> +DESCRIPTION=3D"Start Stop RNBD repeatedly"
> +CHECK_DMESG=3D1
> +QUICK=3D1
> +
> +requires() {
> +       _have_rnbd
> +       _have_loop
> +}
> +
> +test_start_stop_repeatedly()
> +{
> +       _setup_rnbd || return
> +
> +       local loop_dev i j=3D0
> +       loop_dev=3D"$(losetup -f)"
> +
> +       for ((i=3D0;i<100;i++))
> +       do
> +               _start_rnbd_client "${loop_dev}" &>/dev/null
> +               # Always stop it so that the next start has change to wor=
k
> +               _stop_rnbd_client &>/dev/null && ((j++))
> +       done
> +
> +       TEST_RUN["start/stop success ratio"]=3D"${j}/${i}"
> +
> +       _cleanup_rnbd
> +}
> +
> +test() {
> +       echo "Running ${TEST_NAME}"
> +       test_start_stop_repeatedly
> +       echo "Test complete"
> +}
> diff --git a/tests/rnbd/002.out b/tests/rnbd/002.out
> new file mode 100644
> index 000000000000..2f055b8c82f9
> --- /dev/null
> +++ b/tests/rnbd/002.out
> @@ -0,0 +1,2 @@
> +Running rnbd/002
> +Test complete
> --
> 2.47.0
>

