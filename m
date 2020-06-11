Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33DC1F6A1C
	for <lists+linux-block@lfdr.de>; Thu, 11 Jun 2020 16:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgFKOf3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 11 Jun 2020 10:35:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52997 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgFKOf3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 10:35:29 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jjOIh-00019N-Ab; Thu, 11 Jun 2020 14:35:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] umem: remove redundant initialization of variable ret
Date:   Thu, 11 Jun 2020 15:35:27 +0100
Message-Id: <20200611143527.925712-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being initialized with a value that is never read
and it is being updated later with a new value.  The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/umem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index d84e8a878df2..1e2aa5ae2796 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -784,7 +784,7 @@ static const struct block_device_operations mm_fops = {
 
 static int mm_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	int ret = -ENODEV;
+	int ret;
 	struct cardinfo *card = &cards[num_cards];
 	unsigned char	mem_present;
 	unsigned char	batt_status;
-- 
2.27.0.rc0

