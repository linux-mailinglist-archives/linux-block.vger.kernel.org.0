Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743181E65D3
	for <lists+linux-block@lfdr.de>; Thu, 28 May 2020 17:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404149AbgE1PTh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 May 2020 11:19:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404309AbgE1PTe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 11:19:34 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F131A20814;
        Thu, 28 May 2020 15:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590679174;
        bh=jS4YEsYoWGt+s7wdwumSuGHqfyqftPJFoJ/s8TR4Y1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G0WxIIJy0bdQwXxS+gPprQygC2c1qL1BYsCFLa+e0rSnC9HM9bLzjAxx9IcrfnRmJ
         28Hwt3XeFrLVPyPs63HUxHfPPIOM5Cqy31lJyZwaX5KvVi8t6j5LzxZ6fq3eJQIMmx
         hvM3kfAAlo2DLWH13KhBqd6E1ePJZNqptobEdTAU=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/2] nvme: cancel requests for real
Date:   Thu, 28 May 2020 08:19:31 -0700
Message-Id: <20200528151931.3501506-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200528151931.3501506-1-kbusch@kernel.org>
References: <20200528151931.3501506-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Once the driver decides to cancel requests, the concept of those
requests timing out ceases to exist. Use __blk_mq_complete_request() to
bypass fake timeout error injection so that request reclaim may
proceed.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2: Use new export rather than loop for success

 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba860efd250d..f65a0b6cd988 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -310,7 +310,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 		return true;
 
 	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
-	blk_mq_complete_request(req);
+	__blk_mq_complete_request(req);
 	return true;
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_request);
-- 
2.24.1

