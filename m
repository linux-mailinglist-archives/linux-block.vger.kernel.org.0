Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2892C965E
	for <lists+linux-block@lfdr.de>; Tue,  1 Dec 2020 05:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgLAEQd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 Nov 2020 23:16:33 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:54620 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgLAEQc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 23:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606796192; x=1638332192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KZvesihZxqvpooUM98Q5I5u1Gk/h9BuWE3/slZ8Ndhs=;
  b=FO0ia7980e+O4hWlx1QkVEwHXZzAXnh/yPQSWsnRI3U3RM0SJpXqE4E+
   y2Rf443k/TDXjuNrofxP5+8VYqkWuVq+kOa7mA+nkGAO+05uJwk2dS4Rw
   YhN5CzuwCr5u2yBAZTM92XOkY+27mXPQOYpvnmc+QXdmULJEQvJhp4uBO
   v1dZGFqP6QmtRMKPASj3ykUFTuzSc/LegMek0VIgZ55lSPkQjhIFUYohh
   KpJz4gfqD5xgLOhhW/pQ1VQkBHIJQhXD4CmLK9rv4dj9OdI21Dl7mw+GW
   jcCk6Ei3BAwhTn2gIsN8w9CwZx1PhWEwmonRdIsVGNwpZOhsSSDeiiAUN
   g==;
IronPort-SDR: IqOdSwI2y53EnAuBNek2++oNTfqz0NxhbUbTXAvfmO4cIdwRQibTSX/QhoDEZeyjI9/aqD3Jfo
 +kdHC3wCpggsMYo0BxvYMRSiJrdR2vpvv+w465K9Yjq8PWM2PCB3cG9V7vBu9Wflmz4IZD0dWP
 +fS5lL0VYnqp7GqEEo1DCj/0sJsZ0XIy8BACUh1topRvo5ws+kILvNaRA4ovVGcxcTdr0feo9f
 UIdTz7GTzP4yrn01FXa//YQ7zeaY5jUDKARJgNlbTt0AHaXKGLQJFjUMsW52EnXBsM9Gl7GKID
 jXM=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; 
   d="scan'208";a="155078210"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 12:15:36 +0800
IronPort-SDR: fko7w8PeT46ja1Gw2XY8+lt7ii93zy4mZCKRF/vJ76nBniheEwVRtI9f/T1vTlojWDpO+MePAm
 1BvZyd3In2c1xHpqlMqrrFQBlmmpRTpD0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 19:59:48 -0800
IronPort-SDR: nb5WqBJEDzev6Bbho0xCLsxDriknavT5buwPk4zbaeOYOwmzpRPRosFSFyiFKBwhO1T1zPIUrW
 ACs1nuPZch+g==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2020 20:15:36 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V3 9/9] nvmet: add ZNS based I/O cmds handlers
Date:   Mon, 30 Nov 2020 20:14:16 -0800
Message-Id: <20201201041416.16293-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
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

