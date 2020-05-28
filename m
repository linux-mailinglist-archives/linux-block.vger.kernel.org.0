Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31901E627B
	for <lists+linux-block@lfdr.de>; Thu, 28 May 2020 15:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390495AbgE1Nle (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 May 2020 09:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390335AbgE1Nlb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 09:41:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04A5C05BD1E
        for <linux-block@vger.kernel.org>; Thu, 28 May 2020 06:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ZenOMw5c1ia97+5CKaB4JV0NpvlfAyzn3NNkLX38EPc=; b=oPgExP85K6XMQ+1zur8cNY39v7
        PRjWc89E6bp/s8PQGUawnQTQAJ+w1VckLX9mUp9tH7k1PKCyxX4EArrOXxgYoaABnZdqnK0Sq5vj0
        jU0lXqSCwQJQGI6R6JwtZmqn6cHIpVeKbRSs6pzggnhu5Nigo0gZYQ/iiBIRSColmtKpODPYt3btc
        yEz+JNNDpSVHZoZpjkyB8u6kzM75TPYtpXfwfMxndJo59xvWGOJflyRf6vVlnG8gNbFlf/lwrZwrz
        t5ekHg4ZMkERfM+Gg6JuIPAh7vXag4ntZ40WF/l0pt5t93DrtkH5HRC41wjcnq+J0hvh53VTZS6EY
        RjjdKsNA==;
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeImo-0003QF-Ve; Thu, 28 May 2020 13:41:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] block: fix a warning when blkdev.h is included for !CONFIG_BLOCK builds
Date:   Thu, 28 May 2020 15:41:23 +0200
Message-Id: <20200528134123.923849-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

disk_start_io_acct and disk_end_io_acct need at least a struct gendisk
forward declaration, but for weird historic reasons much of blkdev.h
is stubbed out for CONFIG_BLOCK=n.  Fix this by stubbing more out for
now, but eventually this header will need a massive cleanup.

Fixes: 956d510ee78 ("block: add disk/bio-based accounting helpers")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6f7ff0fa8fcf8..8fd900998b4e2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1892,12 +1892,12 @@ static inline void blk_wake_io_task(struct task_struct *waiter)
 		wake_up_process(waiter);
 }
 
+#ifdef CONFIG_BLOCK
 unsigned long disk_start_io_acct(struct gendisk *disk, unsigned int sectors,
 		unsigned int op);
 void disk_end_io_acct(struct gendisk *disk, unsigned int op,
 		unsigned long start_time);
 
-#ifdef CONFIG_BLOCK
 /**
  * bio_start_io_acct - start I/O accounting for bio based drivers
  * @bio:	bio to start account for
-- 
2.26.2

