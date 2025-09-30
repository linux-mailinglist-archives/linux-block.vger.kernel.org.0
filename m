Return-Path: <linux-block+bounces-27933-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F8BBAAEC0
	for <lists+linux-block@lfdr.de>; Tue, 30 Sep 2025 03:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 880B24E1410
	for <lists+linux-block@lfdr.de>; Tue, 30 Sep 2025 01:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FDD1DED49;
	Tue, 30 Sep 2025 01:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UQNQE8gC"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAE635949
	for <linux-block@vger.kernel.org>; Tue, 30 Sep 2025 01:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759197064; cv=none; b=qjDGHn7TF0BZ4/YhQxF/6+kw+6BpgYCewBw2NPoqqkktU0qDK9sGd3KLYxhWm2n8shoCKNBG9kr2OhSQ6UYCmX5nyy/tVnTwHEGtbRdiddXp+NN0k7LOZHtc+YotHptlkXpaf9FdD+PcICvXil0w76GNo1d6XyHCjuWF49F1IWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759197064; c=relaxed/simple;
	bh=+N0f/z3ehit7SLsZO1Dq8s3g1x98JZ7k6qqQxV1GrYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgmDiUBoRjiXoG84/zgoDWWRBMXH2/1GT3NwBvQeU1FuHvuIsm2crVjTXtPgKmXshTGHJTtO8BNSnZn4vWi2gO/q3b7QbnS13TDeWzLauuYI0PlY7bo51Fk7FrUB8hnTaly1kRDF3Vt1jS2TZCGqnYBXYLpWQawEwptu2lGxfCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UQNQE8gC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-280fc0e9f50so7495235ad.3
        for <linux-block@vger.kernel.org>; Mon, 29 Sep 2025 18:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1759197059; x=1759801859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLDDpVJCbpribArLlfcKHUhfqN2M7jf8k0L99iwd+f4=;
        b=UQNQE8gC5N0geWNSFk6jx58uHYb24YcdkpISL79G58Aq5A7DlAU4vZa0owKxAE05PG
         pzhTtP3POa/dK3tvmSEpaHBccz1eLu/eFRhsrCRLJDg2J5qr+agj5Jd7yvvcdw1LWB26
         b+DaZzbeOOtwHbRmmCcWwKga3G/oeTsKOGK8BvTDb1dwobC0Yp0oOopuviNMYbkEKjnF
         iMkyraUlRgXbdi+AVCDbuF6FVo4dudfpIsPmabWvS3dAmpkdQ5HiMsCY+fw75XMwrkME
         6lH0GzBI2RAG90s/Uxc85vubVrzb9jJ7jC3SO3ItF5yczRPYeq3xrzBO1kWzzd9eyFF4
         fiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759197059; x=1759801859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLDDpVJCbpribArLlfcKHUhfqN2M7jf8k0L99iwd+f4=;
        b=Zb9CRfFIKIq+yk3jbupsSa8GOwKfHVkWS0MnHJkU6z54yYWvcCwd1gWwTdAVMeFFrK
         HIWULz7f9vohaUj0NoNaOc9rZcURu6s7+MtUTBwdGeCVFiM58V8+nnY8xmvhp2sxQAsu
         xGRP8K2Q3Knz2vI5BKjRmomim1hSOpM0EtN6SUMpbJaGZLO2+8frtToTN4B9GTyN9xYH
         1iZ1QTSH08m5WXtPPPo25kPjPLLiVAxX/hWXbgplPERbQSpLpn53Bz5MxuOZREKUVJ2q
         4jjBUKxbgUrYWcdaP/cZXsqm4UQXRXrliD3asJ9gU5HhZQhjxqyL/OReac5AFM0AOAfh
         sYSA==
X-Forwarded-Encrypted: i=1; AJvYcCUUUoolii699zVrkwLpOrpkV+KoGtz9QOthcwdezcvckWoCLerieprSK/cWbpj1IOwIgOHba+u2nN6+Fg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9yZdhUTZ1AmxeG1PSsCZg60O3+HB+yFxlja+T+zamuKK3Soai
	24tsZMmrjAmjb/Dx06GQDQeZL58DQNXUiwnpmekzfn0Z6RkxlJ4lAYiqK1DoBPmzkURWtU5tJuD
	pLHZHjlFkp94a8efJZ8KWwV4oyyl/cFTIHJqNyMXFzKdHSJKyM8ai/5k=
X-Gm-Gg: ASbGncspXj5qSFjRcgVcyIn8oxpQhZoA/Sre7uM9c1fDJaw+RTYciuQzpuypJ5J+9RQ
	p+spMf3gJAyspniVbyM2QOS3qzw/fi/CjmsIvt2EDNgPCREcSTHjD605PWclfnI2+F/lAtjDCR3
	g6ORpd4LwrPkqMHgVMOlFqIfn8TL2dlS7v0acHXaGTkBzZtt/AYwBS9JrphFxdTQfjYNsDbD4GG
	80Y3jKuoMvv9Xw8Qi/Uufm6ZL62iWyl+8IAJspeUmtBCA392oIU7r4xyxoknZSw
X-Google-Smtp-Source: AGHT+IH6RwJuxNeJn6zdQL9FTsPniXhf76nPgwgTbM2xpiBjGcwxv0bDtuY9QxYQwzkcuDKyb6ql1W4wKxEMqKCj/Os=
X-Received: by 2002:a17:902:db11:b0:269:8407:499a with SMTP id
 d9443c01a7336-27ed49b9e26mr134366865ad.1.1759197059148; Mon, 29 Sep 2025
 18:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <124c358d-1d50-4691-942a-76ff75396be5@kernel.dk>
In-Reply-To: <124c358d-1d50-4691-942a-76ff75396be5@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 29 Sep 2025 18:50:47 -0700
X-Gm-Features: AS18NWDX1_N-igG_sRtd8xY9ATs2Ey3LCqN7Lb9t0eleKM_rFzAykwSvBs_TVQQ
Message-ID: <CADUfDZoYDMF2BL4+yTKJ=Cr+_-h0j8eD8pjZXw8wTUFOa+dN+Q@mail.gmail.com>
Subject: Re: [GIT PULL] Block changes for 6.18-rc1
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 6:46=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> Hi Linus,
>
> Here are the block changes scheduled for the 6.18 merge window. This
> pull request contains:
>
> - NVMe pull request via Keith:
>         - FC target fixes (Daniel)
>         - Authentication fixes and updates (Martin, Chris)
>         - Admin controller handling (Kamaljit)
>         - Target lockdep assertions (Max)
>         - Keep-alive updates for discovery (Alastair)
>         - Suspend quirk (Georg)
>
> - MD pull request via Yu:
>         - Add support for a lockless bitmap. Key features for the new
>           bitmap are that the IO fastpath is lockless. If user issues
>           lots of write IO to the same bitmap bit in a short time, only
>           the first write has additional overhead to update bitmap bit,
>           no additional overhead for the following writes. By supporting
>           only resync or recover written data, means in the case
>           creating new array or replacing with a new disk, there is no
>           need to do a full disk resync/recovery.
>
> - Switch ->getgeo() and ->bios_param() to using struct gendisk rather
>   than struct block_device.
>
> - Rust block changes via Andreas. This series adds configuration via
>   configfs and remote completion to the rnull driver. The series also
>   includes a set of changes to the rust block device driver API: a few
>   cleanup patches, and a few features supporting the rnull changes.
>
>   The series removes the raw buffer formatting logic from
>   `kernel::block` and improves the logic available in `kernel::string`
>   to support the same use as the removed logic.
>
> - floppy arch cleanups
>
> - Add support for UBLK_F_BATCH_IO, improving the user <-> kernel
>   communication
>         - Per-queue vs Per-I/O: Commands operate on queues rather than
>           individual I/Os
>         - Batch processing: Multiple I/Os are handled in single
>           operation
>         - Multishot commands: Use io_uring multishot for reducing
>           submission overhead
>         - Flexible task assignment: Any task can handle any I/O
>           (no per-I/O daemons)
>         - Better load balancing: Tasks can adjust their workload
>           dynamically
>         - help for following future optimizations:
>                 - blk-mq batch tags allocation/free,
>                 - easier to support io-poll
>                 - per-task batch for avoiding per-io lock

Perhaps I'm missing something, but I don't actually see the
UBLK_F_BATCH_IO series in the list of commits. My understanding was
that it's still in the process of being reviewed, I hadn't seen you
apply it yet.

Best,
Caleb

>
> - Series reducing the number of dereferencing needed for ublk commands
>
> - Restrict supported sockets for nbd. Mostly done to eliminate a class
>   of issues perpetually reported by syzbot, by using nonsensical socket
>   setups.
>
> - A few s390 dasd block fixes
>
> - Series fixing a few issues around atomic writes
>
> - Series improving DMA interation for integrity requests
>
> - Series improving how iovecs are treated with regards to O_DIRECT
>   aligment restraints. Currently the kernel requires each segment to
>   adhere to the constraints, after the series only the request as a
>   whole needs to.
>
> - Series cleaning up and improving p2p support, enabling use of p2p for
>   metadata payloads.
>
> - Improve locking of request lookup, using SRCU where appropriate.
>
> - Use page references properly for brd, avoiding very long RCU sections.
>
> - Fix ordering of recursively submitted IOs.
>
> - Series cleaning up and improving updating nr_requests for a live
>   device.
>
> - Various fixes and cleanups.
>
> Note that this will throw a conflict with rust changes from the tip tree
> (see below links), and obviously the bcachefs changes can just be
> dropped on the floor at this point.
>
> [1] https://lore.kernel.org/all/aMligBYh0Z4V5Biv@sirena.org.uk/
> [2] https://lore.kernel.org/all/aMlkUu2MzRYxh96v@sirena.org.uk/
> [3] https://lore.kernel.org/all/aMiScHEWoOABPgt9@sirena.org.uk/
>
> Please pull!
>
>
> The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e=
00:
>
>   Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git tags/for-=
6.18/block-20250929
>
> for you to fetch changes up to 130e6de62107116eba124647116276266be0f84c:
>
>   s390/dasd: enforce dma_alignment to ensure proper buffer validation (20=
25-09-25 10:34:30 -0600)
>
> ----------------------------------------------------------------
> for-6.18/block-20250929
>
> ----------------------------------------------------------------
> Al Viro (3):
>       scsi: switch scsi_bios_ptable() and scsi_partsize() to gendisk
>       scsi: switch ->bios_param() to passing gendisk
>       block: switch ->getgeo() to struct gendisk
>
> Alistair Francis (1):
>       nvme: Use non zero KATO for persistent discovery connections
>
> Andreas Hindborg (17):
>       rust: str: normalize imports in `str.rs`
>       rust: str: allow `str::Formatter` to format into `&mut [u8]`.
>       rust: str: expose `str::{Formatter, RawFormatter}` publicly.
>       rust: str: introduce `NullTerminatedFormatter`
>       rust: str: introduce `kstrtobool` function
>       rust: configfs: re-export `configfs_attrs` from `configfs` module
>       rust: block: normalize imports for `gen_disk.rs`
>       rust: block: use `NullTerminatedFormatter`
>       rust: block: remove `RawWriter`
>       rust: block: remove trait bound from `mq::Request` definition
>       rust: block: add block related constants
>       rnull: move driver to separate directory
>       rnull: enable configuration via `configfs`
>       rust: block: add `GenDisk` private data support
>       rust: block: mq: fix spelling in a safety comment
>       rust: block: add remote completion to `Request`
>       rnull: add soft-irq completion support
>
> Andy Shevchenko (3):
>       floppy: Remove unused CROSS_64KB() macro from arch/ code
>       floppy: Replace custom SZ_64K constant
>       floppy: Sort headers alphabetically
>
> Bart Van Assche (3):
>       block: Move a misplaced comment in queue_wb_lat_store()
>       blk-mq: Fix the blk_mq_tagset_busy_iter() documentation
>       blk-mq: Fix more tag iteration function documentation
>
> Caleb Sander Mateos (20):
>       ublk: inline __ublk_ch_uring_cmd()
>       ublk: consolidate nr_io_ready and nr_queues_ready
>       ublk: remove ubq check in ublk_check_and_get_req()
>       ublk: don't pass q_id to ublk_queue_cmd_buf_size()
>       ublk: don't pass ublk_queue to __ublk_fail_req()
>       ublk: add helpers to check ublk_device flags
>       ublk: don't dereference ublk_queue in ublk_ch_uring_cmd_local()
>       ublk: don't dereference ublk_queue in ublk_check_and_get_req()
>       ublk: pass ublk_device to ublk_register_io_buf()
>       ublk: don't access ublk_queue in ublk_register_io_buf()
>       ublk: don't access ublk_queue in ublk_daemon_register_io_buf()
>       ublk: pass q_id and tag to __ublk_check_and_get_req()
>       ublk: don't access ublk_queue in ublk_check_fetch_buf()
>       ublk: don't access ublk_queue in ublk_config_io_buf()
>       ublk: don't pass ublk_queue to ublk_fetch()
>       ublk: don't access ublk_queue in ublk_check_commit_and_fetch()
>       ublk: don't access ublk_queue in ublk_need_complete_req()
>       ublk: pass ublk_io to __ublk_complete_rq()
>       ublk: don't access ublk_queue in ublk_unmap_io()
>       ublk: remove redundant zone op check in ublk_setup_iod()
>
> Chris Leech (2):
>       nvme-auth: add hkdf_expand_label()
>       nvme-auth: use hkdf_expand_label()
>
> Christoph Hellwig (2):
>       block: add a bio_init_inline helper
>       block: remove the bi_inline_vecs variable sized array from struct b=
io
>
> Daniel Wagner (4):
>       nvmet-fc: move lsop put work to nvmet_fc_ls_req_op
>       nvmet-fc: avoid scheduling association deletion twice
>       nvmet-fcloop: call done callback even when remote port is gone
>       nvme-fc: use lock accessing port_state and rport state
>
> Eric Dumazet (1):
>       nbd: restrict sockets to TCP and UDP
>
> Genjian Zhang (1):
>       null_blk: Fix the description of the cache_size module argument
>
> Georg Gottleuber (1):
>       nvme-pci: Add TUXEDO IBS Gen8 to Samsung sleep quirk
>
> Han Guangjiang (1):
>       blk-throttle: fix access race during throttle policy activation
>
> Jaehoon Kim (2):
>       s390/dasd: Return BLK_STS_INVAL for EINVAL from do_dasd_request
>       s390/dasd: enforce dma_alignment to ensure proper buffer validation
>
> Jens Axboe (3):
>       Merge tag 'pull-getgeo' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/viro/vfs into for-6.18/block
>       Merge tag 'md-6.18-20250909' of gitolite.kernel.org:pub/scm/linux/k=
ernel/git/mdraid/linux into for-6.18/block
>       Merge tag 'nvme-6.18-2025-09-23' of git://git.infradead.org/nvme in=
to for-6.18/block
>
> John Garry (3):
>       block: update validation of atomic writes boundary for stacked devi=
ces
>       block: fix stacking of atomic writes when atomics are not supported
>       block: relax atomic write boundary vs chunk size check
>
> Kamaljit Singh (2):
>       nvme-core: add method to check for an I/O controller
>       nvme-core: do ioccsz/iorcsz validation only for I/O controllers
>
> Keith Busch (20):
>       blk-mq-dma: create blk_map_iter type
>       blk-mq-dma: provide the bio_vec array being iterated
>       blk-mq-dma: require unmap caller provide p2p map type
>       blk-mq: remove REQ_P2PDMA flag
>       blk-mq-dma: move common dma start code to a helper
>       blk-mq-dma: add scatter-less integrity data DMA mapping
>       blk-integrity: use iterator for mapping sg
>       nvme-pci: create common sgl unmapping helper
>       nvme-pci: convert metadata mapping to dma iter
>       block: check for valid bio while splitting
>       block: add size alignment to bio_iov_iter_get_pages
>       block: align the bio after building it
>       block: simplify direct io validity check
>       iomap: simplify direct io validity check
>       block: remove bdev_iter_is_aligned
>       blk-integrity: use simpler alignment check
>       iov_iter: remove iov_iter_is_aligned
>       blk-integrity: enable p2p source and destination
>       blk-mq-dma: bring back p2p request flags
>       blk-map: provide the bdev to bio if one exists
>
> Li Nan (1):
>       blk-mq: check kobject state_in_sysfs before deleting in blk_mq_unre=
gister_hctx
>
> Marco Crivellari (3):
>       drivers/block: replace use of system_wq with system_percpu_wq
>       drivers/block: replace use of system_unbound_wq with system_dfl_wq
>       drivers/block: WQ_PERCPU added to alloc_workqueue users
>
> Martin George (3):
>       nvme-auth: update bi_directional flag
>       nvme-tcp: send only permitted commands for secure concat
>       nvme-core: use nvme_is_io_ctrl() for I/O controller check
>
> Max Gurtovoy (1):
>       nvmet: add safety check for subsys lock
>
> Ming Lei (6):
>       blk-mq: Move flush queue allocation into blk_mq_init_hctx()
>       blk-mq: Pass tag_set to blk_mq_free_rq_map/tags
>       blk-mq: Defer freeing of tags page_list to SRCU callback
>       blk-mq: Defer freeing flush queue to SRCU callback
>       blk-mq: Replace tags->lock with SRCU for tag iterators
>       blk-mq: Document tags_srcu member in blk_mq_tag_set structure
>
> Nathan Chancellor (1):
>       md/md-llbitmap: Use DIV_ROUND_UP_SECTOR_T
>
> Qianfeng Rong (1):
>       block: use int to store blk_stack_limits() return value
>
> Thorsten Blum (1):
>       block: floppy: Replace kmalloc() + copy_from_user() with memdup_use=
r()
>
> Uday Shankar (4):
>       selftests: ublk: kublk: simplify feat_map definition
>       selftests: ublk: kublk: add UBLK_F_BUF_REG_OFF_DAEMON to feat_map
>       selftests: ublk: add test to verify that feat_map is complete
>       selftests: ublk: fix behavior when fio is not installed
>
> Yu Kuai (56):
>       brd: use page reference to protect page lifetime
>       blk-mq: fix elevator depth_updated method
>       blk-mq: fix blk_mq_tags double free while nr_requests grown
>       md/md-bitmap: remove the parameter 'init' for bitmap_ops->resize()
>       md/md-bitmap: merge md_bitmap_group into bitmap_operations
>       md/md-bitmap: add a new parameter 'flush' to bitmap_ops->enabled
>       md/md-bitmap: add md_bitmap_registered/enabled() helper
>       md/md-bitmap: handle the case bitmap is not enabled before start_sy=
nc()
>       md/md-bitmap: handle the case bitmap is not enabled before end_sync=
()
>       md/raid1: check bitmap before behind write
>       md/raid1: check before referencing mddev->bitmap_ops
>       md/raid10: check before referencing mddev->bitmap_ops
>       md/raid5: check before referencing mddev->bitmap_ops
>       md/dm-raid: check before referencing mddev->bitmap_ops
>       md: check before referencing mddev->bitmap_ops
>       md/md-bitmap: introduce CONFIG_MD_BITMAP
>       md: add a new parameter 'offset' to md_super_write()
>       md: factor out a helper raid_is_456()
>       md/md-bitmap: support discard for bitmap ops
>       md: add a new mddev field 'bitmap_id'
>       md/md-bitmap: add a new sysfs api bitmap_type
>       md/md-bitmap: delay registration of bitmap_ops until creating bitma=
p
>       md/md-bitmap: add a new method skip_sync_blocks() in bitmap_operati=
ons
>       md/md-bitmap: add a new method blocks_synced() in bitmap_operations
>       md: add a new recovery_flag MD_RECOVERY_LAZY_RECOVER
>       md/md-bitmap: make method bitmap_ops->daemon_work optional
>       md/md-llbitmap: introduce new lockless bitmap
>       block: cleanup bio_issue
>       block: initialize bio issue time in blk_mq_submit_bio()
>       blk-mq: add QUEUE_FLAG_BIO_ISSUE_TIME
>       md: fix mssing blktrace bio split events
>       blk-crypto: fix missing blktrace bio split events
>       block: factor out a helper bio_submit_split_bioset()
>       md/raid0: convert raid0_handle_discard() to use bio_submit_split_bi=
oset()
>       md/raid1: convert to use bio_submit_split_bioset()
>       md/raid10: add a new r10bio flag R10BIO_Returned
>       md/raid10: convert read/write to use bio_submit_split_bioset()
>       md/raid5: convert to use bio_submit_split_bioset()
>       md/md-linear: convert to use bio_submit_split_bioset()
>       blk-crypto: convert to use bio_submit_split_bioset()
>       block: skip unnecessary checks for split bio
>       block: fix ordering of recursive split IO
>       md/raid0: convert raid0_make_request() to use bio_submit_split_bios=
et()
>       blk-mq: remove useless checking in queue_requests_store()
>       blk-mq: remove useless checkings in blk_mq_update_nr_requests()
>       blk-mq: check invalid nr_requests in queue_requests_store()
>       blk-mq: convert to serialize updating nr_requests with update_nr_hw=
q_lock
>       blk-mq: cleanup shared tags case in blk_mq_update_nr_requests()
>       blk-mq: split bitmap grow and resize case in blk_mq_update_nr_reque=
sts()
>       blk-mq-sched: add new parameter nr_requests in blk_mq_alloc_sched_t=
ags()
>       blk-mq: fix potential deadlock while nr_requests grown
>       blk-mq: remove blk_mq_tag_update_depth()
>       blk-mq: fix stale nr_requests documentation
>       blk-throttle: fix throtl_data leak during disk release
>       blk-mq: fix null-ptr-deref in blk_mq_free_tags() from error path
>       blk-cgroup: fix possible deadlock while configuring policy
>
> chengkaitao (1):
>       block/mq-deadline: Remove the redundant rb_entry_rq in the deadline=
_from_pos().
>
>  Documentation/ABI/stable/sysfs-block            |   14 +-
>  Documentation/admin-guide/md.rst                |   86 +-
>  Documentation/filesystems/locking.rst           |    2 +-
>  Documentation/scsi/scsi_mid_low_api.rst         |    8 +-
>  MAINTAINERS                                     |    2 +-
>  arch/alpha/include/asm/floppy.h                 |   19 -
>  arch/arm/include/asm/floppy.h                   |    2 -
>  arch/m68k/emu/nfblock.c                         |    4 +-
>  arch/m68k/include/asm/floppy.h                  |    4 -
>  arch/mips/include/asm/floppy.h                  |   15 -
>  arch/parisc/include/asm/floppy.h                |   11 +-
>  arch/powerpc/include/asm/floppy.h               |    5 -
>  arch/sparc/include/asm/floppy_32.h              |    3 -
>  arch/sparc/include/asm/floppy_64.h              |    3 -
>  arch/um/drivers/ubd_kern.c                      |    6 +-
>  arch/x86/include/asm/floppy.h                   |    8 +-
>  block/bfq-iosched.c                             |   22 +-
>  block/bio-integrity.c                           |   25 +-
>  block/bio.c                                     |   78 +-
>  block/blk-cgroup.c                              |   29 +-
>  block/blk-cgroup.h                              |   12 +-
>  block/blk-core.c                                |   19 +-
>  block/blk-crypto-fallback.c                     |   19 +-
>  block/blk-integrity.c                           |   58 -
>  block/blk-iolatency.c                           |   19 +-
>  block/blk-map.c                                 |   13 +-
>  block/blk-merge.c                               |   85 +-
>  block/blk-mq-debugfs.c                          |    1 +
>  block/blk-mq-dma.c                              |  282 +++-
>  block/blk-mq-sched.c                            |   14 +-
>  block/blk-mq-sched.h                            |   13 +-
>  block/blk-mq-sysfs.c                            |    7 +-
>  block/blk-mq-tag.c                              |  128 +-
>  block/blk-mq.c                                  |  175 +--
>  block/blk-mq.h                                  |   22 +-
>  block/blk-settings.c                            |   84 +-
>  block/blk-sysfs.c                               |   70 +-
>  block/blk-throttle.c                            |   15 +-
>  block/blk-throttle.h                            |   18 +-
>  block/blk.h                                     |   46 +-
>  block/elevator.c                                |    3 +-
>  block/elevator.h                                |    2 +-
>  block/fops.c                                    |   10 +-
>  block/ioctl.c                                   |    4 +-
>  block/kyber-iosched.c                           |   19 +-
>  block/mq-deadline.c                             |   20 +-
>  block/partitions/ibm.c                          |    2 +-
>  drivers/ata/libata-scsi.c                       |    4 +-
>  drivers/block/Kconfig                           |   10 +-
>  drivers/block/Makefile                          |    4 +-
>  drivers/block/amiflop.c                         |   10 +-
>  drivers/block/aoe/aoeblk.c                      |    4 +-
>  drivers/block/aoe/aoemain.c                     |    2 +-
>  drivers/block/brd.c                             |   75 +-
>  drivers/block/floppy.c                          |   59 +-
>  drivers/block/mtip32xx/mtip32xx.c               |    6 +-
>  drivers/block/nbd.c                             |   10 +-
>  drivers/block/null_blk/main.c                   |    2 +-
>  drivers/block/rbd.c                             |    2 +-
>  drivers/block/rnbd/rnbd-clt.c                   |    6 +-
>  drivers/block/rnull.rs                          |   80 --
>  drivers/block/rnull/Kconfig                     |   13 +
>  drivers/block/rnull/Makefile                    |    3 +
>  drivers/block/rnull/configfs.rs                 |  262 ++++
>  drivers/block/rnull/rnull.rs                    |  104 ++
>  drivers/block/sunvdc.c                          |    7 +-
>  drivers/block/swim.c                            |    4 +-
>  drivers/block/ublk_drv.c                        |  236 ++--
>  drivers/block/virtio_blk.c                      |    8 +-
>  drivers/block/xen-blkfront.c                    |    4 +-
>  drivers/block/zram/zram_drv.c                   |    2 +-
>  drivers/md/Kconfig                              |   29 +
>  drivers/md/Makefile                             |    4 +-
>  drivers/md/bcache/debug.c                       |    3 +-
>  drivers/md/bcache/io.c                          |    3 +-
>  drivers/md/bcache/journal.c                     |    2 +-
>  drivers/md/bcache/movinggc.c                    |    8 +-
>  drivers/md/bcache/super.c                       |    2 +-
>  drivers/md/bcache/writeback.c                   |    8 +-
>  drivers/md/dm-bufio.c                           |    2 +-
>  drivers/md/dm-flakey.c                          |    2 +-
>  drivers/md/dm-raid.c                            |   18 +-
>  drivers/md/dm-vdo/vio.c                         |    2 +-
>  drivers/md/dm.c                                 |    4 +-
>  drivers/md/md-bitmap.c                          |   89 +-
>  drivers/md/md-bitmap.h                          |  107 +-
>  drivers/md/md-cluster.c                         |    2 +-
>  drivers/md/md-linear.c                          |   14 +-
>  drivers/md/md-llbitmap.c                        | 1626 +++++++++++++++++=
++++++
>  drivers/md/md.c                                 |  382 +++++-
>  drivers/md/md.h                                 |   24 +-
>  drivers/md/raid0.c                              |   30 +-
>  drivers/md/raid1-10.c                           |    2 +-
>  drivers/md/raid1.c                              |  119 +-
>  drivers/md/raid1.h                              |    4 +-
>  drivers/md/raid10.c                             |  107 +-
>  drivers/md/raid10.h                             |    2 +
>  drivers/md/raid5.c                              |   74 +-
>  drivers/memstick/core/ms_block.c                |    4 +-
>  drivers/memstick/core/mspro_block.c             |    4 +-
>  drivers/message/fusion/mptscsih.c               |    2 +-
>  drivers/message/fusion/mptscsih.h               |    2 +-
>  drivers/mmc/core/block.c                        |    4 +-
>  drivers/mtd/mtd_blkdevs.c                       |    4 +-
>  drivers/mtd/ubi/block.c                         |    4 +-
>  drivers/nvdimm/btt.c                            |    4 +-
>  drivers/nvme/common/auth.c                      |   86 +-
>  drivers/nvme/host/auth.c                        |    5 +-
>  drivers/nvme/host/core.c                        |   23 +-
>  drivers/nvme/host/fc.c                          |   10 +-
>  drivers/nvme/host/ioctl.c                       |    5 -
>  drivers/nvme/host/nvme.h                        |    2 +-
>  drivers/nvme/host/pci.c                         |  184 +--
>  drivers/nvme/host/tcp.c                         |    3 +
>  drivers/nvme/target/core.c                      |   15 +-
>  drivers/nvme/target/fc.c                        |   35 +-
>  drivers/nvme/target/fcloop.c                    |    8 +-
>  drivers/s390/block/dasd.c                       |   24 +-
>  drivers/scsi/3w-9xxx.c                          |    2 +-
>  drivers/scsi/3w-sas.c                           |    2 +-
>  drivers/scsi/3w-xxxx.c                          |    2 +-
>  drivers/scsi/BusLogic.c                         |    4 +-
>  drivers/scsi/BusLogic.h                         |    2 +-
>  drivers/scsi/aacraid/linit.c                    |    6 +-
>  drivers/scsi/advansys.c                         |    2 +-
>  drivers/scsi/aha152x.c                          |    4 +-
>  drivers/scsi/aha1542.c                          |    2 +-
>  drivers/scsi/aha1740.c                          |    2 +-
>  drivers/scsi/aic7xxx/aic79xx_osm.c              |    4 +-
>  drivers/scsi/aic7xxx/aic7xxx_osm.c              |    4 +-
>  drivers/scsi/arcmsr/arcmsr_hba.c                |    6 +-
>  drivers/scsi/atp870u.c                          |    2 +-
>  drivers/scsi/fdomain.c                          |    4 +-
>  drivers/scsi/imm.c                              |    2 +-
>  drivers/scsi/initio.c                           |    4 +-
>  drivers/scsi/ipr.c                              |    8 +-
>  drivers/scsi/ips.c                              |    2 +-
>  drivers/scsi/ips.h                              |    2 +-
>  drivers/scsi/libsas/sas_scsi_host.c             |    2 +-
>  drivers/scsi/megaraid.c                         |    4 +-
>  drivers/scsi/megaraid.h                         |    2 +-
>  drivers/scsi/megaraid/megaraid_sas_base.c       |    4 +-
>  drivers/scsi/mpi3mr/mpi3mr_os.c                 |    4 +-
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c            |    4 +-
>  drivers/scsi/mvumi.c                            |    2 +-
>  drivers/scsi/myrb.c                             |    2 +-
>  drivers/scsi/pcmcia/sym53c500_cs.c              |    2 +-
>  drivers/scsi/ppa.c                              |    2 +-
>  drivers/scsi/qla1280.c                          |    2 +-
>  drivers/scsi/qlogicfas408.c                     |    2 +-
>  drivers/scsi/qlogicfas408.h                     |    2 +-
>  drivers/scsi/scsicam.c                          |   16 +-
>  drivers/scsi/sd.c                               |    8 +-
>  drivers/scsi/stex.c                             |    2 +-
>  drivers/scsi/storvsc_drv.c                      |    2 +-
>  drivers/scsi/wd719x.c                           |    2 +-
>  drivers/target/target_core_pscsi.c              |    2 +-
>  fs/bcachefs/btree_io.c                          |    2 +-
>  fs/bcachefs/data_update.h                       |    1 -
>  fs/bcachefs/journal.c                           |    6 +-
>  fs/bcachefs/journal_io.c                        |    2 +-
>  fs/bcachefs/super-io.c                          |    2 +-
>  fs/iomap/direct-io.c                            |    5 +-
>  fs/squashfs/block.c                             |    2 +-
>  include/linux/bio-integrity.h                   |    1 +
>  include/linux/bio.h                             |   18 +-
>  include/linux/blk-integrity.h                   |   32 +
>  include/linux/blk-mq-dma.h                      |   25 +-
>  include/linux/blk-mq.h                          |    4 +
>  include/linux/blk_types.h                       |   19 +-
>  include/linux/blkdev.h                          |   26 +-
>  include/linux/libata.h                          |    2 +-
>  include/linux/uio.h                             |    2 -
>  include/scsi/libsas.h                           |    2 +-
>  include/scsi/scsi_host.h                        |    2 +-
>  include/scsi/scsicam.h                          |    7 +-
>  lib/iov_iter.c                                  |   95 --
>  rust/kernel/block.rs                            |   13 +
>  rust/kernel/block/mq.rs                         |   14 +-
>  rust/kernel/block/mq/gen_disk.rs                |   54 +-
>  rust/kernel/block/mq/operations.rs              |   65 +-
>  rust/kernel/block/mq/raw_writer.rs              |   55 -
>  rust/kernel/block/mq/request.rs                 |   21 +-
>  rust/kernel/configfs.rs                         |    2 +
>  rust/kernel/str.rs                              |  162 ++-
>  samples/rust/rust_configfs.rs                   |    2 +-
>  tools/testing/selftests/ublk/Makefile           |    1 +
>  tools/testing/selftests/ublk/kublk.c            |   32 +-
>  tools/testing/selftests/ublk/test_generic_01.sh |    4 +
>  tools/testing/selftests/ublk/test_generic_02.sh |    4 +
>  tools/testing/selftests/ublk/test_generic_12.sh |    4 +
>  tools/testing/selftests/ublk/test_generic_13.sh |   20 +
>  tools/testing/selftests/ublk/test_null_01.sh    |    4 +
>  tools/testing/selftests/ublk/test_null_02.sh    |    4 +
>  tools/testing/selftests/ublk/test_stress_05.sh  |    4 +
>  195 files changed, 4539 insertions(+), 1833 deletions(-)
>  delete mode 100644 drivers/block/rnull.rs
>  create mode 100644 drivers/block/rnull/Kconfig
>  create mode 100644 drivers/block/rnull/Makefile
>  create mode 100644 drivers/block/rnull/configfs.rs
>  create mode 100644 drivers/block/rnull/rnull.rs
>  create mode 100644 drivers/md/md-llbitmap.c
>  delete mode 100644 rust/kernel/block/mq/raw_writer.rs
>  create mode 100755 tools/testing/selftests/ublk/test_generic_13.sh
>
> --
> Jens Axboe
>
>

