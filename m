Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DA2368A3B
	for <lists+linux-block@lfdr.de>; Fri, 23 Apr 2021 03:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbhDWBLt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 22 Apr 2021 21:11:49 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:36643 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239988AbhDWBLs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 21:11:48 -0400
Received: by mail-pg1-f178.google.com with SMTP id j7so24684865pgi.3;
        Thu, 22 Apr 2021 18:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Nd0WMy8FgoUcWvM9UFTgpm8olPpZGQk9fdjC/twA98=;
        b=LvtG+By7aPGuetm7jNlZH6N4CiYk16xaiHS9lmauSBAwV464JLVsNnJ5lv5147km7m
         O6HjVrdOf4Mb0d8H5i12tKVjOokQmj6IkNyDuGucV7TIOjnaXmiusXMZ8gc265KA64HB
         vhW6/krAIpOaz9cfIL8PUEgjShFL6VhnHPF7ciK9m762K/7bIuWFhDQSAuB/3YT7l2K/
         S3s5Az1eGzZ5nlp4pHnsFNRoXZdWZLgbSyuFe3fOQjf8A8idaKlJn4FJrSHUW1Bqurow
         mYoSS2phFJdvq6ok4iTlOszikXGgFKFCmzTDwTEFODjaSWd96805bUIGDSCF0dLkC/+q
         WiQw==
X-Gm-Message-State: AOAM533Zpcl2iH2qn1Jvh3nOAbhLuotcr6Z+HBTqrrXv7ta56Qx88rM9
        D+h+vuZag5kdHdKN1TaZ5BM=
X-Google-Smtp-Source: ABdhPJwnIMemlD0RK3cg40N+3rroRHEKXBYJfwNMrQN6HHgzEdjmub94djzGU5kpV6rMXs1iOAMegg==
X-Received: by 2002:a63:1357:: with SMTP id 23mr1412832pgt.284.1619140272615;
        Thu, 22 Apr 2021 18:11:12 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id z26sm3050247pfr.106.2021.04.22.18.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 18:11:10 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 5753A418C0; Fri, 23 Apr 2021 01:11:09 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     mcgrof@kernel.org, axboe@kernel.dk, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] zram: avoid disksize setting when device is being claimed
Date:   Fri, 23 Apr 2021 01:11:06 +0000
Message-Id: <20210423011108.11988-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210423011108.11988-1-mcgrof@kernel.org>
References: <20210423011108.11988-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As with other areas of the zram diver, check if the zram
block device is being claimed but do it early to avoid
trying to set something up for a zram device which may
be on its way out.

This doesn't fix a known crash, however the potential for
an issue issue is found through code inspection.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 431b60cd85c1..6051d20b88c3 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1729,7 +1729,7 @@ static ssize_t disksize_store(struct device *dev,
 
 	mutex_lock(&zram_index_mutex);
 
-	if (!zram_up) {
+	if (!zram_up || zram->claim) {
 		err = -ENODEV;
 		goto out;
 	}
-- 
2.27.0

