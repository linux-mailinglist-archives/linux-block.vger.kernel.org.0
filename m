Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDF31EA9A
	for <lists+linux-block@lfdr.de>; Wed, 15 May 2019 11:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfEOJEU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 May 2019 05:04:20 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:47039 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfEOJEU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 May 2019 05:04:20 -0400
X-QQ-mid: bizesmtp21t1557910349twm43nem
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 15 May 2019 16:52:28 +0800 (CST)
X-QQ-SSF: 01400000002000Q0VN60000A0000000
X-QQ-FEAT: RUJ7g7zpdcH15pbNlaE7UgkskUkuq4qEud0T5NnYiaoCzXd3YOH9CYoVxNQBf
        HomWwKI9mJtfVmNEO1keaR/FvI8bKd6pK7GJ5X0mJxbP/IGMiZFyKzOkyD7O9iPgGEXw4HQ
        HTwZS5TVqO588uKaA/e/R1gCPZwkHxAwZ9jA9+DmEXbGae8NpLgjc1olG50lDxWU1CLTeal
        HTGs+PUwBL7BM9eTFxNpbhu72j8lCFVzxXvM/+tD9UCKN1nMEO38pCRBijFhgFGDb0jdJe3
        frjZnrxTGsX367PerxzKASB7+JvhuSfPJkIWndEGEbUfIo4JLjhIC5U5sAfVowRJIYWivxF
        Z7/GP6N8YWl8YRWQXc=
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH] block/bio-integrity: use struct_size() in kmalloc()
Date:   Wed, 15 May 2019 16:52:19 +0800
Message-Id: <1557910339-2140-1-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the new struct_size() helper to keep code simple.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/bio-integrity.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 1b633a3526d4..5152009b5b59 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -57,8 +57,7 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 	unsigned inline_vecs;
 
 	if (!bs || !mempool_initialized(&bs->bio_integrity_pool)) {
-		bip = kmalloc(sizeof(struct bio_integrity_payload) +
-			      sizeof(struct bio_vec) * nr_vecs, gfp_mask);
+		bip = kmalloc(struct_size(bip, bip_inline_vecs, nr_vecs), gfp_mask);
 		inline_vecs = nr_vecs;
 	} else {
 		bip = mempool_alloc(&bs->bio_integrity_pool, gfp_mask);
-- 
2.21.0



