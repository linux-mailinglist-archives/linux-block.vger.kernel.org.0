Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CEF69DCBE
	for <lists+linux-block@lfdr.de>; Tue, 21 Feb 2023 10:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjBUJTS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Feb 2023 04:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjBUJTR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Feb 2023 04:19:17 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B1BB777;
        Tue, 21 Feb 2023 01:19:16 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PLYdC3Qs1z4f3jHr;
        Tue, 21 Feb 2023 17:19:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgBnFCKPjPRj+jbADg--.57503S4;
        Tue, 21 Feb 2023 17:19:13 +0800 (CST)
From:   Zhong Jinghua <zhongjinghua@huaweicloud.com>
To:     axboe@kernel.dk, code@siddh.me, willy@infradead.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongjinghua@huawei.com, yi.zhang@huawei.com, yukuai3@huawei.com,
        houtao1@huawei.com
Subject: [PATCH-next v3] loop: loop_set_status_from_info() check before assignment
Date:   Tue, 21 Feb 2023 17:42:44 +0800
Message-Id: <20230221094244.3631986-1-zhongjinghua@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBnFCKPjPRj+jbADg--.57503S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1Dtw4xtw18Wr45JFW3trb_yoW8Xw4DpF
        sxWFyUC3yFgF4xKF4qv34kXay5G3ZrGry3CFW7KayrZryI9FnI9r9rGa45urZ5JrWxuFWY
        gFn8JFykZF1UWr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: x2kr0wpmlqwxtxd6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Zhong Jinghua <zhongjinghua@huawei.com>

In loop_set_status_from_info(), lo->lo_offset and lo->lo_sizelimit should
be checked before reassignment, because if an overflow error occurs, the
original correct value will be changed to the wrong value, and it will not
be changed back.

Modifying to the wrong value logic is always not quiet right, we hope to
optimize this.

loop_handle_cmd
 do_req_filebacked
  loff_t pos = ((loff_t) blk_rq_pos(rq) << 9) + lo->lo_offset;
  lo_rw_aio
   cmd->iocb.ki_pos = pos

Fixes: c490a0b5a4f3 ("loop: Check for overflow while configuring loop")
Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
---
 v2: Modify note: overflowing -> overflow
 v3: Modify commit message
 drivers/block/loop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1518a6423279..1b35cbd029c7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -977,13 +977,13 @@ loop_set_status_from_info(struct loop_device *lo,
 		return -EINVAL;
 	}
 
+	/* Avoid assigning overflow values */
+	if (info->lo_offset > LLONG_MAX || info->lo_sizelimit > LLONG_MAX)
+		return -EOVERFLOW;
+
 	lo->lo_offset = info->lo_offset;
 	lo->lo_sizelimit = info->lo_sizelimit;
 
-	/* loff_t vars have been assigned __u64 */
-	if (lo->lo_offset < 0 || lo->lo_sizelimit < 0)
-		return -EOVERFLOW;
-
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
 	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
 	lo->lo_flags = info->lo_flags;
-- 
2.31.1

