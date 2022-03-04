Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E004CD893
	for <lists+linux-block@lfdr.de>; Fri,  4 Mar 2022 17:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbiCDQFe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 4 Mar 2022 11:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240627AbiCDQFL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Mar 2022 11:05:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E1D47387;
        Fri,  4 Mar 2022 08:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=j7MFK4Tqy07EjBcR/d909bGuvFPKD80zI65l9OY4evs=; b=lj/pgO+USBJjMZ0GnaLGGB03kv
        FwYgXtbGMSsrCOB/xEQbecrEA2IVTdxW69Ob37ThiRK12fv+Ufq6pSrU9CI6YvC0UbaCt+N26+yBn
        0xWxAo97kBTKDwLMWt19W7I2f2nAQpTpy/Y3cPDWjj2ab0MvZTE3S7cM1DgEc8OcHIHyV8LqI6Oei
        NuVteE/UxD5SCiqsjACQH8Nq7HvQ+ahwOZFU06vttxlQ0zlhbw5PAGLQIBJEXVMNCaZtURymfeHpU
        /zeNCiqccbOc0jfUH9YGbIBmBwDvG7CxZaV/QIogiFCbR0TZcNmG6I+DnOYv+/wUiFD/2aPSRYVfB
        fOXLH0Sg==;
Received: from [2001:4bb8:180:5296:7360:567:acd5:aaa2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQAPj-00AuCh-2q; Fri, 04 Mar 2022 16:04:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 14/14] block: move rq_qos_exit() into disk_release()
Date:   Fri,  4 Mar 2022 17:03:31 +0100
Message-Id: <20220304160331.399757-15-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304160331.399757-1-hch@lst.de>
References: <20220304160331.399757-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

There can't be FS IO in disk_release(), so it is safe to move rq_qos_exit()
there.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/genhd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 857e0a54da7dd..56f66c6fee943 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -627,7 +627,6 @@ void del_gendisk(struct gendisk *disk)
 
 	blk_mq_freeze_queue_wait(q);
 
-	rq_qos_exit(q);
 	blk_sync_queue(q);
 	blk_flush_integrity();
 	/*
@@ -1119,7 +1118,7 @@ static void disk_release_mq(struct request_queue *q)
 		elevator_exit(q);
 		mutex_unlock(&q->sysfs_lock);
 	}
-
+	rq_qos_exit(q);
 	__blk_mq_unfreeze_queue(q, true);
 }
 
-- 
2.30.2

