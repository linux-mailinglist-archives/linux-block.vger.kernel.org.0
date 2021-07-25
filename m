Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0435F3D4C32
	for <lists+linux-block@lfdr.de>; Sun, 25 Jul 2021 07:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhGYFQm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 25 Jul 2021 01:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGYFQm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Jul 2021 01:16:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB73FC061757
        for <linux-block@vger.kernel.org>; Sat, 24 Jul 2021 22:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wvDMupN7NUkhPbg8vayHjZ0ReGS7K0Sbn0xl5v31yvE=; b=EBSeWKjqbVoVlnbsYaAvXMx+Ho
        +ZQ3O9zI+ZajwFipsC0ZxN2zQF/0GXUaEfIkQ4qWRbH8/1sueGEN667BYZPvgn8kLzfWrMuMfwLXv
        SJ9AKHL11VcVCGv7bUG2BQlNG/6xcZ6F9oMGhmRLulDAUOcbvhFRrv6fjq7PgSqmsIIlISl4YKFAF
        KKUJ72kMS9sTDFLzjVgbsUhb8Lx7NgQhc+7fLgis55J+fubE7Li/AC5WArdxDKrS+ItcBO535nSUc
        HBGVig3rlM3TCOy+xGr9LA7/CAJ4k/qI7ahRgYREylq7DSHNZajwqLLVmtHEsVt8jEmPPhm6NYnZe
        /x69UaAA==;
Received: from [2001:4bb8:184:87c5:a8b3:bdfd:fc9b:6250] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7X7x-00Cpk8-4e; Sun, 25 Jul 2021 05:56:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 5/8] dm: cleanup cleanup_mapped_device
Date:   Sun, 25 Jul 2021 07:54:55 +0200
Message-Id: <20210725055458.29008-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210725055458.29008-1-hch@lst.de>
References: <20210725055458.29008-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

md->queue is not always set when md->disk is set, so simplify the
conditionas a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 2c5f9e585211..7971ec8ce677 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1694,13 +1694,9 @@ static void cleanup_mapped_device(struct mapped_device *md)
 		md->disk->private_data = NULL;
 		spin_unlock(&_minor_lock);
 		del_gendisk(md->disk);
-	}
-
-	if (md->queue)
 		dm_queue_destroy_keyslot_manager(md->queue);
-
-	if (md->disk)
 		blk_cleanup_disk(md->disk);
+	}
 
 	cleanup_srcu_struct(&md->io_barrier);
 
-- 
2.30.2

