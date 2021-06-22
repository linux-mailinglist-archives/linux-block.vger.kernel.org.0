Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBF53B0A1F
	for <lists+linux-block@lfdr.de>; Tue, 22 Jun 2021 18:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFVQUB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Jun 2021 12:20:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59249 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhFVQUA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 12:20:00 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lvj5q-0006Bm-RA; Tue, 22 Jun 2021 16:17:42 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] block/mq-deadline: remove redundant assignment of variable ret
Date:   Tue, 22 Jun 2021 17:17:42 +0100
Message-Id: <20210622161742.25194-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable ret is being assigned a value at the end of the function
and the value is never read. The assignment is redundant and can
be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 block/mq-deadline-main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/mq-deadline-main.c b/block/mq-deadline-main.c
index 4815e536091f..e3091d922ba2 100644
--- a/block/mq-deadline-main.c
+++ b/block/mq-deadline-main.c
@@ -639,7 +639,6 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
 	if (ret)
 		goto free_stats;
 
-	ret = 0;
 	q->elevator = eq;
 	return 0;
 
-- 
2.31.1

