Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34421BA5ED
	for <lists+linux-block@lfdr.de>; Mon, 27 Apr 2020 16:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgD0OLq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 27 Apr 2020 10:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgD0OLq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 10:11:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83495C09B050
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 07:11:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v4so121218wme.1
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2020 07:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rgrwiiDcmTLY/3pIbuprV7JGKjk7TBT9JurHhoe0E3Q=;
        b=RR9u10GjnV0WjCoIwVaezMVc3tJebGTgzZr8AJQjF5Opcn4EQPUmOicJnN5QtVG/QM
         o468ApdLKRA1cUH0nnPtvfJO9G9mj/MhSBLV7t1v4ND4xRMAfj2D2asWacP9NWbaL8H7
         aIhabRFWiwSk5iy1GOk4rxmGTM+lEt6OuP2WkFgRzDeuE1RzsUDFI3U5tMBE7whuRD9T
         9USxRTnLZdScaDqQL358ojz7TcX+v15X9FD7t6HQh04tQTXSa89cra/3ebn899DS+3UQ
         2c0hFTz8v7sFArYOisezMkwB1y4rTsqQYdbXjHm/8ImmxUw2e/OMrX87PEwQ8xRl8Tun
         OQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rgrwiiDcmTLY/3pIbuprV7JGKjk7TBT9JurHhoe0E3Q=;
        b=jpDc4zcVMbs23mlqJCHKLGFAR3pa5K1Nk3QJABDzke+LK+ZRnHJeamWTQkfIRZIOkU
         GmdYeJMhhCbOVRP6Qv0x/tR3CT9srLLr2fJhrUs8p5kdVsz6P7Ew5HnF55gQGHE/RA0x
         wvHtHBgQ86g7ch6++I5QYlTd0Gw7K1AuZ8V/791kBxJPqfkayfadG5+Gv+ZpLyGE+Mgi
         F47qM1k7JLV2+b3h1K0fy0FIbyCAr92I2MfBWBncgruT6Ud9tE4rwFIQFFRTCYQ8zCj1
         Bh/udZ0pQgWDTPwJoBzpnLOI5I6q2oWFwRGemLHHptcWgcmDrkVeDIR+Mio+r1MfZqih
         qyxQ==
X-Gm-Message-State: AGi0PuYJguKXJeG7Vy/cTJcYIczEnc6tl0BbXer25y1UMXPSCpiDSpeZ
        AbZ8EtWP8cU03p54j9ESF6uZoqEKOPL0Y/8=
X-Google-Smtp-Source: APiQypLIZ6gd1LEz+l2CLUwx9P2L/VPYehWauU3uMoyEIlFuoGSqZFCGCKfTcABV+dyESxnA1qRv+g==
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr27105979wmm.48.1587996703081;
        Mon, 27 Apr 2020 07:11:43 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id o3sm21499756wru.68.2020.04.27.07.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 07:11:42 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v13 25/25] MAINTAINERS: Add maintainers for RNBD/RTRS modules
Date:   Mon, 27 Apr 2020 16:10:20 +0200
Message-Id: <20200427141020.655-26-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Danil and I will maintain RNBD/RTRS modules.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 26f281d9f32a..b22672f6d22d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14459,6 +14459,13 @@ F:	arch/riscv/
 N:	riscv
 K:	riscv
 
+RNBD BLOCK DRIVERS
+M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
+M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+L:	linux-block@vger.kernel.org
+S:	Maintained
+F:	drivers/block/rnbd/
+
 ROCCAT DRIVERS
 M:	Stefan Achatz <erazor_de@users.sourceforge.net>
 S:	Maintained
@@ -14587,6 +14594,13 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git rtl8xxxu-devel
 F:	drivers/net/wireless/realtek/rtl8xxxu/
 
+RTRS TRANSPORT DRIVERS
+M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
+M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+L:	linux-rdma@vger.kernel.org
+S:	Maintained
+F:	drivers/infiniband/ulp/rtrs/
+
 RXRPC SOCKETS (AF_RXRPC)
 M:	David Howells <dhowells@redhat.com>
 L:	linux-afs@lists.infradead.org
-- 
2.20.1

