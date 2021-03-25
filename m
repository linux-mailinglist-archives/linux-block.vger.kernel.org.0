Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E4C349579
	for <lists+linux-block@lfdr.de>; Thu, 25 Mar 2021 16:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhCYPad (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 25 Mar 2021 11:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCYP36 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 11:29:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC383C06174A
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:29:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b7so3621347ejv.1
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQDJlaw0FtQm0N9dNhdmtBw67bwGouq09B/Vh9aj0v4=;
        b=ID1F/xYE+/4vq5v1Vm/Z3OmCEuGbNf8vNR+/taj8NGVNJ8wPDSSz8toMd7KrKReIbI
         nuVfHQoDywBUkVoZIDNmzpvDEomSQlyFUS9bm0a3eS/h9KJDUQgVeK47Z9RmCxXpiVba
         q/4yhjNLbp581JRvlHdUcHTxnWt/jn5CjP4oUOk9Zxun9xgUkA1YiEBWrXMlXwLsV64O
         Rer5tzWX3uLo77+L7pdNMSDIGJQUOX3zx6e5JWZx8+U4PMMFowUjSPWsfRbGCY3ZoNN9
         6UDVhuCZEqo5UAlyhm8fuhIYrXC4CVP/gSY9JVgLqECMVu6KxB66AKu3rvCr/VMNt2vX
         2vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQDJlaw0FtQm0N9dNhdmtBw67bwGouq09B/Vh9aj0v4=;
        b=TRTpm76kwAwTOt2kmkLN3pN41vLLm8oJ1lsdAtppP6IyjgyElRsDqQt9WPhRKS5KwI
         9YLU1+PQ0dOUhfxhv7KncdExw33pqZIGjYT8AAoHPaqkjMCIaL4+Qwq7W5Tj+p/xxJUd
         rSLsGVej4bHQnwr1b3wMoBjexvd8LQVf/E0oi0IgyCEGlPY5XyfCYJAVlAIqI/PfSypL
         ikmGiHrw9FYyTIhE63kq8RJY4fBJGTi3iec/FI/MyJq+1PgnoCBtXRY390Tt5RPEbNX0
         x2OQHmUrEhguXRvpHZA/RzZW8MRwj+8kK1/X9QPFXRkbJkRrHyJpeQIlnDA0cYJPPixN
         9JtQ==
X-Gm-Message-State: AOAM5337bjvU3VlQjpK6AKKikiP/OukQUx6P0bNBGkhlqV0NKjaZ2cTI
        1thU6fmHyxwij5aijLpuCJkFf6m10dgW8A==
X-Google-Smtp-Source: ABdhPJxKMUaZgopNpGqZK+MKbg/C27mhSvpBR/rjpcqzV8cSBq18D2I9HE+byRJQHPn9cM6SjPqRBg==
X-Received: by 2002:a17:906:5248:: with SMTP id y8mr9928255ejm.150.1616686196398;
        Thu, 25 Mar 2021 08:29:56 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:29:55 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH for-rc 07/24] docs: Add RTRS/RNBD to the index of fault-injection
Date:   Thu, 25 Mar 2021 16:28:54 +0100
Message-Id: <20210325152911.1213627-8-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

Add new documents for RTRS and RNBD to the index file.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 Documentation/fault-injection/index.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/fault-injection/index.rst b/Documentation/fault-injection/index.rst
index 8408a8a91b34..669d146af874 100644
--- a/Documentation/fault-injection/index.rst
+++ b/Documentation/fault-injection/index.rst
@@ -11,6 +11,8 @@ fault-injection
     notifier-error-inject
     nvme-fault-injection
     provoke-crashes
+    rnbd-fault-injection
+    rtrs-fault-injection
 
 .. only::  subproject and html
 
-- 
2.25.1

