Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA342EC91E
	for <lists+linux-block@lfdr.de>; Thu,  7 Jan 2021 04:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbhAGDci (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 Jan 2021 22:32:38 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9961 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbhAGDci (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jan 2021 22:32:38 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DBBbM0PqRzj3Rm;
        Thu,  7 Jan 2021 11:31:11 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Thu, 7 Jan 2021
 11:31:50 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>
Subject: [PATCH v2 0/6] avoid repeated request completion and IO error
Date:   Thu, 7 Jan 2021 11:31:43 +0800
Message-ID: <20210107033149.15701-1-lengchao@huawei.com>
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

V2:
	- use "switch" instead "if" to check return status
	
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
 drivers/nvme/host/nvme.h    | 21 +++++++++++++++++++++
 drivers/nvme/host/rdma.c    |  2 +-
 drivers/nvme/host/tcp.c     |  2 +-
 include/linux/blk-mq.h      |  5 +++++
 6 files changed, 33 insertions(+), 7 deletions(-)

-- 
2.16.4

