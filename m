Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1798C3DE
	for <lists+linux-block@lfdr.de>; Tue, 13 Aug 2019 23:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfHMVmF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 13 Aug 2019 17:42:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:23252 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfHMVmF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 17:42:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:42:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="176328351"
Received: from unknown (HELO revanth-X299-AORUS-Gaming-3-Pro.lm.intel.com) ([10.232.116.91])
  by fmsmga008.fm.intel.com with ESMTP; 13 Aug 2019 14:42:05 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH 2/3] block: sed-opal: Eliminating the dead error
Date:   Tue, 13 Aug 2019 15:43:39 -0600
Message-Id: <20190813214340.15533-3-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813214340.15533-1-revanth.rajashekar@intel.com>
References: <20190813214340.15533-1-revanth.rajashekar@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In the function 'response_parse', num_entries will never be 0 as
slen is checked for 0. Hence, the condition 'if (num_entries == 0)'
can never be true.

Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 block/sed-opal.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index d442f29e84f1..4e95a9792162 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -905,10 +905,6 @@ static int response_parse(const u8 *buf, size_t length,
 		num_entries++;
 	}

-	if (num_entries == 0) {
-		pr_debug("Couldn't parse response.\n");
-		return -EINVAL;
-	}
 	resp->num = num_entries;

 	return 0;
--
2.17.1

