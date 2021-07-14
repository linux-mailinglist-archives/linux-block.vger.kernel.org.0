Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F180C3C81C5
	for <lists+linux-block@lfdr.de>; Wed, 14 Jul 2021 11:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbhGNJkN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 14 Jul 2021 05:40:13 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:11303 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238840AbhGNJkH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jul 2021 05:40:07 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GPsjp4pRrz8sl4;
        Wed, 14 Jul 2021 17:32:46 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 17:37:15 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 14
 Jul 2021 17:37:14 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 0/3] optimize the queue idle judgment
Date:   Wed, 14 Jul 2021 17:45:26 +0800
Message-ID: <20210714094529.758808-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bfqq might plug I/O dispatch when it remains temporarily empty while
being served, this will benefit for both sequence io bandwidth and relative
sync io control.

This path set tries to extend the two special cases that idle is not
needed, and can get better bandwidth.

1) only one group is activated.
2) when more than one groups are activated, all queues are issuring
requests with same size.

Yu Kuai (3):
  block, bfq: do not idle if only one cgroup is activated
  block, bfq: add support to record request size information
  block, bfq: consider request size in bfq_asymmetric_scenario()

 block/bfq-iosched.c | 50 +++++++++++++++++++++++++++++++++++++--------
 block/bfq-iosched.h | 16 +++++++++++++++
 2 files changed, 57 insertions(+), 9 deletions(-)

-- 
2.31.1

