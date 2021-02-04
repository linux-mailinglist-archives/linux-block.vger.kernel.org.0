Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EC230B716
	for <lists+linux-block@lfdr.de>; Tue,  2 Feb 2021 06:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhBBFda (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Feb 2021 00:33:30 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39990 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbhBBFdQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612243995; x=1643779995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PDOc6pto7ajk+QO8i/HkhQk2jPcRHdNdXErGmveZ6x0=;
  b=Sv4zENHaE7m2AcEaeJJ9xPM6v7tjkS2PCmcb8+xf37AN5rpUCJ6lioKp
   XfAZonEmZd6aL2BgIZbe4AEePtHm4TenxVOV2HLIxvRaDwrfKCAMea1wo
   HFu30R4EzcTdbt/VMAPrQragRr77krLlwOG/wRpOIw+uwqFNkJd8CHhxF
   9v24OTv4Drdeymr089Zynw/bG0eUrq8smFUhTinU/jDvys5hgWEYG4URG
   zRI8+6jLBt8LU13I9wUOgA/M/JK24lESZDeoFY4D9I6fsVF4AZ33thMBB
   /nYHFe+qERO+nc+T3N04ykxvr7YJ+d+95U2U1Opjxgkx2NNhCVcoeAQR6
   A==;
IronPort-SDR: LkCcYA4IRQXcZ7x7wXcfW/iK3slCRF8FFuXh57O42oM1DhT8zpQSl5K7JBWfDRUBhNPfPx47ct
 d6pLXfnyeJoELVxaZGZSVdJwzQ2e5wGZT+8XT+NHYRsiyDdgfwufa0TyETFdC9v5G+ADTVOf8z
 0iPHYLFR6EBj1YhI90NOCIz0jz1CQybS+Ezq885erCDx9CoFvPVZthxFL9iXMWCYY5jUIKRj5U
 PBIzROnSQ/6rhk9diuSG9+CNXWONZ7WC3z8+OFiupPmoUQyUG3XdFHL/XkJOCX7SPB/LniYKUd
 nK4=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="158885054"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:27:01 +0800
IronPort-SDR: pF1XYSGLLmW/nPw1jYN/tdUmRoPGbqVJTATrxXUxgexVDMS5J8JgWG2L/zadRQf3Y+2S03xPYi
 d9tHzuALAXGsUfBfXU4rut9LyH8sqBs5iLhdGQ2SU6IhkdeL8MVcZJ0NUYuUHW8iwYxnCowQFR
 RyBUhzPMFiMypq96uWwABdHnq112Jj6djqNcH/3hzJiCzqeBgw645hm28lJ9pTKmIlAZOv96hP
 MX5FhAsz4+GoDPa4wC6a1/EIj3YLUqag8w5VRiJ2cj0lIzxGnQCcfP75gpx/9bFIQgXHsL5iPk
 2Y5MSjYrsN7T/q434Vu7gd0o
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:09:10 -0800
IronPort-SDR: URNVehvRYGZu9DWDKa5uFmNg52WQLyJtkPxafm2QH7oster0rZiA1hag/CmkG340MUl6K5c59z
 iOMWG5oHCdip9tw6F8ujVd8PfeHskeeSsENQIm9WzKz7k6i3mPDE8VPW7JYo1BNWN1yTgiTLqb
 5LlipbJHvTn1Pg+Lf18eM44VrsBIWG+m9Lfdytx9wti0YKXbEHK3o09qs7Y7Drm64uuL3BGErk
 5n2OA9tR2H+Vvl9lUexEl8TYBjeR1AiXRSjbscIweUv/T32m3RYnwGEZvMdHD5kem3/ncFyJs9
 Snc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Feb 2021 21:27:01 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        akpm@linux-foundation.org, aravind.ramesh@wdc.com,
        joshi.k@samsung.com, niklas.cassel@wdc.com, hare@suse.de,
        colyli@suse.de, tj@kernel.org, rdunlap@infradead.org, jack@suse.cz,
        hch@lst.de
Subject: [PATCH 0/7] blktrace: few clenaup
Date:   Mon,  1 Feb 2021 21:25:37 -0800
Message-Id: <20210202052544.4108-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

These are few cleanups for the block trace.

Below is the test log on latest linux-block/for-next.

Last two patches are needed to for testing.

-ck

Chaitanya Kulkarni (7):
  block: remove superfluous param in blk_fill_rwbs()
  blktrace: add blk_fill_rwbs documentation comment
  blktrace: fix blk_rq_issue documentation
  blktrace: fix blk_rq_merge documentation
  block: get rid of the trace rq insert wrapper
  null_blk: allow disacrd on non-membacked mode
  null_blk: add module param queue bounce limit

 block/bfq-iosched.c               |  4 +++-
 block/blk-mq-sched.c              |  6 ------
 block/blk-mq-sched.h              |  1 -
 block/kyber-iosched.c             |  4 +++-
 block/mq-deadline.c               |  4 +++-
 drivers/block/null_blk/main.c     | 31 +++++++++++++++++++++++++------
 drivers/block/null_blk/null_blk.h |  1 +
 include/linux/blktrace_api.h      |  2 +-
 include/trace/events/bcache.h     | 10 +++++-----
 include/trace/events/block.h      | 20 ++++++++++----------
 kernel/trace/blktrace.c           | 13 ++++++++++++-
 11 files changed, 63 insertions(+), 33 deletions(-)

Patch 1 Testing for uncommon tracepoints such as split, requeue :-

Merge Tracepoint :-

252,0    0        1     0.000000000  1096  Q  WS 0 + 8 [systemd-udevd]
252,0    0        2     0.000014217  1096  G  WS 0 + 8 [systemd-udevd]
252,0    0        3     0.000019467  1096  Q  WS 8 + 8 [systemd-udevd]
*252,0    0        4     0.000021200  1096  M  WS 8 + 8 [systemd-udevd]*
252,0    0        5     0.000025568  1096  Q  WS 16 + 8 [systemd-udevd]
252,0    0        6     0.000026540  1096  M  WS 16 + 8 [systemd-udevd]
252,0    0        7     0.000030407  1096  Q  WS 24 + 8 [systemd-udevd]
252,0    0        8     0.000031359  1096  M  WS 24 + 8 [systemd-udevd]
252,0    0        9     0.000035056  1096  Q  WS 32 + 8 [systemd-udevd]
252,0    0       10     0.000036008  1096  M  WS 32 + 8 [systemd-udevd]
252,0    0       11     0.000039234  1096  Q  WS 40 + 8 [systemd-udevd]
252,0    0       12     0.000040165  1096  M  WS 40 + 8 [systemd-udevd]
252,0    0       13     0.000043371  1096  Q  WS 48 + 8 [systemd-udevd]
252,0    0       14     0.000044293  1096  M  WS 48 + 8 [systemd-udevd]
252,0    0       15     0.000047980  1096  Q  WS 56 + 8 [systemd-udevd]
252,0    0       16     0.000048902  1096  M  WS 56 + 8 [systemd-udevd]
252,0    0       17     0.000052068  1096  Q  WS 64 + 8 [systemd-udevd]
252,0    0       18     0.000052999  1096  M  WS 64 + 8 [systemd-udevd]
252,0    0       19     0.000056486  1096  Q  WS 72 + 8 [systemd-udevd]
252,0    0       20     0.000057428  1096  M  WS 72 + 8 [systemd-udevd]
252,0    0       21     0.000061896  1096  I  WS 0 + 80 [systemd-udevd]
252,0    0       22     0.000082194  1096  D  WS 0 + 80 [systemd-udevd]
252,0    0       23     0.000107782    10  C  WS 0 + 80 [0]

ReQueue Tracepoint :-

252,0   29        1     0.000000000  6215  Q  WS 0 + 8 [dd]
252,0   29        2     0.000010109  6215  G  WS 0 + 8 [dd]
252,0   29        3     0.000014577  6215  I  WS 0 + 8 [dd]
252,0   29        4     0.000040476   807  D  WS 0 + 8 [kworker/29:1H]
*252,0   29        5     0.000043151   807  R  WS 0 + 8 [0]*
252,0   29        6     0.000049142   807  D  WS 0 + 8 [kworker/29:1H]
252,0   29        7     0.000050244   807  R  WS 0 + 8 [0]
252,0   29        8     0.000205866   807  I  WS 0 + 8 [kworker/29:1H]
252,0   29        9     0.000249157   807  D  WS 0 + 8 [kworker/29:1H]
252,0   29       10     0.000250379   807  R  WS 0 + 8 [0]
252,0   29       11     0.004154922   807  D  WS 0 + 8 [kworker/29:1H]
252,0   29       12     0.004157446   807  R  WS 0 + 8 [0]
252,0   29       13     0.004164249   807  I  WS 0 + 8 [kworker/29:1H]
252,0   29       14     0.004166974   807  D  WS 0 + 8 [kworker/29:1H]
252,0   29       15     0.004168497   807  R  WS 0 + 8 [0]
252,0   29       16     0.008204045   807  D  WS 0 + 8 [kworker/29:1H]
252,0   29       17     0.008208584   807  R  WS 0 + 8 [0]
252,0   29       18     0.008220506   807  I  WS 0 + 8 [kworker/29:1H]
252,0   29       19     0.008225405   807  D  WS 0 + 8 [kworker/29:1H]
252,0   29       20     0.008251003   157  C  WS 0 + 8 [0]
252,0   29       21     0.008309343  6215  Q  WS 8 + 8 [dd]
252,0   29       22     0.008314632  6215  G  WS 8 + 8 [dd]
252,0   29       23     0.008319391  6215  I  WS 8 + 8 [dd]
252,0   29       24     0.008339239   807  D  WS 8 + 8 [kworker/29:1H]
252,0   29       25     0.008341773   807  R  WS 8 + 8 [0]
252,0   29       26     0.008349738   807  D  WS 8 + 8 [kworker/29:1H]
252,0   29       27     0.008351862   807  R  WS 8 + 8 [0]
252,0   29       28     0.008359607   807  I  WS 8 + 8 [kworker/29:1H]
252,0   29       29     0.008362873   807  D  WS 8 + 8 [kworker/29:1H]
252,0   29       30     0.008376328   157  C  WS 8 + 8 [0]

Split  Tracepoint :-

252,0   29        1     0.000000000  5790  Q  DS 0 + 80 [blkdiscard]
*252,0   29        2     0.000003005  5790  X  DS 0 / 4 [blkdiscard]*
252,0   29        3     0.000008506  5790  G  DS 0 + 4 [blkdiscard]
252,0   29        4     0.000010610  5790  X  DS 4 / 8 [blkdiscard]
252,0   29        5     0.000012062  5790  G  DS 4 + 4 [blkdiscard]
252,0   29        6     0.000013555  5790  X  DS 8 / 12 [blkdiscard]
252,0   29        7     0.000014908  5790  G  DS 8 + 4 [blkdiscard]
252,0   29        8     0.000017062  5790  X  DS 12 / 16 [blkdiscard]
252,0   29        9     0.000018384  5790  G  DS 12 + 4 [blkdiscard]
252,0   29       10     0.000019817  5790  X  DS 16 / 20 [blkdiscard]
252,0   29       11     0.000023774  5790  I  DS 0 + 4 [blkdiscard]
252,0   29       12     0.000024556  5790  I  DS 4 + 4 [blkdiscard]
252,0   29       13     0.000025177  5790  I  DS 8 + 4 [blkdiscard]
252,0   29       14     0.000025758  5790  I  DS 12 + 4 [blkdiscard]
252,0   29       15     0.000050224   807  D  DS 0 + 4 [kworker/29:1H]
252,0   29       16     0.000056275   807  D  DS 4 + 4 [kworker/29:1H]
252,0   29       17     0.000075712   807  D  DS 8 + 4 [kworker/29:1H]
252,0   29       18     0.000076844   807  D  DS 12 + 4 [kworker/29:1H]
252,0   29       19     0.000085310   157  C  DS 0 + 4 [0]
252,0   29       20     0.000089337   157  C  DS 0 + 8 [0]
252,0   29       21     0.000096400   157  C  DS 0 + 12 [0]
252,0   29       22     0.000097913   157  C  DS 0 + 16 [0]


Patch 5 Test log Make sure rq insert works with each sched :-

# ./trace_cleanup_blktrace.sh 
8c8f1a45899a (HEAD -> for-next) null_blk: add module param queue bounce limit
37f33071ed74 null_blk: allow disacrd on non-membacked mode
19af33d82a86 block: get rid of the trace rq insert wrapper
4234aaeef927 blktrace: fix blk_rq_merge documentation
7b6e753dc655 blktrace: fix blk_rq_issue documentation
42c251311549 blktrace: add blk_fill_rwbs documentation comment
ee2ca65cac3a block: remove superfluous param in blk_fill_rwbs()
5.11.0-rc6blk+
####################     kyber     #####################
mq-deadline [kyber] none
5+0 records in
5+0 records out
20480 bytes (20 kB) copied, 0.000729117 s, 28.1 MB/s
####################     bfq     #####################
mq-deadline kyber [bfq] none
5+0 records in
5+0 records out
20480 bytes (20 kB) copied, 0.000329207 s, 62.2 MB/s
####################     mq-deadline     #####################
[mq-deadline] kyber bfq none
5+0 records in
5+0 records out
20480 bytes (20 kB) copied, 0.000333576 s, 61.4 MB/s
####################     none     #####################
[none] mq-deadline kyber bfq 
5+0 records in
5+0 records out
20480 bytes (20 kB) copied, 0.000348243 s, 58.8 MB/s
####################     kyber     #####################
252,0   45        1     0.000000000  1096  Q  WS 0 + 8 [systemd-udevd]
252,0   45        2     0.000011121  1096  B  WS 0 + 8 [systemd-udevd]
252,0   45        3     0.000162665  1096  G  WS 0 + 8 [systemd-udevd]
252,0   45        4     0.000185077  1096  Q  WS 8 + 8 [systemd-udevd]
252,0   45        5     0.000195346  1096  B  WS 8 + 8 [systemd-udevd]
252,0   45        6     0.000198382  1096  M  WS 8 + 8 [systemd-udevd]
252,0   45        7     0.000210565  1096  Q  WS 16 + 8 [systemd-udevd]
252,0   45        8     0.000218119  1096  B  WS 16 + 8 [systemd-udevd]
252,0   45        9     0.000219421  1096  M  WS 16 + 8 [systemd-udevd]
252,0   45       10     0.000226925  1096  Q  WS 24 + 8 [systemd-udevd]
252,0   45       11     0.000232135  1096  B  WS 24 + 8 [systemd-udevd]
252,0   45       12     0.000233297  1096  M  WS 24 + 8 [systemd-udevd]
252,0   45       13     0.000240511  1096  Q  WS 32 + 8 [systemd-udevd]
252,0   45       14     0.000245701  1096  B  WS 32 + 8 [systemd-udevd]
252,0   45       15     0.000246843  1096  M  WS 32 + 8 [systemd-udevd]
*252,0   45       16     0.000264746  1096  I  WS 0 + 40 [systemd-udevd]*
252,0   45       17     0.000337262  1096  D  WS 0 + 40 [systemd-udevd]
252,0   45       18     0.000526978   237  C  WS 0 + 40 [0]
252,0   45       19     0.000531887   237  C  WS 0 + 8 [0]
252,0   45       20     0.000554360   237  C  WS 8 + 8 [0]
252,0   45       21     0.000557505   237  C  WS 16 + 8 [0]
252,0   45       22     0.000560441   237  C  WS 24 + 8 [0]
252,0   45       23     0.000563457   237  C  WS 32 + 8 [0]
CPU45 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           5,       20KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        1,       20KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        6,       40KiB
 Read Merges:            0,        0KiB	 Write Merges:            4,       16KiB
 Read depth:             0        	 Write depth:             1
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 23 entries
Skips: 0 forward (0 -   0.0%)
####################     bfq     #####################
252,0   45        1     0.000000000  1096  Q  WS 0 + 8 [systemd-udevd]
252,0   45        2     0.000010880  1096  B  WS 0 + 8 [systemd-udevd]
252,0   45        3     0.000368781  1096  G  WS 0 + 8 [systemd-udevd]
252,0   45        4     0.000380924  1096  Q  WS 8 + 8 [systemd-udevd]
252,0   45        5     0.000387346  1096  B  WS 8 + 8 [systemd-udevd]
252,0   45        6     0.000389821  1096  M  WS 8 + 8 [systemd-udevd]
252,0   45        7     0.000398728  1096  Q  WS 16 + 8 [systemd-udevd]
252,0   45        8     0.000405360  1096  B  WS 16 + 8 [systemd-udevd]
252,0   45        9     0.000406753  1096  M  WS 16 + 8 [systemd-udevd]
252,0   45       10     0.000415719  1096  Q  WS 24 + 8 [systemd-udevd]
252,0   45       11     0.000421210  1096  B  WS 24 + 8 [systemd-udevd]
252,0   45       12     0.000422592  1096  M  WS 24 + 8 [systemd-udevd]
252,0   45       13     0.000431248  1096  Q  WS 32 + 8 [systemd-udevd]
252,0   45       14     0.000437640  1096  B  WS 32 + 8 [systemd-udevd]
252,0   45       15     0.000438973  1096  M  WS 32 + 8 [systemd-udevd]
252,0   45       16     0.000446617  1096  I  WS 0 + 40 [systemd-udevd]
*252,0   45       17     0.000560571  1096  D  WS 0 + 40 [systemd-udevd]*
252,0   45       18     0.000644438   237  C  WS 0 + 40 [0]
252,0   45       19     0.000651752   237  C  WS 0 + 8 [0]
252,0   45       20     0.000675957   237  C  WS 8 + 8 [0]
252,0   45       21     0.000683341   237  C  WS 16 + 8 [0]
252,0   45       22     0.000690044   237  C  WS 24 + 8 [0]
252,0   45       23     0.000696686   237  C  WS 32 + 8 [0]
CPU45 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           5,       20KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        1,       20KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        6,       40KiB
 Read Merges:            0,        0KiB	 Write Merges:            4,       16KiB
 Read depth:             0        	 Write depth:             1
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 23 entries
Skips: 0 forward (0 -   0.0%)
####################     mq-deadline     #####################
252,0   45        1     0.000000000  1096  Q  WS 0 + 8 [systemd-udevd]
252,0   45        2     0.000011522  1096  B  WS 0 + 8 [systemd-udevd]
252,0   45        3     0.000023454  1096  G  WS 0 + 8 [systemd-udevd]
252,0   45        4     0.000033012  1096  Q  WS 8 + 8 [systemd-udevd]
252,0   45        5     0.000038813  1096  B  WS 8 + 8 [systemd-udevd]
252,0   45        6     0.000041207  1096  M  WS 8 + 8 [systemd-udevd]
252,0   45        7     0.000049022  1096  Q  WS 16 + 8 [systemd-udevd]
252,0   45        8     0.000054412  1096  B  WS 16 + 8 [systemd-udevd]
252,0   45        9     0.000055574  1096  M  WS 16 + 8 [systemd-udevd]
252,0   45       10     0.000062607  1096  Q  WS 24 + 8 [systemd-udevd]
252,0   45       11     0.000067807  1096  B  WS 24 + 8 [systemd-udevd]
252,0   45       12     0.000068939  1096  M  WS 24 + 8 [systemd-udevd]
252,0   45       13     0.000075762  1096  Q  WS 32 + 8 [systemd-udevd]
252,0   45       14     0.000081022  1096  B  WS 32 + 8 [systemd-udevd]
252,0   45       15     0.000082314  1096  M  WS 32 + 8 [systemd-udevd]
*252,0   45       16     0.000251682  1096  I  WS 0 + 40 [systemd-udevd]*
252,0   45       17     0.000264386  1096  D  WS 0 + 40 [systemd-udevd]
252,0   45       18     0.000298630   237  C  WS 0 + 40 [0]
252,0   45       19     0.000305824   237  C  WS 0 + 8 [0]
252,0   45       20     0.000330520   237  C  WS 8 + 8 [0]
252,0   45       21     0.000336641   237  C  WS 16 + 8 [0]
252,0   45       22     0.000342172   237  C  WS 24 + 8 [0]
252,0   45       23     0.000347872   237  C  WS 32 + 8 [0]
CPU45 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           5,       20KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        1,       20KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        6,       40KiB
 Read Merges:            0,        0KiB	 Write Merges:            4,       16KiB
 Read depth:             0        	 Write depth:             1
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 23 entries
Skips: 0 forward (0 -   0.0%)
####################     none     #####################
252,0   45        1     0.000000000  1096  Q  WS 0 + 8 [systemd-udevd]
252,0   45        2     0.000012293  1096  B  WS 0 + 8 [systemd-udevd]
252,0   45        3     0.000021670  1096  G  WS 0 + 8 [systemd-udevd]
252,0   45        4     0.000030807  1096  Q  WS 8 + 8 [systemd-udevd]
252,0   45        5     0.000035747  1096  B  WS 8 + 8 [systemd-udevd]
252,0   45        6     0.000038362  1096  M  WS 8 + 8 [systemd-udevd]
252,0   45        7     0.000045856  1096  Q  WS 16 + 8 [systemd-udevd]
252,0   45        8     0.000051807  1096  B  WS 16 + 8 [systemd-udevd]
252,0   45        9     0.000053099  1096  M  WS 16 + 8 [systemd-udevd]
252,0   45       10     0.000060603  1096  Q  WS 24 + 8 [systemd-udevd]
252,0   45       11     0.000065182  1096  B  WS 24 + 8 [systemd-udevd]
252,0   45       12     0.000066324  1096  M  WS 24 + 8 [systemd-udevd]
252,0   45       13     0.000073327  1096  Q  WS 32 + 8 [systemd-udevd]
252,0   45       14     0.000078286  1096  B  WS 32 + 8 [systemd-udevd]
252,0   45       15     0.000079368  1096  M  WS 32 + 8 [systemd-udevd]
252,0   45       16     0.000086281  1096  D  WS 0 + 40 [systemd-udevd]
252,0   45       17     0.000142327   237  C  WS 0 + 40 [0]
252,0   45       18     0.000149881   237  C  WS 0 + 8 [0]
252,0   45       19     0.000174146   237  C  WS 8 + 8 [0]
252,0   45       20     0.000180067   237  C  WS 16 + 8 [0]
252,0   45       21     0.000185668   237  C  WS 24 + 8 [0]
252,0   45       22     0.000191499   237  C  WS 32 + 8 [0]
CPU45 (252,0):
 Reads Queued:           0,        0KiB	 Writes Queued:           5,       20KiB
 Read Dispatches:        0,        0KiB	 Write Dispatches:        1,       20KiB
 Reads Requeued:         0		 Writes Requeued:         0
 Reads Completed:        0,        0KiB	 Writes Completed:        6,       40KiB
 Read Merges:            0,        0KiB	 Write Merges:            4,       16KiB
 Read depth:             0        	 Write depth:             1
 IO unplugs:             0        	 Timer unplugs:           0

Throughput (R/W): 0KiB/s / 0KiB/s
Events (252,0): 22 entries
Skips: 0 forward (0 -   0.0%)


-- 
2.22.1

