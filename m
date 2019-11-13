Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 806E6FB672
	for <lists+linux-block@lfdr.de>; Wed, 13 Nov 2019 18:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfKMRap (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 Nov 2019 12:30:45 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726443AbfKMRap (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 12:30:45 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DC7CA7D6366D8098886D;
        Thu, 14 Nov 2019 01:30:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Thu, 14 Nov 2019 01:30:36 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/2] blk-mq/sbitmap: Delete some unused functions
Date:   Thu, 14 Nov 2019 01:27:20 +0800
Message-ID: <1573666042-176756-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Function blk_mq_can_queue() never seemed to ever have been referenced, so
delete it and any other now-unused callees.

John Garry (2):
  blk-mq: Delete blk_mq_has_free_tags() and blk_mq_can_queue()
  sbitmap: Delete sbitmap_any_bit_clear()

 block/blk-mq-tag.c      |  8 --------
 block/blk-mq-tag.h      |  1 -
 block/blk-mq.c          |  6 ------
 include/linux/blk-mq.h  |  1 -
 include/linux/sbitmap.h |  9 ---------
 lib/sbitmap.c           | 17 -----------------
 6 files changed, 42 deletions(-)

-- 
2.17.1

