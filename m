Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2294AF8228
	for <lists+linux-block@lfdr.de>; Mon, 11 Nov 2019 22:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKKVSv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 11 Nov 2019 16:18:51 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34080 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfKKVSu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Nov 2019 16:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573507131; x=1605043131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K5sKMPgeIksrSAClxnZaXEp6l+eXrTOJWDsMHZAwG2U=;
  b=pzEy6M6xCL6WUy85bS079/okEH77P2KAViS+KUrvmV5XHWl9p2+dAqBT
   YnzTLAhKgSeO8jBviNEiyKmGOM4T+KqfCLGkK8QEBG4KyONN5eZB6A3Fq
   2WXiti9Sc91MkaNxAAw6r8u9yBYwDmn/zw26v0kmmbCxJX2o2brtZtJQ/
   vYu2qxFLDADKwCePl3xyQvfgwo/JmhHZewCrMXrn4/b15fmKPn3+pftAd
   0TtmmC6mmFaSKCUkWdk43GYMcGoWDl+4zBDsM/1JH1Kcp7D+EQ1jTYz1j
   ftlGGmBPBM+rSOK/Hu1OwTfhANWQxFOJ/rWFGdHgMbN85uOk3M+CET7Z9
   Q==;
IronPort-SDR: IsfUjFd+2I1Lo6WSILui88LInM9AKm22l4PuHbH9I+1Bfld3+BN9NISGL8cC8I5eXjwDgZvkti
 WVinmggOGPmhgbsFcVDcfx/ZdqsCfvDyWcSlr65rBYtR6K+DLvDX2KMyFId3rNSjdt81jETTcV
 99sTeEXLQ3Gd65d7QKPCfAJcnqnq+9l3GtRYM4CW8xq9nr0JGl7R/LnxxiKHxvPq5UTTCV8hFn
 QbIzzoG8pk922KUquo1//c4Zl63j7fUunJAvkZuJiG/w+46YVk9GT0pJHTICioaLEHne7W+3cB
 iG8=
X-IronPort-AV: E=Sophos;i="5.68,293,1569254400"; 
   d="scan'208";a="124300388"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2019 05:18:51 +0800
IronPort-SDR: 0Ndm6eClZTgLT8pnQ0lOjesYFhCHnWWeWqiDKVE5v7LEldPs4B7fQ1gfGJPfMsDe3fhhYh8KCp
 odTBMM5McnXfU3gBQkMUXgHKMzdSf7b/MZdUGqeHlyimi3HE+OuTncD/jkdrg2vMNPo5H9RPdX
 RmIBgg6sk16cvt6aekG23fTIkZZ4gR5kZAC7CNtxQqqhnS50xu5WqPu2fae2bt8VRzM6Of/Tdh
 n20M944su5uI4Q6R5hafvWsTf7Re1PWywQ19n1DVkz0kGYsNpr9US0dcHW1PUzMuWxtY8YD1LF
 ntIqgpW2Tx/LyBfm9QdFKnsL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 13:13:53 -0800
IronPort-SDR: agk6nxup0px58bsnkczWP7eVxry/DRbNRjwVirABMjIb+ol8Qr+47s92xpDaUuuyBFJMzZ35/Y
 JMS3usZek3Q3Ka/lxgHbwRfKnF/vBpzqDRu3TPUaCsxfFj4eahtVcHpQlsPv8ATFHpr/auCdy7
 YJU+pKMbpa95clieg2S1bQwsMznoM3ar/jf/jpjxz1QvDQ4cDjFO7ObDGAcfdu6l9e2YWY9KWp
 3ypUcEI3xmvJnMiMgR4TqCRBToJpb0gcJMR7CLy+OnqEbJhiP0Am9ldK9faPk+QN8bLnOX2Ugb
 rlE=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Nov 2019 13:18:50 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 1/2] block: export blk_should_abort()
Date:   Mon, 11 Nov 2019 13:18:43 -0800
Message-Id: <20191111211844.5922-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191111211844.5922-1-chaitanya.kulkarni@wdc.com>
References: <20191111211844.5922-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch exports blk_should_abort() function to avoid dulicate code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-lib.c | 3 ++-
 block/blk.h     | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 6ca7cae62876..c0afddb2a67b 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -11,7 +11,7 @@
 
 #include "blk.h"
 
-static int blk_should_abort(struct bio *bio)
+int blk_should_abort(struct bio *bio)
 {
 	int ret;
 
@@ -22,6 +22,7 @@ static int blk_should_abort(struct bio *bio)
 	bio_put(bio);
 	return ret ? ret : -EINTR;
 }
+EXPORT_SYMBOL(blk_should_abort);
 
 struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp)
 {
diff --git a/block/blk.h b/block/blk.h
index 2bea40180b6f..63fa4694d333 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -297,6 +297,8 @@ static inline struct io_context *create_io_context(gfp_t gfp_mask, int node)
 	return current->io_context;
 }
 
+int blk_should_abort(struct bio *bio);
+
 /*
  * Internal throttling interface
  */
-- 
2.22.1

