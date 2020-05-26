Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA6F1BBF47
	for <lists+linux-block@lfdr.de>; Tue, 28 Apr 2020 15:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgD1NZh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Apr 2020 09:25:37 -0400
Received: from mx1.didichuxing.com ([111.202.154.82]:10843 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1727844AbgD1NZg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 09:25:36 -0400
X-ASG-Debug-ID: 1588080321-0e4088442c55ffb0001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.236]) by bsf01.didichuxing.com with ESMTP id fR989kaJ7i6xxYRV; Tue, 28 Apr 2020 21:25:21 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 28 Apr
 2020 21:25:20 +0800
Date:   Tue, 28 Apr 2020 21:25:19 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tom.leiming@gmail.com>, <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH v4 0/6] Fix potential kernel panic when increase hardware
 queue
Message-ID: <cover.1588078594.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v4 0/6] Fix potential kernel panic when increase hardware
 queue
Mail-Followup-To: axboe@kernel.dk, tom.leiming@gmail.com,
        bvanassche@acm.org, linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.236]
X-Barracuda-Start-Time: 1588080321
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1993
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81478
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This series do some improvement base on V2, and also fix two memleaks.
And V2 import a regression for blktest/block/test/029, this test case
will increase and decrease hardware queue count quickly.


Memleak 1:

__blk_mq_alloc_rq_maps
	__blk_mq_alloc_rq_map

if fail
	blk_mq_free_rq_map

Actually, __blk_mq_alloc_rq_map alloc both map and request, here
also need free request.

Memleak 2:
When driver decrease hardware queue, set->nr_hw_queues will be changed
firstly in blk_mq_realloc_tag_set_tags or __blk_mq_update_nr_hw_queues,
then blk_mq_realloc_hw_ctxs and blk_mq_map_swqueue, even
blk_mq_free_tag_set have no chance to free these hardware queue resource,
because they iterate hardware queue by
for (i = 0; i < set->nr_hw_queues; i++).

Patch1: fix Memleak 1.
Patch2: fix prev_nr_hw_queues issue, need be saved before change.
Patch3: refactor __blk_mq_alloc_rq_maps and fix Memleak 2.
Patch4: fix potential kernel panic when increase hardware queue.
Patch5~6: rename two function, because these two function alloc both
map and request, and keep in pair with blk_mq_free_map_and_request(s).

Changes since V3:
* record patchset, fix issue fistly then rename.
* rename function to blk_mq_alloc_map_and_request

Changes since V2:
 * rename some functions name and fix memleak when free map and requests
 * Not free new allocated map and request, they will be relased when tagset gone

Changes since V1:
 * Add fix for potential kernel panic when increase hardware queue

Weiping Zhang (6):
  block: free both rq_map and request
  block: save previous hardware queue count before udpate
  block: refactor __blk_mq_alloc_rq_maps
  block: alloc map and request for new hardware queue
  block: rename __blk_mq_alloc_rq_map
  block: rename blk_mq_alloc_rq_maps

 block/blk-mq.c         | 47 +++++++++++++++++++++++++++++-------------
 include/linux/blk-mq.h |  1 +
 2 files changed, 34 insertions(+), 14 deletions(-)

-- 
2.18.1

