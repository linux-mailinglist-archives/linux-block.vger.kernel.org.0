Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A507362AA
	for <lists+linux-block@lfdr.de>; Tue, 20 Jun 2023 06:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjFTEbC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 20 Jun 2023 00:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjFTEa7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 00:30:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0473310C7
        for <linux-block@vger.kernel.org>; Mon, 19 Jun 2023 21:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=hvpjk8KKQcr9IDmEyVt9Wo1djvED5dV1KauMGQoG7v8=; b=d/DNLZ29WSrEijket2ZGS7pGKo
        tT4aF/ffra3TLJz0jDjGixUUExkl3LkwXHA/MGzU9EVGuR3Mcbjj6YgLL3+FiZglSpVSyUxTJrjzz
        aS0OF92Sgi+Fr0XDCGoan5YPr/SCKJcERw9rZCQt4hlXeUOu3UrgJ5R9oyMPQdDYUPVFARgx5+P7D
        13WMt2TLQMU0x1Skd/1DNZoz3C4H7RUcyqLypBPJCnqWHARyNFEjHBwDjhhDCBL2s48qEWc6rJUOc
        3PlSL5FKVGElzjxOnmaS0Y+FoRwHvdWiKO+KS5VTKgIBlBmRfKbzKJsXvUqB0W2ByghxYPUzU+TtL
        10czTDxA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBT15-00A7uz-2i;
        Tue, 20 Jun 2023 04:30:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] swim: fix a missing FMODE_ -> BLK_OPEN_ conversion in floppy_open
Date:   Tue, 20 Jun 2023 06:30:51 +0200
Message-Id: <20230620043051.707196-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix a missing conversion to the new BLK_OPEN constant in swim.

Fixes: 05bdb9965305 ("block: replace fmode_t with a block-specific type for block open flags")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/swim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 651009b3a601eb..f85b6af414b431 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -640,7 +640,7 @@ static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 	if (mode & (BLK_OPEN_READ | BLK_OPEN_WRITE)) {
 		if (disk_check_media_change(disk) && fs->disk_in)
 			fs->ejected = 0;
-		if ((mode & FMODE_WRITE) && fs->write_protected) {
+		if ((mode & BLK_OPEN_WRITE) && fs->write_protected) {
 			err = -EROFS;
 			goto out;
 		}
-- 
2.39.2

