Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB29938FA94
	for <lists+linux-block@lfdr.de>; Tue, 25 May 2021 08:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhEYGOm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 May 2021 02:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhEYGOm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 02:14:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3180AC061574;
        Mon, 24 May 2021 23:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=393ZukKZxHBq/9fct1KmqTknJ+Q/QTxrsBMyumX1Mgc=; b=i526FDLa/XnS/3517Sz7SuzhYP
        pE8tfO+pNgh7UDWPJL00V7L3KquuEObwpUO9z5ub/RDV9sTpMG/BRdu9hpyQCGB0y08/CbvNKnjuM
        7LNfAfXgakiXuRTPZuOX7+s32rx5MhOfrBUrLbizVPwhun4OsgSlMGkzYeWhb3eAsx3erC7KpHODk
        oVQjSSC4+vkqy7Z/iipVUWMYJQq2CEpADLYCIoh7Z7pHwlseWSIHtxXTpaN87r28D8UGZa9KeyUbF
        +IeW6YCfgp1UElqhHKC1eimVNGY9uGl1LuvGQrjKAFm6GWpAvDSm0e3k+EtHLSySsyeCX5iV+VyIM
        CKpUNyGA==;
Received: from [2001:4bb8:190:7543:af90:8b76:7e65:6578] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llQJL-003Z7I-Uf; Tue, 25 May 2021 06:13:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: move bd_mutex to the gendisk v2
Date:   Tue, 25 May 2021 08:12:53 +0200
Message-Id: <20210525061301.2242282-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this series first cleans up gendisk allocation in the md driver to remove
the ERESTARTSYS hack in blkdev_get, then further refactors blkdev_get
and then finally moves bd_mutex into the gendisk as having separate locks
for the whole device vs partitions just complicates locking in places that
add an remove partitions a lot.

Changes since v1:
 - rebased to the latest for-5.14/block branch

Diffstat:
 Documentation/filesystems/locking.rst |    2 
 block/genhd.c                         |   59 +++------
 block/ioctl.c                         |    2 
 block/partitions/core.c               |   45 +++----
 drivers/block/loop.c                  |   14 +-
 drivers/block/xen-blkfront.c          |    8 -
 drivers/block/zram/zram_drv.c         |   18 +-
 drivers/block/zram/zram_drv.h         |    2 
 drivers/md/md.h                       |    6 
 drivers/s390/block/dasd_genhd.c       |    8 -
 drivers/scsi/sd.c                     |    4 
 fs/block_dev.c                        |  207 ++++++++++++++++------------------
 fs/btrfs/volumes.c                    |    2 
 fs/super.c                            |    8 -
 include/linux/blk_types.h             |    4 
 include/linux/genhd.h                 |    6 
 init/do_mounts.c                      |   10 -
 17 files changed, 186 insertions(+), 219 deletions(-)
