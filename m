Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850B2AFF1B
	for <lists+linux-block@lfdr.de>; Wed, 11 Sep 2019 16:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfIKOr4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Sep 2019 10:47:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56910 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbfIKOr4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 10:47:56 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id A9A02260785
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, axboe@kernel.dk, m@bjorling.me,
        kernel@collabora.com, krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 3/3] null_blk: validated the number of devices
Date:   Wed, 11 Sep 2019 11:46:36 -0300
Message-Id: <20190911144636.226945-3-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190911144636.226945-1-andrealmeid@collabora.com>
References: <20190911144636.226945-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no sense defining a negative number of devices, so change the type
to unsigned. If the number of devices is 0, it is impossible to the
userspace interact with the module, so there is no reasoning in loading
it.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 drivers/block/null_blk_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 7bc553ff7407..ab4b87677139 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -141,7 +141,7 @@ static int g_bs = 512;
 module_param_named(bs, g_bs, int, 0444);
 MODULE_PARM_DESC(bs, "Block size (in bytes)");
 
-static int nr_devices = 1;
+static unsigned int nr_devices = 1;
 module_param(nr_devices, int, 0444);
 MODULE_PARM_DESC(nr_devices, "Number of devices to register");
 
@@ -1758,6 +1758,10 @@ static int __init null_init(void)
 		pr_err("null_blk: legacy IO path no longer available\n");
 		return -EINVAL;
 	}
+	if (!nr_devices) {
+		pr_err("null_blk: invalid number of devices\n");
+		return -EINVAL;
+	}
 	if (g_queue_mode == NULL_Q_MQ && g_use_per_node_hctx) {
 		if (g_submit_queues != nr_online_nodes) {
 			pr_warn("null_blk: submit_queues param is set to %u.\n",
-- 
2.23.0

