Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4FC247E07
	for <lists+linux-block@lfdr.de>; Tue, 18 Aug 2020 07:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgHRFpv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 18 Aug 2020 01:45:51 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:35792 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726583AbgHRFpu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 01:45:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U67402C_1597729537;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U67402C_1597729537)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Aug 2020 13:45:38 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Some clean-ups for bio merge
Date:   Tue, 18 Aug 2020 13:45:27 +0800
Message-Id: <cover.1597727255.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

There are some duplicated code when trying to merge bio from pluged list
and software queue, thus this patch set did some clean-ups when merging
a bio. Any comments are welcome. Thanks.

Changes from v1:
 - Drop patch 2 and patch 5 in v1 patch set.
 - Add reviewed-by tag from Christoph.
 - Move blk_mq_bio_list_merge() into blk-merge.c and rename it.
 - Some coding style improvements.

Baolin Wang (3):
  block: Move bio merge related functions into blk-merge.c
  block: Add a new helper to attempt to merge a bio
  block: Remove blk_mq_attempt_merge() function

 block/blk-core.c       | 156 --------------------------------------
 block/blk-merge.c      | 202 +++++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-sched.c   |  94 +++++------------------
 block/blk.h            |  23 ++++--
 block/kyber-iosched.c  |   2 +-
 include/linux/blk-mq.h |   2 -
 6 files changed, 239 insertions(+), 240 deletions(-)

-- 
1.8.3.1

