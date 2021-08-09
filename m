Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF8A3E3E09
	for <lists+linux-block@lfdr.de>; Mon,  9 Aug 2021 04:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhHIC7G (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 8 Aug 2021 22:59:06 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13402 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhHIC7G (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Aug 2021 22:59:06 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gjgfz2dd7zcmGX;
        Mon,  9 Aug 2021 10:55:07 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 10:58:44 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 9 Aug
 2021 10:58:44 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <josef@toxicpanda.com>, <bvanassche@acm.org>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v2 0/2] fix request uaf in nbd_read_stat()
Date:   Mon, 9 Aug 2021 11:09:25 +0800
Message-ID: <20210809030927.1946162-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patchset fix request uaf in nbd, other drivers might have the
same problem. Will fix them later if this patchset is accepted.

Changes in v2:
 - as Bart suggested, add a new helper function for drivers to get
 request by tag.

Yu Kuai (2):
  blk-mq: add a new interface to get request by tag
  nbd: convert to use blk_mq_get_rq_by_tag()

 block/blk-mq-tag.c     | 33 +++++++++++++++++++++++++++++++++
 block/blk-mq.c         |  1 +
 block/blk-mq.h         |  1 -
 drivers/block/nbd.c    | 11 ++++++-----
 include/linux/blk-mq.h |  3 +++
 5 files changed, 43 insertions(+), 6 deletions(-)

-- 
2.31.1

