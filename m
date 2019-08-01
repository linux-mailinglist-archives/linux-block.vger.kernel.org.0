Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 466237E604
	for <lists+linux-block@lfdr.de>; Fri,  2 Aug 2019 00:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfHAWvB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 1 Aug 2019 18:51:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32970 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbfHAWvA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 18:51:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so34901871pfq.0
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2019 15:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EhWldTClpduPmOO/VmISBa3rF5geaIGGYKKo8yPkexo=;
        b=NuRUgyKe9Gn2yGPI1NDzu0uPs3gDLx+xHNHVUraLQnOxzSOe7gY4gRkzfuFEdiVnWB
         IYeBgEwqkGWJI5XIfIUmg6vcxuZmRAvluZiigEU76gKlQrgqWT0wUjozJ+DT5YYPJpp4
         dutIH4LCY2g2zNUcwPsUw2gkns4oJWqylPRBMzjuERuYJVTHvnEdcAjVjfO8zFMUYG5u
         PXQka42QHzpGGlg+eDDMI1lPFA+0lQ3ilEYVLfqocI3Yx5w+LF7iSnW53Qrz/Ey29r51
         MzXWKGjTAQAnslgTgsUKm68L7MuXLK5cnJyyIGyolnw0AfYNhwdbAMpPv17Mrag2fy+f
         ml3g==
X-Gm-Message-State: APjAAAWWgrTOiOS6gQhkUqnRABmj3zRiW4NBmXF1vfYkJFg0skmi/uud
        69MH4/X6RMwOQ7seHhZ2yFo=
X-Google-Smtp-Source: APXvYqzAEbp/QPfntLQwmfFIaVw6ieR3K/vZYR0eXEXNgFZ9xitps583DyC+XXHP+h7VhuiOf2dhuA==
X-Received: by 2002:a62:6dc2:: with SMTP id i185mr56894680pfc.40.1564699859202;
        Thu, 01 Aug 2019 15:50:59 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id d12sm35472010pfn.11.2019.08.01.15.50.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 15:50:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH v2 5/5] block: Improve physical block alignment of split bios
Date:   Thu,  1 Aug 2019 15:50:44 -0700
Message-Id: <20190801225044.143478-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801225044.143478-1-bvanassche@acm.org>
References: <20190801225044.143478-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Consider the following example:
* The logical block size is 4 KB.
* The physical block size is 8 KB.
* max_sectors equals (16 KB >> 9) sectors.
* A non-aligned 4 KB and an aligned 64 KB bio are merged into a single
  non-aligned 68 KB bio.

The current behavior is to split such a bio into (16 KB + 16 KB + 16 KB
+ 16 KB + 4 KB). The start of none of these five bio's is aligned to a
physical block boundary.

This patch ensures that such a bio is split into four aligned and
one non-aligned bio instead of being split into five non-aligned bios.
This improves performance because most block devices can handle aligned
requests faster than non-aligned requests.

Since the physical block size is larger than or equal to the logical
block size, this patch preserves the guarantee that the returned
value is a multiple of the logical block size.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-merge.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index a6bc08255b1b..48e6725b32ee 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -132,16 +132,29 @@ static struct bio *blk_bio_write_same_split(struct request_queue *q,
 	return bio_split(bio, q->limits.max_write_same_sectors, GFP_NOIO, bs);
 }
 
+/*
+ * Return the maximum number of sectors from the start of a bio that may be
+ * submitted as a single request to a block device. If enough sectors remain,
+ * align the end to the physical block size. Otherwise align the end to the
+ * logical block size. This approach minimizes the number of non-aligned
+ * requests that are submitted to a block device if the start of a bio is not
+ * aligned to a physical block boundary.
+ */
 static inline unsigned get_max_io_size(struct request_queue *q,
 				       struct bio *bio)
 {
 	unsigned sectors = blk_max_size_offset(q, bio->bi_iter.bi_sector);
-	unsigned mask = queue_logical_block_size(q) - 1;
+	unsigned max_sectors = sectors;
+	unsigned pbs = queue_physical_block_size(q) >> SECTOR_SHIFT;
+	unsigned lbs = queue_logical_block_size(q) >> SECTOR_SHIFT;
+	unsigned start_offset = bio->bi_iter.bi_sector & (pbs - 1);
 
-	/* aligned to logical block size */
-	sectors &= ~(mask >> 9);
+	max_sectors += start_offset;
+	max_sectors &= ~(pbs - 1);
+	if (max_sectors > start_offset)
+		return max_sectors - start_offset;
 
-	return sectors;
+	return sectors & (lbs - 1);
 }
 
 static unsigned get_max_segment_size(const struct request_queue *q,
-- 
2.22.0.770.g0f2c4a37fd-goog

