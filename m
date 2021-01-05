Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA182EA5CE
	for <lists+linux-block@lfdr.de>; Tue,  5 Jan 2021 08:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbhAEHU1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 Jan 2021 02:20:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10546 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbhAEHU1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jan 2021 02:20:27 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D93kg486lzMFcp;
        Tue,  5 Jan 2021 15:18:35 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Tue, 5 Jan 2021
 15:19:36 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <lengchao@huawei.com>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>
Subject: [PATCH 0/6] avoid repeated request completion and IO error
Date:   Tue, 5 Jan 2021 15:19:30 +0800
Message-ID: <20210105071936.25097-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

First avoid repeated request completion for nvmf_fail_nonready_command.
Second avoid IO error and repeated request completion for queue_rq.

Chao Leng (6):
  blk-mq: introduce blk_mq_set_request_complete
  nvme-core: introduce complete failed request
  nvme-fabrics: avoid repeated request completion for
    nvmf_fail_nonready_command
  nvme-rdma: avoid IO error and repeated request completion
  nvme-tcp: avoid IO error and repeated request completion
  nvme-fc: avoid IO error and repeated request completion

 drivers/nvme/host/fabrics.c |  4 +---
 drivers/nvme/host/fc.c      |  6 ++++--
 drivers/nvme/host/nvme.h    | 18 ++++++++++++++++++
 drivers/nvme/host/rdma.c    |  2 +-
 drivers/nvme/host/tcp.c     |  2 +-
 include/linux/blk-mq.h      |  5 +++++
 6 files changed, 30 insertions(+), 7 deletions(-)

-- 
2.16.4

