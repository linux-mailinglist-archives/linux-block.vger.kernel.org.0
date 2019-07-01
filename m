Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9FA45DC6
	for <lists+linux-block@lfdr.de>; Fri, 14 Jun 2019 15:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfFNNPD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 14 Jun 2019 09:15:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:45934 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728121AbfFNNPC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 09:15:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E24BAE07;
        Fri, 14 Jun 2019 13:15:01 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Coly Li <colyli@suse.de>
Subject: [PATCH 15/29] bcache: use sysfs_match_string() instead of __sysfs_match_string()
Date:   Fri, 14 Jun 2019 21:13:44 +0800
Message-Id: <20190614131358.2771-16-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190614131358.2771-1-colyli@suse.de>
References: <20190614131358.2771-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

The arrays (of strings) that are passed to __sysfs_match_string() are
static, so use sysfs_match_string() which does an implicit ARRAY_SIZE()
over these arrays.

Functionally, this doesn't change anything.
The change is more cosmetic.

It only shrinks the static arrays by 1 byte each.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 7a88ba4bfbfb..53f70f97241e 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -21,28 +21,24 @@ static const char * const bch_cache_modes[] = {
 	"writethrough",
 	"writeback",
 	"writearound",
-	"none",
-	NULL
+	"none"
 };
 
 /* Default is 0 ("auto") */
 static const char * const bch_stop_on_failure_modes[] = {
 	"auto",
-	"always",
-	NULL
+	"always"
 };
 
 static const char * const cache_replacement_policies[] = {
 	"lru",
 	"fifo",
-	"random",
-	NULL
+	"random"
 };
 
 static const char * const error_actions[] = {
 	"unregister",
-	"panic",
-	NULL
+	"panic"
 };
 
 write_attribute(attach);
@@ -333,7 +329,7 @@ STORE(__cached_dev)
 		bch_cached_dev_run(dc);
 
 	if (attr == &sysfs_cache_mode) {
-		v = __sysfs_match_string(bch_cache_modes, -1, buf);
+		v = sysfs_match_string(bch_cache_modes, buf);
 		if (v < 0)
 			return v;
 
@@ -344,7 +340,7 @@ STORE(__cached_dev)
 	}
 
 	if (attr == &sysfs_stop_when_cache_set_failed) {
-		v = __sysfs_match_string(bch_stop_on_failure_modes, -1, buf);
+		v = sysfs_match_string(bch_stop_on_failure_modes, buf);
 		if (v < 0)
 			return v;
 
@@ -794,7 +790,7 @@ STORE(__bch_cache_set)
 			    0, UINT_MAX);
 
 	if (attr == &sysfs_errors) {
-		v = __sysfs_match_string(error_actions, -1, buf);
+		v = sysfs_match_string(error_actions, buf);
 		if (v < 0)
 			return v;
 
@@ -1058,7 +1054,7 @@ STORE(__bch_cache)
 	}
 
 	if (attr == &sysfs_cache_replacement_policy) {
-		v = __sysfs_match_string(cache_replacement_policies, -1, buf);
+		v = sysfs_match_string(cache_replacement_policies, buf);
 		if (v < 0)
 			return v;
 
-- 
2.16.4

