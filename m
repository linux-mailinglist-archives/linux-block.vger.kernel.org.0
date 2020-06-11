Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1B81F6A0E
	for <lists+linux-block@lfdr.de>; Thu, 11 Jun 2020 16:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgFKOaR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 11 Jun 2020 10:30:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52728 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgFKOaR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jun 2020 10:30:17 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jjODf-0000ff-14; Thu, 11 Jun 2020 14:30:15 +0000
From:   Colin King <colin.king@canonical.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pktcdvd: remove redundant initialization of variable ret
Date:   Thu, 11 Jun 2020 15:30:14 +0100
Message-Id: <20200611143014.925317-1-colin.king@canonical.com>
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
 drivers/block/pktcdvd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 0b944ac96d6b..27a33adc41e4 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1613,7 +1613,7 @@ static noinline_for_stack int pkt_get_last_written(struct pktcdvd_device *pd,
 	disc_information di;
 	track_information ti;
 	__u32 last_track;
-	int ret = -1;
+	int ret;
 
 	ret = pkt_get_disc_info(pd, &di);
 	if (ret)
-- 
2.27.0.rc0

