Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF4D3A09BB
	for <lists+linux-block@lfdr.de>; Wed,  9 Jun 2021 03:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhFICAt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 8 Jun 2021 22:00:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40925 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233277AbhFICAt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jun 2021 22:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623203935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q8nKU7UnSp5v/Pw/LbxaxGvU7HBGXpGdDckUuWp0QKM=;
        b=KeYh+8UiKmKAwcnpzzfx6JRzIiwodm9Hsur78Euy9MJxCQljoAXKwEPRlaT14YJZPTRIm7
        liE/Z2XcqRKHP+tapApmLmFIyVwzadv3LNpQvcalcDEDJFXRV6mi72skYwDicJPkmpdN6T
        6yJqq6yMP8+uQonuAKnA/meFYjLh9gM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-fnfkVLO8PdCwpKghEMNoHQ-1; Tue, 08 Jun 2021 21:58:54 -0400
X-MC-Unique: fnfkVLO8PdCwpKghEMNoHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 704AE1854E27;
        Wed,  9 Jun 2021 01:58:53 +0000 (UTC)
Received: from localhost (ovpn-12-143.pek2.redhat.com [10.72.12.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 408B119C45;
        Wed,  9 Jun 2021 01:58:45 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V3 2/2] block: mark queue init done at the end of blk_register_queue
Date:   Wed,  9 Jun 2021 09:58:22 +0800
Message-Id: <20210609015822.103433-3-ming.lei@redhat.com>
In-Reply-To: <20210609015822.103433-1-ming.lei@redhat.com>
References: <20210609015822.103433-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Mark queue init done when everything is done well in blk_register_queue(),
so that wbt_enable_default() can be run quickly without any RCU period
involved since adding rq qos requires to freeze queue.

Also no any side effect by delaying to mark queue init done.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f89e2fc3963b..370d83c18057 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -866,20 +866,6 @@ int blk_register_queue(struct gendisk *disk)
 		  "%s is registering an already registered queue\n",
 		  kobject_name(&dev->kobj));
 
-	/*
-	 * SCSI probing may synchronously create and destroy a lot of
-	 * request_queues for non-existent devices.  Shutting down a fully
-	 * functional queue takes measureable wallclock time as RCU grace
-	 * periods are involved.  To avoid excessive latency in these
-	 * cases, a request_queue starts out in a degraded mode which is
-	 * faster to shut down and is made fully functional here as
-	 * request_queues for non-existent devices never get registered.
-	 */
-	if (!blk_queue_init_done(q)) {
-		blk_queue_flag_set(QUEUE_FLAG_INIT_DONE, q);
-		percpu_ref_switch_to_percpu(&q->q_usage_counter);
-	}
-
 	blk_queue_update_readahead(q);
 
 	ret = blk_trace_init_sysfs(dev);
@@ -938,6 +924,21 @@ int blk_register_queue(struct gendisk *disk)
 	ret = 0;
 unlock:
 	mutex_unlock(&q->sysfs_dir_lock);
+
+	/*
+	 * SCSI probing may synchronously create and destroy a lot of
+	 * request_queues for non-existent devices.  Shutting down a fully
+	 * functional queue takes measureable wallclock time as RCU grace
+	 * periods are involved.  To avoid excessive latency in these
+	 * cases, a request_queue starts out in a degraded mode which is
+	 * faster to shut down and is made fully functional here as
+	 * request_queues for non-existent devices never get registered.
+	 */
+	if (!blk_queue_init_done(q)) {
+		blk_queue_flag_set(QUEUE_FLAG_INIT_DONE, q);
+		percpu_ref_switch_to_percpu(&q->q_usage_counter);
+	}
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_register_queue);
-- 
2.31.1

