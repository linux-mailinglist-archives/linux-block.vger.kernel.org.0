Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC1940090B
	for <lists+linux-block@lfdr.de>; Sat,  4 Sep 2021 03:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350906AbhIDBgo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 3 Sep 2021 21:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350875AbhIDBgl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Sep 2021 21:36:41 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A8CC0617AE;
        Fri,  3 Sep 2021 18:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PhsefcTyzBYmTELi91sPT5fpjIKsUhTq4DdmWtknBpg=; b=jR7T1uiXl5sZErItmK+nrpQ94j
        xOA2oYZozCBp7Hthi2VTRbYP/js27AhWdupOIc+F8Xd//AQGiWvQ2A69mFrRyFTfVSTcgumdYSB39
        qiiJSQGRAce/Fr25CbPvXPdLTfjgsIwZkis7fDk/2v3CI7+XXabeL8uIDh684+nuxtiBXODj41wWt
        sa8HsihvQojtWs1wQkV7hXoJEy09PBfcSjwIJAOmqTK+jKN8N2j7VJ9wp+fgPRpzrpSDeP5dKGVvi
        Nrguq88eTQw4O1LRoeVhfaPiguDgE6WyI9fqUpXiE5cQjoJF/vGoEb93ALu7aZr4+kEKoSVjfwQN9
        pDDV8Tng==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMKan-00DLb6-9F; Sat, 04 Sep 2021 01:35:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 03/14] floppy: use blk_cleanup_disk()
Date:   Fri,  3 Sep 2021 18:35:25 -0700
Message-Id: <20210904013536.3181237-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210904013536.3181237-1-mcgrof@kernel.org>
References: <20210904013536.3181237-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the blk_cleanup_queue() followed by put_disk() can be
replaced with blk_cleanup_disk(). No need for two separate
loops.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/floppy.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 3e6390fd5f2b..9538146e520e 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4950,13 +4950,9 @@ static void __exit floppy_module_exit(void)
 		}
 		for (i = 0; i < ARRAY_SIZE(floppy_type); i++) {
 			if (disks[drive][i])
-				blk_cleanup_queue(disks[drive][i]->queue);
+				blk_cleanup_disk(disks[drive][i]);
 		}
 		blk_mq_free_tag_set(&tag_sets[drive]);
-		for (i = 0; i < ARRAY_SIZE(floppy_type); i++) {
-			if (disks[drive][i])
-				put_disk(disks[drive][i]);
-		}
 	}
 
 	cancel_delayed_work_sync(&fd_timeout);
-- 
2.30.2

