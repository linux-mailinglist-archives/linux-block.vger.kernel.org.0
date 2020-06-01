Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4790C1EA411
	for <lists+linux-block@lfdr.de>; Mon,  1 Jun 2020 14:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgFAMjZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 1 Jun 2020 08:39:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5321 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbgFAMjY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Jun 2020 08:39:24 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7252BF6B52CED81A3185;
        Mon,  1 Jun 2020 20:39:22 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Mon, 1 Jun 2020
 20:39:14 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <martin.petersen@oracle.com>, <wenwen@cs.uga.edu>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] block/bio-integrity: don't free 'buf' if bio_integrity_add_page() failed
Date:   Mon, 1 Jun 2020 20:38:56 +0800
Message-ID: <20200601123856.3895734-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

commit e7bf90e5afe3 ("block/bio-integrity: fix a memory leak bug") add a
kree() for 'buf' if bio_integrity_add_page() return '0'. However, the
object will be freed in bio_integrity_free() since 'bio->bi_opf' and
'bio->bi_integrity' was set previousy in bio_integrity_alloc().

Fixes: commit e7bf90e5afe3 ("block/bio-integrity: fix a memory leak bug")
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 block/bio-integrity.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index bf62c25cde8f..ae07dd78e951 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -278,7 +278,6 @@ bool bio_integrity_prep(struct bio *bio)
 
 		if (ret == 0) {
 			printk(KERN_ERR "could not attach integrity payload\n");
-			kfree(buf);
 			status = BLK_STS_RESOURCE;
 			goto err_end_io;
 		}
-- 
2.25.4

