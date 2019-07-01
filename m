Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F22471B066
	for <lists+linux-block@lfdr.de>; Mon, 13 May 2019 08:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfEMGiv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 13 May 2019 02:38:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35964 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfEMGiv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 02:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Yp0zT0SGd+/Wmp0NljlwoaBS3wwIcRgoBd92ftS54D8=; b=n3dXk4S/wZ+FL5xhnLs+T2/89s
        vCWcxGuipozDBfATq2S8Y5hrO7Oribs/wHnwl7Fn+ZA28VrpVH3WuW4rykdHYhUMjneoKyhKFbi9r
        2OJdhi0BEMs9ZZMqblsT0M3P+S1rjuqoKNyqEES+DCMnkOF2oiK2eSfcOb8VICDqIgX4gpEppreh5
        wTltmA4yn9Dk++jKHqajkctjiNsaSIT6oMaeN9Y4N37KAImoEIPclu58avcxFa9S4GiH1XymoQrb5
        b7YHeuuXdbXO/i8ddtycBf1i7ojPGJvZnzCDWDznuJlGOy3AzQI7bZsogJuCT+mrbg2nR5p4H3yyZ
        IIYnxo2Q==;
Received: from 089144210233.atnat0019.highway.a1.net ([89.144.210.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ4bp-0007Q0-VM; Mon, 13 May 2019 06:38:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     ming.lei@redhat.com, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Subject: [PATCH 05/10] block: initialize the write priority in blk_rq_bio_prep
Date:   Mon, 13 May 2019 08:37:49 +0200
Message-Id: <20190513063754.1520-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513063754.1520-1-hch@lst.de>
References: <20190513063754.1520-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The priority fiel also make sense for passthrough requests, so
initialize it in blk_rq_bio_prep.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 419d600e6637..7fb394dd3e11 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -716,7 +716,6 @@ void blk_init_request_from_bio(struct request *req, struct bio *bio)
 		req->cmd_flags |= REQ_FAILFAST_MASK;
 
 	req->__sector = bio->bi_iter.bi_sector;
-	req->ioprio = bio_prio(bio);
 	req->write_hint = bio->bi_write_hint;
 	blk_rq_bio_prep(req->q, req, bio);
 }
@@ -1494,6 +1493,7 @@ void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
 
 	rq->__data_len = bio->bi_iter.bi_size;
 	rq->bio = rq->biotail = bio;
+	rq->ioprio = bio_prio(bio);
 
 	if (bio->bi_disk)
 		rq->rq_disk = bio->bi_disk;
-- 
2.20.1

