Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDD927128B
	for <lists+linux-block@lfdr.de>; Sun, 20 Sep 2020 07:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgITFp6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 20 Sep 2020 01:45:58 -0400
Received: from smtp.infotech.no ([82.134.31.41]:43396 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgITFp6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Sep 2020 01:45:58 -0400
X-Greylist: delayed 578 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Sep 2020 01:45:57 EDT
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 62DC820419A;
        Sun, 20 Sep 2020 07:36:17 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QmwB39jA3PkQ; Sun, 20 Sep 2020 07:36:11 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-78-251-166.dyn.295.ca [45.78.251.166])
        by smtp.infotech.no (Postfix) with ESMTPA id D6E3720417C;
        Sun, 20 Sep 2020 07:36:10 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Subject: [PATCH] sgl_alloc_order: memory leak
Date:   Sun, 20 Sep 2020 01:36:07 -0400
Message-Id: <20200920053607.35002-1-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Noticed that when sgl_alloc_order() failed with order > 0 that
free memory on my machine shrank. That function shouldn't call
sgl_free() on its error path since that is only correct when
order==0 .

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 lib/scatterlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 5d63a8857f36..c448642e0f78 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -514,7 +514,7 @@ struct scatterlist *sgl_alloc_order(unsigned long long length,
 		elem_len = min_t(u64, length, PAGE_SIZE << order);
 		page = alloc_pages(gfp, order);
 		if (!page) {
-			sgl_free(sgl);
+			sgl_free_order(sgl, order);
 			return NULL;
 		}
 
-- 
2.25.1

