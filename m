Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6C23CADD9
	for <lists+linux-block@lfdr.de>; Thu, 15 Jul 2021 22:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhGOU0z (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 15 Jul 2021 16:26:55 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:40542 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhGOU0w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 16:26:52 -0400
Received: by mail-pf1-f172.google.com with SMTP id j199so6596098pfd.7;
        Thu, 15 Jul 2021 13:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3khaOBDF2TUjaEauEhoMcOwHkFhcJLZPkymfQXVmPI=;
        b=ZnJVOA7DJ7cp5ND2zwUNE9b4j9Y+1IgMTlUv9YwJeL0BfLkruQPyeso7pKPKzuUnHP
         yvc9XemyppdKU8sMPrLrmDNR6P/A7d5OqlBHHduha+RQ+KouNwwpi++CYRxJEf94iJU7
         g7zmAgjrOqJrNh/VbGDCsFYyQ3gOqrUdzH62vEYI2paJIsTAMbutNisw8oVcXtX6srmr
         ZKK36O/CGvNSuJk229SAuPtc8LWomEBMrw6BqsSzexJxbv6dYjtAh68DMtAjq1YB6oW/
         ndxQka5FxGVMq3E0cheRqasxJInnDDEOGFNNPvYAe4HHlB13swUBWr+pVLXKpMUjzfJE
         EpWQ==
X-Gm-Message-State: AOAM533lgb0JkWXZcx9fyQS28lSlaDYBJaE6pL6AMSBiIyzOk+QjFSVA
        bPL0S5UI3+GutgZD1eLPePE=
X-Google-Smtp-Source: ABdhPJwMkNVjgzSLc5UCcrstUsKbyccL9VC2+JdMEDS+lXn9apVBaieeh8RJ/W2InjB5Bn+yUSoV3Q==
X-Received: by 2002:a63:1214:: with SMTP id h20mr6104040pgl.355.1626380638828;
        Thu, 15 Jul 2021 13:23:58 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id u23sm9029639pgk.38.2021.07.15.13.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:23:58 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 6/6] fs/block_dev: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED
Date:   Thu, 15 Jul 2021 13:23:41 -0700
Message-Id: <20210715202341.2016612-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715202341.2016612-1-mcgrof@kernel.org>
References: <20210715202341.2016612-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The GENHD_FL_DISK_ADDED flag is what we really want, as the
flag GENHD_FL_UP could be set on a semi-initialized device.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/block_dev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0c424a0cadaa..c41d0e550d39 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1338,7 +1338,8 @@ struct block_device *blkdev_get_no_open(dev_t dev)
 	disk = bdev->bd_disk;
 	if (!kobject_get_unless_zero(&disk_to_dev(disk)->kobj))
 		goto bdput;
-	if ((disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
+	if ((disk->flags &
+	    (GENHD_FL_DISK_ADDED | GENHD_FL_HIDDEN)) != GENHD_FL_DISK_ADDED)
 		goto put_disk;
 	if (!try_module_get(bdev->bd_disk->fops->owner))
 		goto put_disk;
@@ -1407,7 +1408,7 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 
 	mutex_lock(&disk->open_mutex);
 	ret = -ENXIO;
-	if (!(disk->flags & GENHD_FL_UP))
+	if (!(disk->flags & GENHD_FL_DISK_ADDED))
 		goto abort_claiming;
 	if (bdev_is_partition(bdev))
 		ret = blkdev_get_part(bdev, mode);
-- 
2.27.0

