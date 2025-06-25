Return-Path: <linux-block+bounces-23182-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3BDAE79FF
	for <lists+linux-block@lfdr.de>; Wed, 25 Jun 2025 10:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8803A4055
	for <lists+linux-block@lfdr.de>; Wed, 25 Jun 2025 08:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8D525BEF6;
	Wed, 25 Jun 2025 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="lV6s34nB"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB20F20C48D
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750839981; cv=none; b=HCWQjOTSGBVDzYCIUGzzaezOYi0SOH4aw1hGmHJmMu0HkIAGTXSIF+d6o1et+bNYqS6uJmeA5/WXZ0OAXoj2eTNtkvhTbU2f/U0x+EmZIxdYcJCR3zWOOdOIBYwtIsxm0tl76rCH2m/t731aW9niMRMC8ncwHJqI2OJflp+A7Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750839981; c=relaxed/simple;
	bh=x3s6pDwaCEUAVubGNQpuCh4DlAX1ROWDyvqVSL7W4/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UF7vk3jGOwM3oOwuUNUGlYA+tOYESt4AEmqBO2Is6uU06qJObqdFPbsuDrcq7xBFUVQ5oMPtqRNv+CXSJZLfwSqcCHP6LqaES7zMyZIlSPsUEXWBAfgdUNBvm78UrIvXt5fSByAHvybWJVj6E56rm71zqxlx1RE/35RxkhEsg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=lV6s34nB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74924255af4so3277229b3a.1
        for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 01:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1750839978; x=1751444778; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qAXb9BST5ecfPhMNlhVdRiqqEsLQt/xkjIWsYe5X1PQ=;
        b=lV6s34nB8STOvC9H3HfBmXPvj5v7bcVf4jCrfLyCyphlqHHOjoVWDz9SvuKQTMbqnk
         MMHEUbivVbNwRxvPeVjr5QVt9H8L9D5etVxpuyz4hV2rrylczanTI9Qzx6+qdmFODlZV
         Yg8u4fa8anvq7EgKzb/hA6RMWqWHCbbK6harscaGjFgzeQGjk7ORWp9SeVl6AfLPVLt3
         z1g6wLDcbrl5nQ/l4X5+q1KmRG6zer4Crgalta/+DqSPB54pnhqlrLkv2l/36d5caV3E
         MmC5ylTCtoc0mpttQwGRULA2zFe7r3+oCtDYDPosVhux95Yc8JvYyoXsr1ZMLTv2/GW0
         /Lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750839978; x=1751444778;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qAXb9BST5ecfPhMNlhVdRiqqEsLQt/xkjIWsYe5X1PQ=;
        b=gpH/wizDBXlJRZD3Vm/8l4+LSfywg0WobBDPes5GxxL1ioxm8b9k5S6zDuN5YsDmwx
         2OODuhhvOx3hx/uZZZaagoFRyzDHDis3NhoVn7iDxZI+a7RGcTac6NaqyZ1YmbQPqW5b
         D7VMSbPlhf38uBx5gthalPZeNYj9bGZwWLNT87xG14HDW2bkkqDncK1vYaNDDSww7vUY
         /tgfjQNMXwr1dVE+144yoMfwxAs5jHbi/Vqnnvlnj0ks6L6Rf4d5p3JlckuuZnu7Khl9
         t4WTBmfNEYPe6y5uiXWR9o6Lt86S1Ve9NkPVFIVkaiDxl9GAZHp28QLhdWYRA718JZpA
         1cew==
X-Gm-Message-State: AOJu0Yy9xADUFezCGMbXyE31iie30GjUDXffSwneeWT/0pFTtXBzNhlX
	7WlRgsZj0Nd3ojoclMCS/LEd3Iu+7uXE9ciLxhVEOPPV4q8A8SokAELxt/V3bNGYpvQ=
X-Gm-Gg: ASbGnct9G73exHW/vYXv3P2cO6RPeZNlWwEJVOLPum1W34WG8NJrc0bQgLZxL7U697I
	grcHaOB8T405q09cHvFUNOqdWYhfAkKFFSj3CX/G4GEyMTWZeP9xKjEszz4UAUOQloIwgdEIn4v
	z5G++ufLVFv0w5fCqgpr7eDVjRKpBf7USfdKDYcpd/4GsonSjD5UUGofb/FFWkOa3W/I5biDee9
	8yD1N/4ApZVWJB7TCCypwjGJFIALle/v2BiPPD1S83b6YacmOTPf6ZmseQSBJ3rf1hjFH+csXjW
	jX42AGbQdj/8O/p4LlIAEgp7JQN9A9QNTcj/gks0amonw0G1wptJw1pO0oxM4lTrGAWDTpvwDek
	dHQ5SovN+22FQ5jBsQ24MjIbwph5tExCbt9pPuw==
X-Google-Smtp-Source: AGHT+IGPP6jH1OhrPPEX7Tdmb1FdEVZrUHboHZxSH9RhO+d7rxrDBLljybwZMh3J3M99jVGNxlHmlA==
X-Received: by 2002:a05:6a20:7350:b0:216:5f66:e382 with SMTP id adf61e73a8af0-2207f2be25amr4349531637.35.1750839978127;
        Wed, 25 Jun 2025 01:26:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e23962sm3994755b3a.53.2025.06.25.01.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 01:26:17 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uULSQ-0000000304P-2Ocf;
	Wed, 25 Jun 2025 18:26:14 +1000
Date: Wed, 25 Jun 2025 18:26:14 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev
Subject: [WARN 6.16-rc3] warning in bdev_count_inflight()
Message-ID: <aFuypjqCXo9-5_En@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jens,

I had this warning fire on 6.16-rc3 whilst running fstests. I don't
know what test caused it - I run 64 tests in parallel over a couple
of hundred loop devices, so there's lots of stuff going on all the
time.

This warning fired when xfs_repair was running on some kind of DM
device:

[ 7339.374977] ------------[ cut here ]------------
[ 7339.378576] WARNING: CPU: 49 PID: 2034647 at block/genhd.c:144 bdev_count_inflight+0x7c/0x90
[ 7339.382933] Modules linked in:
[ 7339.385169] CPU: 49 UID: 0 PID: 2034647 Comm: xfs_repair Not tainted 6.16.0-rc3-dgc+ #342 PREEMPT(full)
[ 7339.390668] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[ 7339.396211] RIP: 0010:bdev_count_inflight+0x7c/0x90
[ 7339.399196] Code: ff 48 8b 94 16 90 00 00 00 01 d3 48 ff c0 eb bc 45 85 ff 78 15 85 db 78 1a 44 01 fb 89 d8 5b 41 5e 41 5f 5d c3 cc cc cc cc cc <0f> 0b 45 31 ff 85 db 79 e6 0f 0b 31 db eb e0 0f 1f 44 00 00 90 90
[ 7339.409039] RSP: 0018:ffffc900100bf978 EFLAGS: 00010286
[ 7339.412126] RAX: 0000000000000040 RBX: 0000000000000000 RCX: 0000000000000040
[ 7339.417910] RDX: 0000000000000040 RSI: 0000000000000040 RDI: ffffffff82f911c8
[ 7339.421923] RBP: ffffc900100bf990 R08: 0000000000000c00 R09: ffff889878c81400
[ 7339.425940] R10: 0000000000000000 R11: ffffffff823dc150 R12: 00000001006b668c
[ 7339.433641] R13: ffff889849c98600 R14: ffff889849c98600 R15: 00000000ffffffff
[ 7339.437308] FS:  00007f383ad55680(0000) GS:ffff88a09a4b1000(0000) knlGS:0000000000000000
[ 7339.441577] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7339.444716] CR2: 00007f3820000020 CR3: 0000001886ec6000 CR4: 0000000000350ef0
[ 7339.447851] Call Trace:
[ 7339.449436]  <TASK>
[ 7339.450683]  bdev_start_io_acct+0x58/0xc0
[ 7339.452661]  dm_io_acct+0x60/0x100
[ 7339.454471]  dm_submit_bio_remap+0x4f/0x100
[ 7339.456592]  __map_bio+0x125/0x260
[ 7339.458423]  dm_submit_bio+0x562/0xd70
[ 7339.459996]  ? kmem_cache_alloc_noprof+0x188/0x320
[ 7339.462501]  ? __blk_flush_plug+0xe6/0x140
[ 7339.464613]  __submit_bio+0x12c/0x210
[ 7339.467010]  submit_bio_noacct_nocheck+0x12e/0x2a0
[ 7339.469166]  ? iov_iter_extract_pages+0x152/0x220
[ 7339.476238]  submit_bio_noacct+0x2fd/0x380
[ 7339.478354]  submit_bio+0xe5/0xf0
[ 7339.480182]  submit_bio_wait+0x54/0xc0
[ 7339.481722]  blkdev_direct_IO+0x415/0x480
[ 7339.483977]  ? __pfx_submit_bio_wait_endio+0x10/0x10
[ 7339.487079]  blkdev_read_iter+0x9d/0x170
[ 7339.494123]  vfs_read+0x269/0x2f0
[ 7339.494131]  __x64_sys_pread64+0x71/0xc0
[ 7339.494134]  x64_sys_call+0x28ca/0x2f60
[ 7339.498789]  do_syscall_64+0x6b/0x1f0
[ 7339.498794]  ? exc_page_fault+0x70/0xa0
[ 7339.498798]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 7339.505840] RIP: 0033:0x7f383dd039ee
[ 7339.505845] Code: 08 0f 85 f5 4b ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 80 00 00 00 00 48 83 ec 08
[ 7339.505848] RSP: 002b:00007f383ad548e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000011
[ 7339.505851] RAX: ffffffffffffffda RBX: 00007f383ad55680 RCX: 00007f383dd039ee
[ 7339.505854] RDX: 0000000000000200 RSI: 000055f7bb191400 RDI: 0000000000000004
[ 7339.538888] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
[ 7339.541277] RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000000
[ 7339.541282] R10: 000000001c200000 R11: 0000000000000246 R12: 00000000000e1000
[ 7339.544844]  49-....
[ 7339.548428] R13: 0000000000000001 R14: 00007f383ad54a60 R15: 000055f7bb186ae0
[ 7339.548433]  </TASK>

I have no idea if it is reproducable - this is the first time I've
hit it. I've cc'd the DM list so they are aware of this, too.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

