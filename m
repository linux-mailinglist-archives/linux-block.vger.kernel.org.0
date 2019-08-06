Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1BC82A11
	for <lists+linux-block@lfdr.de>; Tue,  6 Aug 2019 05:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfHFDiG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 5 Aug 2019 23:38:06 -0400
Received: from smtpbg202.qq.com ([184.105.206.29]:51693 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbfHFDiG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Aug 2019 23:38:06 -0400
X-QQ-mid: bizesmtp11t1565062658tbzka1ji
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 06 Aug 2019 11:37:37 +0800 (CST)
X-QQ-SSF: 01400000002000R0XQ80000A0000000
X-QQ-FEAT: mAJfWfDYrJPS00QQubGsDYnALKFh7jUNCIAoZOWheXFnrCyvMNu6jDpox3icJ
        Z+VFjqeMl2n4d3ACgbhbRjhdXUmT1yKrPaYtPSDOk6LAnxEpzv+oj7h3QUuVi6cRdESt3KZ
        KZLNT4ZHTiX3E35W+Oumse4oEnnxZT3Bcy6P2ZjKtESVVgIkq2NnDEa7aNSc/vekw8Uz3fS
        ++ZsIOEs7viJuxleBit+bCyWc7S1jMhx85NejpHJYXhHNmboTlnuMKqZj7mjLxWV2erf1Qb
        RZ3HMoP3xj6jc9DstaP4AK0OdsyoPBGpAl/IObcRCDHlTNFMFq27NI09ty1PTN/d5lsVbeW
        uSffd25NfT9AhGRQefiDd4YaafxZQ==
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH] io_uring: remove duplicate judgments when put_user_pages
Date:   Tue,  6 Aug 2019 11:37:32 +0800
Message-Id: <1565062652-12596-1-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When pret is less than or equal to 0, put_user_pages can be
processed correctly.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 8a1de5a..be1e010 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2959,8 +2959,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 			 * if we did partial map, or found file backed vmas,
 			 * release any pages we did get
 			 */
-			if (pret > 0)
-				put_user_pages(pages, pret);
+			put_user_pages(pages, pret);
 			if (ctx->account_mem)
 				io_unaccount_mem(ctx->user, nr_pages);
 			kvfree(imu->bvec);
-- 
2.7.4



