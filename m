Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAFB4114AF
	for <lists+linux-block@lfdr.de>; Mon, 20 Sep 2021 14:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhITMlr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Sep 2021 08:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhITMln (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 08:41:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF1DC061574
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 05:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ngp4mt8OG2XgNvPQKgO+avIHV37KM8ekIOHG1V6M0iM=; b=rS5zAUWsOkZqE9on5cFrk2Qp/U
        5O4RZYpG0VLZ6JI3+a3S+GeBKvrYNx+V2ENZrM/xEd1zHaW6oWO97feTBlAy947KAHBriRuoMKYya
        qBZMc1XzXXLQCkc3QyypCcy73qP4FUkjln2dgyp262JCeW8Jv7NFJvTbwh3Wwlzwv5PfrNF6t8Vdm
        wRqFOdbblvHzZLbMcfHecQpbU95u2PaK6DyToT45+tTqAWF1JOxQphKX/OnfLf6zfH07BWrvo10sH
        77Eu4qOrLA61gGRVfi2MgJvQo1BB+HEpDxpkclBap4aIntQqGNk8GfS0H5pfGabVP/Fp+/Se26oeC
        lIYq4mEQ==;
Received: from [2001:4bb8:184:72db:7ad9:14d9:8599:3025] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSIaD-002fFz-PO; Mon, 20 Sep 2021 12:39:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 09/17] block: remove the unused blk_queue_state enum
Date:   Mon, 20 Sep 2021 14:33:20 +0200
Message-Id: <20210920123328.1399408-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920123328.1399408-1-hch@lst.de>
References: <20210920123328.1399408-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 12b9dbcc980ee..9e367509bea10 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -262,11 +262,6 @@ enum blk_eh_timer_return {
 	BLK_EH_RESET_TIMER,	/* reset timer and try again */
 };
 
-enum blk_queue_state {
-	Queue_down,
-	Queue_up,
-};
-
 #define BLK_TAG_ALLOC_FIFO 0 /* allocate starting from 0 */
 #define BLK_TAG_ALLOC_RR 1 /* allocate starting from last allocated tag */
 
-- 
2.30.2

