Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E5129A560
	for <lists+linux-block@lfdr.de>; Tue, 27 Oct 2020 08:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436609AbgJ0HTR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 27 Oct 2020 03:19:17 -0400
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:9591 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with SMTP id S1728739AbgJ0HTR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 03:19:17 -0400
X-ASG-Debug-ID: 1603783147-0e41083db9d4da00008-Cu09wu
Received: from mail.didiglobal.com (bogon [172.20.36.204]) by bsf02.didichuxing.com with ESMTP id MZVPiA8m4HJ5HHyy; Tue, 27 Oct 2020 15:19:09 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 27 Oct
 2020 12:54:15 +0800
Date:   Tue, 27 Oct 2020 12:54:14 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <snitzer@redhat.com>,
        <mpatocka@redhat.com>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH v5 0/2] fix inaccurate io_ticks
Message-ID: <20201027045411.GA39796@192.168.3.9>
X-ASG-Orig-Subj: [PATCH v5 0/2] fix inaccurate io_ticks
Mail-Followup-To: axboe@kernel.dk, ming.lei@redhat.com, snitzer@redhat.com,
        mpatocka@redhat.com, linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS01.didichuxing.com (172.20.36.235) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bogon[172.20.36.204]
X-Barracuda-Start-Time: 1603783149
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1666
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.85498
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patchset include two patches,

01. block: fix inaccurate io_ticks
fix the io_ticks if start a new IO and there is no inflight IO before.

02. blk-mq: break more earlier when interate hctx
An optimization for blk_mq_queue_inflight and blk_mq_part_is_in_flight
these two function only want to know if there is IO inflight and do
not care how many inflight IOs are there.
After this patch blk_mq_queue_inflight will stop interate other hctx
when find a inflight IO, blk_mq_part_is_in_inflight stop interate
other setbit/hctx when find a inflight IO.

Changes since v4:
 * only get inflight in update_io_ticks when start a new IO every jiffy.

Changes since v3:
 * add a parameter for blk_mq_queue_tag_busy_iter to break earlier
   when interate hctx of a queue, since blk_mq_part_is_in_inflight
   and blk_mq_queue_inflight do not care how many inflight IOs.

Changes since v2:
* use blk_mq_queue_tag_busy_iter framework instead of open-code.
* update_io_ticks before update inflight for __part_start_io_acct

Changes since v1:
* avoid iterate all tagset, return directly if find a set bit.
* fix some typo in commit message

Weiping Zhang (2):
  block: fix inaccurate io_ticks
  blk-mq: break more earlier when interate hctx

 block/blk-core.c       | 19 ++++++++++----
 block/blk-mq-tag.c     | 11 ++++++--
 block/blk-mq-tag.h     |  2 +-
 block/blk-mq.c         | 58 +++++++++++++++++++++++++++++++++++++++---
 block/blk-mq.h         |  1 +
 block/blk.h            |  1 +
 block/genhd.c          | 13 ++++++++++
 include/linux/blk-mq.h |  1 +
 8 files changed, 94 insertions(+), 12 deletions(-)

-- 
2.18.4

