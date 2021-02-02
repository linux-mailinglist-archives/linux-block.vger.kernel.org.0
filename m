Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC01C30C78F
	for <lists+linux-block@lfdr.de>; Tue,  2 Feb 2021 18:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbhBBRX4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Feb 2021 12:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbhBBRVu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 12:21:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48D4C0617AA;
        Tue,  2 Feb 2021 09:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0nik6YWYCo1wHtUKyfVchNP168ZV7sAXydtLxpLuz4I=; b=M1AdLAfI9icdv6jrKeLPc5B9KW
        LlmFM8KllS6W+18NqkL0zPuvj8gSV+Hf1/BK1y7C/AcNNjqyP+rNN59/29fHd7rSqOHrgSxPn+6qk
        Pv48QRsTx5FoNo/bDV7wFFRnht7PiUHtDR2GE5fg33yDfgyJqD75a1rfL1cbyg0NBtktMIp3FAidX
        vA5qOvz6YJLinCRnIDdUF2eMKKP83GfwVEbMtJmiG+IVoSSh4xAKq3xX8y/DCOdBb8skSBM8HDKZI
        rlqLUrGleRXCuZZbdmcgBXmCIXHbf4+XckcUAfKoP65MVv0PTxZiMqiOQABoWrYpRJFY2Zd/B4w2t
        4ofhOPAw==;
Received: from [2001:4bb8:198:6bf4:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l6zLD-00FW0j-G1; Tue, 02 Feb 2021 17:19:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org
Subject: [PATCH 10/11] md/raid10: remove dead code in reshape_request
Date:   Tue,  2 Feb 2021 18:19:28 +0100
Message-Id: <20210202171929.1504939-11-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210202171929.1504939-1-hch@lst.de>
References: <20210202171929.1504939-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A bio allocated by bio_alloc_bioset comes pre-zeroed, no need to
clear random fields.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid10.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index e1eefbec15d444..a9ae7d113492c9 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4539,10 +4539,6 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 	read_bio->bi_private = r10_bio;
 	read_bio->bi_end_io = end_reshape_read;
 	bio_set_op_attrs(read_bio, REQ_OP_READ, 0);
-	read_bio->bi_flags &= (~0UL << BIO_RESET_BITS);
-	read_bio->bi_status = 0;
-	read_bio->bi_vcnt = 0;
-	read_bio->bi_iter.bi_size = 0;
 	r10_bio->master_bio = read_bio;
 	r10_bio->read_slot = r10_bio->devs[r10_bio->read_slot].devnum;
 
-- 
2.29.2

