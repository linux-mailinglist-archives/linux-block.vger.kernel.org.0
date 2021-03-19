Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC47B341651
	for <lists+linux-block@lfdr.de>; Fri, 19 Mar 2021 08:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhCSHQp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 19 Mar 2021 03:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbhCSHQm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 03:16:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC34FC06174A
        for <linux-block@vger.kernel.org>; Fri, 19 Mar 2021 00:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=M76xO1K/EQV5CCb+NqCLsqK0FN5oML1Ebg7OCq+pRBQ=; b=jxcC9LoF5K+EckjwTs6DaZdETQ
        y9XFjmtdVE2fcqDbe/TC2f4Q8OGLdYN9gdfG1t5ynE1u+UxmLnMXSEgMh6CftwuL6VuLB8MtJPV9x
        CV5IIBSvoVewMkk35HP7qjWcBh+DxEKZJfp2a5d00y0p0vbfBwR8qz7edSSou3mYxp9TTQvHCv7tO
        54Y7SRNkYWG5NRUc0jk8ZbUu0KiVzudYqAv4UONvtZJJQm4oP2Xgje7uVDtbJKGg2xRkmPeNdTTBV
        j4blFiTeRHXVVqiQtB2Wy5h4UpkLuxVE9VbpkObjoq+O5gBINlbVlp7yZH9ZKrfoOcBdBl9gkqCmm
        AXhyKdkg==;
Received: from 089144199244.atnat0008.highway.a1.net ([89.144.199.244] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lN9Mt-0045v0-Vh; Fri, 19 Mar 2021 07:16:26 +0000
Date:   Fri, 19 Mar 2021 08:14:12 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.12
Message-ID: <YFRPRP/WLS/5FCSc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.12-20210319

for you to fetch changes up to bac04454ef9fada009f0572576837548b190bf94:

  nvmet-tcp: fix kmap leak when data digest in use (2021-03-18 05:39:18 +0100)

----------------------------------------------------------------
nvme fixes for 5.12

 - fix tag allocation for keep alive
 - fix a unit mismatch for the Write Zeroes limits
 - various TCP transport fixes (Sagi Grimberg, Elad Grupi)
 - fix iosqes and iocqes validation for discovery controllers (Sagi Grimberg)

----------------------------------------------------------------
Christoph Hellwig (4):
      nvme-fabrics: only reserve a single tag
      nvme: merge nvme_keep_alive into nvme_keep_alive_work
      nvme: allocate the keep alive request using BLK_MQ_REQ_NOWAIT
      nvme: fix Write Zeroes limitations

Elad Grupi (1):
      nvmet-tcp: fix kmap leak when data digest in use

Sagi Grimberg (5):
      nvme-tcp: fix a NULL deref when receiving a 0-length r2t PDU
      nvme-tcp: fix misuse of __smp_processor_id with preemption enabled
      nvme-tcp: fix possible hang when failing to set io queues
      nvme-rdma: fix possible hang when failing to set io queues
      nvmet: don't check iosqes,iocqes for discovery controllers

 drivers/nvme/host/core.c    | 64 +++++++++++++++------------------------------
 drivers/nvme/host/fabrics.h |  7 +++++
 drivers/nvme/host/fc.c      |  4 +--
 drivers/nvme/host/rdma.c    | 11 +++++---
 drivers/nvme/host/tcp.c     | 20 ++++++++++----
 drivers/nvme/target/core.c  | 17 +++++++++---
 drivers/nvme/target/loop.c  |  4 +--
 drivers/nvme/target/tcp.c   |  2 +-
 8 files changed, 69 insertions(+), 60 deletions(-)
