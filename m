Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7752E2DEE
	for <lists+linux-block@lfdr.de>; Sat, 26 Dec 2020 11:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgLZK0e (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 26 Dec 2020 05:26:34 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10365 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgLZK0X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Dec 2020 05:26:23 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D30LC6f61z7Kpx;
        Sat, 26 Dec 2020 18:24:51 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Sat, 26 Dec 2020
 18:25:27 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH 0/3] fix the performance fluctuation due to shared tagset
Date:   Sat, 26 Dec 2020 18:28:05 +0800
Message-ID: <20201226102808.2534966-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The problem is due to the max number of avaliable tags is
max(total tags / active_queues, 4).

We fix it by ensuring the following:
a. don't restrict if the utilization rate of total tags is less than
100%
b. if the utilization rate of total tags is 100%, and someone failed
to get driver tag, start to restrict as before.
b. if the utilization rate of total tags goes below 100%, it can
stop to restrict quickly.

Yu Kuai (3):
  blk-mq: allow hardware queue to get more tag while sharing a tag set
  blk-mq: clear 'active_queues' immediately when 'nr_active' is
    decreased to 0
  blk-mq: decrease pending_queues when it expires

 block/blk-mq-debugfs.c |  2 ++
 block/blk-mq-tag.c     | 61 +++++++++++++++++++++++++++++++++++++++++-
 block/blk-mq-tag.h     | 23 ++++++++++++++++
 block/blk-mq.c         |  9 +++++--
 block/blk-mq.h         | 11 +++++---
 include/linux/blk-mq.h | 10 ++++++-
 include/linux/blkdev.h |  1 +
 7 files changed, 110 insertions(+), 7 deletions(-)

-- 
2.25.4

