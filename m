Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A7142FF34
	for <lists+linux-block@lfdr.de>; Sat, 16 Oct 2021 01:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbhJOXzT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 15 Oct 2021 19:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239031AbhJOXzF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Oct 2021 19:55:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A07C061570;
        Fri, 15 Oct 2021 16:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qipf6So8PiT9INdx54i/oyCsyup0P8n0B263b/OsQJ4=; b=t3gCfbHNlbboUocETcAM5VOV6d
        AJLTHpezByfiDQMOqnTlcXwpgyT05T23oSIBWBKgLRQ72ton2E1A2ljGdUfJTlvzgdQhPekg7nKHM
        klgH7xbJSKVzjdx5UC+DtcocBxWXLSTv11aoSHl2Q7APe4B4bC/miatiJIqZ70W2Egz4HlHMilNQL
        Z9LySleaw0wZqkEeqaykCp4znP22IegCeRAPKQMl57XDPNGq/lsCmt+xlrhVUkM99cEjMftqcmhAm
        WN144g0qC1mqMuA5h3bZoI8WPC4u/acsbiZ4qEi6hSp7C7X3LT2OmZacYin/LyeOYhehZilzxmS8v
        HJc4llZw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbWzs-009C2t-UH; Fri, 15 Oct 2021 23:52:20 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, geoff@infradead.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, jim@jtan.com,
        minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me
Cc:     linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 00/13] block: add_disk() error handling stragglers
Date:   Fri, 15 Oct 2021 16:52:06 -0700
Message-Id: <20211015235219.2191207-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch set consists of al the straggler drivers for which we have
have no patch reviews done for yet. I'd like to ask for folks to please
consider chiming in, specially if you're the maintainer for the driver.
Additionally if you can specify if you'll take the patch in yourself or
if you want Jens to take it, that'd be great too.

Luis Chamberlain (13):
  block/brd: add error handling support for add_disk()
  nvme-multipath: add error handling support for add_disk()
  nvdimm/btt: do not call del_gendisk() if not needed
  nvdimm/btt: use goto error labels on btt_blk_init()
  nvdimm/btt: add error handling support for add_disk()
  nvdimm/blk: avoid calling del_gendisk() on early failures
  nvdimm/blk: add error handling support for add_disk()
  zram: add error handling support for add_disk()
  z2ram: add error handling support for add_disk()
  ps3disk: add error handling support for add_disk()
  ps3vram: add error handling support for add_disk()
  block/sunvdc: add error handling support for add_disk()
  mtd/ubi/block: add error handling support for add_disk()

 drivers/block/brd.c           |  9 +++++++--
 drivers/block/ps3disk.c       |  8 ++++++--
 drivers/block/ps3vram.c       |  7 ++++++-
 drivers/block/sunvdc.c        | 14 +++++++++++---
 drivers/block/z2ram.c         |  7 +++++--
 drivers/block/zram/zram_drv.c |  6 +++++-
 drivers/mtd/ubi/block.c       |  8 +++++++-
 drivers/nvdimm/blk.c          | 21 +++++++++++++++------
 drivers/nvdimm/btt.c          | 24 +++++++++++++++---------
 drivers/nvme/host/multipath.c | 14 ++++++++++++--
 10 files changed, 89 insertions(+), 29 deletions(-)

-- 
2.30.2

