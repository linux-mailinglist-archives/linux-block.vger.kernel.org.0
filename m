Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A3A2CB4F7
	for <lists+linux-block@lfdr.de>; Wed,  2 Dec 2020 07:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgLBGZG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Dec 2020 01:25:06 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:47445 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbgLBGZG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 01:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606890976; x=1638426976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KZvesihZxqvpooUM98Q5I5u1Gk/h9BuWE3/slZ8Ndhs=;
  b=BHtLCuTgbXn3M/qX7KhFi/X9oK01y6nk0u6dLJRCk/VboQuPEeevb85y
   WOYuhzwfBdaiIHLfp063vt3mLFKA6B6HGNJN5n4UuIsg1RBjRHWmX/7tR
   D0xzDalBcTS4xCjUVmjxDExsNJsCdgrQw5BAfhPcgve1N36Y252FGeBcr
   KAkNg1xIKb+gZRVJQWx+Epkl3XAtVgEdl60BYBPyMBieuW6L+y1JwNAGO
   /Z8o5ra+nmco1M4Jzc5kxGri9R9zgLG0PXj/IjTM7IxzLFeZR/inzbMNT
   gpSBpK1KAj2gYeX3pHkrxdggFcAHGnt1qSGTfzwreqMTgehpcQcBaIR5I
   w==;
IronPort-SDR: XnWDQPLWcZkN8q0wHx99a5uiPg+ISk30PleIeIslu+gFfRrvxgr4j6u+ApjHEaZ/FK20YiLfqK
 xvluwa+GNApvo+fGDGkUuLQEfLGibMW6jnineE2ZzSsBDmkcuMSWcT4SanSI9h2NVMmJUJ+XaM
 YlmjxOS+ReD4xQdUp0Ol68klYJmsq9FfwppHwJIr3ax/Rek4P6V+7LpTiKIubDkc+AXb0WyX73
 6iLKO0dEFGdFSC8vIejyV5e71tFbU6p6nE7NrpZdLXS0+6M/kHeRNxxO9qj5To7exCu/v7Wv4H
 Rew=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; 
   d="scan'208";a="257684168"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 14:34:37 +0800
IronPort-SDR: WSRrg083iSMiNxwXypi2IZbyKTUlmN17M32dnlU7O/J42wvbLAdeIjHYJIvwcauM4e3IUv5Yvo
 gnnHQSOrlbWoWnWOP+fR+56IYta1kmTM4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 22:08:12 -0800
IronPort-SDR: pBQWN2G/rG01ZtfZmZxyR1JoaSnr0hctnDIfC2fg5Qi3qzSlOZAhl7P3HVUfMpjNGA0ULBA/K6
 O7h4KZUNikNw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Dec 2020 22:24:01 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        johannes.thumshirn@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 9/9] nvmet: add ZNS based I/O cmds handlers
Date:   Tue,  1 Dec 2020 22:22:27 -0800
Message-Id: <20201202062227.9826-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add zone-mgmt-send, zone-mgmt-recv and zone-zppend handlers for the
bdev backend so that it can support zbd.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index e1f6d59dd341..25dcd0544d5d 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -453,6 +453,15 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_bdev_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_zone_append:
+		req->execute = nvmet_bdev_execute_zone_append;
+		return 0;
+	case nvme_cmd_zone_mgmt_recv:
+		req->execute = nvmet_bdev_execute_zone_mgmt_recv;
+		return 0;
+	case nvme_cmd_zone_mgmt_send:
+		req->execute = nvmet_bdev_execute_zone_mgmt_send;
+		return 0;
 	default:
 		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
 		       req->sq->qid);
-- 
2.22.1

