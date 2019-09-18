Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5D09B618B
	for <lists+linux-block@lfdr.de>; Wed, 18 Sep 2019 12:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfIRKi4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 18 Sep 2019 06:38:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34980 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbfIRKi4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Sep 2019 06:38:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id y21so1978371wmi.0
        for <linux-block@vger.kernel.org>; Wed, 18 Sep 2019 03:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yYuOfi6SRpI0pisf6okbAWwjxdq6TT7Dd4t8NehGj3k=;
        b=P8PJaeWyFpty1cB9YHCqKvCTTWMWK0nWXQ+nzYkZdFv0c9YfzcSZGX6CJ7KYmTtUDF
         liF3SCWikSVOf4EiWOrUEY463Tt7EGH6/SWNIa1yChhgvRNOzBFZUNH8kLE4ZgMKnx/+
         TCaNRDfKDUQqVO0caACcS9V6xUwNMLj1ApPIn7zHdMP0MMkj4cVKWzGZt7Xj6FITUuml
         LzK8n7fOHGaEAwU6mncYnFuMt7EIDEL2iI3Xiq4oG2pmV/ycr5l5pVTku0ItoDzb7Fyd
         9pK9d/3a0E/jBIy3sYbXF90d/coyoH3lDfZFCL+qsF3RFHhv6UsAuWHwUhnvHNw4erMq
         rnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yYuOfi6SRpI0pisf6okbAWwjxdq6TT7Dd4t8NehGj3k=;
        b=Bm1EMCP/O6IvcEHjawHBzKVnDotGpNdRqT3aUL0iOeAlztivD/BA+XuL/D2qBq8h7H
         8XwgmdTxS5GOiQs4m7n1/HSdGnEpAV0tAnjMl48W1X94IEJgcSOCQuEbRJYhGcmJmudU
         DIuKknUYSgsB1JIh+EcQUFmlywlJzAz/a0OFVFHZeHkX+ee2TIl7ogozdrJL/ptwrrez
         CUEJp5UZwMgwEbj2exOxawJRTzEox+PynwapIQRjMhb92HenEYMg9eAOHp644g++EAoS
         2HSkY1LO1lpr3TykeAhcFDBOSOaWQ9cGNDWdFD8b9m3jYXSSNMj9HUC9FZSglaXZFKYw
         TDFQ==
X-Gm-Message-State: APjAAAVBTSTHvPzrDPsXO77Zz1lKNc9omlbjNHqeY8upOzH39D7sJUdH
        R6Gulyw9FvBo4KvxoTbTKaihEQzxX8R+aA==
X-Google-Smtp-Source: APXvYqyiY17RMt+LzMSEzkyulXEt5507TcTU9m37clIy3bS1NeFO+C7SqXCv51y3xJGJDfG+KnoKfQ==
X-Received: by 2002:a1c:c189:: with SMTP id r131mr2301208wmf.153.1568803132510;
        Wed, 18 Sep 2019 03:38:52 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id a13sm12721867wrf.73.2019.09.18.03.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 03:38:52 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Alessio Balsini <balsini@android.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: Fix implicit unsigned to signed conversion
Date:   Wed, 18 Sep 2019 11:38:28 +0100
Message-Id: <20190918103828.257631-1-balsini@android.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

An unsigned integer variable may be assigned negative values, and is
returned by the function with an implicit conversion to signed.  Besides
the implicit conversion at return time for which the variable
representation is fine and there is no variable manipulation that may
lead to bugs in the current code base, this is a conceptual error.

Fix by changing the variable type from unsigned to signed.

Signed-off-by: Alessio Balsini <balsini@android.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 block/blk-settings.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 6bd1e3b082d8..c76c25c45869 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -496,7 +496,8 @@ EXPORT_SYMBOL(blk_queue_stack_limits);
 int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		     sector_t start)
 {
-	unsigned int top, bottom, alignment, ret = 0;
+	unsigned int top, bottom, alignment;
+	int ret = 0;
 
 	t->max_sectors = min_not_zero(t->max_sectors, b->max_sectors);
 	t->max_hw_sectors = min_not_zero(t->max_hw_sectors, b->max_hw_sectors);
-- 
2.23.0.237.gc6a4ce50a0-goog

