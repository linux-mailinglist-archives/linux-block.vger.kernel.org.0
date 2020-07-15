Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFE8220487
	for <lists+linux-block@lfdr.de>; Wed, 15 Jul 2020 07:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgGOFqg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Jul 2020 01:46:36 -0400
Received: from [195.135.220.15] ([195.135.220.15]:38472 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1728663AbgGOFqg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jul 2020 01:46:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4453AB7D;
        Wed, 15 Jul 2020 05:46:37 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH v2 07/17] bcache: move bucket related code into read_super_basic()
Date:   Wed, 15 Jul 2020 13:46:02 +0800
Message-Id: <20200715054612.6349-8-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715054612.6349-1-colyli@suse.de>
References: <20200715054612.6349-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Setting sb->first_bucket and checking sb->keys indeed are only for cache
device, it does not make sense to do them in read_super() for backing
device too.

This patch moves the related code piece into read_super_basic()
explicitly for cache device and avoid the confusion.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 071509590e1e..4c97d8c4a878 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -66,12 +66,17 @@ static const char *read_super_basic(struct cache_sb *sb,  struct block_device *b
 	const char *err;
 	unsigned int i;
 
+	sb->first_bucket= le16_to_cpu(s->first_bucket);
 	sb->nbuckets	= le64_to_cpu(s->nbuckets);
 	sb->bucket_size	= le16_to_cpu(s->bucket_size);
 
 	sb->nr_in_set	= le16_to_cpu(s->nr_in_set);
 	sb->nr_this_dev	= le16_to_cpu(s->nr_this_dev);
 
+	err = "Too many journal buckets";
+	if (sb->keys > SB_JOURNAL_BUCKETS)
+		goto err;
+
 	err = "Too many buckets";
 	if (sb->nbuckets > LONG_MAX)
 		goto err;
@@ -155,7 +160,6 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 	sb->flags		= le64_to_cpu(s->flags);
 	sb->seq			= le64_to_cpu(s->seq);
 	sb->last_mount		= le32_to_cpu(s->last_mount);
-	sb->first_bucket	= le16_to_cpu(s->first_bucket);
 	sb->keys		= le16_to_cpu(s->keys);
 
 	for (i = 0; i < SB_JOURNAL_BUCKETS; i++)
@@ -172,10 +176,6 @@ static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
 	if (memcmp(sb->magic, bcache_magic, 16))
 		goto err;
 
-	err = "Too many journal buckets";
-	if (sb->keys > SB_JOURNAL_BUCKETS)
-		goto err;
-
 	err = "Bad checksum";
 	if (s->csum != csum_set(s))
 		goto err;
-- 
2.26.2

