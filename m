Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660341B3483
	for <lists+linux-block@lfdr.de>; Wed, 22 Apr 2020 03:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDVB2u (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Apr 2020 21:28:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38096 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726228AbgDVB2u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 21:28:50 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8CF947FF075052E8B1B1;
        Wed, 22 Apr 2020 09:28:46 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.166.215.55) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 22 Apr 2020 09:28:40 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] brd: remove a redundant check
Date:   Wed, 22 Apr 2020 09:28:11 +0800
Message-ID: <20200422012811.1606-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Because pages[i] can't be NULL, otherwise "pos = pages[i]->index;" will
panic. So when "ret" is NULL, it can't be equal to pages[i].

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/block/brd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 2fb25c348d53..59fec4a8ac93 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -147,7 +147,7 @@ static void brd_free_pages(struct brd_device *brd)
 			BUG_ON(pages[i]->index < pos);
 			pos = pages[i]->index;
 			ret = radix_tree_delete(&brd->brd_pages, pos);
-			BUG_ON(!ret || ret != pages[i]);
+			BUG_ON(ret != pages[i]);
 			__free_page(pages[i]);
 		}
 
-- 
2.26.0.106.g9fadedd


