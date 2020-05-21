Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4A61DD672
	for <lists+linux-block@lfdr.de>; Thu, 21 May 2020 21:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgEUS75 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 May 2020 14:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729555AbgEUS75 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 May 2020 14:59:57 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F7AC061A0F
        for <linux-block@vger.kernel.org>; Thu, 21 May 2020 11:59:57 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id h16so7422926eds.5
        for <linux-block@vger.kernel.org>; Thu, 21 May 2020 11:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Ywk6LfudhfW/QxS6TT/2iEiv5VyTiN0xpyOE7piVw4=;
        b=i+fI4Gqf/Ohk+Vqa/qZmFeMmfSE5I8dtvu8vlQu9S59kga/51dcu3IcmgWYwKrOh44
         997Kt2i7SYbF9JqEpHwzP1AIiobUzugYQVSJ7q+NiobOlM689uT3//6sdxkGqJyVeG1P
         KBCsvIXDKeB0opXU5JA/ybuZ7Uc/+DS3UpzqFhKcz126TYpME8bPq+o8z+6wNL4Rm0ZC
         J2iaAbQTBVWes6M6Kjg+tSLsn9Va9D8kLTHtjKi+8RAvzHCs1zMUvKktuMI5eno5wDNR
         XEXvK1wt5ANk0SUlYXisqMnBXotOFNkdNP6cDk7RzBcyxtlEsUxgR42gUhk2VeMmPZFT
         rPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Ywk6LfudhfW/QxS6TT/2iEiv5VyTiN0xpyOE7piVw4=;
        b=GqzTP17vvW3o4FfDAR7DLeE0paQlldrVO6Nqy+dlNHn81oTsyFHa+yg1PFSTSvbX/0
         +1EE4mksbUNxy0M5KTSnjASBW2g/7ssn3F8mQVcRQ7yd0rBc9AKYZNV6ddZVI6s/3GKJ
         hMRgAI+BpN6c3p5+/DH9o1RogW3zBIcVB5kpHY1TB3106MycrUn6L9VrVjGWwwdZiCn+
         Od+PVYIV5/SwlVj8T+fNIIVHIIRllKD3953FX3/R0ie95l1XDaSMUo+n9ezxsuM6qE2y
         REsVG26MaWB25GdxBWxWhKFLOhN0/1pQSA3viVgN+nBJ6bFbZa1R9vtOC/Z6ItLNSMif
         /CWw==
X-Gm-Message-State: AOAM531O9oWaaDqHhygqUKgo1OUawOYpq+ZLy3A3hD3pSUYuclXAks+U
        48cGF7XwFhTjFVRGtuYws32LYA1qCA==
X-Google-Smtp-Source: ABdhPJx0d62NTCDUeOOm12GdNsFYQXlCIgeKz6/a2uCAOb9qssFSyy8B9j2Yq7mpSTZtypm9+6TF8g==
X-Received: by 2002:a50:9f02:: with SMTP id b2mr102475edf.29.1590087595328;
        Thu, 21 May 2020 11:59:55 -0700 (PDT)
Received: from dkxps.local (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id e9sm5493836edl.25.2020.05.21.11.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 11:59:54 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, rdunlap@infradead.org
Cc:     axboe@kernel.dk, bvanassche@acm.org, leon@kernel.org,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        guoqing.jiang@cloud.ionos.com
Subject: [PATCH] rnbd: fix compilation error when CONFIG_MODULES is disabled
Date:   Thu, 21 May 2020 20:59:09 +0200
Message-Id: <20200521185909.457245-1-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ca0729a1-2e4d-670d-2519-a175b3035b28@infradead.org>
References: <ca0729a1-2e4d-670d-2519-a175b3035b28@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

module_is_live function is only defined when CONFIG_MODULES is enabled.
Use try_module_get instead to check whether the module is being removed.

When module unload and manuall unmapping is happening in parallel, we can
try removing the symlink twice: rnbd_client_exit vs. rnbd_clt_unmap_dev_store.

This is probably not the best way to deal with this race in general, but for
now this fixes the compilation issue when CONFIG_MODULES is disabled and has
no functional impact. Regression tests passed.

Fixes: 1eb54f8f5dd8 ("block/rnbd: client: sysfs interface functions")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
v1->v2 Fix format of the "Fixes:" line
       Add Acked-by Randy Runlap <rdunlap@infradead.org>
 drivers/block/rnbd/rnbd-clt-sysfs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index a4508fcc7ffe..73d7cb40abb3 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -428,12 +428,14 @@ static struct attribute *rnbd_dev_attrs[] = {
 void rnbd_clt_remove_dev_symlink(struct rnbd_clt_dev *dev)
 {
 	/*
-	 * The module_is_live() check is crucial and helps to avoid annoying
-	 * sysfs warning raised in sysfs_remove_link(), when the whole sysfs
-	 * path was just removed, see rnbd_close_sessions().
+	 * The module unload rnbd_client_exit path is racing with unmapping of the
+	 * last single device from the sysfs manually i.e. rnbd_clt_unmap_dev_store()
+	 * leading to a sysfs warning because of sysfs link already was removed already.
 	 */
-	if (strlen(dev->blk_symlink_name) && module_is_live(THIS_MODULE))
+	if (strlen(dev->blk_symlink_name) && try_module_get(THIS_MODULE)) {
 		sysfs_remove_link(rnbd_devs_kobj, dev->blk_symlink_name);
+		module_put(THIS_MODULE);
+	}
 }
 
 static struct kobj_type rnbd_dev_ktype = {
-- 
2.25.1

