Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1D5B34BD8
	for <lists+linux-block@lfdr.de>; Tue,  4 Jun 2019 17:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfFDPQq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 4 Jun 2019 11:16:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:39176 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727737AbfFDPQq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Jun 2019 11:16:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18E2BACF5;
        Tue,  4 Jun 2019 15:16:45 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 04/15] bcache: add io error counting in write_bdev_super_endio()
Date:   Tue,  4 Jun 2019 23:16:13 +0800
Message-Id: <20190604151624.105150-5-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190604151624.105150-1-colyli@suse.de>
References: <20190604151624.105150-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When backing device super block is written by bch_write_bdev_super(),
the bio complete callback write_bdev_super_endio() simply ignores I/O
status. Indeed such write request also contribute to backing device
health status if the request failed.

This patch checkes bio->bi_status in write_bdev_super_endio(), if there
is error, bch_count_backing_io_errors() will be called to count an I/O
error to dc->io_errors.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index da9d6a63b81a..877113b62b0f 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -197,7 +197,9 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 static void write_bdev_super_endio(struct bio *bio)
 {
 	struct cached_dev *dc = bio->bi_private;
-	/* XXX: error checking */
+
+	if (bio->bi_status)
+		bch_count_backing_io_errors(dc, bio);
 
 	closure_put(&dc->sb_write);
 }
-- 
2.16.4

