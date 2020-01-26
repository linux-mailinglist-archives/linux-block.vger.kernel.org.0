Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 708411498BE
	for <lists+linux-block@lfdr.de>; Sun, 26 Jan 2020 05:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgAZEmZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 25 Jan 2020 23:42:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:26120 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729014AbgAZEmZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Jan 2020 23:42:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2020 20:42:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,364,1574150400"; 
   d="scan'208";a="260691504"
Received: from ajakowsk-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.70.106])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2020 20:42:23 -0800
From:   Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
To:     axboe@kernel.dk, song@kernel.org
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: [PATCH 0/2] Enable polling on stackable devices
Date:   Sat, 25 Jan 2020 21:41:36 -0700
Message-Id: <20200126044138.5066-1-andrzej.jakowski@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

IO polling is available on blk-mq devices. Currently it is not possible to
perform IO polling on stackable devices like MD. 

We have built a prototype exposing new function for bio devices to do IO
polling on them. That function is in available on request_queue so bio based
drivers can provide handler for it. 

IO polling has been provided for RAID-0 level for MD.

Andrzej Jakowski (2):
  block: introduce polling on bio level
  md: enable io polling

 block/blk-core.c       |  3 ++-
 block/blk-mq.c         | 26 ++++++++++++++++++++++++++
 drivers/md/md.c        | 39 +++++++++++++++++++++++++++++++++++----
 include/linux/blkdev.h |  2 ++
 4 files changed, 65 insertions(+), 5 deletions(-)

-- 
2.20.1

