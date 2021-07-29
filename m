Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10203D9DDD
	for <lists+linux-block@lfdr.de>; Thu, 29 Jul 2021 08:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbhG2Guy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 29 Jul 2021 02:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbhG2Guy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jul 2021 02:50:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61757C061757;
        Wed, 28 Jul 2021 23:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XXrANT4zWc9rH01tOFrhFGiFuyzFQ758i3QEZug8Na0=; b=TIuqCAdF0YthJ2f0NfjmuJ98Sk
        RRyZTNmHGddNUue2lUxeaV5f8uL32m8KZm7vBl325tVW0zNaRO3hE/fCyzIfhNeepSZnK+xdlttR4
        YOiBiO61SJJTw/ZLuS81oYv5EAlLuTeAK4Hy7zhM4paYwjI+3vcvqlje5SG8u3+edN89WZFodT3iq
        QRxjM+Pyj4uBrdzkmqSQv3GMx6eeNc/ukW+4C68js+ZzuZL2L7futb4dEhKI0G9qg/I7lnb9OsJHe
        ZWQ3Jhw68B/EbJHzJ6/ddw67RZ1pElyaqjEd0sa1P08jHJ9W72uxHubQ320AejOkCqU9YTbleN1kw
        efMWPDCw==;
Received: from [2001:4bb8:184:87c5:8c88:c313:79e2:b780] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8zrn-00Gnht-Vg; Thu, 29 Jul 2021 06:50:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 2/4] block: remove BLK_SCSI_MAX_CMDS
Date:   Thu, 29 Jul 2021 08:48:43 +0200
Message-Id: <20210729064845.1044147-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729064845.1044147-1-hch@lst.de>
References: <20210729064845.1044147-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This was used for the table based scsi passthough permission checking
that is gone now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 28957ccdd9c2..e0bb14acb708 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -271,9 +271,6 @@ enum blk_queue_state {
 #define BLK_TAG_ALLOC_FIFO 0 /* allocate starting from 0 */
 #define BLK_TAG_ALLOC_RR 1 /* allocate starting from last allocated tag */
 
-#define BLK_SCSI_MAX_CMDS	(256)
-#define BLK_SCSI_CMD_PER_LONG	(BLK_SCSI_MAX_CMDS / (sizeof(long) * 8))
-
 /*
  * Zoned block device models (zoned limit).
  *
-- 
2.30.2

