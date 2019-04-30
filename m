Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC0AFE44
	for <lists+linux-block@lfdr.de>; Tue, 30 Apr 2019 18:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbfD3Q75 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Apr 2019 12:59:57 -0400
Received: from charlie.dont.surf ([128.199.63.193]:57008 "EHLO
        charlie.dont.surf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3Q74 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 12:59:56 -0400
Received: from apples.localdomain (ip-5-186-120-196.cgn.fibianet.dk [5.186.120.196])
        by charlie.dont.surf (Postfix) with ESMTPSA id 15B5ABF7AF;
        Tue, 30 Apr 2019 16:59:55 +0000 (UTC)
From:   Klaus Birkelund Jensen <klaus@birkelund.eu>
To:     Klaus Birkelund <klaus@birkelund.eu>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] nvme-pci: fix psdt field for single segment sgls
Date:   Tue, 30 Apr 2019 18:59:54 +0200
Message-Id: <20190430165954.7165-1-klaus@birkelund.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The shortcut for single segment SGL requests did not set the PSDT field
to mark the request as using SGLs.

Fixes: 297910571f08 ("nvme-pci: optimize mapping single segment requests using SGLs")
Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c1eecde6b853..efc1da56521c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -830,6 +830,7 @@ static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
 		return BLK_STS_RESOURCE;
 	iod->dma_len = bv->bv_len;
 
+	cmnd->flags = NVME_CMD_SGL_METABUF;
 	cmnd->dptr.sgl.addr = cpu_to_le64(iod->first_dma);
 	cmnd->dptr.sgl.length = cpu_to_le32(iod->dma_len);
 	cmnd->dptr.sgl.type = NVME_SGL_FMT_DATA_DESC << 4;
-- 
2.21.0

