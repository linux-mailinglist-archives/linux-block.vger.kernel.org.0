Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B2A6E9895
	for <lists+linux-block@lfdr.de>; Thu, 20 Apr 2023 17:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjDTPmW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Apr 2023 11:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjDTPmV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 11:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBAA5B93
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682005290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ap2ofZ8Q+jeeFALfMA8laNKolfF/ck/NkbULDKJfIa0=;
        b=D/0KTwhWwST70xSh2d9jkmJm3IpqSMDJv4tVph8Lr/1AwdjZ0CIfCJqeOspqifdgkxwiDK
        8P/04VWuVZV31u+H/8iYX0OkLdXT79Hee4mwWhunMNADSh70a5vMo6EZKwxstPOIiRxZKS
        VQC2C55TGZu1VybskXNnNtheZwxHuLc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-g98WgGzaPnaRgBDoqhFoLg-1; Thu, 20 Apr 2023 11:41:27 -0400
X-MC-Unique: g98WgGzaPnaRgBDoqhFoLg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF0CD185A78F;
        Thu, 20 Apr 2023 15:41:26 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16F2A2026D16;
        Thu, 20 Apr 2023 15:41:25 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/7] ublk: grab request reference when the request is handled by userspace
Date:   Thu, 20 Apr 2023 23:40:29 +0800
Message-Id: <20230420154032.1272836-5-ming.lei@redhat.com>
In-Reply-To: <20230420154032.1272836-1-ming.lei@redhat.com>
References: <20230420154032.1272836-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add one reference counter into request pdu data, and hold this reference
in the request's lifetime.

Prepare for supporting to move request data copy into userspace, which
needs to copy request data by read()/write() on /dev/ublkcN, so we have
to guarantee that read()/write() is done on one valid/active request,
and that will be enhanced by holding the io request reference in
read()/write().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 67 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index fee8c603c096..11ce55f0c395 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -43,6 +43,7 @@
 #include <asm/page.h>
 #include <linux/task_work.h>
 #include <linux/namei.h>
+#include <linux/kref.h>
 #include <uapi/linux/ublk_cmd.h>
 
 #define UBLK_MINORS		(1U << MINORBITS)
@@ -62,6 +63,8 @@
 
 struct ublk_rq_data {
 	struct llist_node node;
+
+	struct kref ref;
 };
 
 struct ublk_uring_cmd_pdu {
@@ -180,6 +183,9 @@ struct ublk_params_header {
 	__u32	types;
 };
 
+static inline void __ublk_complete_rq(struct request *req);
+static void ublk_complete_rq(struct kref *ref);
+
 static dev_t ublk_chr_devt;
 static struct class *ublk_chr_class;
 
@@ -288,6 +294,45 @@ static int ublk_apply_params(struct ublk_device *ub)
 	return 0;
 }
 
+static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
+{
+	return false;
+}
+
+static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
+		struct request *req)
+{
+	if (ublk_need_req_ref(ubq)) {
+		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+
+		kref_init(&data->ref);
+	}
+}
+
+static inline bool ublk_get_req_ref(const struct ublk_queue *ubq,
+		struct request *req)
+{
+	if (ublk_need_req_ref(ubq)) {
+		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+
+		return kref_get_unless_zero(&data->ref);
+	}
+
+	return true;
+}
+
+static inline void ublk_put_req_ref(const struct ublk_queue *ubq,
+		struct request *req)
+{
+	if (ublk_need_req_ref(ubq)) {
+		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+
+		kref_put(&data->ref, ublk_complete_rq);
+	} else {
+		__ublk_complete_rq(req);
+	}
+}
+
 static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_NEED_GET_DATA;
@@ -624,13 +669,19 @@ static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
 }
 
 /* todo: handle partial completion */
-static void ublk_complete_rq(struct request *req)
+static inline void __ublk_complete_rq(struct request *req)
 {
 	struct ublk_queue *ubq = req->mq_hctx->driver_data;
 	struct ublk_io *io = &ubq->ios[req->tag];
 	unsigned int unmapped_bytes;
 	blk_status_t res = BLK_STS_OK;
 
+	/* called from ublk_abort_queue() code path */
+	if (io->flags & UBLK_IO_FLAG_ABORTED) {
+		res = BLK_STS_IOERR;
+		goto exit;
+	}
+
 	/* failed read IO if nothing is read */
 	if (!io->res && req_op(req) == REQ_OP_READ)
 		io->res = -EIO;
@@ -670,6 +721,15 @@ static void ublk_complete_rq(struct request *req)
 	blk_mq_end_request(req, res);
 }
 
+static void ublk_complete_rq(struct kref *ref)
+{
+	struct ublk_rq_data *data = container_of(ref, struct ublk_rq_data,
+			ref);
+	struct request *req = blk_mq_rq_from_pdu(data);
+
+	__ublk_complete_rq(req);
+}
+
 /*
  * Since __ublk_rq_task_work always fails requests immediately during
  * exiting, __ublk_fail_req() is only called from abort context during
@@ -688,7 +748,7 @@ static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
 		if (ublk_queue_can_use_recovery_reissue(ubq))
 			blk_mq_requeue_request(req, false);
 		else
-			blk_mq_end_request(req, BLK_STS_IOERR);
+			ublk_put_req_ref(ubq, req);
 	}
 }
 
@@ -795,6 +855,7 @@ static inline void __ublk_rq_task_work(struct request *req)
 			mapped_bytes >> 9;
 	}
 
+	ublk_init_req_ref(ubq, req);
 	ubq_complete_io_cmd(io, UBLK_IO_RES_OK);
 }
 
@@ -981,7 +1042,7 @@ static void ublk_commit_completion(struct ublk_device *ub,
 	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
 
 	if (req && likely(!blk_should_fake_timeout(req->q)))
-		ublk_complete_rq(req);
+		ublk_put_req_ref(ubq, req);
 }
 
 /*
-- 
2.39.2

