Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05ED31DF31
	for <lists+linux-block@lfdr.de>; Wed, 17 Feb 2021 19:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhBQSoG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 17 Feb 2021 13:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhBQSoD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Feb 2021 13:44:03 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEA3C061574
        for <linux-block@vger.kernel.org>; Wed, 17 Feb 2021 10:43:23 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id o15so12210851ilt.6
        for <linux-block@vger.kernel.org>; Wed, 17 Feb 2021 10:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=jVZVNyH1ZBF6CH3yd+kaujLRjcOSHmonDtEawsnc4DQ=;
        b=tfXyXKUOjIXoeXCb9nIQxwICHqdOyjrX6S9LNK4JP96j1JKMMiNq/2xh3mg/moRQNX
         A3M5PcQDqlAxSAdZSO0q0zarCXPQK4eNHA9H6IuhQpz5S5YEZUSScVANJEvphN89P0bz
         HsU8NDlCPFQHLDGcSBunGv7JpgGHJ4pb7PfhubS49OlldeR+3TWaUFl4pDXr8muQ9Hl/
         fNy3+dv0o8y3W3SPsxbM7o578jMIbOOpZxpgqsz4f4jIr7ZdXGdK0btTJdjSgtHDy2H3
         p4/rRXdSeAPR7wnsCT4c6WQulhBfBwQtjgzD9tCxCGXfJ9FT/hwUnNQXJtJANOSDEdsx
         Ddqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=jVZVNyH1ZBF6CH3yd+kaujLRjcOSHmonDtEawsnc4DQ=;
        b=Z9y1phboleg1izD52SN+SQVT0rJrBR/5+o9uUFVhobdXgqr91uw6wKz6yqtOqrEk/p
         aIVQ+VTNQvv9zCNXd0QbYrgAaLmfgCcPek0lBZw9UVwaPalbIl9UEVcCMIkyQtdj/W7k
         E+fDohlhJj+23xemQH5hVmoONdSEs5eIU0lwXBWPBiBx2AV+KT5MBWZttni498xa6kx9
         Z4zETXZUSqcFEQgTrPGK8fByA7fXuIW80DzHMgCs/f0G7g6PXEwVL8dDZ0piGtWODxBw
         8Gdd4GEUS/LgeFSzxYU59Zp0WpDqxtwWUBSkQLgf1xjG6+rfv3X+dMDVRjcnQMrQ7APY
         vZ+w==
X-Gm-Message-State: AOAM531i+hK1IVD6fZNjoUiW5cbw0LJbzZ8PmOHoZstMXpocnjJlhJba
        xX1b/ToVH1/wlmaOkPfHFRxRlKbFkEsh9OoC
X-Google-Smtp-Source: ABdhPJzW177FrGNAbVl4m/JYY9waMweODaBYtI0HnrZrzyxq2WACtXfoMbTZWfCKjT3FdvZCnNw4lA==
X-Received: by 2002:a92:cb4c:: with SMTP id f12mr366373ilq.169.1613587402595;
        Wed, 17 Feb 2021 10:43:22 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s6sm1509770ild.45.2021.02.17.10.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 10:43:22 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring changes for 5.12-rc
Message-ID: <6626be56-907e-83fe-2fbb-45f880261fd8@kernel.dk>
Date:   Wed, 17 Feb 2021 11:43:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Highlights from this cycles are things like request recycling and
task_work optimizations, which net us anywhere from 10-20% of speedups
on workloads that mostly are inline. This work was originall done to put
io_uring under memcg, which adds considerable overhead. But it's a
really nice win as well. Also worth highlighting is the LOOKUP_CACHED
work in the VFS, and using it in io_uring. Greatly speeds up the fast
path for file opens.

Note that this branch depends on Al's work.namei pull request that he
sent in earlier.

- Put io_uring under memcg protection. We accounted just the rings
  themselves under rlimit memlock before, now we account everything.

- Request cache recycling, persistent across invocations (Pavel, me)

- First part of a cleanup/improvement to buffer registration (Bijan)

- SQPOLL fixes (Hao)

- File registration NULL pointer fixup (Dan)

- LOOKUP_CACHED support for io_uring

- Disable /proc/thread-self/ for io_uring, like we do for /proc/self

- Add Pavel to the io_uring MAINTAINERS entry

- Tons of code cleanups and optimizations (Pavel)

- Support for skip entries in file registration (Noah)

Please pull!


The following changes since commit 1048ba83fb1c00cd24172e23e8263972f6b5d9ac:

  Linux 5.11-rc6 (2021-01-31 13:50:09 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.12/io_uring-2021-02-17

for you to fetch changes up to 0b81e80c813f92520667c872d499a2dba8377be6:

  io_uring: tctx->task_lock should be IRQ safe (2021-02-16 11:11:20 -0700)

----------------------------------------------------------------
for-5.12/io_uring-2021-02-17

----------------------------------------------------------------
Bijan Mottahedeh (10):
      io_uring: modularize io_sqe_buffer_register
      io_uring: modularize io_sqe_buffers_register
      io_uring: rename file related variables to rsrc
      io_uring: generalize io_queue_rsrc_removal
      io_uring: separate ref_list from fixed_rsrc_data
      io_uring: add rsrc_ref locking routines
      io_uring: split alloc_fixed_file_ref_node
      io_uring: create common fixed_rsrc_ref_node handling routines
      io_uring: create common fixed_rsrc_data allocation routines
      io_uring: make percpu_ref_release names consistent

Colin Ian King (1):
      io_uring: remove redundant initialization of variable ret

Dan Carpenter (1):
      io_uring: Fix NULL dereference in error in io_sqe_files_register()

Hao Xu (2):
      io_uring: check kthread parked flag before sqthread goes to sleep
      io_uring: fix possible deadlock in io_uring_poll

Jens Axboe (19):
      Merge branch 'work.namei' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs into for-5.12/io_uring
      io_uring: enable LOOKUP_CACHED path resolution for filename lookups
      fs: provide locked helper variant of close_fd_get_file()
      io_uring: get rid of intermediate IORING_OP_CLOSE stage
      io_uring/io-wq: kill off now unused IO_WQ_WORK_NO_CANCEL
      io_uring: use persistent request cache
      io_uring: provide FIFO ordering for task_work
      io_uring: enable req cache for task_work items
      io_uring: enable req cache for IRQ driven IO
      io_uring: enable kmemcg account for io_uring requests
      io_uring: place ring SQ/CQ arrays under memcg memory limits
      io_uring: assign file_slot prior to calling io_sqe_file_register()
      io_uring: move submit side state closer in the ring
      io-wq: clear out worker ->fs and ->files
      io_uring: allow task match to be passed to io_req_cache_free()
      io_uring: add helper to free all request caches
      io_uring: kill cached requests from exiting task closing the ring
      proc: don't allow async path resolution of /proc/thread-self components
      io_uring: tctx->task_lock should be IRQ safe

Pavel Begunkov (69):
      io_uring: split ref_node alloc and init
      io_uring: optimise io_rw_reissue()
      io_uring: refactor io_resubmit_prep()
      io_uring: cleanup personalities under uring_lock
      io_uring: inline io_async_submit()
      io_uring: inline __io_commit_cqring()
      io_uring: further deduplicate #CQ events calc
      io_uring: simplify io_alloc_req()
      io_uring: remove __io_state_file_put
      io_uring: deduplicate failing task_work_add
      io_uring: add a helper timeout mode calculation
      io_uring: help inlining of io_req_complete()
      io_uring: don't flush CQEs deep down the stack
      io_uring: save atomic dec for inline executed reqs
      io_uring: ensure only sqo_task has file notes
      io_uring: consolidate putting reqs task
      io_uring: cleanup files_update looping
      MAINTAINERS: update io_uring section
      io_uring: fix inconsistent lock state
      io_uring: kill not used needs_file_no_error
      io_uring: inline io_req_drop_files()
      io_uring: remove work flags after cleanup
      io_uring: deduplicate adding to REQ_F_INFLIGHT
      io_uring: simplify do_read return parsing
      io_uring: deduplicate core cancellations sequence
      io_uring: refactor scheduling in io_cqring_wait
      io_uring: refactor io_cqring_wait
      io_uring: refactor io_read for unsupported nowait
      io_uring: further simplify do_read error parsing
      io_uring: let io_setup_async_rw take care of iovec
      io_uring: don't forget to adjust io_size
      io_uring: inline io_read()'s iovec freeing
      io_uring: highlight read-retry loop
      io_uring: treat NONBLOCK and RWF_NOWAIT similarly
      io_uring: io_import_iovec return type cleanup
      io_uring: deduplicate file table slot calculation
      io_uring/io-wq: return 2-step work swap scheme
      io_uring: set msg_name on msg fixup
      io_uring: clean iov usage for recvmsg buf select
      io_uring: refactor sendmsg/recvmsg iov managing
      io_uring: cleanup up cancel SQPOLL reqs across exec
      io_uring: replace force_nonblock with flags
      io_uring: make op handlers always take issue flags
      io_uring: don't propagate io_comp_state
      io_uring: don't keep submit_state on stack
      io_uring: remove ctx from comp_state
      io_uring: don't reinit submit state every time
      io_uring: replace list with array for compl batch
      io_uring: submit-completion free batching
      io_uring: remove fallback_req
      io_uring: count ctx refs separately from reqs
      io_uring: persistent req cache
      io_uring: feed reqs back into alloc cache
      io_uring: take comp_state from ctx
      io_uring: defer flushing cached reqs
      io_uring: unpark SQPOLL thread for cancelation
      io_uring: clean up io_req_free_batch_finish()
      io_uring: simplify iopoll reissuing
      io_uring: move res check out of io_rw_reissue()
      io_uring: inline io_complete_rw_common()
      io_uring: take compl state from submit state
      io_uring: optimise out unlikely link queue
      io_uring: optimise SQPOLL mm/files grabbing
      io_uring: don't duplicate io_req_task_queue()
      io_uring: save ctx put/get for task_work submit
      io_uring: don't split out consume out of SQE get
      io_uring: don't check PF_EXITING from syscall
      io_uring: clean io_req_find_next() fast check
      io_uring: optimise io_init_req() flags setting

Yejune Deng (1):
      io_uring: simplify io_remove_personalities()

noah (1):
      io_uring: Add skip option for __io_sqe_files_update

 MAINTAINERS                   |    5 +
 fs/file.c                     |   36 +-
 fs/internal.h                 |    1 +
 fs/io-wq.c                    |   31 +-
 fs/io-wq.h                    |   14 +-
 fs/io_uring.c                 | 2658 +++++++++++++++++----------------
 fs/namei.c                    |    8 +-
 fs/proc/self.c                |    2 +-
 fs/proc/thread_self.c         |    7 +
 include/linux/io_uring.h      |   14 +
 include/uapi/linux/io_uring.h |   10 +
 11 files changed, 1435 insertions(+), 1351 deletions(-)

-- 
Jens Axboe

