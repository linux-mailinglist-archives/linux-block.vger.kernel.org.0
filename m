Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996FB560D81
	for <lists+linux-block@lfdr.de>; Thu, 30 Jun 2022 01:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiF2Xdd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Jun 2022 19:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiF2Xda (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:33:30 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D20AA4
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:18 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id x138so13812074pfc.3
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2gp0UvqLbsoA0Ni6cyG6gP2JZx76ey6eHskW647sBT4=;
        b=LqCktmOAdc/MPS87dnWusjx+Yh6WoiRxu/JmgBSSG/vhiumz4gOm1Ed9jAWVVziOYc
         UsFrzADY4r9RtlaKyLP2zHOYrhIxDfRppZ+B2+nwvveKLG3DTDPbo9EoQAX8nNtIASkP
         Fy/MKm/cdUXz77rZgXlS1Saa1x6WMuCqh5Q1VkSXilD4Kd58fK1UrMySrstZ8xZWK4Tg
         JBWeIp2s5P5xZIW8xwF0VcmbTS8MO8m0lfEAnqm9GadJ0mGhVSqyQuXACxFJf/FEJzRe
         5B4oxrN8/rE2eI2HTlfS2GOOxQZTY2Y3KHXefAZKJK7IceXtWENTvHLFtPT1rg8STalq
         /LBA==
X-Gm-Message-State: AJIora9TURBd7VZ/vS5kqeOpvEPN3zXC/NuF/+SzOrPioi5hLScEcKg6
        kv+1DQph9/B/hEA3B4qwivQ=
X-Google-Smtp-Source: AGRyM1sFm/ZoREMBgGEoI9QYWkn3POPHU9iYrqAHEDPwfzLbeHalKEEMLE2yKzbQN1+0kchd6+Abew==
X-Received: by 2002:aa7:9911:0:b0:525:1bb3:965a with SMTP id z17-20020aa79911000000b005251bb3965amr11687494pff.79.1656545592781;
        Wed, 29 Jun 2022 16:33:12 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:33:11 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v2 52/63] fs/f2fs: Use the enum req_op and blk_opf_t types
Date:   Wed, 29 Jun 2022 16:31:34 -0700
Message-Id: <20220629233145.2779494-53-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/f2fs/data.c              | 11 ++++++-----
 fs/f2fs/f2fs.h              |  6 +++---
 fs/f2fs/node.c              |  2 +-
 fs/f2fs/segment.c           |  2 +-
 include/trace/events/f2fs.h | 22 +++++++++++-----------
 5 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7fcbcf979737..5c13ee321940 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -387,11 +387,11 @@ int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr)
 	return 0;
 }
 
-static unsigned int f2fs_io_flags(struct f2fs_io_info *fio)
+static blk_opf_t f2fs_io_flags(struct f2fs_io_info *fio)
 {
 	unsigned int temp_mask = (1 << NR_TEMP_TYPE) - 1;
 	unsigned int fua_flag, meta_flag, io_flag;
-	unsigned int op_flags = 0;
+	blk_opf_t op_flags = 0;
 
 	if (fio->op != REQ_OP_WRITE)
 		return 0;
@@ -999,7 +999,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 }
 
 static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
-				      unsigned nr_pages, unsigned op_flag,
+				      unsigned nr_pages, blk_opf_t op_flag,
 				      pgoff_t first_idx, bool for_write)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -1047,7 +1047,8 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 
 /* This can handle encryption stuffs */
 static int f2fs_submit_page_read(struct inode *inode, struct page *page,
-				 block_t blkaddr, int op_flags, bool for_write)
+				 block_t blkaddr, blk_opf_t op_flags,
+				 bool for_write)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct bio *bio;
@@ -1181,7 +1182,7 @@ int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index)
 }
 
 struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
-						int op_flags, bool for_write)
+				     blk_opf_t op_flags, bool for_write)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct dnode_of_data dn;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d9bbecd008d2..868170b72de9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1183,8 +1183,8 @@ struct f2fs_io_info {
 	nid_t ino;		/* inode number */
 	enum page_type type;	/* contains DATA/NODE/META/META_FLUSH */
 	enum temp_type temp;	/* contains HOT/WARM/COLD */
-	int op;			/* contains REQ_OP_ */
-	int op_flags;		/* req_flag_bits */
+	enum req_op op;		/* contains REQ_OP_ */
+	blk_opf_t op_flags;	/* req_flag_bits */
 	block_t new_blkaddr;	/* new block address to be written */
 	block_t old_blkaddr;	/* old block address before Cow */
 	struct page *page;	/* page to be written */
@@ -3741,7 +3741,7 @@ int f2fs_reserve_new_block(struct dnode_of_data *dn);
 int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index);
 int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index);
 struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
-			int op_flags, bool for_write);
+			blk_opf_t op_flags, bool for_write);
 struct page *f2fs_find_data_page(struct inode *inode, pgoff_t index);
 struct page *f2fs_get_lock_data_page(struct inode *inode, pgoff_t index,
 			bool for_write);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index cf6f7fc83c08..04a145f1dcfc 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1327,7 +1327,7 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
  * 0: f2fs_put_page(page, 0)
  * LOCKED_PAGE or error: f2fs_put_page(page, 1)
  */
-static int read_node_page(struct page *page, int op_flags)
+static int read_node_page(struct page *page, blk_opf_t op_flags)
 {
 	struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 	struct node_info ni;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 874c1b9c41a2..c7afc588cf26 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1082,7 +1082,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
 					&(dcc->fstrim_list) : &(dcc->wait_list);
-	int flag = dpolicy->sync ? REQ_SYNC : 0;
+	blk_opf_t flag = dpolicy->sync ? REQ_SYNC : 0;
 	block_t lstart, start, len, total_len;
 	int err = 0;
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 513e889ef8aa..f1e922237736 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -66,7 +66,7 @@ TRACE_DEFINE_ENUM(CP_RESIZE);
 
 #define F2FS_OP_FLAGS (REQ_RAHEAD | REQ_SYNC | REQ_META | REQ_PRIO |	\
 			REQ_PREFLUSH | REQ_FUA)
-#define F2FS_BIO_FLAG_MASK(t)	(t & F2FS_OP_FLAGS)
+#define F2FS_BIO_FLAG_MASK(t) (__force u32)((t) & F2FS_OP_FLAGS)
 
 #define show_bio_type(op,op_flags)	show_bio_op(op),		\
 						show_bio_op_flags(op_flags)
@@ -75,12 +75,12 @@ TRACE_DEFINE_ENUM(CP_RESIZE);
 
 #define show_bio_op_flags(flags)					\
 	__print_flags(F2FS_BIO_FLAG_MASK(flags), "|",			\
-		{ REQ_RAHEAD,		"R" },				\
-		{ REQ_SYNC,		"S" },				\
-		{ REQ_META,		"M" },				\
-		{ REQ_PRIO,		"P" },				\
-		{ REQ_PREFLUSH,		"PF" },				\
-		{ REQ_FUA,		"FUA" })
+		{ (__force u32)REQ_RAHEAD,	"R" },			\
+		{ (__force u32)REQ_SYNC,	"S" },			\
+		{ (__force u32)REQ_META,	"M" },			\
+		{ (__force u32)REQ_PRIO,	"P" },			\
+		{ (__force u32)REQ_PREFLUSH,	"PF" },			\
+		{ (__force u32)REQ_FUA,		"FUA" })
 
 #define show_data_type(type)						\
 	__print_symbolic(type,						\
@@ -1036,8 +1036,8 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
 		__field(pgoff_t, index)
 		__field(block_t, old_blkaddr)
 		__field(block_t, new_blkaddr)
-		__field(int, op)
-		__field(int, op_flags)
+		__field(enum req_op, op)
+		__field(blk_opf_t, op_flags)
 		__field(int, temp)
 		__field(int, type)
 	),
@@ -1092,8 +1092,8 @@ DECLARE_EVENT_CLASS(f2fs__bio,
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(dev_t,	target)
-		__field(int,	op)
-		__field(int,	op_flags)
+		__field(enum req_op,	op)
+		__field(blk_opf_t,	op_flags)
 		__field(int,	type)
 		__field(sector_t,	sector)
 		__field(unsigned int,	size)
