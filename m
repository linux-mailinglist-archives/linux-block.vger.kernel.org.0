Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794F1697153
	for <lists+linux-block@lfdr.de>; Wed, 15 Feb 2023 00:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjBNXA0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 Feb 2023 18:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjBNXAZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2023 18:00:25 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC3C2298C1;
        Tue, 14 Feb 2023 15:00:21 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 337CF7A058D;
        Wed, 15 Feb 2023 00:00:19 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/18] pata_parport: Remove pi_swab16 and pi_swab32
Date:   Tue, 14 Feb 2023 23:59:55 +0100
Message-Id: <20230214230010.20318-4-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230214230010.20318-1-linux@zary.sk>
References: <20230214230010.20318-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Convert comm and kbic drivers to use standard swab16.
Remove pi_swab16 and pi_swab32.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/comm.c |  7 +++++--
 drivers/ata/pata_parport/kbic.c |  7 +++++--
 include/linux/pata_parport.h    | 17 -----------------
 3 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/pata_parport/comm.c b/drivers/ata/pata_parport/comm.c
index 1775e7ed9336..11ed9fb57744 100644
--- a/drivers/ata/pata_parport/comm.c
+++ b/drivers/ata/pata_parport/comm.c
@@ -165,11 +165,14 @@ static void comm_write_block( PIA *pi, char * buf, int count )
                 break;
 
         case 3: w3(0x48); (void)r1();
-                for (k=0;k<count/2;k++) w4w(pi_swab16(buf,k));
+		for (k = 0; k < count / 2; k++)
+			w4w(swab16(((u16 *)buf)[k]));
                 break;
 
         case 4: w3(0x48); (void)r1();
-                for (k=0;k<count/4;k++) w4l(pi_swab32(buf,k));
+		for (k = 0; k < count / 4; k++)
+			w4l(swab16(((u16 *)buf)[2 * k]) |
+			    swab16(((u16 *)buf)[2 * k + 1]) << 16);
                 break;
 
 
diff --git a/drivers/ata/pata_parport/kbic.c b/drivers/ata/pata_parport/kbic.c
index f0960eb68635..93430ca32a52 100644
--- a/drivers/ata/pata_parport/kbic.c
+++ b/drivers/ata/pata_parport/kbic.c
@@ -213,12 +213,15 @@ static void kbic_write_block( PIA *pi, char * buf, int count )
 		break;
 
 	case 4: w0(0xa0); w2(4); w2(6); w2(4); w3(0);
-                for(k=0;k<count/2;k++) w4w(pi_swab16(buf,k));
+		for (k = 0; k < count / 2; k++)
+			w4w(swab16(((u16 *)buf)[k]));
                 w2(4); w2(0); w2(4);
                 break;
 
         case 5: w0(0xa0); w2(4); w2(6); w2(4); w3(0);
-                for(k=0;k<count/4;k++) w4l(pi_swab32(buf,k));
+		for (k = 0; k < count / 4; k++)
+			w4l(swab16(((u16 *)buf)[2 * k]) |
+			    swab16(((u16 *)buf)[2 * k + 1]) << 16);
                 w2(4); w2(0); w2(4);
                 break;
 
diff --git a/include/linux/pata_parport.h b/include/linux/pata_parport.h
index 58781846f282..458544fe5e6c 100644
--- a/include/linux/pata_parport.h
+++ b/include/linux/pata_parport.h
@@ -54,23 +54,6 @@ typedef struct pi_adapter PIA;	/* for paride protocol modules */
 #define r4w()			(delay_p, inw(pi->port + 4))
 #define r4l()			(delay_p, inl(pi->port + 4))
 
-static inline u16 pi_swab16(char *b, int k)
-{
-	union { u16 u; char t[2]; } r;
-
-	r.t[0] = b[2 * k + 1]; r.t[1] = b[2 * k];
-	return r.u;
-}
-
-static inline u32 pi_swab32(char *b, int k)
-{
-	union { u32 u; char f[4]; } r;
-
-	r.f[0] = b[4 * k + 1]; r.f[1] = b[4 * k];
-	r.f[2] = b[4 * k + 3]; r.f[3] = b[4 * k + 2];
-	return r.u;
-}
-
 struct pi_protocol {
 	char name[8];
 
-- 
Ondrej Zary

