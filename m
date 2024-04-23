Return-Path: <linux-block+bounces-6482-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A618AE7CD
	for <lists+linux-block@lfdr.de>; Tue, 23 Apr 2024 15:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCE228DB98
	for <lists+linux-block@lfdr.de>; Tue, 23 Apr 2024 13:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A60F131181;
	Tue, 23 Apr 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewTWgQA8"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B77135416
	for <linux-block@vger.kernel.org>; Tue, 23 Apr 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878285; cv=none; b=pXdQmMEAqK8CkDt9rJsM3p7A/7lvFONF3AJpilZFr05kbct1rvLonG833XKQIIftUujVYiz6CQgZ34VEnLhcMvjIKHAElFIiuP3GDEKOLVFepPfjwnQfyuV1H3OqH5G29BFVG/8rq/F1JvUTqPyI6k5GCmWJ9lKgPyoT+Qm33X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878285; c=relaxed/simple;
	bh=9h+AoQHkqUFH4oAVO39t8FtaJ8mKVB20JNenhUxlLyY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lsR8/F3wTcPs3Vnp673AIEty6PhPZ1rnG6kmCEUUxqJpe3+w8jrZI1MOwNLnrzMOkl0ihDyQgBEoayNIfqXn+1RaUqPR5gkS/k0Q0EhllgvzTnhM2+avszct0+JlXUfKKGMtiKxlTtMLXp2l/ezjfXw85vweAZJPgT6EJ/nNh6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ewTWgQA8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713878282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=d98uVD4LXZvJe0N65duILwWkFNiOhDNR19sPhiV8nd0=;
	b=ewTWgQA8f6EM2Y14f0ctA1dD7qDaGAuade88ugtwdRT6K3Olqt58ZIK4XChNENoxuiMZuM
	xmqpNzY1FNhH1JvdyF/N1NKF3A4WGHETS8lil0E9WHRTQyJejz0DVUOc0GxeZluKuzDlSR
	f+TvsunK8zBIwIAMxbrF/1Ro/rjL6mE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-Nkre3aqeOM2wcsEYUCZivg-1; Tue, 23 Apr 2024 09:17:55 -0400
X-MC-Unique: Nkre3aqeOM2wcsEYUCZivg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a48ed89c7eso6286299a91.3
        for <linux-block@vger.kernel.org>; Tue, 23 Apr 2024 06:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713878273; x=1714483073;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d98uVD4LXZvJe0N65duILwWkFNiOhDNR19sPhiV8nd0=;
        b=A7vOLFov38vCrJTC1ZaWl9A9EppRWd51zpekk3WixjBAA1cmF8XLVbhvKIVqGnbLh9
         9Q4dQZptCcnODSo/Budw/+qg/OYKB8Lfme9AKykPd5JUAVGg6j4Dr5v3bH2JdAtXHnYJ
         HCQhXEQBmJpN4yymGttsuWmcT+je81UWxbuKlLXhjuk8qMfanasrRXr5tG1bwJdazDjr
         ES/ibvn8pG5rKfi8o+MwZBxdc76ymmYiEtFVH9rlLVqKdXKoMjZYBQgyn0sknQuiHShP
         sifRHsHeVTTnyr67tpL4fAxvYXgEAXdxw/2assL8BbWcEfmi8ojjsmLcBqeAm4iaEUHn
         ulwQ==
X-Gm-Message-State: AOJu0Yz0uPhaBB5c2ZaO2DegFPsnRPOpdj8kFeiH1f+4FziQpIHYJTV/
	2WFK4PyhgMZJ63buAk77g5biA8mjdcmS3MjG1iIwxVxcA+LD+RhtI7pVNqWdbZFyo+wmAPS3oSP
	E+xkk4Re3yn8VYMUxjXTxGc2guUqITSB1p9cF5JD9Fcd+ZWMeL3QtRQhk/MenBVLgCYImM5sJVH
	5j7mnidtwacD57LzVuExUbaNC5L+/ahjOpteieFDVnxvHLiA==
X-Received: by 2002:a17:90b:4f83:b0:2ae:7f27:82cd with SMTP id qe3-20020a17090b4f8300b002ae7f2782cdmr2908189pjb.7.1713878272989;
        Tue, 23 Apr 2024 06:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy2LrIJiZhLKdIFnCf1Q5pCEzzDzFw7QimUq74uGXnjTtY0dml1kjSUmSWBWKyNmHFPAUOQcrcHiefNmIr118=
X-Received: by 2002:a17:90b:4f83:b0:2ae:7f27:82cd with SMTP id
 qe3-20020a17090b4f8300b002ae7f2782cdmr2908168pjb.7.1713878272614; Tue, 23 Apr
 2024 06:17:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 23 Apr 2024 21:17:40 +0800
Message-ID: <CAHj4cs8X31NnOWGVLniT5OWBRtEphxw-AcYrPaygG_uYaoeENQ@mail.gmail.com>
Subject: [bug report] RIP: 0010:blk_flush_complete_seq+0x450/0x1060 observed
 during blktests nvme/tcp nvme/012
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"

Hi
I found this issue on the latest linux-block/for-next by blktests
nvme/tcp nvme/012, please help check it and let me know if you need
any info/testing for it, thanks.

[ 1873.394323] run blktests nvme/012 at 2024-04-23 04:13:47
[ 1873.761900] loop0: detected capacity change from 0 to 2097152
[ 1873.846926] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1873.987806] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 1874.208883] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1874.243423] nvme nvme0: creating 48 I/O queues.
[ 1874.362383] nvme nvme0: mapped 48/0/0 default/read/poll queues.
[ 1874.517677] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 1875.649484] XFS (nvme0n1): Mounting V5 Filesystem
b5a2998b-e06a-40d0-a291-a46b67aa43db
[ 1875.770202] XFS (nvme0n1): Ending clean mount
[ 1936.174561] nvme nvme0: I/O tag 49 (a031) type 4 opcode 0x1 (I/O
Cmd) QID 2 timeout
[ 1936.182573] nvme nvme0: starting error recovery
[ 1936.187622] nvme nvme0: I/O tag 50 (5032) type 4 opcode 0x1 (I/O
Cmd) QID 2 timeout
[ 1936.196829] nvme nvme0: I/O tag 51 (b033) type 4 opcode 0x1 (I/O
Cmd) QID 2 timeout
[ 1936.205619] block nvme0n1: no usable path - requeuing I/O
[ 1936.211228] nvme nvme0: I/O tag 52 (0034) type 4 opcode 0x1 (I/O
Cmd) QID 2 timeout
[ 1936.218975] block nvme0n1: no usable path - requeuing I/O
[ 1936.224691] nvme nvme0: I/O tag 53 (3035) type 4 opcode 0x1 (I/O
Cmd) QID 2 timeout
[ 1936.232395] block nvme0n1: no usable path - requeuing I/O
[ 1936.237916] nvme nvme0: I/O tag 54 (0036) type 4 opcode 0x1 (I/O
Cmd) QID 2 timeout
[ 1936.245731] block nvme0n1: no usable path - requeuing I/O
[ 1936.251165] block nvme0n1: no usable path - requeuing I/O
[ 1936.256967] nvme nvme0: I/O tag 55 (8037) type 4 opcode 0x1 (I/O
Cmd) QID 2 timeout
[ 1936.264676] block nvme0n1: no usable path - requeuing I/O
[ 1936.270159] nvme nvme0: I/O tag 56 (1038) type 4 opcode 0x1 (I/O
Cmd) QID 2 timeout
[ 1936.277848] block nvme0n1: no usable path - requeuing I/O
[ 1936.283294] block nvme0n1: no usable path - requeuing I/O
[ 1936.288743] nvme nvme0: I/O tag 57 (b039) type 4 opcode 0x1 (I/O
Cmd) QID 2 timeout
[ 1936.296450] block nvme0n1: no usable path - requeuing I/O
[ 1936.301920] nvme nvme0: I/O tag 58 (503a) type 4 opcode 0x1 (I/O
Cmd) QID 2 timeout
[ 1936.309621] block nvme0n1: no usable path - requeuing I/O
[ 1936.315076] nvme nvme0: I/O tag 59 (a03b) type 4 opcode 0x1 (I/O
Cmd) QID 2 timeout
[ 1936.323271] nvme nvme0: I/O tag 60 (803c) type 4 opcode 0x1 (I/O
Cmd) QID 2 timeout
[ 1936.331018] nvme nvme0: I/O tag 61 (203d) type 4 opcode 0x1 (I/O
Cmd) QID 2 timeout
[ 1936.338769] nvme nvme0: I/O tag 62 (503e) type 4 opcode 0x1 (I/O
Cmd) QID 2 timeout
[ 1936.346515] nvme nvme0: I/O tag 63 (c03f) type 4 opcode 0x1 (I/O
Cmd) QID 2 timeout
[ 1936.354693] nvme nvme0: I/O tag 64 (a040) type 4 opcode 0x1 (I/O
Cmd) QID 2 timeout
[ 1936.362479] nvme nvme0: I/O tag 49 (0031) type 4 opcode 0x0 (I/O
Cmd) QID 8 timeout
[ 1936.370819] nvme nvme0: I/O tag 50 (0032) type 4 opcode 0x1 (I/O
Cmd) QID 8 timeout
[ 1936.378679] nvme nvme0: I/O tag 51 (0033) type 4 opcode 0x1 (I/O
Cmd) QID 8 timeout
[ 1936.386464] nvme nvme0: I/O tag 52 (0034) type 4 opcode 0x1 (I/O
Cmd) QID 8 timeout
[ 1936.394235] nvme nvme0: I/O tag 53 (0035) type 4 opcode 0x1 (I/O
Cmd) QID 8 timeout
[ 1936.402062] nvme nvme0: I/O tag 54 (0036) type 4 opcode 0x1 (I/O
Cmd) QID 8 timeout
[ 1936.409847] nvme nvme0: I/O tag 55 (0037) type 4 opcode 0x1 (I/O
Cmd) QID 8 timeout
[ 1936.417773] nvme nvme0: I/O tag 56 (0038) type 4 opcode 0x1 (I/O
Cmd) QID 8 timeout
[ 1936.449539] general protection fault, probably for non-canonical
address 0xdffffc0000000004: 0000 [#1] PREEMPT SMP KASAN PTI
[ 1936.450749] nvme nvme0: Reconnecting in 10 seconds...
[ 1936.460764] KASAN: null-ptr-deref in range
[0x0000000000000020-0x0000000000000027]
[ 1936.460775] CPU: 15 PID: 848 Comm: kworker/15:1H Not tainted 6.9.0-rc4.v1+ #2
[ 1936.480528] Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
2.20.1 09/13/2023
[ 1936.488094] Workqueue: kblockd blk_mq_run_work_fn
[ 1936.492806] RIP: 0010:blk_flush_complete_seq+0x450/0x1060
[ 1936.498216] Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 a8 08 00 00
49 8d 7c 24 20 4d 89 65 38 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48
c1 ea 03 <80> 3c 02 00 0f 85 8e 08 00 00 49 8d 7d 30 4d 8b 64 24 20 48
b8 00
[ 1936.516960] RSP: 0018:ffffc9000f86f850 EFLAGS: 00010002
[ 1936.522185] RAX: dffffc0000000000 RBX: 1ffff92001f0df10 RCX: 1ffff11543588c4a
[ 1936.529318] RDX: 0000000000000004 RSI: dffffc0000000000 RDI: 0000000000000020
[ 1936.536449] RBP: ffff88aa1a419da0 R08: ffff88c7aba3f9e0 R09: 1ffffffff38e0bb3
[ 1936.543582] R10: 1ffff11543588c4a R11: ffffffffffe25e18 R12: 0000000000000000
[ 1936.550714] R13: ffff88aa1ac46200 R14: ffff88a9c4560d00 R15: 0000000000000000
[ 1936.557847] FS:  0000000000000000(0000) GS:ffff88c7aba00000(0000)
knlGS:0000000000000000
[ 1936.565930] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1936.571675] CR2: 00007fc90f80b004 CR3: 00000029d18a0004 CR4: 00000000007706f0
[ 1936.578809] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1936.585942] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1936.593072] PKRU: 55555554
[ 1936.595784] Call Trace:
[ 1936.598237]  <TASK>
[ 1936.600344]  ? __die_body.cold+0x19/0x25
[ 1936.604279]  ? die_addr+0x46/0x70
[ 1936.607606]  ? exc_general_protection+0x14f/0x250
[ 1936.612325]  ? asm_exc_general_protection+0x26/0x30
[ 1936.617212]  ? blk_flush_complete_seq+0x450/0x1060
[ 1936.622012]  ? __pfx_blk_flush_complete_seq+0x10/0x10
[ 1936.627072]  mq_flush_data_end_io+0x279/0x500
[ 1936.631430]  ? __pfx_mq_flush_data_end_io+0x10/0x10
[ 1936.636308]  blk_mq_end_request+0x1b8/0x690
[ 1936.640493]  ? _raw_spin_unlock_irqrestore+0x45/0x80
[ 1936.645460]  nvme_failover_req+0x37d/0x4e0 [nvme_core]
[ 1936.650634]  nvme_fail_nonready_command+0x130/0x180 [nvme_core]
[ 1936.656578]  blk_mq_dispatch_rq_list+0x3b3/0x2100
[ 1936.661292]  ? __pfx_blk_mq_dispatch_rq_list+0x10/0x10
[ 1936.666436]  __blk_mq_sched_dispatch_requests+0x554/0x1510
[ 1936.671925]  ? __pfx___lock_acquire+0x10/0x10
[ 1936.676285]  ? __pfx_lock_acquired+0x10/0x10
[ 1936.680558]  ? __pfx___blk_mq_sched_dispatch_requests+0x10/0x10
[ 1936.686477]  ? __pfx_lock_acquire+0x10/0x10
[ 1936.690668]  blk_mq_sched_dispatch_requests+0xa6/0xf0
[ 1936.695721]  blk_mq_run_work_fn+0x122/0x2c0
[ 1936.699908]  ? blk_mq_run_work_fn+0x114/0x2c0
[ 1936.704266]  process_one_work+0x85d/0x13f0
[ 1936.708371]  ? worker_thread+0xcc/0x1130
[ 1936.712301]  ? __pfx_process_one_work+0x10/0x10
[ 1936.716835]  ? assign_work+0x16c/0x240
[ 1936.720596]  worker_thread+0x6da/0x1130
[ 1936.724438]  ? __pfx_worker_thread+0x10/0x10
[ 1936.728712]  kthread+0x2ed/0x3c0
[ 1936.731944]  ? _raw_spin_unlock_irq+0x28/0x60
[ 1936.736303]  ? __pfx_kthread+0x10/0x10
[ 1936.740058]  ret_from_fork+0x31/0x70
[ 1936.743636]  ? __pfx_kthread+0x10/0x10
[ 1936.747387]  ret_from_fork_asm+0x1a/0x30
[ 1936.751319]  </TASK>
[ 1936.753516] Modules linked in: nvmet_tcp nvmet nvme_tcp
nvme_fabrics nvme_keyring nvme_core nvme_auth intel_rapl_msr
intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common
isst_if_common skx_edac x86_pkg_temp_thermal intel_powerclamp coretemp
kvm_intel kvm spi_nor iTCO_wdt intel_pmc_bxt cdc_ether mtd usbnet
iTCO_vendor_support dell_smbios rapl intel_cstate rfkill sunrpc dcdbas
dell_wmi_descriptor wmi_bmof intel_uncore pcspkr bnxt_en mii tg3
i2c_i801 spi_intel_pci i2c_smbus spi_intel mei_me ipmi_ssif mei
lpc_ich intel_pch_thermal acpi_ipmi ipmi_si ipmi_devintf
ipmi_msghandler nd_pmem nd_btt dax_pmem acpi_power_meter fuse loop
nfnetlink zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel
polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3
sha256_ssse3 sha1_ssse3 mgag200 megaraid_sas i2c_algo_bit wmi nfit
libnvdimm [last unloaded: nvmet]
[ 1936.829942] ---[ end trace 0000000000000000 ]---
[ 1936.880774] RIP: 0010:blk_flush_complete_seq+0x450/0x1060
[ 1936.886183] Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 a8 08 00 00
49 8d 7c 24 20 4d 89 65 38 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48
c1 ea 03 <80> 3c 02 00 0f 85 8e 08 00 00 49 8d 7d 30 4d 8b 64 24 20 48
b8 00
[ 1936.904925] RSP: 0018:ffffc9000f86f850 EFLAGS: 00010002
[ 1936.910150] RAX: dffffc0000000000 RBX: 1ffff92001f0df10 RCX: 1ffff11543588c4a
[ 1936.917285] RDX: 0000000000000004 RSI: dffffc0000000000 RDI: 0000000000000020
[ 1936.924416] RBP: ffff88aa1a419da0 R08: ffff88c7aba3f9e0 R09: 1ffffffff38e0bb3
[ 1936.931548] R10: 1ffff11543588c4a R11: ffffffffffe25e18 R12: 0000000000000000
[ 1936.938680] R13: ffff88aa1ac46200 R14: ffff88a9c4560d00 R15: 0000000000000000
[ 1936.945811] FS:  0000000000000000(0000) GS:ffff88c7aba00000(0000)
knlGS:0000000000000000
[ 1936.953899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1936.959642] CR2: 00007fc90f80b004 CR3: 00000029d18a0004 CR4: 00000000007706f0
[ 1936.966776] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1936.973906] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1936.981039] PKRU: 55555554
[ 1936.983752] note: kworker/15:1H[848] exited with irqs disabled
[ 1936.989617] note: kworker/15:1H[848] exited with preempt_count 1
[ 1946.926323] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 1946.944673] nvme nvme0: creating 48 I/O queues.

(gdb) l *(blk_flush_complete_seq+0x450)
0xffffffff826c5370 is in blk_flush_complete_seq (block/blk-flush.c:133).
128 * After flush data completion, @rq->bio is %NULL but we need to
129 * complete the bio again.  @rq->biotail is guaranteed to equal the
130 * original @rq->bio.  Restore it.
131 */
132 rq->bio = rq->biotail;
133 rq->__sector = rq->bio->bi_iter.bi_sector;
134
135 /* make @rq a normal request */
136 rq->rq_flags &= ~RQF_FLUSH_SEQ;
137 rq->end_io = rq->flush.saved_end_io;



--
Best Regards,
  Yi Zhang


