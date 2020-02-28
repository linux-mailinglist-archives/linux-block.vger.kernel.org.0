Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2FB174271
	for <lists+linux-block@lfdr.de>; Fri, 28 Feb 2020 23:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgB1Wo1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 28 Feb 2020 17:44:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:63115 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgB1Wo0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 17:44:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 14:44:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400"; 
   d="scan'208";a="227686635"
Received: from linux-machine.lm.intel.com ([10.232.116.103])
  by orsmga007.jf.intel.com with ESMTP; 28 Feb 2020 14:44:25 -0800
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     linux-block@vger.kernel.org
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        =?UTF-8?q?Andrzej=20Jakowski=C2=BB?= <andrzej.jakowski@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: [PATCH] block: sed-opal: Change the check condition for regular session validity
Date:   Fri, 28 Feb 2020 15:42:25 -0700
Message-Id: <20200228224225.61368-1-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch changes the check condition for the validity/authentication
of the session.

1. The Host Session Number(HSN) in the response should match the HSN for
   the session.
2. The TPER Session Number(TSN) can never be less than 4096 for a regular
   session.

Reference:
Section 3.2.2.1   of https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Opal_SSC_Application_Note_1-00_1-00-Final.pdf
Section 3.3.7.1.1 of https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Architecture_Core_Spec_v2.01_r1.00.pdf

Co-developed-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 block/opal_proto.h | 1 +
 block/sed-opal.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index 325cbba2465f..27740baad61d 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -36,6 +36,7 @@ enum opal_response_token {

 #define DTAERROR_NO_METHOD_STATUS 0x89
 #define GENERIC_HOST_SESSION_NUM 0x41
+#define RSVD_TPER_SESSION_NUM	4096

 #define TPER_SYNC_SUPPORTED 0x01
 #define MBR_ENABLED_MASK 0x10
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 880cc57a5f6b..f2b61a868901 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1056,7 +1056,7 @@ static int start_opal_session_cont(struct opal_dev *dev)
 	hsn = response_get_u64(&dev->parsed, 4);
 	tsn = response_get_u64(&dev->parsed, 5);

-	if (hsn == 0 && tsn == 0) {
+	if (hsn != GENERIC_HOST_SESSION_NUM || tsn < RSVD_TPER_SESSION_NUM) {
 		pr_debug("Couldn't authenticate session\n");
 		return -EPERM;
 	}
--
2.17.1

