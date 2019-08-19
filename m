Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A391294FF2
	for <lists+linux-block@lfdr.de>; Mon, 19 Aug 2019 23:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfHSVdX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 19 Aug 2019 17:33:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:53841 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbfHSVdX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 17:33:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 14:33:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,406,1559545200"; 
   d="scan'208";a="377562896"
Received: from unknown (HELO revanth-X299-AORUS-Gaming-3-Pro.lm.intel.com) ([10.232.116.91])
  by fmsmga005.fm.intel.com with ESMTP; 19 Aug 2019 14:33:23 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH v2 3/3] block: sed-opal: Removed duplicate OPAL_METHOD_LENGTH definition
Date:   Mon, 19 Aug 2019 15:35:06 -0600
Message-Id: <20190819213506.14788-4-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213506.14788-1-revanth.rajashekar@intel.com>
References: <20190819213506.14788-1-revanth.rajashekar@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 block/opal_proto.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index 562b78f40824..5532412d567c 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -119,8 +119,6 @@ enum opal_uid {
 	OPAL_UID_HEXFF,
 };

-#define OPAL_METHOD_LENGTH 8
-
 /* Enum for indexing the OPALMETHOD array */
 enum opal_method {
 	OPAL_PROPERTIES,
--
2.17.1

