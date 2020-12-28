Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FEF2E6CA7
	for <lists+linux-block@lfdr.de>; Tue, 29 Dec 2020 01:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgL2AAR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 28 Dec 2020 19:00:17 -0500
Received: from smtp.infotech.no ([82.134.31.41]:59799 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbgL2AAR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Dec 2020 19:00:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 34DD4204271;
        Tue, 29 Dec 2020 00:50:06 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JvVK8k-3kqyi; Tue, 29 Dec 2020 00:49:59 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        by smtp.infotech.no (Postfix) with ESMTPA id 47D3C204193;
        Tue, 29 Dec 2020 00:49:58 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com,
        bostroesser@gmail.com, bvanassche@acm.org, ddiss@suse.de
Subject: [PATCH v5 0/4] scatterlist: add new capabilities
Date:   Mon, 28 Dec 2020 18:49:51 -0500
Message-Id: <20201228234955.190858-1-dgilbert@interlog.com>
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
sgl_copy_sgl(), sgl_compare_sgl() and sgl_memset().

The existing sgl_alloc_order() function can be seen as a replacement
for vmalloc() for large, long-term allocations.  For what seems like
no good reason, sgl_alloc_order() currently restricts its total
allocation to less than or equal to 4 GiB. vmalloc() has no such
restriction.

Changes since v3 [posted 20201105]:
  - rebase on lk 5.11.0-rc2

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

