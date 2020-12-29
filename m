Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A38E2E6F56
	for <lists+linux-block@lfdr.de>; Tue, 29 Dec 2020 10:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgL2J3K (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 29 Dec 2020 04:29:10 -0500
Received: from mail.synology.com ([211.23.38.101]:43858 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726161AbgL2J3J (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Dec 2020 04:29:09 -0500
Received: from localhost.localdomain (unknown [10.17.198.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 42A66CE780A1;
        Tue, 29 Dec 2020 17:21:11 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1609233671; bh=Qxu4vUKQKWL6/tjzR7ffoqsmtCLzkIMcEENQ3xILAzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PPqsYzcSJbLZkxbveH10J50u+etbYati2u7k8Mv/Xo5+MTdqnXiXq6zsE8c9ZQ5EQ
         cQ2PpGFgP8n9LzwWvFtF7lEjlRVFWKQ5ChQTDsIDx0PhDzs7gfqohvrMjx04MZObis
         rXdvQm5NQFx4lyZM+vbHj4mxPuDluUW6l7+7ElBE=
From:   dannyshih <dannyshih@synology.com>
To:     axboe@kernel.dk
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, Danny Shih <dannyshih@synology.com>
Subject: [PATCH 3/4] dm: use submit_bio_noacct_add_head for split bio sending back
Date:   Tue, 29 Dec 2020 17:18:41 +0800
Message-Id: <1609233522-25837-4-git-send-email-dannyshih@synology.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609233522-25837-1-git-send-email-dannyshih@synology.com>
References: <1609233522-25837-1-git-send-email-dannyshih@synology.com>
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Danny Shih <dannyshih@synology.com>

Use submit_bio_noacct_add_head when sending split bio back to dm device.
Otherwise, it might be handled after the lately split bio.

Signed-off-by: Danny Shih <dannyshih@synology.com>
Reviewed-by: Allen Peng <allenpeng@synology.com>
Reviewed-by: Alex Wu <alexwu@synology.com>
---
 drivers/md/dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index b3c3c8b..1a651d5 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1613,7 +1613,7 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 
 				bio_chain(b, bio);
 				trace_block_split(b, bio->bi_iter.bi_sector);
-				ret = submit_bio_noacct(bio);
+				ret = submit_bio_noacct_add_head(bio);
 				break;
 			}
 		}
-- 
2.7.4

