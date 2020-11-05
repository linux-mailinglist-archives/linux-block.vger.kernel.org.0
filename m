Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA8D2A8943
	for <lists+linux-block@lfdr.de>; Thu,  5 Nov 2020 22:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbgKEVw3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 5 Nov 2020 16:52:29 -0500
Received: from smtp.infotech.no ([82.134.31.41]:34340 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731508AbgKEVw2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Nov 2020 16:52:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 786CB20425B;
        Thu,  5 Nov 2020 22:52:27 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t8B9R1lbAKY3; Thu,  5 Nov 2020 22:52:20 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        by smtp.infotech.no (Postfix) with ESMTPA id B0EA12040E4;
        Thu,  5 Nov 2020 22:52:19 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     axboe@kernel.dk, martin.petersen@oracle.com, bostroesser@gmail.com,
        bvanassche@acm.org, ddiss@suse.de
Subject: [PATCH v4 0/4] scatterlist: add new capabilities
Date:   Thu,  5 Nov 2020 16:52:12 -0500
Message-Id: <20201105215216.23304-1-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Scatter-gather lists (sgl_s) are frequently used as data carriers in
the block layer. For example the SCSI and NVMe subsystems interchange
data with the block layer using sgl_s. The sgl API is declared in
<linux/scatterlist.h>

The author has extended these transient sgl use cases to a store (i.e.
a ramdisk) in the scsi_debug driver. Other new potential uses of sgl_s
could be for the target subsystem. When this extra step is taken, the
need to copy between sgl_s becomes apparent. The patchset adds
sgl_copy_sgl() and two other sgl operations.

The existing sgl_alloc_order() function can be seen as a replacement
for vmalloc() for large, long-term allocations.  For what seems like
no good reason, sgl_alloc_order() currently restricts its total
allocation to less than or equal to 4 GiB. vmalloc() has no such
restriction.

Changes since v3 [posted 20201019]:
  - re-instate check on integer overflow of nent calculation in
    sgl_alloc_order(). Do it in such a way as to not limit the
    overall sgl size to 4  GiB
  - introduce sgl_compare_sgl_idx() helper function that, if
    requested and if a miscompare is detected, will yield the byte
    index of the first miscompare.
  - add Reviewed-by tags from Bodo Stroesser
  - rebase on lk 5.10.0-rc2 [was on lk 5.9.0]

Changes since v2 [posted 20201018]:
  - remove unneeded lines from sgl_memset() definition.
  - change sg_zero_buffer() to call sgl_memset() as the former
    is a subset.

Changes since v1 [posted 20201016]:
  - Bodo Stroesser pointed out a problem with the nesting of
    kmap_atomic() [called via sg_miter_next()] and kunmap_atomic()
    calls [called via sg_miter_stop()] and proposed a solution that
    simplifies the previous code.

  - the new implementation of the three functions has shorter periods
    when pre-emption is disabled (but has more them). This should
    make operations on large sgl_s more pre-emption "friendly" with
    a relatively small performance hit.

  - sgl_memset return type changed from void to size_t and is the
    number of bytes actually (over)written. That number is needed
    anyway internally so may as well return it as it may be useful to
    the caller.

This patchset is against lk 5.10.0-rc2

Douglas Gilbert (4):
  sgl_alloc_order: remove 4 GiB limit, sgl_free() warning
  scatterlist: add sgl_copy_sgl() function
  scatterlist: add sgl_compare_sgl() function
  scatterlist: add sgl_memset()

 include/linux/scatterlist.h |  16 +++
 lib/scatterlist.c           | 244 +++++++++++++++++++++++++++++++++---
 2 files changed, 243 insertions(+), 17 deletions(-)

-- 
2.25.1

