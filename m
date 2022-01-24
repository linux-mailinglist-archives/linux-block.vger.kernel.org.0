Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF57497B5B
	for <lists+linux-block@lfdr.de>; Mon, 24 Jan 2022 10:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242660AbiAXJLn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 Jan 2022 04:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242649AbiAXJLi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jan 2022 04:11:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F58C06173B;
        Mon, 24 Jan 2022 01:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Mjlg0k+4PavheCjtECQRQWUa0Hx79sA/tX844Pch6ns=; b=Cq0TPNTknrpMgSPyE0DO6o8Qzt
        f/iZoR0ubS3Fi0mNYFhpPl8fPbwxg/xP1Xsb9wAVH+J7Xi2rGTgLxSNRU/sh9E8Pausv23uDyD8GM
        MPk203cd/Z1rnUElKzw1r/Wzqi37FWlZ4t6koT8hF+Sk7/ozar/Vdkeh4G40FH4h4j7SnokgW8dXc
        a8PQHEniFdLS0v2JKyUDqyV7VP5MGaEeYidHKzzT+aNgHNjiPVUSS9tU+PDOLnMLPzkME51Qb/3uf
        n61njfRrtW/q1yUlOOM1gMmXqSOJ8tw+YUWV8V80IP6LcwNj92/3FhKy5mGr4hvrynh0ZMAvkwguX
        MwVYB/7Q==;
Received: from [2001:4bb8:184:72a4:a337:a75f:a24e:7e39] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBvNr-002kA4-JE; Mon, 24 Jan 2022 09:11:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal " <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        xen-devel@lists.xenproject.org, drbd-dev@lists.linbit.com
Subject: [PATCH 08/19] dm-thin: use blkdev_issue_flush instead of open coding it
Date:   Mon, 24 Jan 2022 10:10:56 +0100
Message-Id: <20220124091107.642561-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124091107.642561-1-hch@lst.de>
References: <20220124091107.642561-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use blkdev_issue_flush, which uses an on-stack bio instead of an
opencoded version with a bio embedded into struct pool.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-thin.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 76a9c2e9aeeea..411a3f56ed90c 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -282,8 +282,6 @@ struct pool {
 	struct dm_bio_prison_cell **cell_sort_array;
 
 	mempool_t mapping_pool;
-
-	struct bio flush_bio;
 };
 
 static void metadata_operation_failed(struct pool *pool, const char *op, int r);
@@ -2906,7 +2904,6 @@ static void __pool_destroy(struct pool *pool)
 	if (pool->next_mapping)
 		mempool_free(pool->next_mapping, &pool->mapping_pool);
 	mempool_exit(&pool->mapping_pool);
-	bio_uninit(&pool->flush_bio);
 	dm_deferred_set_destroy(pool->shared_read_ds);
 	dm_deferred_set_destroy(pool->all_io_ds);
 	kfree(pool);
@@ -2987,7 +2984,6 @@ static struct pool *pool_create(struct mapped_device *pool_md,
 	pool->low_water_triggered = false;
 	pool->suspended = true;
 	pool->out_of_data_space = false;
-	bio_init(&pool->flush_bio, NULL, 0);
 
 	pool->shared_read_ds = dm_deferred_set_create();
 	if (!pool->shared_read_ds) {
@@ -3194,13 +3190,8 @@ static void metadata_low_callback(void *context)
 static int metadata_pre_commit_callback(void *context)
 {
 	struct pool *pool = context;
-	struct bio *flush_bio = &pool->flush_bio;
-
-	bio_reset(flush_bio);
-	bio_set_dev(flush_bio, pool->data_dev);
-	flush_bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 
-	return submit_bio_wait(flush_bio);
+	return blkdev_issue_flush(pool->data_dev);
 }
 
 static sector_t get_dev_size(struct block_device *bdev)
-- 
2.30.2

