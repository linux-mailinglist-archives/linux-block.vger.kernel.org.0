Return-Path: <linux-block+bounces-7501-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E5D8C978D
	for <lists+linux-block@lfdr.de>; Mon, 20 May 2024 02:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5AC1C208E1
	for <lists+linux-block@lfdr.de>; Mon, 20 May 2024 00:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6A44A33;
	Mon, 20 May 2024 00:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSiBRSeD"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCD71FA4
	for <linux-block@vger.kernel.org>; Mon, 20 May 2024 00:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716165587; cv=none; b=iXrpYyIteSeooJ0Ey7yn//6we7LEqyFHaUCW1CQNszaTVFDxFwjohRWTmkUef0pCfcfA3mFkl4pxv7pJgW3IipsWIVOlrHdmSLto28q0c0ovP2p5AlOpfsdBgIe8dOxLKXmQ0e9bzA+hzCPoq2HI7PAggYrDoQvbYX8JpxJHw+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716165587; c=relaxed/simple;
	bh=ejf7HFaZkDkUwERVl1PQhgTcdeTBGjO/iZFbnibwH6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiVXGhcKDnauyfrnTew4/KiUhN212F/sMtBUTl3pe86k4aaVbYlEsfEkNEliAaTQ90MtFWmXu9xO1iJX869BjnH59DkIDj4bEOmYYLYg+nY3JMYC0p1KmYOFgjRSG096tiSL9+OQAnrXk1hF0HEIAGzWovpcDBn2cduBDDNE7JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSiBRSeD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716165583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xuZnRGG5Sp6tD2E+r+C7bfAJ0EQeGCo7wVVmP46oe18=;
	b=bSiBRSeDK4ps0rO9Njkzx5/bL2lUJYfj2pr284dCukDEHHt3an24ipyVEWuqU5LS1gYtfi
	guAfLG341Ckoo31zENkGi/bZBXubWETht/6fa7s2096IHSfA2fnzlxavv12OJZ26G6IB/o
	9narMx1zZkyj8RTm+z34uOppjhwwpV0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-BLs946W-O_2-1VTcRovgZA-1; Sun, 19 May 2024 20:39:42 -0400
X-MC-Unique: BLs946W-O_2-1VTcRovgZA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2bd8417d3c3so163697a91.2
        for <linux-block@vger.kernel.org>; Sun, 19 May 2024 17:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716165581; x=1716770381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuZnRGG5Sp6tD2E+r+C7bfAJ0EQeGCo7wVVmP46oe18=;
        b=ZXjhTaah0QMf+CQmDcUoDlEx4F+DwiPFOlABJbjVTKtdqMM6jA/AbVJ9sh6xniabZZ
         Xo0vgJSkAr/C+zwsChSCchrUOS+h1omtFW9gQzmWjrvQD+8HwWlfFVyRa1DJVs5VLn4P
         pF7Uc+T+EnjH8wKNhm5keoa2CXmotvSN5GEmBdAJPYnegdLj3mPdng8FSC3xDyfrZIrU
         udG0tefyxZsRpE4UoegcxSLO0+9Z1vLOF1/IS4/Zy8IKZjnuYHjYmOWcSLMq9L+sC2xW
         OxF+xq7X37N8rB3nkL0sYgFDkLwuyGhppf6mdjnFUKdNPH8IXTfbC1RPIxQjjU6m8Y1b
         YW+A==
X-Forwarded-Encrypted: i=1; AJvYcCVT6XoDG3QRMFUU337GVNXcWrPWspdSZ5oiu461ARsk2uCSN9DcNgPW+CiSVpAibeg2Gaes8F+G4b6k+81Zh1oNyWACfh4Pd2M72LE=
X-Gm-Message-State: AOJu0YzDu7++gCTs6MIWPJu6Nkj/3pz42NX9FnsNDwr0vw7MY35A//HC
	4Cm5a7A5zsF7OHbC3A3ilpOe/qIv+nh3v3weW144BVvD3417hVvFtF6s7BacSp3EdjtcpJAMEk1
	qqwPHBS5r6uzGdRQ50jzLlptoWeVYRUySulvtS/8nhR9cciodShEiTD81FLVWtq9xAT7g6A+HxF
	aJarwwhw2DDDPH3iS5E5UA1pnjJFdm94//jag=
X-Received: by 2002:a17:90a:c505:b0:2b9:78b9:fefe with SMTP id 98e67ed59e1d1-2b978b9ff78mr12361719a91.47.1716165581147;
        Sun, 19 May 2024 17:39:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/0IGsNqjIubOi+g1gYxBv0DLHVy+j6qe52IWOdbh2Is5isyJkU2ekb41bxAPs53hqq78+B2KT8Kuej8b38TQ=
X-Received: by 2002:a17:90a:c505:b0:2b9:78b9:fefe with SMTP id
 98e67ed59e1d1-2b978b9ff78mr12361702a91.47.1716165580561; Sun, 19 May 2024
 17:39:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+Xsmzy2G9YuEatfMT6qv1M--YdOCQ0g7z7OVmcTbBxQAg@mail.gmail.com>
 <ZkXsOKV5d4T0Hyqu@fedora> <9b340157-dc0c-6e6a-3d92-f2c65b515461@huaweicloud.com>
 <CAGVVp+XtThX7=bZm441VxyVd-wv_ycdqMU=19a2pa4wUkbkJ3g@mail.gmail.com>
 <1b35a177-670a-4d2f-0b68-6eda769af37d@huaweicloud.com> <CAGVVp+WQVeV0PE12RvpojFTRB4rHXh6Lk01vLmdStw1W9zUACg@mail.gmail.com>
In-Reply-To: <CAGVVp+WQVeV0PE12RvpojFTRB4rHXh6Lk01vLmdStw1W9zUACg@mail.gmail.com>
From: Changhui Zhong <czhong@redhat.com>
Date: Mon, 20 May 2024 08:39:29 +0800
Message-ID: <CAGVVp+WGyPS5nOQYhWtgJyQnXwUb-+Hui14pXqxd+-ZUjWpTrA@mail.gmail.com>
Subject: Re: [bug report] INFO: task mdX_resync:42168 blocked for more than
 122 seconds
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Ming Lei <ming.lei@redhat.com>, Linux Block Devices <linux-block@vger.kernel.org>, 
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>, linux-raid@vger.kernel.org, 
	Xiao Ni <xni@redhat.com>, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2024 at 2:44=E2=80=AFPM Changhui Zhong <czhong@redhat.com> =
wrote:
>
> On Fri, May 17, 2024 at 10:49=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com=
> wrote:
> >
> >
> > Thanks for the test, this do look like a deadlock, beside
> > raise_barrier(), is there any other victim? I can't reporduce this,
> > and I have no clue yet. The possible next step might be bisect to
> > locate the blame commit first. Maybe related to dm-raid1.
> >
> > Thanks,
> > Kuai
> >
>
> Hi=EF=BC=8CYu Kuai
>
> I tried to do git bisect and got the following result, please help check=
=EF=BC=8C
>
> [czhong@vm linux-block]$ git bisect start
> [czhong@vm linux-block]$ git bisect bad
> [czhong@vm linux-block]$ git bisect good
> d0487577e6e0b640d71375a6ec2f9e8a2d3555f2
> Bisecting: 2652 revisions left to test after this (roughly 11 steps)
> [895621f1c81695da7660fe909173e9f98619e89c] bnxt_en: Don't support
> offline self test when RoCE driver is loaded
> [czhong@vm linux-block]$
> [czhong@vm linux-block]$ git bisect good
> Bisecting: 1219 revisions left to test after this (roughly 10 steps)
> [6c60000f0b9ae7da630a5715a9ba33042d87e7fd] Merge tag 'soc-dt-6.10' of
> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> [czhong@vm linux-block]$
> [czhong@vm linux-block]$ git bisect good
> Bisecting: 612 revisions left to test after this (roughly 9 steps)
> [87caef42200cd44f8b808ec2f8ac2257f3e0a8c1] Merge tag
> 'hardening-6.10-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
> [czhong@vm linux-block]$
> [czhong@vm linux-block]$ git bisect bad
> Bisecting: 303 revisions left to test after this (roughly 8 steps)
> [25c73642cc5baea5b91bbb9b1f5fcd93672bfa08] Merge tag
> 'keys-next-6.10-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd
> [czhong@vm linux-block]$ git bisect good
> Bisecting: 155 revisions left to test after this (roughly 7 steps)
> [f4e8d80292859809ea135e9f4c43bae47e4f58bc] Merge tag 'vfs-6.10.rw' of
> git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
> [czhong@vm linux-block]$
> [czhong@vm linux-block]$ git bisect good
> Bisecting: 77 revisions left to test after this (roughly 6 steps)
> [ac5f71a3d9d7eb540f6bf7e794eb4a3e4c3f11dd] io_uring/net: add provided
> buffer support for IORING_OP_SEND
> [czhong@vm linux-block]$ git bisect good
> Bisecting: 37 revisions left to test after this (roughly 5 steps)
> [0c9f4ac808b017a0013cee92a30de980550145d5] Merge tag
> 'for-6.10/block-20240511' of git://git.kernel.dk/linux
> [czhong@vm linux-block]$ git bisect bad
> Bisecting: 19 revisions left to test after this (roughly 4 steps)
> [a3166c51702bb00b8f8b84022090cbab8f37be1a] blk-throttle: delay
> initialization until configuration
> [czhong@vm linux-block]$
> [czhong@vm linux-block]$ git bisect bad
> Bisecting: 9 revisions left to test after this (roughly 3 steps)
> [e8b4869bc78da1a71f2a2ab476caf50c1dcfeed0] block: add a
> blk_alloc_discard_bio helper
> [czhong@vm linux-block]$ git bisect good
> Bisecting: 4 revisions left to test after this (roughly 2 steps)
> [3a861560ccb35f2a4f0a4b8207fa7c2a35fc7f31] bcache: fix variable length
> array abuse in btree_iter
> [czhong@vm linux-block]$ git bisect good
> Bisecting: 2 revisions left to test after this (roughly 1 step)
> [99dc422335d8b2bd4d105797241d3e715bae90e9] block: support to account
> io_ticks precisely
> [czhong@vm linux-block]$
> [czhong@vm linux-block]$ git bisect bad
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [060406c61c7cb4bbd82a02d179decca9c9bb3443] block: add plug while submitti=
ng IO
> [czhong@vm linux-block]$ git bisect bad
> 060406c61c7cb4bbd82a02d179decca9c9bb3443 is the first bad commit
> commit 060406c61c7cb4bbd82a02d179decca9c9bb3443
> Author: Yu Kuai <yukuai3@huawei.com>
> Date:   Thu May 9 20:38:25 2024 +0800
>
>     block: add plug while submitting IO
>
>     So that if caller didn't use plug, for example, __blkdev_direct_IO_si=
mple()
>     and __blkdev_direct_IO_async(), block layer can still benefit from ca=
ching
>     nsec time in the plug.
>
>     Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>     Link: https://lore.kernel.org/r/20240509123825.3225207-1-yukuai1@huaw=
eicloud.com
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>
>  block/blk-core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> [czhong@vm linux-block]$
>
> Thanks=EF=BC=8C
> Changhui

update with  git bisect log=EF=BC=9A
[czhong@vm linux-block]$ git bisect log
git bisect start
# bad: [59ef8180748269837975c9656b586daa16bb9def] Merge branch
'block-6.10' into for-next
git bisect bad 59ef8180748269837975c9656b586daa16bb9def
# good: [d0487577e6e0b640d71375a6ec2f9e8a2d3555f2] Merge tag
'md-6.10-20240502' of
https://git.kernel.org/pub/scm/linux/kernel/git/song/md into
for-6.10/block
git bisect good d0487577e6e0b640d71375a6ec2f9e8a2d3555f2
# good: [895621f1c81695da7660fe909173e9f98619e89c] bnxt_en: Don't
support offline self test when RoCE driver is loaded
git bisect good 895621f1c81695da7660fe909173e9f98619e89c
# good: [6c60000f0b9ae7da630a5715a9ba33042d87e7fd] Merge tag
'soc-dt-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good 6c60000f0b9ae7da630a5715a9ba33042d87e7fd
# bad: [87caef42200cd44f8b808ec2f8ac2257f3e0a8c1] Merge tag
'hardening-6.10-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect bad 87caef42200cd44f8b808ec2f8ac2257f3e0a8c1
# good: [25c73642cc5baea5b91bbb9b1f5fcd93672bfa08] Merge tag
'keys-next-6.10-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd
git bisect good 25c73642cc5baea5b91bbb9b1f5fcd93672bfa08
# good: [f4e8d80292859809ea135e9f4c43bae47e4f58bc] Merge tag
'vfs-6.10.rw' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
git bisect good f4e8d80292859809ea135e9f4c43bae47e4f58bc
# good: [ac5f71a3d9d7eb540f6bf7e794eb4a3e4c3f11dd] io_uring/net: add
provided buffer support for IORING_OP_SEND
git bisect good ac5f71a3d9d7eb540f6bf7e794eb4a3e4c3f11dd
# bad: [0c9f4ac808b017a0013cee92a30de980550145d5] Merge tag
'for-6.10/block-20240511' of git://git.kernel.dk/linux
git bisect bad 0c9f4ac808b017a0013cee92a30de980550145d5
# bad: [a3166c51702bb00b8f8b84022090cbab8f37be1a] blk-throttle: delay
initialization until configuration
git bisect bad a3166c51702bb00b8f8b84022090cbab8f37be1a
# good: [e8b4869bc78da1a71f2a2ab476caf50c1dcfeed0] block: add a
blk_alloc_discard_bio helper
git bisect good e8b4869bc78da1a71f2a2ab476caf50c1dcfeed0
# good: [3a861560ccb35f2a4f0a4b8207fa7c2a35fc7f31] bcache: fix
variable length array abuse in btree_iter
git bisect good 3a861560ccb35f2a4f0a4b8207fa7c2a35fc7f31
# bad: [99dc422335d8b2bd4d105797241d3e715bae90e9] block: support to
account io_ticks precisely
git bisect bad 99dc422335d8b2bd4d105797241d3e715bae90e9
# bad: [060406c61c7cb4bbd82a02d179decca9c9bb3443] block: add plug
while submitting IO
git bisect bad 060406c61c7cb4bbd82a02d179decca9c9bb3443
# first bad commit: [060406c61c7cb4bbd82a02d179decca9c9bb3443] block:
add plug while submitting IO
[czhong@vm linux-block]$

Thanks=EF=BC=8C


