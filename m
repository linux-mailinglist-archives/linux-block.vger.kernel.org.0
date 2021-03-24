Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0773E346FA8
	for <lists+linux-block@lfdr.de>; Wed, 24 Mar 2021 03:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbhCXCkm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Mar 2021 22:40:42 -0400
Received: from relay.corp-email.com ([222.73.234.233]:10895 "EHLO
        relay.corp-email.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbhCXCkP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 22:40:15 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Mar 2021 22:40:15 EDT
Received: from ([183.47.25.45])
        by relay.corp-email.com ((LNX1044)) with ASMTP (SSL) id RVF00057;
        Wed, 24 Mar 2021 10:33:57 +0800
Received: from GCY-EXS-15.TCL.com (10.74.128.165) by GCY-EXS-08.TCL.com
 (10.74.128.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 24 Mar
 2021 10:33:56 +0800
Received: from localhost.localdomain (172.16.34.11) by GCY-EXS-15.TCL.com
 (10.74.128.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 24 Mar
 2021 10:33:56 +0800
From:   Rokudo Yan <wu-yan@tcl.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>
CC:     <wu-yan@tcl.com>
Subject: [PATCH] block,bfq: fix the timeout calculation in bfq_bfqq_charge_time
Date:   Wed, 24 Mar 2021 10:33:41 +0800
Message-ID: <20210324023341.1545234-1-wu-yan@tcl.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.34.11]
X-ClientProxiedBy: GCY-EXS-04.TCL.com (10.74.128.154) To GCY-EXS-15.TCL.com
 (10.74.128.165)
tUid:   20213241033573bc190bfe2d245a8b4fab6964b1eb80d
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

in bfq_bfqq_charge_time, timeout_ms is calculated with global
constant bfq_timeout(HZ/8), which is not correct. It should be
bfqd->bfq_timeout here as per-device bfq_timeout can be modified
through /sys/block/<disk/queue/iosched/timeout_sync.

Signed-off-by: Rokudo Yan <wu-yan@tcl.com>
---
 block/bfq-wf2q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 070e34a7feb1..48f540a5ee6a 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -872,7 +872,7 @@ void bfq_bfqq_charge_time(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			  unsigned long time_ms)
 {
 	struct bfq_entity *entity = &bfqq->entity;
-	unsigned long timeout_ms = jiffies_to_msecs(bfq_timeout);
+	unsigned long timeout_ms = jiffies_to_msecs(bfqd->bfq_timeout);
 	unsigned long bounded_time_ms = min(time_ms, timeout_ms);
 	int serv_to_charge_for_time =
 		(bfqd->bfq_max_budget * bounded_time_ms) / timeout_ms;
-- 
2.25.1

