Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE302FEAF5
	for <lists+linux-block@lfdr.de>; Thu, 21 Jan 2021 14:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbhAUNAn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 Jan 2021 08:00:43 -0500
Received: from m12-14.163.com ([220.181.12.14]:48011 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729516AbhAUNAA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 08:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=FEdSHQ+VY9QSsQqqOi
        sGJNCqPdWCuaYg20onoC444ig=; b=L7JAkcxBw3NQbgfQrQQbjYKBW8UwDHFMdp
        kKGKYKsoM+9YWai8041JNiJyXtemYZDCtVGSKO+6+bW3TnUDQAiXG+8Qqih3W3GP
        dpEXwmIq4EG1Pfx8uvIHZG8CcsaLfEXUpDBd/QIcZlvq2qMqfrT3by7Ztqp6LtH/
        jTNwlvTHw=
Received: from localhost.localdomain (unknown [119.3.119.20])
        by smtp10 (Coremail) with SMTP id DsCowAA3XoqjKwlg_aB8hA--.62335S4;
        Thu, 21 Jan 2021 15:22:15 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Matias Bjorling <mb@lightnvm.io>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] lightnvm: fix memory leak when submit fails
Date:   Wed, 20 Jan 2021 23:22:02 -0800
Message-Id: <20210121072202.120810-1-bianpan2016@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DsCowAA3XoqjKwlg_aB8hA--.62335S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1kuFy7Cr47Xr4rXry5Arb_yoWfJrb_C3
        WjvFs7AryrCay2qwn8t3W3Z3s29w4rWrsY9r4ftasxJryDXwnIyayYgr9Iqa4Yvr43ur9x
        GaykAF17uw1rtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5_rc3UUUUU==
X-Originating-IP: [119.3.119.20]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBzx4hclaD9zBl9gABsC
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The allocated page is not released if error occurs in
nvm_submit_io_sync_raw(). __free_page() is moved ealier to avoid
possible memory leak issue.

Fixes: aff3fb18f957 ("lightnvm: move bad block and chunk state logic to core")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/lightnvm/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index c1bcac71008c..28ddcaa5358b 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -844,11 +844,10 @@ static int nvm_bb_chunk_sense(struct nvm_dev *dev, struct ppa_addr ppa)
 	rqd.ppa_addr = generic_to_dev_addr(dev, ppa);
 
 	ret = nvm_submit_io_sync_raw(dev, &rqd);
+	__free_page(page);
 	if (ret)
 		return ret;
 
-	__free_page(page);
-
 	return rqd.error;
 }
 
-- 
2.17.1


