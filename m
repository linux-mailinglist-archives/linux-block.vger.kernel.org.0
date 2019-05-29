Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E58312D75B
	for <lists+linux-block@lfdr.de>; Wed, 29 May 2019 10:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfE2IJm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 May 2019 04:09:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfE2IJm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 04:09:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE34A3087958;
        Wed, 29 May 2019 08:09:41 +0000 (UTC)
Received: from rhel3.localdomain (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A22C36148C;
        Wed, 29 May 2019 08:09:38 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk, nbd@other.debian.org
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, atumball@redhat.com,
        Xiubo Li <xiubli@redhat.com>
Subject: [RFC PATCH] nbd: set the default nbds_max to 0
Date:   Wed, 29 May 2019 16:08:36 +0800
Message-Id: <20190529080836.13031-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 29 May 2019 08:09:42 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

There is one problem that when trying to check the nbd device
NBD_CMD_STATUS and at the same time insert the nbd.ko module,
we can randomly get some of the 16 /dev/nbd{0~15} are connected,
but they are not. This is because that the udev service in user
space will try to open /dev/nbd{0~15} devices to do some sanity
check when they are added in "__init nbd_init()" and then close
it asynchronousely.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---

Not sure whether this patch make sense here, coz this issue can be
avoided by setting the "nbds_max=0" when inserting the nbd.ko modules.



 drivers/block/nbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 4c1de1c..98be6ca 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -137,7 +137,7 @@ struct nbd_cmd {
 
 #define NBD_DEF_BLKSIZE 1024
 
-static unsigned int nbds_max = 16;
+static unsigned int nbds_max;
 static int max_part = 16;
 static struct workqueue_struct *recv_workqueue;
 static int part_shift;
@@ -2310,6 +2310,6 @@ static void __exit nbd_cleanup(void)
 MODULE_LICENSE("GPL");
 
 module_param(nbds_max, int, 0444);
-MODULE_PARM_DESC(nbds_max, "number of network block devices to initialize (default: 16)");
+MODULE_PARM_DESC(nbds_max, "number of network block devices to initialize (default: 0)");
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "number of partitions per device (default: 16)");
-- 
1.8.3.1

