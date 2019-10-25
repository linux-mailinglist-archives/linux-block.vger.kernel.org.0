Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B409E4413
	for <lists+linux-block@lfdr.de>; Fri, 25 Oct 2019 09:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406097AbfJYHJD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 25 Oct 2019 03:09:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:54228 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405843AbfJYHJD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 03:09:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5499FAD76;
        Fri, 25 Oct 2019 07:09:02 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Coly Li <colyli@suse.com>, Neil Brown <neilb@suse.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH] md/raid1: avoid soft lockup under high load
Date:   Fri, 25 Oct 2019 09:08:56 +0200
Message-Id: <20191025070856.76761-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As all I/O is being pushed through a kernel thread the softlockup
watchdog might be triggered under high load.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/raid1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index d37a55f8e461..d7543805e9ff 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -821,6 +821,7 @@ static void flush_bio_list(struct r1conf *conf, struct bio *bio)
 		else
 			generic_make_request(bio);
 		bio = next;
+		cond_resched();
 	}
 }
 
-- 
2.16.4

