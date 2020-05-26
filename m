Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D311C4BD0
	for <lists+linux-block@lfdr.de>; Tue,  5 May 2020 04:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgEECK4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 May 2020 22:10:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20873 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726549AbgEECK4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 May 2020 22:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588644654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gAxdaOm9FlUEqCCJZl96GkCvvlNikmfNWwfhROYSelc=;
        b=Rq98XDowmKpwQOlSLb9NkuM6gDNgIFfYqLr2Gu7uL+iXdRrteD/fgeGQ0Ku2Q5M9XlZWjT
        CQOdGJs9FJtdj5Jo1sjK+/mbHTEDI84taPyKTmN2m3Cteull/14w0OhS0j+nkiPgSBQLH1
        ZDCUigXaaxyjFm24vLEyQwjWWrkptqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-YKcVxDBLNxuJX4sNCxseVQ-1; Mon, 04 May 2020 22:10:50 -0400
X-MC-Unique: YKcVxDBLNxuJX4sNCxseVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4514A1840426;
        Tue,  5 May 2020 02:10:49 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 597131001B30;
        Tue,  5 May 2020 02:10:45 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V10 09/11] blk-mq: add blk_mq_hctx_handle_dead_cpu for handling cpu dead
Date:   Tue,  5 May 2020 10:09:28 +0800
Message-Id: <20200505020930.1146281-10-ming.lei@redhat.com>
In-Reply-To: <20200505020930.1146281-1-ming.lei@redhat.com>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add helper of blk_mq_hctx_handle_dead_cpu for handling cpu dead,
and prepare for handling inactive hctx.

No functional change.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Tested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4a2250ac4fbb..73e1a1d4c1c5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2382,22 +2382,13 @@ static int blk_mq_hctx_notify_online(unsigned int=
 cpu, struct hlist_node *node)
 	return 0;
 }
=20
-/*
- * 'cpu' is going away. splice any existing rq_list entries from this
- * software queue to the hw queue dispatch list, and ensure that it
- * gets run.
- */
-static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *=
node)
+static void blk_mq_hctx_handle_dead_cpu(struct blk_mq_hw_ctx *hctx,
+		unsigned int cpu)
 {
-	struct blk_mq_hw_ctx *hctx =3D hlist_entry_safe(node,
-			struct blk_mq_hw_ctx, cpuhp_dead);
 	struct blk_mq_ctx *ctx;
 	LIST_HEAD(tmp);
 	enum hctx_type type;
=20
-	if (!cpumask_test_cpu(cpu, hctx->cpumask))
-		return 0;
-
 	ctx =3D __blk_mq_get_ctx(hctx->queue, cpu);
 	type =3D hctx->type;
=20
@@ -2409,13 +2400,27 @@ static int blk_mq_hctx_notify_dead(unsigned int c=
pu, struct hlist_node *node)
 	spin_unlock(&ctx->lock);
=20
 	if (list_empty(&tmp))
-		return 0;
+		return;
=20
 	spin_lock(&hctx->lock);
 	list_splice_tail_init(&tmp, &hctx->dispatch);
 	spin_unlock(&hctx->lock);
=20
 	blk_mq_run_hw_queue(hctx, true);
+}
+
+/*
+ * 'cpu' is going away. splice any existing rq_list entries from this
+ * software queue to the hw queue dispatch list, and ensure that it
+ * gets run.
+ */
+static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *=
node)
+{
+	struct blk_mq_hw_ctx *hctx =3D hlist_entry_safe(node,
+			struct blk_mq_hw_ctx, cpuhp_dead);
+
+	if (cpumask_test_cpu(cpu, hctx->cpumask))
+		blk_mq_hctx_handle_dead_cpu(hctx, cpu);
 	return 0;
 }
=20
--=20
2.25.2

