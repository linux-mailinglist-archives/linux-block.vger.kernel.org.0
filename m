Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9942C7D6B
	for <lists+linux-block@lfdr.de>; Mon, 30 Nov 2020 04:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgK3DbK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 29 Nov 2020 22:31:10 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30931 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgK3DbK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Nov 2020 22:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606707069; x=1638243069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hUhzJ651cVoNvniIQeg3wff/FCoz1DE77FDFCSJt0Zk=;
  b=dxorGgZsqz9bCywuhSQHdWW0TyB0hKDqBniG9Lal/8/7RZerA7378Qdo
   yrRDorf01uOE5RVn2mg4+p9KEvQjtif8swFx4Vz2MhVsBkLh2/V9/F8WT
   Qjv9nYWKBCSZZ9OjXCyRhdYDIG/7KDyb2R8XswCHNH6lYiPwNN5M4vKpY
   pLWvS+qeYjxUg9azKw/wC8OAuN0pZfUTWFs0GcRPj4AF/KKLrct7iNEoN
   QCAHcq7NH1BlRPD4dQrZTadmZUbHyJ1uHXIIiFTWxdNu4viVK/04dSeXu
   0OV221U2pMuI02hvPc0obYojOwBVo56WpRMQldNJLrV5WVgFBXPmBJfAy
   A==;
IronPort-SDR: Vz8pk7GDA89gxZR/83cQca8jfR0YEDNjzzuNPVMukaqufT8+P+6CH+Tf4hOY3ONxp/bTD2e7WA
 19GG67rhhB5A7u/BRmPJ6KboGlu3mcH20A17Q1aH9Dfe/6FD3+wwCWthnqdKxNvtPzL4JLXiUQ
 eEDfL6zC1do8UnB4zzGiTJ+Y6c1bpRBmfFl+yyK3zS/ccK9+tvZQXLltREFGIPY3r9XsJgVdLm
 2K6qRRR8E7kHVwCkyrwegg/vEViSb6P4JYnc1UmonwfJZD8JwL413GbgGOsOu3PGGLMjCrUKQI
 dCU=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; 
   d="scan'208";a="158242338"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 11:30:04 +0800
IronPort-SDR: UTl6zHH4ouMmnXd1mHWUdzJhQnut1NH3BnTVu1K29s/zs68PFVUjGDGemnudwGlmI0kdZoznfC
 z1hmp2sMGpFI9p4pb2KUukuBRvrwgyiW4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2020 19:14:18 -0800
IronPort-SDR: EqveP7U1iUJ9hEUH58pnDm3xDHLqLsQBe/x3lVQjWWaHN8ixfBGO2/LGRJPuSwUIw0LlcpCFMM
 nHFUoGOxmQaw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2020 19:30:04 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 7/9] nvmet: add zns cmd effects to support zbdev
Date:   Sun, 29 Nov 2020 19:29:07 -0800
Message-Id: <20201130032909.40638-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Update the target side command effects logs with support for
ZNS commands for zbdev.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index cd368cbe3855..0099275951da 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -191,6 +191,8 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
 	log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
 	log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
 
+	nvmet_zns_add_cmd_effects(log);
+
 	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
 
 	kfree(log);
-- 
2.22.1

