Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D271E80F7
	for <lists+linux-block@lfdr.de>; Fri, 29 May 2020 16:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgE2OwH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 May 2020 10:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgE2OwG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 10:52:06 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63BBE207BC;
        Fri, 29 May 2020 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590763926;
        bh=H5Holb5ECxic2kwSWoJ+5oUahBN+4rFGAhnvcBXaHvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zmyn1wvIDs1iWVrPq9KH1AvCfNqFHBllEjfDIn7MQjPqzYr90/1/Q23d4PnfImaJP
         CeDEI9R6eVlQxIsG3ICZRPaaV8cHEeyCsleTHgIyA6CphWJwbP4SnK/CY978pCOwYl
         x0coWYjj+FiuJs/S5Tv9IaFdnaR4cHR5xAIC0zqg=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     alan.adamson@oracle.com, Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCHv4 2/2] nvme: force complete cancelled requests
Date:   Fri, 29 May 2020 07:52:00 -0700
Message-Id: <20200529145200.3545747-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200529145200.3545747-1-kbusch@kernel.org>
References: <20200529145200.3545747-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use blk_mq_foce_complete_rq() to bypass fake timeout error injection so
that request reclaim may proceed.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba860efd250d..891e9461bfae 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -310,7 +310,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 		return true;
 
 	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
-	blk_mq_complete_request(req);
+	blk_mq_force_complete_rq(req);
 	return true;
 }
 EXPORT_SYMBOL_GPL(nvme_cancel_request);
-- 
2.24.1

