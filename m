Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D4EB9FD4
	for <lists+linux-block@lfdr.de>; Sun, 22 Sep 2019 00:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfIUWBA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 21 Sep 2019 18:01:00 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46342 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725446AbfIUWBA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Sep 2019 18:01:00 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 22 Sep 2019 01:00:54 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x8LM0nBv031982;
        Sun, 22 Sep 2019 01:00:49 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com
Cc:     Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 1/1] block: add default clause for unsupported T10_PI types
Date:   Sun, 22 Sep 2019 01:00:49 +0300
Message-Id: <1569103249-24018-1-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

kbuild robot reported the following warning:

block/t10-pi.c: In function 't10_pi_verify':
block/t10-pi.c:62:3: warning: enumeration value 'T10_PI_TYPE0_PROTECTION'
                     not handled in switch [-Wswitch]
      switch (type) {
      ^~~~~~

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 block/t10-pi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index 0c0120a..57f304a 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -79,6 +79,9 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 			    pi->ref_tag == T10_PI_REF_ESCAPE)
 				goto next;
 			break;
+		default:
+			/* Currently we support only TYPE1/2/3 */
+			BUG();
 		}
 
 		csum = fn(iter->data_buf, iter->interval);
-- 
1.8.3.1

