Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27813B5B7A
	for <lists+linux-block@lfdr.de>; Mon, 28 Jun 2021 11:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhF1Jmz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 28 Jun 2021 05:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbhF1Jmz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jun 2021 05:42:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1924C061574
        for <linux-block@vger.kernel.org>; Mon, 28 Jun 2021 02:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=R66QSLbOFCWvlVRtJ6T98lmstmrk2uoFiCZavVLSWfs=; b=s6xpNRRPJahtY5xw+F+jwfWQ7B
        rggIyCZzvrr8A0GR0Cl+FMzAZwpC6zWjlF/+XEgfFJtfsdoRX+8RQlyfrtjvOsrmeIevQapZyrTkG
        g7bP06LRX/g/aqB1vpVybk3WaeIzcMTbzJB8xooPxhu3pGW60C8vuTG8R7qgsSrofwjA9L14uG4qo
        Ma9RHMa3B+2enDxlA3pxMXnHcDM1lrJxuDPsUV6FvjWIWZMOhlYgsIDcuQepC+uBA1phgVAtwnwYF
        6sKNR2dMu38Kxv6KspyOtt8Q5iPpwPYRl+9f3Gy/IyMdWWn4/R6H7EM8D9QHQv83221Dpsyl3Ubbq
        m/EtowqA==;
Received: from [2001:4bb8:180:285:1edd:a6ea:5791:8644] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxnju-002nEt-EN; Mon, 28 Jun 2021 09:39:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     linux-um@lists.infradead.org, linux-block@vger.kernel.org
Subject: [PATCH] ubd: remove dead code in ubd_setup_common
Date:   Mon, 28 Jun 2021 11:39:37 +0200
Message-Id: <20210628093937.1325608-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove some leftovers of the fake major number parsing that cause
complains from some compilers.

Fixes: aebbd9fdb0cc ("ubd: remove the code to register as the legacy IDE driver")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 0b86aa1b12f1..e3093071406d 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -243,22 +243,12 @@ static int ubd_setup_common(char *str, int *index_out, char **error_out)
 	if(index_out) *index_out = -1;
 	n = *str;
 	if(n == '='){
-		char *end;
-		int major;
-
 		str++;
 		if(!strcmp(str, "sync")){
 			global_openflags = of_sync(global_openflags);
 			return err;
 		}
 
-		err = -EINVAL;
-		major = simple_strtoul(str, &end, 0);
-		if((*end != '\0') || (end == str)){
-			*error_out = "Didn't parse major number";
-			return err;
-		}
-
 		pr_warn("fake major not supported any more\n");
 		return 0;
 	}
-- 
2.30.2

