Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882AA1E91EA
	for <lists+linux-block@lfdr.de>; Sat, 30 May 2020 16:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgE3OEx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 30 May 2020 10:04:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:54830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgE3OEx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 May 2020 10:04:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 56949AC6D;
        Sat, 30 May 2020 14:04:50 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-block@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Jens Axboe <axboe@fb.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Shaun Tancheff <shaun.tancheff@seagate.com>
Subject: [PATCH v2] block: change REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_ALL to be odd numbers
Date:   Sat, 30 May 2020 22:02:25 +0800
Message-Id: <20200530140225.122537-1-colyli@suse.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_ALL are defined as
even numbers 6 and 8, such zone reset bios are treated as READ bios by
bio_data_dir(), which is obviously misleading.

The macro bio_data_dir() is defined in include/linux/bio.h as,
 55 #define bio_data_dir(bio) \
 56         (op_is_write(bio_op(bio)) ? WRITE : READ)

And op_is_write() is defined in include/linux/blk_types.h as,
397 static inline bool op_is_write(unsigned int op)
398 {
399         return (op & 1);
400 }

The convention of op_is_write() is when there is data transfer then the
op code should be odd number, and treat as a write op. bio_data_dir()
treats all bio direction as READ if op_is_write() reports false, and
WRITE if op_is_write() reports true.

Because REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_ALL are even numbers,
although they don't transfer data but reporting them as READ bio by
bio_data_dir() is misleading and might be wrong. Because these two
commands will reset the writer pointers of the resetting zones, and all
content after the reset write pointer will be invalid and unaccessible,
obviously they are not READ bios in any means.

This patch changes REQ_OP_ZONE_RESET from 6 to 15, and changes
REQ_OP_ZONE_RESET_ALL from 8 to 17. Now bios with these two op code
can be treated as WRITE by bio_data_dir(). Although they don't transfer
data, now we keep them consistent with REQ_OP_DISCARD and
REQ_OP_WRITE_ZEROES with the ituition that they change on-media content
and should be WRITE request.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@fb.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Shaun Tancheff <shaun.tancheff@seagate.com>
---
Changelog:
v2: add Reviewed-by tag for Damien and Chaitanya.
v1: initial version.

 include/linux/blk_types.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ccb895f911b1..447b46a0accf 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -300,12 +300,8 @@ enum req_opf {
 	REQ_OP_DISCARD		= 3,
 	/* securely erase sectors */
 	REQ_OP_SECURE_ERASE	= 5,
-	/* reset a zone write pointer */
-	REQ_OP_ZONE_RESET	= 6,
 	/* write the same sector many times */
 	REQ_OP_WRITE_SAME	= 7,
-	/* reset all the zone present on the device */
-	REQ_OP_ZONE_RESET_ALL	= 8,
 	/* write the zero filled sector many times */
 	REQ_OP_WRITE_ZEROES	= 9,
 	/* Open a zone */
@@ -316,6 +312,10 @@ enum req_opf {
 	REQ_OP_ZONE_FINISH	= 12,
 	/* write data at the current zone write pointer */
 	REQ_OP_ZONE_APPEND	= 13,
+	/* reset a zone write pointer */
+	REQ_OP_ZONE_RESET	= 15,
+	/* reset all the zone present on the device */
+	REQ_OP_ZONE_RESET_ALL	= 17,
 
 	/* SCSI passthrough using struct scsi_request */
 	REQ_OP_SCSI_IN		= 32,
-- 
2.25.0

