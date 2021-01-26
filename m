Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACC7304711
	for <lists+linux-block@lfdr.de>; Tue, 26 Jan 2021 19:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389384AbhAZROh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 26 Jan 2021 12:14:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11495 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389736AbhAZIQt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 03:16:49 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DPzzX1Hz9zjDQL;
        Tue, 26 Jan 2021 16:14:32 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Tue, 26 Jan 2021
 16:15:39 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>
Subject: [PATCH v4 0/5] avoid double request completion and IO error
Date:   Tue, 26 Jan 2021 16:15:34 +0800
Message-ID: <20210126081539.13320-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add blk_mq_set_request_complete and nvme_complete_failed_req for two bug
fixs.
First avoid double request completion for nvmf_fail_nonready_command.
Second avoid IO error for nvme native multipath.

V4:
	- add status parameter for nvme_complete_failed_req.
	- export nvme_complete_failed_req instead of inline function.
V3:
	- complete the request just for HBA driver path related error.
V2:
	- use "switch" instead "if" to check return status.

Chao Leng (5):
  blk-mq: introduce blk_mq_set_request_complete
  nvme-core: introduce complete failed request
  nvme-fabrics: avoid double request completion for
    nvmf_fail_nonready_command
  nvme-rdma: avoid IO error for nvme native multipath
  nvme-fc: avoid IO error for nvme native multipath

 drivers/nvme/host/core.c    | 8 ++++++++
 drivers/nvme/host/fabrics.c | 4 +---
 drivers/nvme/host/fc.c      | 7 ++++++-
 drivers/nvme/host/nvme.h    | 1 +
 drivers/nvme/host/rdma.c    | 9 ++++++++-
 include/linux/blk-mq.h      | 5 +++++
 6 files changed, 29 insertions(+), 5 deletions(-)

-- 
2.16.4

