Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E8496107
	for <lists+linux-block@lfdr.de>; Tue, 20 Aug 2019 15:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbfHTNou (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 20 Aug 2019 09:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730768AbfHTNnE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Aug 2019 09:43:04 -0400
Received: from sasha-vm.mshome.net (unknown [12.236.144.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05CA322DBF;
        Tue, 20 Aug 2019 13:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566308583;
        bh=yVM/l2fOqk9pJj3nswGYrniTutsJc7xd36/VJP/3HrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hIBZso2ccAhPxvzlb0HLN4CeBkoaiVUv57cBHOkkvDOLM+7kS9v7an+UKPkHNMOIQ
         0LFYgmwRxoMc1fh8q6F39yMvJ2DAzuLntk1avCzyAUaHWDFRVnU7CjEm8ZVAg+x9t9
         r24/tzejbwNwwWdB+78YwWr4EaLb83e9aUyWSSTw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/12] xen/blkback: fix memory leaks
Date:   Tue, 20 Aug 2019 09:42:48 -0400
Message-Id: <20190820134253.11562-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820134253.11562-1-sashal@kernel.org>
References: <20190820134253.11562-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit ae78ca3cf3d9e9f914bfcd0bc5c389ff18b9c2e0 ]

In read_per_ring_refs(), after 'req' and related memory regions are
allocated, xen_blkif_map() is invoked to map the shared frame, irq, and
etc. However, if this mapping process fails, no cleanup is performed,
leading to memory leaks. To fix this issue, invoke the cleanup before
returning the error.

Acked-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/xen-blkback/xenbus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 21c1be1eb2260..ed4e807791243 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -973,6 +973,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
 	}
 	blkif->nr_ring_pages = nr_grefs;
 
+	err = -ENOMEM;
 	for (i = 0; i < nr_grefs * XEN_BLKIF_REQS_PER_PAGE; i++) {
 		req = kzalloc(sizeof(*req), GFP_KERNEL);
 		if (!req)
@@ -995,7 +996,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
 	err = xen_blkif_map(ring, ring_ref, nr_grefs, evtchn);
 	if (err) {
 		xenbus_dev_fatal(dev, err, "mapping ring-ref port %u", evtchn);
-		return err;
+		goto fail;
 	}
 
 	return 0;
@@ -1015,8 +1016,7 @@ static int read_per_ring_refs(struct xen_blkif_ring *ring, const char *dir)
 		}
 		kfree(req);
 	}
-	return -ENOMEM;
-
+	return err;
 }
 
 static int connect_ring(struct backend_info *be)
-- 
2.20.1

