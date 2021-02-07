Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2221B31232D
	for <lists+linux-block@lfdr.de>; Sun,  7 Feb 2021 10:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhBGJY5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 7 Feb 2021 04:24:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53832 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229795AbhBGJYo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 7 Feb 2021 04:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612689798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vYtWTnAXgtFS9ppvSzY14Z8fWYhtiqYqAeHMrlM/v8A=;
        b=iqfrAwIhjM4w1yofD3B0nm8hyX0Yhsm2P8xtekLxwavVuroE5gFO3RlMAzhFk0eelKwqc3
        We8+6mn75GSdwM4IfsMlAtD6qLujSLdtp5rKarcvB182mvvJnxM49BM0k5HuoC0OlaXkU6
        yTIChShxMw6rSn/jygwuqezHh7OISNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-ynmM4MOJMG-ep7gMi6xxtg-1; Sun, 07 Feb 2021 04:23:13 -0500
X-MC-Unique: ynmM4MOJMG-ep7gMi6xxtg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CEDE801962;
        Sun,  7 Feb 2021 09:23:12 +0000 (UTC)
Received: from localhost (ovpn-13-9.pek2.redhat.com [10.72.13.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2A6F10016FF;
        Sun,  7 Feb 2021 09:23:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V8 12/13] scsi: make sure sdev->queue_depth is <= max(shost->can_queue, 1024)
Date:   Sun,  7 Feb 2021 17:20:28 +0800
Message-Id: <20210207092029.1558550-13-ming.lei@redhat.com>
In-Reply-To: <20210207092029.1558550-1-ming.lei@redhat.com>
References: <20210207092029.1558550-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Limit scsi device's queue depth is less than max(host->can_queue, 1024)
in scsi_change_queue_depth(), and 1024 is big enough for saturating
current fast SCSI LUN(SSD, or raid volume on multiple SSDs). Also
single hw queue depth is usually enough for saturating single LUN
because per-core performance is often considered in storage design.

We need this patch for replacing sdev->device_busy with sbitmap which
has to be pre-allocated with reasonable max depth.

Cc: Omar Sandoval <osandov@fb.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Tested-by: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 24619c3bebd5..a28d48c850cf 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -214,6 +214,15 @@ void scsi_finish_command(struct scsi_cmnd *cmd)
 	scsi_io_completion(cmd, good_bytes);
 }
 
+
+/*
+ * 1024 is big enough for saturating the fast scsi LUN now
+ */
+static int scsi_device_max_queue_depth(struct scsi_device *sdev)
+{
+	return max_t(int, sdev->host->can_queue, 1024);
+}
+
 /**
  * scsi_change_queue_depth - change a device's queue depth
  * @sdev: SCSI Device in question
@@ -223,6 +232,8 @@ void scsi_finish_command(struct scsi_cmnd *cmd)
  */
 int scsi_change_queue_depth(struct scsi_device *sdev, int depth)
 {
+	depth = min_t(int, depth, scsi_device_max_queue_depth(sdev));
+
 	if (depth > 0) {
 		sdev->queue_depth = depth;
 		wmb();
-- 
2.29.2

