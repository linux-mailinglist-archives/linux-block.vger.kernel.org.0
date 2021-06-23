Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4953B1D02
	for <lists+linux-block@lfdr.de>; Wed, 23 Jun 2021 17:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhFWPDh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 23 Jun 2021 11:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWPDh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 11:03:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D00C061574
        for <linux-block@vger.kernel.org>; Wed, 23 Jun 2021 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=miz2SHtXr83p5l2VfoB34cIcc7wi7YYh2t9n5METgEM=; b=Eom5tOHeYarLJZGbbgMNDR7TzF
        JxHX6zAczc6lTHVooXcaMt2WjAF2qS7C+DwmZ3NySLr4yKGt2nmZ/+2LXPQRjy/oo85DwRR/6t5hP
        y0WyJ3Ciz0nW5wb7ingIrmLWvI59b3JNtgl9Rukzv+cAzcftWhUT+pwXnnr9rjpFF6tff/YwmVZ+r
        vVENsBl3DIfB6zMsL3G9H0+XV3fIViERtqvhziwmxNlju+SJYMY9MEHVTdUXsjRcHw9+Jc+d7nkk4
        /dUrCDSlQ6HFENTxgrqOviwnNoA0WD18ofLsuA4xNeOmKlHoIBgfesFak+fiujE8JAapR9OsIE90v
        K6wwWmyA==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw4MT-00FXtO-OB; Wed, 23 Jun 2021 15:00:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/9] loop: reduce loop_ctl_mutex coverage in loop_exit
Date:   Wed, 23 Jun 2021 16:59:01 +0200
Message-Id: <20210623145908.92973-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623145908.92973-1-hch@lst.de>
References: <20210623145908.92973-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

loop_ctl_mutex is only needed to iterate the IDR for removing the loop
devices, so reduce the coverage.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/loop.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 44fa27c54ac2..9df9fb490f87 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2380,13 +2380,14 @@ static int loop_exit_cb(int id, void *ptr, void *data)
 
 static void __exit loop_exit(void)
 {
-	mutex_lock(&loop_ctl_mutex);
 	unregister_blkdev(LOOP_MAJOR, "loop");
 	misc_deregister(&loop_misc);
 
+	mutex_lock(&loop_ctl_mutex);
 	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
-	idr_destroy(&loop_index_idr);
 	mutex_unlock(&loop_ctl_mutex);
+
+	idr_destroy(&loop_index_idr);
 }
 
 module_init(loop_init);
-- 
2.30.2

