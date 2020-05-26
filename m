Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBFB1C4BCC
	for <lists+linux-block@lfdr.de>; Tue,  5 May 2020 04:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgEECKd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 May 2020 22:10:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22540 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726549AbgEECKd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 22:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588644631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkBKhPN3hzVtyShi+Olbb4CJEcsgW4H0ZVRyrJuB1Ig=;
        b=AGBobAgp23Z8izQ86QklXQTpYEhrbdTp2qziH7U5wbIlSu7Iu0E2WZo11s2rKYcT4b/xFE
        4NncmFrEU9nHFTn2pWCkCWD2pdjl++jHQ7EDR9hbBAlm8hATPOks8xq0U9dUN5PvkRiVml
        Ik+fMtl0SGeRLCI9NQM4Qc9japSvKF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-y3qTEzgTMpOZ-Y9IwHzmVw-1; Mon, 04 May 2020 22:10:27 -0400
X-MC-Unique: y3qTEzgTMpOZ-Y9IwHzmVw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A51D1005510;
        Tue,  5 May 2020 02:10:26 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82D0662490;
        Tue,  5 May 2020 02:10:25 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V10 05/11] blk-mq: support rq filter callback when iterating rqs
Date:   Tue,  5 May 2020 10:09:24 +0800
Message-Id: <20200505020930.1146281-6-ming.lei@redhat.com>
In-Reply-To: <20200505020930.1146281-1-ming.lei@redhat.com>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now request is thought as in-flight only when its state is updated as
MQ_RQ_IN_FLIGHT, which is done by driver via blk_mq_start_request().

Actually from blk-mq's view, one rq can be thought as in-flight
after its tag is >=3D 0.

Passing one rq filter callback so that we can iterating requests very
flexible.

Implement blk_mq_all_tag_busy_iter() which accepts a 'busy_fn' argument
to filter over which commands to iterate, and make the existing
blk_mq_tag_busy_iter() a wrapper for the new function.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c | 39 +++++++++++++++++++++++++++------------
 block/blk-mq-tag.h |  4 ++++
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 586c9d6e904a..2e43b827c96d 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -255,6 +255,7 @@ static void bt_for_each(struct blk_mq_hw_ctx *hctx, s=
truct sbitmap_queue *bt,
 struct bt_tags_iter_data {
 	struct blk_mq_tags *tags;
 	busy_tag_iter_fn *fn;
+	busy_rq_iter_fn *busy_rq_fn;
 	void *data;
 	bool reserved;
 };
@@ -274,7 +275,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsi=
gned int bitnr, void *data)
 	 * test and set the bit before assining ->rqs[].
 	 */
 	rq =3D tags->rqs[bitnr];
-	if (rq && blk_mq_request_started(rq))
+	if (rq && iter_data->busy_rq_fn(rq, iter_data->data, reserved))
 		return iter_data->fn(rq, iter_data->data, reserved);
=20
 	return true;
@@ -294,11 +295,13 @@ static bool bt_tags_iter(struct sbitmap *bitmap, un=
signed int bitnr, void *data)
  *		bitmap_tags member of struct blk_mq_tags.
  */
 static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_qu=
eue *bt,
-			     busy_tag_iter_fn *fn, void *data, bool reserved)
+			     busy_tag_iter_fn *fn, busy_rq_iter_fn *busy_rq_fn,
+			     void *data, bool reserved)
 {
 	struct bt_tags_iter_data iter_data =3D {
 		.tags =3D tags,
 		.fn =3D fn,
+		.busy_rq_fn =3D busy_rq_fn,
 		.data =3D data,
 		.reserved =3D reserved,
 	};
@@ -310,19 +313,30 @@ static void bt_tags_for_each(struct blk_mq_tags *ta=
gs, struct sbitmap_queue *bt,
 /**
  * blk_mq_all_tag_busy_iter - iterate over all started requests in a tag=
 map
  * @tags:	Tag map to iterate over.
- * @fn:		Pointer to the function that will be called for each started
- *		request. @fn will be called as follows: @fn(rq, @priv,
- *		reserved) where rq is a pointer to a request. 'reserved'
- *		indicates whether or not @rq is a reserved request. Return
- *		true to continue iterating tags, false to stop.
+ * @fn:		Pointer to the function that will be called for each request
+ * 		when .busy_rq_fn(rq) returns true. @fn will be called as
+ * 		follows: @fn(rq, @priv, reserved) where rq is a pointer to a
+ * 		request. 'reserved' indicates whether or not @rq is a reserved
+ * 		request. Return true to continue iterating tags, false to stop.
+ * @busy_rq_fn: Pointer to the function that will be called for each req=
uest,
+ * 		@busy_rq_fn's type is same with @fn. Only when @busy_rq_fn(rq,
+ * 		@priv, reserved) returns true, @fn will be called on this rq.
  * @priv:	Will be passed as second argument to @fn.
  */
-static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
-		busy_tag_iter_fn *fn, void *priv)
+void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
+		busy_tag_iter_fn *fn, busy_rq_iter_fn *busy_rq_fn,
+		void *priv)
 {
 	if (tags->nr_reserved_tags)
-		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv, true);
-	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, false);
+		bt_tags_for_each(tags, &tags->breserved_tags, fn, busy_rq_fn,
+				priv, true);
+	bt_tags_for_each(tags, &tags->bitmap_tags, fn, busy_rq_fn, priv, false)=
;
+}
+
+static bool blk_mq_default_busy_rq(struct request *rq, void *data,
+		bool reserved)
+{
+	return blk_mq_request_started(rq);
 }
=20
 /**
@@ -342,7 +356,8 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *t=
agset,
=20
 	for (i =3D 0; i < tagset->nr_hw_queues; i++) {
 		if (tagset->tags && tagset->tags[i])
-			blk_mq_all_tag_busy_iter(tagset->tags[i], fn, priv);
+			blk_mq_all_tag_busy_iter(tagset->tags[i], fn,
+					blk_mq_default_busy_rq, priv);
 	}
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 2b8321efb682..fdf095d513e5 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -21,6 +21,7 @@ struct blk_mq_tags {
 	struct list_head page_list;
 };
=20
+typedef bool (busy_rq_iter_fn)(struct request *, void *, bool);
=20
 extern struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags, unsign=
ed int reserved_tags, int node, int alloc_policy);
 extern void blk_mq_free_tags(struct blk_mq_tags *tags);
@@ -34,6 +35,9 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx=
 *hctx,
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *f=
n,
 		void *priv);
+void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
+		busy_tag_iter_fn *fn, busy_rq_iter_fn *busy_rq_fn,
+		void *priv);
=20
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *b=
t,
 						 struct blk_mq_hw_ctx *hctx)
--=20
2.25.2

