Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7442B8263
	for <lists+linux-block@lfdr.de>; Wed, 18 Nov 2020 17:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgKRQyJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 18 Nov 2020 11:54:09 -0500
Received: from mga07.intel.com ([134.134.136.100]:25390 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgKRQyJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Nov 2020 11:54:09 -0500
IronPort-SDR: 9QnQvVPINyKM1arDRg/KvOwW04imsKzs8R0zxCWHbrrCYu+XQ8caFVKmYh5Pbxw+j22torBs6F
 fbXc9PrZmClA==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="235294715"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="235294715"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 08:54:05 -0800
IronPort-SDR: b+Me0fA2hfNwx+X46TMrYBI82RVTkrCUtHxSyR25hoePnkSSSplrZ9+/sMhT3iEsZC4Qv1KC6X
 K+ttF8smDYjQ==
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="325656162"
Received: from dlmurray-mobl3.ger.corp.intel.com (HELO localhost) ([10.251.82.13])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 08:54:03 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     jani.nikula@intel.com, intel-gfx@lists.freedesktop.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 6/6] blktrace: make relay callbacks const
Date:   Wed, 18 Nov 2020 18:53:20 +0200
Message-Id: <20201118165320.26829-6-jani.nikula@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201118165320.26829-1-jani.nikula@intel.com>
References: <20201118165320.26829-1-jani.nikula@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that relay_open() accepts const callbacks, make relay callbacks
const.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 kernel/trace/blktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index f1022945e346..b5c4b9ade960 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -449,7 +449,7 @@ static struct dentry *blk_create_buf_file_callback(const char *filename,
 					&relay_file_operations);
 }
 
-static struct rchan_callbacks blk_relay_callbacks = {
+static const struct rchan_callbacks blk_relay_callbacks = {
 	.subbuf_start		= blk_subbuf_start_callback,
 	.create_buf_file	= blk_create_buf_file_callback,
 	.remove_buf_file	= blk_remove_buf_file_callback,
-- 
2.20.1

