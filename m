Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE3EB2CE6
	for <lists+linux-block@lfdr.de>; Sat, 14 Sep 2019 22:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfINUeS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 14 Sep 2019 16:34:18 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:43778 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726254AbfINUeS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Sep 2019 16:34:18 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 14 Sep 2019 23:34:14 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x8EKYDfd002665;
        Sat, 14 Sep 2019 23:34:13 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me
Cc:     shlomin@mellanox.com, israelr@mellanox.com,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH v6 1/2] block: use symbolic constants for t10_pi type
Date:   Sat, 14 Sep 2019 23:34:12 +0300
Message-Id: <1568493253-18142-1-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---

changes from v5:
 - added Reviewed-by signature

---
 block/t10-pi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index 0c00946..7fed587 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -27,7 +27,7 @@ static __be16 t10_pi_ip_fn(void *data, unsigned int len)
  * tag.
  */
 static blk_status_t t10_pi_generate(struct blk_integrity_iter *iter,
-		csum_fn *fn, unsigned int type)
+		csum_fn *fn, enum t10_dif_type type)
 {
 	unsigned int i;
 
@@ -37,7 +37,7 @@ static blk_status_t t10_pi_generate(struct blk_integrity_iter *iter,
 		pi->guard_tag = fn(iter->data_buf, iter->interval);
 		pi->app_tag = 0;
 
-		if (type == 1)
+		if (type == T10_PI_TYPE1_PROTECTION)
 			pi->ref_tag = cpu_to_be32(lower_32_bits(iter->seed));
 		else
 			pi->ref_tag = 0;
@@ -51,7 +51,7 @@ static blk_status_t t10_pi_generate(struct blk_integrity_iter *iter,
 }
 
 static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
-		csum_fn *fn, unsigned int type)
+		csum_fn *fn, enum t10_dif_type type)
 {
 	unsigned int i;
 
@@ -60,8 +60,8 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 		__be16 csum;
 
 		switch (type) {
-		case 1:
-		case 2:
+		case T10_PI_TYPE1_PROTECTION:
+		case T10_PI_TYPE2_PROTECTION:
 			if (pi->app_tag == T10_PI_APP_ESCAPE)
 				goto next;
 
@@ -74,7 +74,7 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 				return BLK_STS_PROTECTION;
 			}
 			break;
-		case 3:
+		case T10_PI_TYPE3_PROTECTION:
 			if (pi->app_tag == T10_PI_APP_ESCAPE &&
 			    pi->ref_tag == T10_PI_REF_ESCAPE)
 				goto next;
@@ -102,42 +102,42 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 
 static blk_status_t t10_pi_type1_generate_crc(struct blk_integrity_iter *iter)
 {
-	return t10_pi_generate(iter, t10_pi_crc_fn, 1);
+	return t10_pi_generate(iter, t10_pi_crc_fn, T10_PI_TYPE1_PROTECTION);
 }
 
 static blk_status_t t10_pi_type1_generate_ip(struct blk_integrity_iter *iter)
 {
-	return t10_pi_generate(iter, t10_pi_ip_fn, 1);
+	return t10_pi_generate(iter, t10_pi_ip_fn, T10_PI_TYPE1_PROTECTION);
 }
 
 static blk_status_t t10_pi_type1_verify_crc(struct blk_integrity_iter *iter)
 {
-	return t10_pi_verify(iter, t10_pi_crc_fn, 1);
+	return t10_pi_verify(iter, t10_pi_crc_fn, T10_PI_TYPE1_PROTECTION);
 }
 
 static blk_status_t t10_pi_type1_verify_ip(struct blk_integrity_iter *iter)
 {
-	return t10_pi_verify(iter, t10_pi_ip_fn, 1);
+	return t10_pi_verify(iter, t10_pi_ip_fn, T10_PI_TYPE1_PROTECTION);
 }
 
 static blk_status_t t10_pi_type3_generate_crc(struct blk_integrity_iter *iter)
 {
-	return t10_pi_generate(iter, t10_pi_crc_fn, 3);
+	return t10_pi_generate(iter, t10_pi_crc_fn, T10_PI_TYPE3_PROTECTION);
 }
 
 static blk_status_t t10_pi_type3_generate_ip(struct blk_integrity_iter *iter)
 {
-	return t10_pi_generate(iter, t10_pi_ip_fn, 3);
+	return t10_pi_generate(iter, t10_pi_ip_fn, T10_PI_TYPE3_PROTECTION);
 }
 
 static blk_status_t t10_pi_type3_verify_crc(struct blk_integrity_iter *iter)
 {
-	return t10_pi_verify(iter, t10_pi_crc_fn, 3);
+	return t10_pi_verify(iter, t10_pi_crc_fn, T10_PI_TYPE3_PROTECTION);
 }
 
 static blk_status_t t10_pi_type3_verify_ip(struct blk_integrity_iter *iter)
 {
-	return t10_pi_verify(iter, t10_pi_ip_fn, 3);
+	return t10_pi_verify(iter, t10_pi_ip_fn, T10_PI_TYPE3_PROTECTION);
 }
 
 const struct blk_integrity_profile t10_pi_type1_crc = {
-- 
1.8.3.1

