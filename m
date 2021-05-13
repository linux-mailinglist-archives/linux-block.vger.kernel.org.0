Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8261C37F760
	for <lists+linux-block@lfdr.de>; Thu, 13 May 2021 14:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbhEMMGd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 13 May 2021 08:06:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3747 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhEMMGb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 May 2021 08:06:31 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FgqyX3Xc4zqTdF;
        Thu, 13 May 2021 20:01:56 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 20:05:12 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <ming.lei@redhat.com>,
        <kashyap.desai@broadcom.com>, <chenxiang66@hisilicon.com>,
        <yama@redhat.com>, <dgilbert@interlog.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 0/2] blk-mq: Request queue-wide tags for shared sbitmap
Date:   Thu, 13 May 2021 20:00:56 +0800
Message-ID: <1620907258-30910-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is v3 of patch/series. I have spun off a new patch for tag allocation
refactoring.

Details are in commit messages.

Changes since v2:
- Spin off separate patch for tag allocation refactoring
- Combine sched shared sbitmap code into a single function

Changes since v1:
- Embed sbitmaps in request_queue struct
- Relocate IO sched functions to blk-mq-sched.c
- Fix error path code

Please retest, thanks! For some reason I could not recreate the original
issue, but I am using qemu...

John Garry (2):
  blk-mq: Some tag allocation code refactoring
  blk-mq: Use request queue-wide tags for tagset-wide sbitmap

 block/blk-mq-sched.c   | 67 ++++++++++++++++++++++++++++++++++--------
 block/blk-mq-sched.h   |  2 ++
 block/blk-mq-tag.c     | 65 +++++++++++++++++++++++-----------------
 block/blk-mq-tag.h     |  9 ++++--
 block/blk-mq.c         | 15 ++++++++--
 include/linux/blkdev.h |  4 +++
 6 files changed, 116 insertions(+), 46 deletions(-)

-- 
2.26.2

