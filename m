Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED90C369C68
	for <lists+linux-block@lfdr.de>; Sat, 24 Apr 2021 00:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbhDWWGi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 23 Apr 2021 18:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231218AbhDWWGi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 18:06:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E7ED61467;
        Fri, 23 Apr 2021 22:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619215561;
        bh=+EWqmc8YwD8d9cozTk6jy29faIJiC8bZ96N+cd5c9TQ=;
        h=From:To:Cc:Subject:Date:From;
        b=cUax5d3HL67Fv0R8h/6zbwIbDpPJz/S8k8IFUg0En+T15P06zp2WPa9uDzaQ1Ch01
         I7RQEVVlO5XJREn0ucyJLOZOFSQJVP3tFVbqIW0yurt+V1Bd0Ml0MkIZimOliHXrxE
         SOCLDFwhVXrVEWIkfo4hWGQ2UnJyVh2kH1zuNXFVaNdeE+tmS61bsZI5q0RqaE6Ull
         7rRIMduXbxUFgwB6BduByxIq1FF4XEYY/Vp8YahuWvUjow81LZTlEjOv5wIeaFHUGP
         83auax6U6Qbz9BZ6k64laXli6D9LM7N9H1+Q0W74rD9aggjyFhoMoM3/0bvvr0lD1V
         zj+0DtfOSKifQ==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/5] block and nvme passthrough error handling
Date:   Fri, 23 Apr 2021 15:05:53 -0700
Message-Id: <20210423220558.40764-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

v1 -> v2:

  Unify nvme's polled and non-polled requests by pushing that logic to
  the generic block layer.

  Include the ioctl and passthrough users for getting the error status
  from the passthrough execution.

  Added nvme patch allowing a user to specify a polled ioctl request.

Keith Busch (5):
  block: support polling through blk_execute_rq
  nvme: use blk_execute_rq() for passthrough commands
  block: return errors from blk_execute_rq()
  nvme: use return value from blk_execute_rq()
  nvme: allow user passthrough commands to poll

 block/blk-exec.c                | 18 ++++++++--
 drivers/nvme/host/core.c        | 62 ++++++++++++---------------------
 drivers/nvme/host/fabrics.c     | 13 ++++---
 drivers/nvme/host/fabrics.h     |  2 +-
 drivers/nvme/host/fc.c          |  2 +-
 drivers/nvme/host/ioctl.c       | 38 ++++++++++----------
 drivers/nvme/host/lightnvm.c    |  4 +--
 drivers/nvme/host/nvme.h        |  7 ++--
 drivers/nvme/host/pci.c         |  4 +--
 drivers/nvme/host/rdma.c        |  3 +-
 drivers/nvme/host/tcp.c         |  2 +-
 drivers/nvme/target/loop.c      |  2 +-
 drivers/nvme/target/passthru.c  | 10 +++---
 include/linux/blkdev.h          |  2 +-
 include/uapi/linux/nvme_ioctl.h |  4 +++
 15 files changed, 85 insertions(+), 88 deletions(-)

-- 
2.25.4

