Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF563B4E2A
	for <lists+linux-block@lfdr.de>; Sat, 26 Jun 2021 12:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhFZKoG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 26 Jun 2021 06:44:06 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:8307 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZKoF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Jun 2021 06:44:05 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GBqzb5X39z1BRTk;
        Sat, 26 Jun 2021 18:36:27 +0800 (CST)
Received: from dggpeml500009.china.huawei.com (7.185.36.209) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 18:41:42 +0800
Received: from huawei.com (10.175.101.6) by dggpeml500009.china.huawei.com
 (7.185.36.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 26 Jun
 2021 18:41:41 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>,
        "Yufen Yu" <yuyufen@huawei.com>
Subject: [PATCH] block: remove redundant bio_uninit from simple direct io
Date:   Sat, 26 Jun 2021 18:47:36 +0800
Message-ID: <20210626104736.911941-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500009.china.huawei.com (7.185.36.209)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since bio_endio() will call bio_uninit() for us, we can remove
it from current code path.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 fs/block_dev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6cc4d4cfe0c2..7a63fc3ce8d9 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -299,8 +299,6 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	if (vecs != inline_vecs)
 		kfree(vecs);
 
-	bio_uninit(&bio);
-
 	return ret;
 }
 
-- 
2.25.4

