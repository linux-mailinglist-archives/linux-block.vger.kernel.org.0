Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A45823E9B9
	for <lists+linux-block@lfdr.de>; Fri,  7 Aug 2020 11:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgHGJGJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 7 Aug 2020 05:06:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49932 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726655AbgHGJGJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Aug 2020 05:06:09 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 889B452B4EBCE571D88B;
        Fri,  7 Aug 2020 17:06:07 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 7 Aug 2020
 17:05:59 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <lengchao@huawei.com>
Subject: [PATCH v2 0/3] reduce quiesce time for lots of name spaces
Date:   Fri, 7 Aug 2020 17:05:59 +0800
Message-ID: <20200807090559.29582-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nvme_stop_queues quiesce queues for all name spaces, now quiesce one by
one, if there is lots of name spaces, sync wait long time(more than 10s).
Multipath can not fail over to retry quickly, cause io pause long time.
This is not expected.
To reduce quiesce time, we introduce async mechanism for sync SRCUs
and quiesce queue.

Changes from v1:
- add support for blocking queue.
- introduce async mechanism for sync SRCU
- introduce async mechanism for quiesce queue

Chao Leng (3):
  rcu: introduce async mechanism for sync SRCU
  blk-mq: introduce async mechanism for quiesce queue
  nvme-core: reduce io pause time when fail over

 block/blk-mq.c                | 28 ++++++++++++++++++++++++++++
 drivers/nvme/host/core.c      |  7 ++++++-
 include/linux/blk-mq.h        |  2 ++
 include/linux/rcupdate_wait.h |  6 ++++++
 include/linux/srcu.h          |  1 +
 include/linux/srcutiny.h      |  2 ++
 include/linux/srcutree.h      |  2 ++
 kernel/rcu/srcutiny.c         | 15 +++++++++++++++
 kernel/rcu/srcutree.c         | 26 ++++++++++++++++++++++++++
 kernel/rcu/update.c           | 11 +++++++++++
 10 files changed, 99 insertions(+), 1 deletion(-)

-- 
2.16.4

