Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4CA3CADD1
	for <lists+linux-block@lfdr.de>; Thu, 15 Jul 2021 22:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhGOU0m (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 15 Jul 2021 16:26:42 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:46658 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhGOU0l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 16:26:41 -0400
Received: by mail-pg1-f173.google.com with SMTP id w15so7663014pgk.13;
        Thu, 15 Jul 2021 13:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5aHOdlU/2L/54/3zHXa8OhKj5BX9a+lmYl8Ye4JMN18=;
        b=q6065wRohwotdJ8VVOvEvDbAKP2AdTuw79cdfLy7rn6nxwDkXyypY/ycpyH8oRFKss
         2WP6gCkKgtjAIFaF4t2bKhzenZrv4DYR0+g9MaoGOboGJrld753v+aN/6vLh0MgJaJhi
         UEY3Gh6utVzAmWnhUIHQp2ogTK27etV0tYUAHyIausT8gJjy+MyuVWZjL3ARCmMjGt8y
         SwgVL5a8l5r/HB3XI2jZMAZxvSUjpxMUW9JzgrVBX0rZogoqXZjxwxuCJMMGjt2A5DWO
         Y22VMbYE+CAzKtdXrqYkukyeXhvls8WHnQ9bXKw3o57J/QhK8PBwQbVfvecsrD11Scg1
         sD3Q==
X-Gm-Message-State: AOAM531ivF3XQ13Oa/Kj9PX+9tbfykdo21ZcQbA4VhlTLH/zUOup8RUd
        33Mh0BuD3N+rptvV2HoS5m4=
X-Google-Smtp-Source: ABdhPJysmZfjlK+PrSxzaeydc42/L/S4TmgdqhfgzzWI7mdaj7plYzAjl1H7T/j9dNXjm7u/2q3M1Q==
X-Received: by 2002:aa7:8593:0:b029:32b:c173:cd96 with SMTP id w19-20020aa785930000b029032bc173cd96mr6293315pfn.63.1626380627327;
        Thu, 15 Jul 2021 13:23:47 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id p24sm8335768pgl.68.2021.07.15.13.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:23:46 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 1/6] genhd: update docs for GENHD_FL_UP
Date:   Thu, 15 Jul 2021 13:23:36 -0700
Message-Id: <20210715202341.2016612-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715202341.2016612-1-mcgrof@kernel.org>
References: <20210715202341.2016612-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The GENHD_FL_UP is used internally so we can know when we can add and
remove partitions, so just clarify that. Right now it has this 1980's
description comparing it to network drivers "ifconfig up" idea, and
that can easily lead to invalid uses.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 include/linux/genhd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 51f27b9b38b5..dc07a957c9e1 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -61,7 +61,7 @@ struct partition_meta_info {
  * Affects responses to the ``CDROM_GET_CAPABILITY`` ioctl.
  *
  * ``GENHD_FL_UP`` (0x0010): indicates that the block device is "up",
- * with a similar meaning to network interfaces.
+ * and we can add / remove partitions.
  *
  * ``GENHD_FL_SUPPRESS_PARTITION_INFO`` (0x0020): don't include
  * partition information in ``/proc/partitions`` or in the output of
-- 
2.27.0

