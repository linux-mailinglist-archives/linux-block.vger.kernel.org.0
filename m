Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8054943301F
	for <lists+linux-block@lfdr.de>; Tue, 19 Oct 2021 09:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhJSH4g (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 19 Oct 2021 03:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhJSH4f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 03:56:35 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F01AC06161C;
        Tue, 19 Oct 2021 00:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=t0i0DNLwERozyxCDDYreYWwPN+qo9mUSj9/ICf6Q8qM=; b=ehUZFOUoAm3+N+DnAo0Qu+xgFv
        BxMzpsTkc5dGk/2mT9ovc6Icz0L3QmGL2XuD99IxJMkcepjDqqZ/bQp2/lxcKR2W9u5INrr48Ea/a
        OhbFHU7om3rEImrOHHCqDyNxRmObzMegX3X9kSrOutPvShb+E6+NyOiQ8SE4UFRNUy3VvZOPADefJ
        5P8f4GBeBb1ryAn9VE5pULLXWP7AjONurpjKlZ2HpeZvX2puFElvPbk7w/LkJ3+p21KBAv1/MCP+x
        aPPx3u3T4AEpTCCLH5wKi18XB8z4x8OKO1750sQAVK6NQ4o8Z9ONvVDLEexPGmb9PTadpsYi4QWwV
        o885d60w==;
Received: from [2001:4bb8:180:8777:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcjwy-000T7h-KE; Tue, 19 Oct 2021 07:54:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: remove QUEUE_FLAG_SCSI_PASSTHROUGH v2
Date:   Tue, 19 Oct 2021 09:54:11 +0200
Message-Id: <20211019075418.2332481-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this series removes the QUEUE_FLAG_SCSI_PASSTHROUGH and thus the last
remaining SCSI passthrough concept from the block layer.

The changes to support pktcdvd are a bit ugly, but I can't think of
anything better (except for removing the driver entirely).
If we'd want to support packet writing today it would probably live
entirely inside the sr driver.

Changes since v1:
 - use an extra local variable in sd_get_unique_id to make sure we
   always return the right length
 - add an enum and a comment to better document ->get_unique_id
 - spelling fixes

Diffstat:
 block/blk-core.c                   |    9 --
 block/blk-mq-debugfs.c             |    1 
 block/bsg-lib.c                    |   32 +++----
 drivers/block/Kconfig              |    2 
 drivers/block/pktcdvd.c            |    7 +
 drivers/scsi/scsi_bsg.c            |    4 
 drivers/scsi/scsi_error.c          |    2 
 drivers/scsi/scsi_ioctl.c          |    4 
 drivers/scsi/scsi_lib.c            |   27 ++++--
 drivers/scsi/scsi_scan.c           |    1 
 drivers/scsi/sd.c                  |   39 +++++++++
 drivers/scsi/sg.c                  |    4 
 drivers/scsi/sr.c                  |    2 
 drivers/scsi/st.c                  |    2 
 drivers/target/target_core_pscsi.c |    3 
 fs/nfsd/Kconfig                    |    1 
 fs/nfsd/blocklayout.c              |  158 +++++++++----------------------------
 fs/nfsd/nfs4layouts.c              |    5 -
 include/linux/blk-mq.h             |    5 -
 include/linux/blkdev.h             |   14 ++-
 include/scsi/scsi_cmnd.h           |    3 
 21 files changed, 148 insertions(+), 177 deletions(-)
