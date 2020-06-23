Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0786205BA6
	for <lists+linux-block@lfdr.de>; Tue, 23 Jun 2020 21:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbgFWTSD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Jun 2020 15:18:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36725 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733308AbgFWTSB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 15:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592939880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pEwcRgLvtMw24J+haf2mTbN9rcYAaYqY5Ij/FN/Jf0=;
        b=R6rlJ4GEa/Zb4o3C+1+OY9OruU/Vq06n4eiFYzwD4pJtvaQELG7jmGMSPCZIXXVM2wFk7p
        ow6kxYfF1jEYD7o0D7r8dqdLGkD0Z8KeWZbOx7ENW0UT+l9B/+q8WmMdSQHhHuRPj9ngEG
        NPjFYkS5FrmFBy7NTFMsargoCVB6bZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-HZBeNS4BOFK4k7JsVqXFwQ-1; Tue, 23 Jun 2020 15:17:59 -0400
X-MC-Unique: HZBeNS4BOFK4k7JsVqXFwQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8344410059A5;
        Tue, 23 Jun 2020 19:17:58 +0000 (UTC)
Received: from sulaco.redhat.com (unknown [10.3.128.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 730E171699;
        Tue, 23 Jun 2020 19:17:57 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: [RFC PATCH v3 5/8] ata_dev_printk: Use dev_printk
Date:   Tue, 23 Jun 2020 14:17:46 -0500
Message-Id: <20200623191749.115200-6-tasleson@redhat.com>
In-Reply-To: <20200623191749.115200-1-tasleson@redhat.com>
References: <20200623191749.115200-1-tasleson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Utilize the dev_printk function which will add structured data
to the log message.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 drivers/ata/libata-core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index beca5f91bb4c..44c874367fe3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6475,6 +6475,7 @@ EXPORT_SYMBOL(ata_link_printk);
 void ata_dev_printk(const struct ata_device *dev, const char *level,
 		    const char *fmt, ...)
 {
+	const struct device *gendev;
 	struct va_format vaf;
 	va_list args;
 
@@ -6483,9 +6484,12 @@ void ata_dev_printk(const struct ata_device *dev, const char *level,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	printk("%sata%u.%02u: %pV",
-	       level, dev->link->ap->print_id, dev->link->pmp + dev->devno,
-	       &vaf);
+	gendev = (dev->sdev) ? &dev->sdev->sdev_gendev : &dev->tdev;
+
+	dev_printk(level, gendev, "ata%u.%02u: %pV",
+			dev->link->ap->print_id,
+			dev->link->pmp + dev->devno,
+			&vaf);
 
 	va_end(args);
 }
-- 
2.25.4

