Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF543E3808
	for <lists+linux-block@lfdr.de>; Sun,  8 Aug 2021 05:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhHHDHc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 7 Aug 2021 23:07:32 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8375 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhHHDHb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 7 Aug 2021 23:07:31 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gj3tp4lZHz83sX;
        Sun,  8 Aug 2021 11:03:14 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 8 Aug 2021 11:07:08 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 8 Aug
 2021 11:07:08 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 0/2] fix request uaf in nbd_read_stat()
Date:   Sun, 8 Aug 2021 11:17:50 +0800
Message-ID: <20210808031752.579882-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yu Kuai (2):
  blk-mq: add two interfaces to lock/unlock blk_mq_tags->lock
  nbd: hold tags->lock to prevent access freed request through
    blk_mq_tag_to_rq()

 block/blk-mq-tag.c     | 12 ++++++++++++
 drivers/block/nbd.c    | 22 ++++++++++++++++------
 include/linux/blk-mq.h |  2 ++
 3 files changed, 30 insertions(+), 6 deletions(-)

-- 
2.31.1

