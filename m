Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B18FD12FC
	for <lists+linux-block@lfdr.de>; Wed,  9 Oct 2019 17:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfJIPiQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Oct 2019 11:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729865AbfJIPiQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Oct 2019 11:38:16 -0400
Received: from washi1.fujisawa.hgst.com (unknown [199.255.47.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5794B21848;
        Wed,  9 Oct 2019 15:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570635495;
        bh=dAhvtaqSKk7/BeCp/U43sNqmrx6iFLyPfHJcY88cPXQ=;
        h=From:To:Cc:Subject:Date:From;
        b=xJBRwxnismyYsN9LAK2nDGW1YS0jThVIL6lMlt00hZzoqt9vX5N4/wMmVLPuiWbdl
         P5OgbNGrDTpJBg8zHYT2rEXxlDLiS66SmlVBgcPQiBSQgqek2BtwZK84IrBHD46joS
         j7giOMFD1mEUZg/ptVqRWTv5IrQXf3QZsW+LFh28=
From:   kbusch@kernel.org
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] null_blk: Fix zoned command return code
Date:   Thu, 10 Oct 2019 00:38:13 +0900
Message-Id: <20191009153813.4854-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The return code from null_handle_zoned() sets the cmd->error value. Returning
OK status when an error occured overwrites the intended cmd->error. Return the
appropriate error code instead of setting the error in the cmd.

Fixes: fceb5d1b19cbe626 ("null_blk: create a helper for zoned devices")
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/block/null_blk_zoned.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index eabc116832a7..3d7fdea872f8 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -142,8 +142,7 @@ static blk_status_t null_zone_reset(struct nullb_cmd *cmd, sector_t sector)
 		zone->wp = zone->start;
 		break;
 	default:
-		cmd->error = BLK_STS_NOTSUPP;
-		break;
+		return BLK_STS_NOTSUPP;
 	}
 	return BLK_STS_OK;
 }
-- 
2.21.0

