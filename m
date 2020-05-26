Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323E41D1A86
	for <lists+linux-block@lfdr.de>; Wed, 13 May 2020 18:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbgEMQEF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 12:04:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:43198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733083AbgEMQEE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 12:04:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 56CF5AE95;
        Wed, 13 May 2020 16:04:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5532E1E12AE; Wed, 13 May 2020 18:04:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] blkparse: Print PID information for TN_MESSAGE events
Date:   Wed, 13 May 2020 18:04:02 +0200
Message-Id: <20200513160402.8050-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The kernel now provides PID information for TN_MESSAGE events. Print it.
Old kernels fill 0 there so the behavior is unaffected for them.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 blkparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blkparse.c b/blkparse.c
index ae4cb4433944..911309e26a15 100644
--- a/blkparse.c
+++ b/blkparse.c
@@ -643,7 +643,7 @@ static void handle_notify(struct blk_io_trace *bit)
 				MAJOR(bit->device), MINOR(bit->device),
 				bit->cpu, "0", (int)SECONDS(bit->time),
 				(unsigned long)NANO_SECONDS(bit->time),
-				0, cgidstr, "m", "N", msg);
+				bit->pid, cgidstr, "m", "N", msg);
 		}
 		break;
 
-- 
2.16.4

