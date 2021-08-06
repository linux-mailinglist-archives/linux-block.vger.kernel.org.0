Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BB33E214D
	for <lists+linux-block@lfdr.de>; Fri,  6 Aug 2021 03:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhHFB5z (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 5 Aug 2021 21:57:55 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12458 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhHFB5z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Aug 2021 21:57:55 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GgpRv3x3TzcgKC;
        Fri,  6 Aug 2021 09:54:03 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 09:57:38 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 6 Aug
 2021 09:57:38 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v2 0/4] optimize the bfq queue idle judgment
Date:   Fri, 6 Aug 2021 10:08:22 +0800
Message-ID: <20210806020826.1407257-1-yukuai3@huawei.com>
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

Chagnes in V2:
 - as suggested by Paolo, add support to track if root_group have any
 pending requests, and use that to handle the situation when only one
 group is activated while root group doesn't have any pending requests.
 - modify commit message in patch 2

Yu Kuai (4):
  block, bfq: add support to track if root_group have any pending
    requests
  block, bfq: do not idle if only one cgroup is activated
  block, bfq: add support to record request size information
  block, bfq: consider request size in bfq_asymmetric_scenario()

 block/bfq-iosched.c | 69 ++++++++++++++++++++++++++++++++++++++-------
 block/bfq-iosched.h | 29 +++++++++++++++++--
 block/bfq-wf2q.c    | 37 +++++++++++++++---------
 3 files changed, 110 insertions(+), 25 deletions(-)

-- 
2.31.1

