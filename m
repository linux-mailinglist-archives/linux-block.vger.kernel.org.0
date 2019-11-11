Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA88F8229
	for <lists+linux-block@lfdr.de>; Mon, 11 Nov 2019 22:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfKKVSw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 11 Nov 2019 16:18:52 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34080 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfKKVSw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Nov 2019 16:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573507133; x=1605043133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I0Au4ydjiedNzQQKsqqRTc1ReUvzEDkcVQjLVZRbLj8=;
  b=J5Wx6VHl48CDfdf/sIfLLikap7iXPRgv4jSUmN9Y/YI39gTnuaQUir+Z
   tCzR/gpaUHgsViXF1Jh7jJ3J2VlG39Ne1oMpjYTX/uZlBS1CnTGhtuBST
   gb44bGS8ocaqBRl9OIFnMy0hvCh9un6LHJHju8GSgzAwJs45+DALvcj8B
   mKf4GdDIyFvYsG4R6pnPagmU8qZ5Cw5n7+KdVpvivQZ3aWvVF5CMgvvNZ
   Pt6cxiXLNNniU31oKfq50JHTOs7aBnb2R8X3l1ROTesDBhk+h4e/yqJ3Q
   TgAl7A4X+0qs+wrs0bQBoc5HFrmgyYiEuZmzZKfWnSIrQpGmWOXpNiL3X
   A==;
IronPort-SDR: CihNmio72bqYx5xf9uuOwbU827vqcD1ublvTF+SfU0AHCAmTTxZbm1bxTl50jpzyOSml7Zexus
 Ypl3f4GRKy3lg1c1eJa4hvpbMOb8LI4nML0f9hiYve9Ozmzh9AoDB72a+v/odaZSvoMw7ZDMiw
 eBkkX4qVRAHglLlrL3FVcNYPzFJNfxPUrTXlIchxAT67nO1rbGIxBiI5n88E9nc4iSgcCmvXoZ
 5ufcXXQcQvAMNhUaebkt35QQn7KPTWcSD+RozVoBOlW+FQ6pBs2ZcLCw7bjPzFkunWgCAp/RUQ
 bnU=
X-IronPort-AV: E=Sophos;i="5.68,293,1569254400"; 
   d="scan'208";a="124300391"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2019 05:18:53 +0800
IronPort-SDR: /PBW8RulWETRRffyIvWvF8kyt15VgRUowXg8wiPJwVVxQnyxYDLIKdPpRAZJsS6ax2a4EPJOdf
 YSKBndXqo6+ONnSb697unVR2BrFxiNk1QDJ7afI4QKT8ZL3FWqwCMwyENwoXQEzLIkNoGuLMWM
 zgqBknexoSjCyCuc4nst7hmkqyMplm1DAQ7m4uz6MDYakJ9dtqRHDUXP859rz4fdvXA1y7rXUO
 aSczEJzDwhEADfl48j3s9RV4G1TuWsiGBlKIEjtTfa+83FVW4Opk1iRZkCl5NPJen9qQxVxzQh
 pVJIUxDphO1Ym/eKGJjKbI78
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 13:13:55 -0800
IronPort-SDR: hxvmqW1SUcvkll+hfxyHX5om+ykb9m2YLJ4U9KQMhRfDUDNEptUIEdbjYMx6nlp8byqqwYftGv
 PbYm+/Yyl2bI8LB7m6b+qqCK0+6ITIPgTZmF8bwsYY9O5FUd8asw5WDcvx7eEEgHK0BrYQRhB+
 Xk4um2BdHjTeoDp/ycIxiBO1NXHnwIzUAsQASvWDU+A5ke0K9lAfRzn7dYwPieWC6DXghfG8ah
 nKIVXbrXaVjrxcpzKc0qqtfN5ejgz2pq+VrLo4wl+FmCdDpleTS4qMfy0F4w/LWhdPLeBenOfG
 MGA=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com) ([10.6.138.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Nov 2019 13:18:52 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 2/2] block: allow zone_mgmt_ops to bail out on SIGKILL
Date:   Mon, 11 Nov 2019 13:18:44 -0800
Message-Id: <20191111211844.5922-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191111211844.5922-1-chaitanya.kulkarni@wdc.com>
References: <20191111211844.5922-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch is on the similar concept which is posted earlier:-
https://marc.info/?l=linux-block&m=157321402002207&w=2.

This allows zone-mgmt ops to handle SIGKILL.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/blk-zoned.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 481eaf7d04d4..8f0f740d89e8 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -286,12 +286,15 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 		sector += zone_sectors;
 
 		/* This may take a while, so be nice to others */
-		cond_resched();
+		ret = blk_should_abort(bio);
+		if (ret)
+			goto out;
 	}
 
 	ret = submit_bio_wait(bio);
 	bio_put(bio);
 
+out:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blkdev_zone_mgmt);
-- 
2.22.1

