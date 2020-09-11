Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1B1265710
	for <lists+linux-block@lfdr.de>; Fri, 11 Sep 2020 04:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgIKCmG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 10 Sep 2020 22:42:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24968 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKCmE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Sep 2020 22:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599792123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xbG1GA7EmxIM6OFuKoLm0uEGcjT5hmviO9SzGOkDFtQ=;
        b=h+62xvkFTaD2dMvDbt9cVXKRXH/NFVHQqaIP6TZX9DTE33oNmfgFi/bzk3vaOWWNpOz6u3
        R8oNiUh6yOl43C7utB0YiwNBZWVpybbRIOlEGuyOIJUrlrioLtia5YtYgn3hR4W5cz1pCl
        WtSHO+QJKVmda1wm8uPT6Z426Hb8cWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-OIQcsDiQMkK0Na6gG4eMnA-1; Thu, 10 Sep 2020 22:41:59 -0400
X-MC-Unique: OIQcsDiQMkK0Na6gG4eMnA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDE072FD02;
        Fri, 11 Sep 2020 02:41:57 +0000 (UTC)
Received: from localhost (ovpn-13-69.pek2.redhat.com [10.72.13.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3667D7512A;
        Fri, 11 Sep 2020 02:41:53 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 4/4] nvme: use blk_mq_[un]quiesce_tagset
Date:   Fri, 11 Sep 2020 10:41:17 +0800
Message-Id: <20200911024117.62480-5-ming.lei@redhat.com>
In-Reply-To: <20200911024117.62480-1-ming.lei@redhat.com>
References: <20200911024117.62480-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

All controller namespaces share the same tagset, so we
can use this interface which does the optimal operation
for parallel quiesce based on the tagset type (e.g.
blocking tagsets and non-blocking tagsets).

Reviewed-by: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chao Leng <lengchao@huawei.com>

Add code to unquiesce ctrl->connect_q in nvme_stop_queues(), meantime
avoid to call blk_mq_quiesce_tagset()/blk_mq_unquiesce_tagset() if
this tagset isn't initialized.
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ea1fa41fbba8..a6af8978a3ba 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4623,23 +4623,22 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
+	if (list_empty_careful(&ctrl->namespaces))
+		return;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_quiesce_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	blk_mq_quiesce_tagset(ctrl->tagset);
+
+	if (ctrl->connect_q)
+		blk_mq_unquiesce_queue(ctrl->connect_q);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
 void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
+	if (list_empty_careful(&ctrl->namespaces))
+		return;
 
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_unquiesce_queue(ns->queue);
-	up_read(&ctrl->namespaces_rwsem);
+	blk_mq_unquiesce_tagset(ctrl->tagset);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
-- 
2.25.2

