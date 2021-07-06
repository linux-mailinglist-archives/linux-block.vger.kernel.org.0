Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807B83BC480
	for <lists+linux-block@lfdr.de>; Tue,  6 Jul 2021 03:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhGFBKk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 5 Jul 2021 21:10:40 -0400
Received: from out0.migadu.com ([94.23.1.103]:42186 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhGFBKj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Jul 2021 21:10:39 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1625533680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uY9MQ3YxTij2WZatl2iKTTHoHr3pwU5udJVdRcNhJRQ=;
        b=xsu0+lAL74TCCayFDHbSiWBy9U9Akx8glWcc7tBoa5rBhmmxx4HJenli95sIbNt8y4amiR
        qIhQuJ9X0uHGix5J0jYxBEz4f3D3c0P0CPxehy4g7LdNOv6pWEmGtOXloTQ4E/gGNH+wKk
        yw/CzrUxQCv/wn18ZZlLvvc5v/n5kq8=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     axboe@kernel.dk, tim@cyberelk.net, hch@lst.de
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] pd: fix order of cleaning up the queue and freeing the tagset
Date:   Tue,  6 Jul 2021 09:07:34 +0800
Message-Id: <20210706010734.1356066-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: guoqing.jiang@linux.dev
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <jiangguoqing@kylinos.cn>

We must release the queue before freeing the tagset.

Fixes: 262d431f9000 ("pd: use blk_mq_alloc_disk and blk_cleanup_disk")
Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>
---
 drivers/block/paride/pd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 3b2b8e872beb..9b3298926356 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -1014,8 +1014,8 @@ static void __exit pd_exit(void)
 		if (p) {
 			disk->gd = NULL;
 			del_gendisk(p);
-			blk_mq_free_tag_set(&disk->tag_set);
 			blk_cleanup_disk(p);
+			blk_mq_free_tag_set(&disk->tag_set);
 			pi_release(disk->pi);
 		}
 	}
-- 
2.25.1

