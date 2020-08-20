Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C828124AD78
	for <lists+linux-block@lfdr.de>; Thu, 20 Aug 2020 05:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHTDx5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 Aug 2020 23:53:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53298 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbgHTDx4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 23:53:56 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A9D0B895FAD8BE814C02;
        Thu, 20 Aug 2020 11:53:54 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 20 Aug 2020
 11:53:44 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>
CC:     <linux-block@vger.kernel.org>, <kbusch@kernel.org>, <axboe@fb.com>,
        <hch@lst.de>, <sagi@grimberg.me>, <lengchao@huawei.com>
Subject: [PATCH 0/3] fix crash and deadlock when connect timeout
Date:   Thu, 20 Aug 2020 11:53:44 +0800
Message-ID: <20200820035344.1579-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we test nvme over roce with link blink, deadlock and crash happen.
To fix the bug we need set the flag:NVME_REQ_CANCELLED for io which is
canceled by host. This is conflict with error translation of
nvme_revalidate_disk, so we need improve the error translation of
nvme_revalidate_disk first.

Chao Leng (3):
  nvme-core: improve avoiding false remove namespace
  nvme-core: fix deadlock when reconnect failed due to
    nvme_set_queue_count timeout
  nvme-core: fix crash when nvme_enable_aen timeout

 drivers/nvme/host/core.c    | 21 ++++++++++++++-------
 drivers/nvme/host/fabrics.c |  1 +
 2 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.16.4

