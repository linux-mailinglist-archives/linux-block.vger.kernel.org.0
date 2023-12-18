Return-Path: <linux-block+bounces-1232-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F158176F2
	for <lists+linux-block@lfdr.de>; Mon, 18 Dec 2023 17:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8477D1F23F44
	for <lists+linux-block@lfdr.de>; Mon, 18 Dec 2023 16:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DE242387;
	Mon, 18 Dec 2023 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2ULm2DH"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA193D54C;
	Mon, 18 Dec 2023 16:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F595C433C9;
	Mon, 18 Dec 2023 16:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702915503;
	bh=YKnvFnU90MLtOfW7ZUGVnLDGtzT+XNtezHnJjjlx3W4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W2ULm2DHLvbKgwufoXz2eG7C0DCc2cZA5ADG1JYOZJkarrfvBCa7mIRPhjQhyfuFf
	 GK+MUvYbyKACtve62uXxQoEDx6eAEzWGn1fsPbfjKQKx7F0cPvmzZydXNgg6P40sVg
	 8j2jSJvnH912ldoUXzQMIiG+CNv1176HUTg8b0mTDlEuGGBnqOuo9MRUhkNMHAcYLF
	 2xYJDcmpt9borp/yNzZJ5imcFBWNERprz91h0Kc5ac9+JllMuSCAzM0sy8H87t8Y4n
	 rzPa4UmgFyRcWXNqLiVt2T9/1TlJiBqiZF63bO6R5rpdp/UInbcS5eCjVjt3ebE2G3
	 28hySGJKpa+rA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cc3f5e7451so39120811fa.2;
        Mon, 18 Dec 2023 08:05:03 -0800 (PST)
X-Gm-Message-State: AOJu0YxnQZR3Bki2E3Xpj3IvMOXkkmO7iP2dYfHs0QlLSb7tjweVo7+G
	DcErfH9v8d3Sjth8b2yaW1aSqJijT4W1DDh0ZX8=
X-Google-Smtp-Source: AGHT+IF/1c2sVKIWhklkyKwxs+e/TlmjZyKZ44P+rlu8hMftsh8338VA9tYvJ1f4yipZyHIykWTNfiJ5aJO7SaPFQt4=
X-Received: by 2002:a05:651c:506:b0:2cb:3ece:1235 with SMTP id
 o6-20020a05651c050600b002cb3ece1235mr6781953ljp.38.1702915501728; Mon, 18 Dec
 2023 08:05:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215013931.3329455-1-linan666@huaweicloud.com>
 <20231215013931.3329455-2-linan666@huaweicloud.com> <CAPhsuW6VTvXy3L9CUhTrSC3+_-_n9FDVrtdzQ7SWWkukoQg13Q@mail.gmail.com>
 <be8d9147-4f7f-2fab-da2a-bb4cde46fd12@huaweicloud.com> <CAPhsuW6kv7FRB_1NoheiDqvmLmongiJ-ty9mYRNvFw3yecE_Ug@mail.gmail.com>
 <baf95bd0-0378-9b3a-9ab9-473baa35ebbc@huaweicloud.com>
In-Reply-To: <baf95bd0-0378-9b3a-9ab9-473baa35ebbc@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Mon, 18 Dec 2023 08:04:50 -0800
X-Gmail-Original-Message-ID: <CAPhsuW61yzkH5Tp0ku37DBjnQzT81yJUx0F4bag4xdq1rX5gsA@mail.gmail.com>
Message-ID: <CAPhsuW61yzkH5Tp0ku37DBjnQzT81yJUx0F4bag4xdq1rX5gsA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] md: Fix overflow in is_mddev_idle
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: linan666@huaweicloud.com, axboe@kernel.dk, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 5:39=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
[...]
> >
> > We only use  this for idle or not check, the behavior is OK (I think).
> > However, this logic is error prone.
> >
> > On 64-bit systems, there is a 4-byte hole behind sync_io. I think we ca=
n
> > just use it for atomic64_t so that we don't have to worry about overflo=
w.
>
> I'm not sure about this, because other than this ubsan warning, this
> overflow doesn't have any impact on functionality to me.

Fixing warnings for zero or low cost is always a good idea. It helps boost
the signal when UBSAN (and other debug features) detects real issues.

> If we care about this 'hole', there are lots of holes in gendisk, and
> can be avoiled, for example, moving 'sync_io' near  to 'node_id'.

The point was not "let's fill the hole", but "we can use atomic64_t
without extra memory cost". In general, I don't think we care too
much about holes in "struct gendisk".

Does this make sense?

Thanks,
Song

