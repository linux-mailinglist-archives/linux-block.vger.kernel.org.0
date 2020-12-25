Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B732E2B88
	for <lists+linux-block@lfdr.de>; Fri, 25 Dec 2020 14:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgLYNHk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 25 Dec 2020 08:07:40 -0500
Received: from smtpbgsg3.qq.com ([54.179.177.220]:44638 "EHLO smtpbgsg3.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgLYNHk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Dec 2020 08:07:40 -0500
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Dec 2020 08:07:38 EST
X-QQ-mid: bizesmtp12t1608901238t6nlmmhb
Received: from localhost.localdomain (unknown [106.19.113.205])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 25 Dec 2020 21:00:33 +0800 (CST)
X-QQ-SSF: 01400000002000M0T000B00A0000000
X-QQ-FEAT: k1hXLmrpFRu9ve9u/pJNcDsvJJDkmnWMtwB0SdLw6MVoUIRMwi7r9rLn/84pT
        Wnr7ZRhTS6UixPgU6i74KMNR5KVDgUxIYAEWxm8nr1UEs79BBpH1lAtk7f+MGJg68JolZ8a
        KRyVWfppRvfpVMobVEtOgyYbop5vafFPgc6kATwj4wJ1SSymkuKt9nfhMgk86bDr3RkQDhv
        VfJLPBtuSsKDdlLP7LgAKyv+G10j8i1MeBbfmwq75Zfqe6Mu31OMPjnuIYwmiEM0WAeFmIw
        wjvCp5vnZQ5xzDcTpEVWgsTkXmR8ClD4L9PBTDbDQAPxqyG13byDE9j+kilK+FB21roPEJp
        vPGRkY6GnxEoSa7ago=
X-QQ-GoodBg: 2
From:   huhai <huhai@tj.kylinos.cn>
To:     axboe@kernel.dk, paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, huhai <huhai@tj.kylinos.cn>
Subject: [PATCH] bfq: don't duplicate code for different paths
Date:   Fri, 25 Dec 2020 21:00:16 +0800
Message-Id: <20201225130016.20485-1-huhai@tj.kylinos.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tj.kylinos.cn:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As we can see, returns parent_sched_may_change whether
sd->next_in_service changes or not, so remove this judgment.

Signed-off-by: huhai <huhai@tj.kylinos.cn>
---
 block/bfq-wf2q.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 26776bdbdf36..070e34a7feb1 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -137,9 +137,6 @@ static bool bfq_update_next_in_service(struct bfq_sched_data *sd,
 
 	sd->next_in_service = next_in_service;
 
-	if (!next_in_service)
-		return parent_sched_may_change;
-
 	return parent_sched_may_change;
 }
 
-- 
2.20.1



