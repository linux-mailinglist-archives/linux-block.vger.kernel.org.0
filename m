Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB11286C4E
	for <lists+linux-block@lfdr.de>; Thu,  8 Oct 2020 03:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgJHBCC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 7 Oct 2020 21:02:02 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50629 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgJHBCC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Oct 2020 21:02:02 -0400
X-Greylist: delayed 2267 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Oct 2020 21:02:01 EDT
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0980Ntjp043957;
        Thu, 8 Oct 2020 09:23:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Thu, 08 Oct 2020 09:23:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0980No8b043905
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 8 Oct 2020 09:23:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] block: ratelimit handle_bad_sector() message
Date:   Thu,  8 Oct 2020 09:23:44 +0900
Message-Id: <20201008002344.6759-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot is reporting unkillable task [1], for the caller is failing to
handle a corrupted filesystem image which attempts to access beyond
the end of the device. While we need to fix the caller, flooding the
console with handle_bad_sector() message is unlikely useful.

[1] https://syzkaller.appspot.com/bug?id=f1f49fb971d7a3e01bd8ab8cff2ff4572ccf3092

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 block/blk-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 10c08ac50697..8b67b6e941db 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -803,8 +803,8 @@ static void handle_bad_sector(struct bio *bio, sector_t maxsector)
 {
 	char b[BDEVNAME_SIZE];
 
-	printk(KERN_INFO "attempt to access beyond end of device\n");
-	printk(KERN_INFO "%s: rw=%d, want=%Lu, limit=%Lu\n",
+	printk_ratelimited(KERN_INFO "attempt to access beyond end of device\n");
+	printk_ratelimited(KERN_INFO "%s: rw=%d, want=%Lu, limit=%Lu\n",
 			bio_devname(bio, b), bio->bi_opf,
 			(unsigned long long)bio_end_sector(bio),
 			(long long)maxsector);
-- 
2.18.4

