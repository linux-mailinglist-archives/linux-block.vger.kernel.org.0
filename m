Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF5E3A3643
	for <lists+linux-block@lfdr.de>; Thu, 10 Jun 2021 23:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhFJVqt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 10 Jun 2021 17:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhFJVqs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 17:46:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C93E61404;
        Thu, 10 Jun 2021 21:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623361492;
        bh=Nm2lG9+SJgKjIstjugCTUl6kie9LX9Danvpz1BD7x3o=;
        h=From:To:Cc:Subject:Date:From;
        b=hvTbuus3egZkN0mDA5ZGbn+7ZHya0BQXs1jLjULpxHS1tQ4iBAwpqyKcXWEVIGaAx
         MkSSS9Cy9RGes0b/QeG49wRfeI9d9IvD71yTSjUYWhnRBf+xJ1opkvLLpf79O/APbw
         QehY9AjE5P8sbKu4MJP+/o93bC4QTflfa/dqtGywVlH5V7U4c+IcKe0UeN0dVM6Cfz
         4lvZYGcIbZF1x80XySArWoTwxKEgXNKoX7wyecEKDod1WAu9lWUGhYBdssQDK2z/17
         pUDtDCzT2mkg/psigFoWU4IteNhB060YPp6KneBtQaTGfEHw9wsrVHFFcKxweUv8Ti
         0vo0+ocfQv6Kw==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 0/4] block and nvme passthrough error handling
Date:   Thu, 10 Jun 2021 14:44:33 -0700
Message-Id: <20210610214437.641245-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series has blk_execute_rq() return queueing errors so the caller
may know if their request wasn't dispatched, and adds polled hctx
support.

Chances since v3:

  Added recieved "Reviewed-by:" tags.

  Retain the REQ_HIPRI flag for nvme polled passthrough requests
  (patch 2)

  Combined nvme request dispatch with the status decoding into single
  function (patch 4)

Keith Busch (4):
  block: support polling through blk_execute_rq
  nvme: use blk_execute_rq() for passthrough commands
  block: return errors from blk_execute_rq()
  nvme: use return value from blk_execute_rq()

 block/blk-exec.c               | 25 +++++++++++--
 drivers/nvme/host/core.c       | 65 +++++++++++++++-------------------
 drivers/nvme/host/fabrics.c    | 13 ++++---
 drivers/nvme/host/fabrics.h    |  2 +-
 drivers/nvme/host/fc.c         |  2 +-
 drivers/nvme/host/ioctl.c      |  6 +---
 drivers/nvme/host/nvme.h       |  4 +--
 drivers/nvme/host/rdma.c       |  3 +-
 drivers/nvme/host/tcp.c        |  2 +-
 drivers/nvme/target/loop.c     |  2 +-
 drivers/nvme/target/passthru.c |  8 ++---
 include/linux/blkdev.h         |  4 ++-
 12 files changed, 72 insertions(+), 64 deletions(-)

-- 
2.25.4

