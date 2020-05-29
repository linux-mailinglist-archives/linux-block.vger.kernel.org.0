Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADD11E8065
	for <lists+linux-block@lfdr.de>; Fri, 29 May 2020 16:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgE2Ohr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 May 2020 10:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbgE2Ohq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 10:37:46 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0B5420776;
        Fri, 29 May 2020 14:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590763066;
        bh=6c+sUZE1lDgrvZXEOBr3V7VAXwat7DZ3zJaGULnLPcE=;
        h=From:To:Cc:Subject:Date:From;
        b=1KsUxj2VkajVhiX6EZh32wl0WVR9k5QvZcUtpdrxxyy2y5jKuCjT+z9Gvx3tMzthd
         Do90xTY9q+kEGF4X/7aSmYDTUTj9sh5G0lVf7yiavDZ1Ad0s663x5aBuQxMvMSZRDn
         s1BBFS82DLJDTZvR0w7E+6qx9j8qlIDGWPh62eHE=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     alan.adamson@oracle.com, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/2] blk-mq: force completion
Date:   Fri, 29 May 2020 07:37:42 -0700
Message-Id: <20200529143744.3545429-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I've renamed the newly exported function from
__blk_mq_complete_request() to blk_mq_force_complete_rq() and added
kerneldoc for its intended usage.

Reviews and Acks from previous versions are not included for PATCH 1/2
since the name changed.

Keith Busch (2):
  blk-mq: export blk_mq_force_complete_rq
  nvme: force complete cancelled requests

 block/blk-mq.c           | 15 +++++++++++++--
 drivers/nvme/host/core.c |  2 +-
 include/linux/blk-mq.h   |  1 +
 3 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.24.1

