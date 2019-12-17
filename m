Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 197561230EA
	for <lists+linux-block@lfdr.de>; Tue, 17 Dec 2019 16:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfLQPyY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Dec 2019 10:54:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:34830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfLQPyX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 10:54:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C529CAEAF;
        Tue, 17 Dec 2019 15:54:21 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Roman Penyaev <rpenyaev@suse.de>
Subject: [PATCH 1/1] block: end bio with BLK_STS_AGAIN in case of non-mq devs and REQ_NOWAIT
Date:   Tue, 17 Dec 2019 16:54:07 +0100
Message-Id: <20191217155407.928386-1-rpenyaev@suse.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Non-mq devs do not honor REQ_NOWAIT so give a chance to the caller to repeat
request gracefully on -EAGAIN error.

The problem is well reproduced using io_uring:

   mkfs.ext4 /dev/ram0
   mount /dev/ram0 /mnt

   # Preallocate a file
   dd if=/dev/zero of=/mnt/file bs=1M count=1

   # Start fio with io_uring and get -EIO
   fio --rw=write --ioengine=io_uring --size=1M --direct=1 --name=job --filename=/mnt/file

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
---
 block/blk-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d5e668ec751b..1075aaff606d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -886,11 +886,14 @@ generic_make_request_checks(struct bio *bio)
 	}
 
 	/*
-	 * For a REQ_NOWAIT based request, return -EOPNOTSUPP
-	 * if queue is not a request based queue.
+	 * Non-mq queues do not honor REQ_NOWAIT, so complete a bio
+	 * with BLK_STS_AGAIN status in order to catch -EAGAIN and
+	 * to give a chance to the caller to repeat request gracefully.
 	 */
-	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_mq(q))
-		goto not_supported;
+	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_mq(q)) {
+		status = BLK_STS_AGAIN;
+		goto end_io;
+	}
 
 	if (should_fail_bio(bio))
 		goto end_io;
-- 
2.24.0

