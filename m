Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C2B69BD58
	for <lists+linux-block@lfdr.de>; Sat, 18 Feb 2023 23:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjBRWCV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 18 Feb 2023 17:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjBRWCR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Feb 2023 17:02:17 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20BDA12BC5;
        Sat, 18 Feb 2023 14:02:08 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id B10C87A071B;
        Sat, 18 Feb 2023 23:02:03 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/18] pata_parport: remove bpck6 verbose parameter
Date:   Sat, 18 Feb 2023 23:01:34 +0100
Message-Id: <20230218220138.5692-15-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230218220138.5692-1-linux@zary.sk>
References: <20230218220138.5692-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove now useless verbose parameter of bpck6 module.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck6.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index f144e1b3cacb..f0ab30fa739a 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -30,10 +30,6 @@
 #include "ppc6lnx.c"
 #include <linux/pata_parport.h>
 
-/* PARAMETERS */
-static bool verbose; /* set this to 1 to see debugging messages and whatnot */
- 
-
 #define PPCSTRUCT(pi) ((Interface *)(pi->private))
 
 /****************************************************************/
@@ -220,5 +216,4 @@ static struct pi_protocol bpck6 = {
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Micro Solutions Inc.");
 MODULE_DESCRIPTION("BACKPACK Protocol module, compatible with PARIDE");
-module_param(verbose, bool, 0644);
 module_pata_parport_driver(bpck6);
-- 
Ondrej Zary

