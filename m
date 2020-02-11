Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA3715998D
	for <lists+linux-block@lfdr.de>; Tue, 11 Feb 2020 20:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgBKTRx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 11 Feb 2020 14:17:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:40289 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731496AbgBKTRx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 14:17:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 11:17:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="266372296"
Received: from unknown (HELO localhost.localdomain) ([10.232.115.123])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2020 11:17:52 -0800
From:   Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
To:     axboe@kernel.dk, song@kernel.org
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: [PATCH v2 0/2] Enable polling on stackable devices
Date:   Tue, 11 Feb 2020 12:17:27 -0700
Message-Id: <20200211191729.4745-1-andrzej.jakowski@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Changes since v1:
 - reintroduced original blk_poll() function that has been removed some time
   ago (Jens)

 - added fastpath calls to blk_mq_poll() in blk_poll() (Christoph, Jens)

 - incorporated code style fixes into md patch (Christoph)
 
[1]: https://lore.kernel.org/linux-block/20200126044138.5066-1-andrzej.jakowski@linux.intel.com/T/#t

---

IO polling is available on blk-mq devices. It is not possible to perform IO
polling on stackable devices like MD.

In this patch series we propose to reintroduce blk_poll() function. blk_poll()
when called on stackable block device that supports polling will invoke its
polling handler. Otherwise it will call blk_mq_poll() directly for fast
accesses.

This patch set also includes example implemetation of polling on MD RAID-0
volume.

---

TODO:
 - introduce REQ_NOWAIT support for stackable devices in a separate patchset 
   (Christoph)

Andrzej Jakowski (1):
  block: reintroduce polling on bio level

Artur Paszkiewicz (1):
  md: enable io polling

 block/blk-core.c       | 28 ++++++++++++++++++++++++++++
 block/blk-mq.c         | 23 ++---------------------
 block/blk-mq.h         |  2 ++
 drivers/md/md.c        | 40 ++++++++++++++++++++++++++++++++++++----
 include/linux/blkdev.h |  2 ++
 5 files changed, 70 insertions(+), 25 deletions(-)

-- 
2.20.1

