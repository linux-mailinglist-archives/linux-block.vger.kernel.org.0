Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1976416AA
	for <lists+linux-block@lfdr.de>; Sat,  3 Dec 2022 13:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLCM0b (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 3 Dec 2022 07:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLCM0b (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 3 Dec 2022 07:26:31 -0500
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 03 Dec 2022 04:26:30 PST
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9204F2D1C0
        for <linux-block@vger.kernel.org>; Sat,  3 Dec 2022 04:26:30 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 1RTspiirkpJKl1RTtpLW6C; Sat, 03 Dec 2022 13:18:58 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 03 Dec 2022 13:18:58 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-block@vger.kernel.org
Subject: [PATCH] block: sed-opal: Don't include <linux/kernel.h>
Date:   Sat,  3 Dec 2022 13:18:49 +0100
Message-Id: <a2de79b3de30fe70c457953af935dadd49441f00.1670069909.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no need to include <linux/kernel.h> here.

Prefer the less invasive <linux/types.h> and <linux/compiler_types.h>
which are needed in this .h file itself.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Let see if build-bots agree with me!
---
 include/linux/sed-opal.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 6f837bb6c715..87f981c70894 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -11,7 +11,9 @@
 #define LINUX_OPAL_H
 
 #include <uapi/linux/sed-opal.h>
-#include <linux/kernel.h>
+
+#include <linux/compiler_types.h>		/* for __user */
+#include <linux/types.h>
 
 struct opal_dev;
 
-- 
2.34.1

