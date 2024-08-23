Return-Path: <linux-block+bounces-10804-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB4695C64A
	for <lists+linux-block@lfdr.de>; Fri, 23 Aug 2024 09:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CAB71C20DC2
	for <lists+linux-block@lfdr.de>; Fri, 23 Aug 2024 07:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F031417984;
	Fri, 23 Aug 2024 07:11:23 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A829F4F88C;
	Fri, 23 Aug 2024 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724397083; cv=none; b=Us7Zz8HT/FaGqDNHcE6uypQHZSA3Ee7rmUmqmOJM2KOpU71ItzQD4QoG0WFJ01tiuz0qFEb6P4FYda5DQPiEduh6anmdLDafuvJ3fpPgvRfRruvi/lZJ6jfOTNRp5vXWLshDZyGXDX3FMKFfOzhgrf2yqJF9kPLgQ/Ph14rt2jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724397083; c=relaxed/simple;
	bh=0nX5cizmjDfwa0vSoG5uTMuuvECCUZmvgA7PTcXsBOs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K1Do2dTAjdD9YYJJ6e6o2w7CJs9BlfGa0YxIR7Q1TjGCYyH95Xb8aGyFKGYkVIagq5RI1GFQDM3bnTR9oHWcvM68AIgCpiO/G1F39sFkvjy5khJFbVYo16EzpnJSguqboS7dUlWTRlj85tiq2gYplpAefGeVlpXx4p3NJA/x0Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee766c8360a95e-84962;
	Fri, 23 Aug 2024 15:11:09 +0800 (CST)
X-RM-TRANSID:2ee766c8360a95e-84962
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea66c8360d970-ed34b;
	Fri, 23 Aug 2024 15:11:09 +0800 (CST)
X-RM-TRANSID:2eea66c8360d970-ed34b
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: axboe@kernel.dk
Cc: justin@coraid.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] aoe: Use IS_ERR_OR_NULL() to clean code
Date: Fri, 23 Aug 2024 13:26:40 +0800
Message-Id: <20240823052640.3668-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Jiao <zhangjiao2@cmss.chinamobile.com>

Use IS_ERR_OR_NULL() to make the code cleaner.

Signed-off-by: Zhang Jiao <zhangjiao2@cmss.chinamobile.com>
---
 drivers/block/aoe/aoecmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index cc9077b588d7..5514b7a6e5c2 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -1256,7 +1256,7 @@ aoe_ktstart(struct ktstate *k)
 
 	init_completion(&k->rendez);
 	task = kthread_run(kthread, k, "%s", k->name);
-	if (task == NULL || IS_ERR(task))
+	if (IS_ERR_OR_NULL(task))
 		return -ENOMEM;
 	k->task = task;
 	wait_for_completion(&k->rendez); /* allow kthread to start */
-- 
2.33.0




