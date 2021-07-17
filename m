Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6113CC33E
	for <lists+linux-block@lfdr.de>; Sat, 17 Jul 2021 14:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbhGQMgc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 17 Jul 2021 08:36:32 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:55452 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhGQMgc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Jul 2021 08:36:32 -0400
Received: from localhost (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id B5A55B3A131;
        Sat, 17 Jul 2021 14:33:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1626525214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SD0R3zYxm1t/0uzxERpXDObXCsoS886xQ4oYuK4JvFQ=;
        b=TUdwv1Is81UuNOHvc02lrew+ITkwqXP258zdpyM4UJqjxEHo4fA/hKv987fsuqcH7uLXnf
        Yn36cuzPlVPYF2CFI2L1Ty74q3GF6NOBM6h4D2rZ6lQqURI6rPGFohtmUqTZoSwkwS6emy
        n1Hl3sVJJ/Nejvs/bMgtTAYmzEg76KM=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        David Jeffery <djeffery@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] block: increase BLKCG_MAX_POLS
Date:   Sat, 17 Jul 2021 14:33:28 +0200
Message-Id: <20210717123328.945810-1-oleksandr@natalenko.name>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After mq-deadline learnt to deal with cgroups, the BLKCG_MAX_POLS value
became too small for all the elevators to be registered properly. The
following issue is seen:

```
calling  bfq_init+0x0/0x8b @ 1
blkcg_policy_register: BLKCG_MAX_POLS too small
initcall bfq_init+0x0/0x8b returned -28 after 507 usecs
```

and BFQ is non-functional.

Increase BLKCG_MAX_POLS to allow space for everyone

Link: https://lore.kernel.org/lkml/8988303.mDXGIdCtx8@natalenko.name/
Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3177181c4326..d3afea47ade6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -57,7 +57,7 @@ struct blk_keyslot_manager;
  * Maximum number of blkcg policies allowed to be registered concurrently.
  * Defined here to simplify include dependency.
  */
-#define BLKCG_MAX_POLS		5
+#define BLKCG_MAX_POLS		6
 
 typedef void (rq_end_io_fn)(struct request *, blk_status_t);
 
-- 
2.32.0

