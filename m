Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EC4369C6B
	for <lists+linux-block@lfdr.de>; Sat, 24 Apr 2021 00:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhDWWGm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 23 Apr 2021 18:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232429AbhDWWGk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 18:06:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C42BA6147F;
        Fri, 23 Apr 2021 22:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619215563;
        bh=Orw80HiJiHtXUgb9tSaOsuFFaPf+nNNCx4L2ais7NsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i9hC8QVJg8F8lNFiCLvwp6arEBLF4JhNrgAEkgL5qGXdDP+5Iiz5wUrr7fm0L4GVK
         SOr25o+R18JFwodIOn6VodjdmKnmPDgOgWihwt1VEhjoXE4pKxQOdImp/5U6DpXc75
         BVXPexdUVvXzqSghgMsh6bPQQzzb7SQd+TMzv9humKSYPVsST5UuzTU/G3yGBqJWLS
         426RZ22SVyiPlhWBQBNQ3OgOy3jaFEzxOzCU1qDEW0ulp87wCCtdK2OvTsBVVMoDEe
         uAXJmcO0NG34qtrKzDG7O0qPJu+vUeqF7HtqHRK88fQOUBbFiEAmgw2bkts9dSYRi7
         TA6+hs2rCp24g==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 3/5] block: return errors from blk_execute_rq()
Date:   Fri, 23 Apr 2021 15:05:56 -0700
Message-Id: <20210423220558.40764-4-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210423220558.40764-1-kbusch@kernel.org>
References: <20210423220558.40764-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The synchronous blk_execute_rq() had not provided a way for its callers
to know if its request was successful or not. Return the errno from the
dispatch status.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-exec.c       | 6 ++++--
 include/linux/blkdev.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index b960ad187ba5..4e8e6fe20956 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -21,7 +21,7 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
 {
 	struct completion *waiting = rq->end_io_data;
 
-	rq->end_io_data = NULL;
+	rq->end_io_data = ERR_PTR(blk_status_to_errno(error));
 
 	/*
 	 * complete last, if this is a stack request the process (and thus
@@ -77,8 +77,9 @@ static bool blk_rq_is_poll(struct request *rq)
  * Description:
  *    Insert a fully prepared request at the back of the I/O scheduler queue
  *    for execution and wait for completion.
+ * Return: The errno value of the blk_status_t provided to blk_mq_end_request().
  */
-void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
+int blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
 {
 	DECLARE_COMPLETION_ONSTACK(wait);
 	unsigned long hang_check;
@@ -97,5 +98,6 @@ void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
 		while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
 	else
 		wait_for_completion_io(&wait);
+	return PTR_ERR_OR_ZERO(rq->end_io_data);
 }
 EXPORT_SYMBOL(blk_execute_rq);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b91ba6207365..15e4ffac33af 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -938,7 +938,7 @@ extern int blk_rq_map_kern(struct request_queue *, struct request *, void *, uns
 extern int blk_rq_map_user_iov(struct request_queue *, struct request *,
 			       struct rq_map_data *, const struct iov_iter *,
 			       gfp_t);
-extern void blk_execute_rq(struct gendisk *, struct request *, int);
+extern int blk_execute_rq(struct gendisk *, struct request *, int);
 extern void blk_execute_rq_nowait(struct gendisk *,
 				  struct request *, int, rq_end_io_fn *);
 
-- 
2.25.4

