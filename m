Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3881A3AD8EE
	for <lists+linux-block@lfdr.de>; Sat, 19 Jun 2021 11:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbhFSJaU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 19 Jun 2021 05:30:20 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7492 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhFSJaU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jun 2021 05:30:20 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G6VkY6f67zZjs2;
        Sat, 19 Jun 2021 17:25:09 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 19
 Jun 2021 17:28:07 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <jbacik@fb.com>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH 0/2] blk-wbt: fix two wbt enable problems
Date:   Sat, 19 Jun 2021 17:36:58 +0800
Message-ID: <20210619093700.920393-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit a79050434b45 ("blk-rq-qos: refactor out common elements of
blk-wbt") introduce two wbt enable problems. The first one will cause
false positive check by rwb_enabled() and lead to IO hung, the second
one is wbt_enable_default() could not re-enable wbt after switch
elevator back from bfq to other one.

Zhang Yi (2):
  blk-wbt: introduce a new disable state to prevent false positive by
    rwb_enabled()
  blk-wbt: make sure throttle is enabled properly

 block/blk-wbt.c | 11 ++++++++---
 block/blk-wbt.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.31.1

