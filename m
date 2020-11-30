Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC092C7EC1
	for <lists+linux-block@lfdr.de>; Mon, 30 Nov 2020 08:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgK3HdG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 Nov 2020 02:33:06 -0500
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net ([209.97.182.222]:54198
        "HELO zg8tmja5ljk3lje4mi4ymjia.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1727026AbgK3HdG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 02:33:06 -0500
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Nov 2020 02:33:05 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
        Date:Message-Id; bh=cmoJFMRS8u18q8sx5qsdIoOyJwxATJvYAISsdbMd504=;
        b=CLahJEghogB7Q7PDuk+IHkiMOl/cK9YRt/MaMJsCt4RKrDTvxEGuk6gOb0WZxx
        v9B+WZUY1WqtAOmcwoGt7CkcJw1irzQttUL1B61EGxQM7dxneSeHFAmdxmCC7P8M
        UtwJtT5Llbb6j8KzI8cCcQom9pJXqNM0PhlSH0X9+Hr4c=
Received: from ubuntu.localdomain (unknown [166.111.83.82])
        by web2 (Coremail) with SMTP id yQQGZQBH7DYRnsRfXSsQAA--.283S4;
        Mon, 30 Nov 2020 15:24:02 +0800 (CST)
From:   tangzhenhao <tzh18@mails.tsinghua.edu.cn>
To:     linux-block@vger.kernel.org
Cc:     mb@lightnvm.io, tangzhenhao <tzh18@mails.tsinghua.edu.cn>
Subject: [PATCH] drivers/lightnvm: fix a null-ptr-deref bug in pblk-core.c
Date:   Sun, 29 Nov 2020 23:23:56 -0800
Message-Id: <20201130072356.5378-1-tzh18@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: yQQGZQBH7DYRnsRfXSsQAA--.283S4
X-Coremail-Antispam: 1UD129KBjvdXoWruryftw1DuFy7Kr4rGw1ftFb_yoWDXrc_C3
        ZayF97GF95X3W2gwn7AFW5AryrKFn5Xrn5WFWSqa43Zry7Ar45Grn8ur93GrWUKr1fZFnr
        Aw47Aw43A347JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbskFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
        IFyTuYvjfUYyxRDUUUU
X-CM-SenderInfo: pw2kimo6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQIQEV7nE6mG2QABsf
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

At line 294 in drivers/lightnvm/pblk-write.c, function pblk_gen_run_ws is called with actual param GFP_ATOMIC. pblk_gen_run_ws call mempool_alloc using "GFP_ATOMIC" flag, so mempool_alloc can return null. So we need to check the return-val of mempool_alloc to avoid null-ptr-deref bug.

Signed-off-by: tangzhenhao <tzh18@mails.tsinghua.edu.cn>
---
 drivers/lightnvm/pblk-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 97c68731406b..1dddba11e721 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1869,6 +1869,10 @@ void pblk_gen_run_ws(struct pblk *pblk, struct pblk_line *line, void *priv,
 	struct pblk_line_ws *line_ws;
 
 	line_ws = mempool_alloc(&pblk->gen_ws_pool, gfp_mask);
+	if (!line_ws) {
+		pblk_err(pblk, "pblk: could not allocate memory\n");
+		return;
+	}
 
 	line_ws->pblk = pblk;
 	line_ws->line = line;
-- 
2.17.1

