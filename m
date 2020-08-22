Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3448C24E736
	for <lists+linux-block@lfdr.de>; Sat, 22 Aug 2020 13:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgHVLqI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 22 Aug 2020 07:46:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:56820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgHVLqG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Aug 2020 07:46:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6A6FAD2C;
        Sat, 22 Aug 2020 11:46:33 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 09/12] bcache: don't check seq numbers in register_cache_set()
Date:   Sat, 22 Aug 2020 19:45:33 +0800
Message-Id: <20200822114536.23491-10-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200822114536.23491-1-colyli@suse.de>
References: <20200822114536.23491-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In order to update the partial super block of cache set, the seq numbers
of cache and cache set are checked in register_cache_set(). If cache's
seq number is larger than cache set's seq number, cache set must update
its partial super block from cache's super block. It is unncessary when
the embedded struct cache_sb is removed from struct cache set.

This patch removed the seq numbers checking from register_cache_set(),
because later there will be no such partial super block in struct cache
set, the cache set will directly reference in-memory super block from
struct cache. This is a preparation patch for removing embedded struct
cache_sb from struct cache_set.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/bcache/super.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 28257f11d835..3dfe81bf31c8 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2176,21 +2176,6 @@ static const char *register_cache_set(struct cache *ca)
 	    sysfs_create_link(&c->kobj, &ca->kobj, buf))
 		goto err;
 
-	/*
-	 * A special case is both ca->sb.seq and c->sb.seq are 0,
-	 * such condition happens on a new created cache device whose
-	 * super block is never flushed yet. In this case c->sb.version
-	 * and other members should be updated too, otherwise we will
-	 * have a mistaken super block version in cache set.
-	 */
-	if (ca->sb.seq > c->sb.seq || c->sb.seq == 0) {
-		c->sb.version		= ca->sb.version;
-		memcpy(c->set_uuid, ca->sb.set_uuid, 16);
-		c->sb.flags             = ca->sb.flags;
-		c->sb.seq		= ca->sb.seq;
-		pr_debug("set version = %llu\n", c->sb.version);
-	}
-
 	kobject_get(&ca->kobj);
 	ca->set = c;
 	ca->set->cache = ca;
-- 
2.26.2

