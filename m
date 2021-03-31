Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB1034D3E1
	for <lists+linux-block@lfdr.de>; Mon, 29 Mar 2021 17:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhC2P2S (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 29 Mar 2021 11:28:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231270AbhC2P15 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 11:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617031676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fNlG+3ho3blgJVyFVypZc5c3TnkhPbJk0ckqheigCu8=;
        b=DJeaqRz+bhmKXKte+4pa601xC2xvi9ydbYrJauroVB7c2JzwzDchy7GO+ez5civnDi4JUf
        BZOC4HPmyOQHAZu/BxFmaM8TGaIaGFKFQjh7JlHQ6t6u2Dzq63OZrAYEJr6Kp7WIRZKUzJ
        o1sllRYrQo+0/Of3DbhtbiphFH7GdcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-LGej-2lTNAWJ_5UslOIKxQ-1; Mon, 29 Mar 2021 11:27:54 -0400
X-MC-Unique: LGej-2lTNAWJ_5UslOIKxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 574D287A83B;
        Mon, 29 Mar 2021 15:27:53 +0000 (UTC)
Received: from localhost (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 622EA5D6A1;
        Mon, 29 Mar 2021 15:27:52 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 07/12] block: prepare for supporting bio_list via other link
Date:   Mon, 29 Mar 2021 23:26:17 +0800
Message-Id: <20210329152622.173035-8-ming.lei@redhat.com>
In-Reply-To: <20210329152622.173035-1-ming.lei@redhat.com>
References: <20210329152622.173035-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So far bio list helpers always use .bi_next to traverse the list, we
will support to link bios by other bio field.

Prepare for such support by adding a macro so that users can define
another helpers for linking bios by other bio field.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bio.h | 132 +++++++++++++++++++++++---------------------
 1 file changed, 68 insertions(+), 64 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index d0246c92a6e8..619edd26a6c0 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -608,75 +608,11 @@ static inline unsigned bio_list_size(const struct bio_list *bl)
 	return sz;
 }
 
-static inline void bio_list_add(struct bio_list *bl, struct bio *bio)
-{
-	bio->bi_next = NULL;
-
-	if (bl->tail)
-		bl->tail->bi_next = bio;
-	else
-		bl->head = bio;
-
-	bl->tail = bio;
-}
-
-static inline void bio_list_add_head(struct bio_list *bl, struct bio *bio)
-{
-	bio->bi_next = bl->head;
-
-	bl->head = bio;
-
-	if (!bl->tail)
-		bl->tail = bio;
-}
-
-static inline void bio_list_merge(struct bio_list *bl, struct bio_list *bl2)
-{
-	if (!bl2->head)
-		return;
-
-	if (bl->tail)
-		bl->tail->bi_next = bl2->head;
-	else
-		bl->head = bl2->head;
-
-	bl->tail = bl2->tail;
-}
-
-static inline void bio_list_merge_head(struct bio_list *bl,
-				       struct bio_list *bl2)
-{
-	if (!bl2->head)
-		return;
-
-	if (bl->head)
-		bl2->tail->bi_next = bl->head;
-	else
-		bl->tail = bl2->tail;
-
-	bl->head = bl2->head;
-}
-
 static inline struct bio *bio_list_peek(struct bio_list *bl)
 {
 	return bl->head;
 }
 
-static inline struct bio *bio_list_pop(struct bio_list *bl)
-{
-	struct bio *bio = bl->head;
-
-	if (bio) {
-		bl->head = bl->head->bi_next;
-		if (!bl->head)
-			bl->tail = NULL;
-
-		bio->bi_next = NULL;
-	}
-
-	return bio;
-}
-
 static inline struct bio *bio_list_get(struct bio_list *bl)
 {
 	struct bio *bio = bl->head;
@@ -686,6 +622,74 @@ static inline struct bio *bio_list_get(struct bio_list *bl)
 	return bio;
 }
 
+#define BIO_LIST_HELPERS(_pre, link)					\
+									\
+static inline void _pre##_add(struct bio_list *bl, struct bio *bio)	\
+{									\
+	bio->bi_##link = NULL;						\
+									\
+	if (bl->tail)							\
+		bl->tail->bi_##link = bio;				\
+	else								\
+		bl->head = bio;						\
+									\
+	bl->tail = bio;							\
+}									\
+									\
+static inline void _pre##_add_head(struct bio_list *bl, struct bio *bio) \
+{									\
+	bio->bi_##link = bl->head;					\
+									\
+	bl->head = bio;							\
+									\
+	if (!bl->tail)							\
+		bl->tail = bio;						\
+}									\
+									\
+static inline void _pre##_merge(struct bio_list *bl, struct bio_list *bl2) \
+{									\
+	if (!bl2->head)							\
+		return;							\
+									\
+	if (bl->tail)							\
+		bl->tail->bi_##link = bl2->head;			\
+	else								\
+		bl->head = bl2->head;					\
+									\
+	bl->tail = bl2->tail;						\
+}									\
+									\
+static inline void _pre##_merge_head(struct bio_list *bl,		\
+				       struct bio_list *bl2)		\
+{									\
+	if (!bl2->head)							\
+		return;							\
+									\
+	if (bl->head)							\
+		bl2->tail->bi_##link = bl->head;			\
+	else								\
+		bl->tail = bl2->tail;					\
+									\
+	bl->head = bl2->head;						\
+}									\
+									\
+static inline struct bio *_pre##_pop(struct bio_list *bl)		\
+{									\
+	struct bio *bio = bl->head;					\
+									\
+	if (bio) {							\
+		bl->head = bl->head->bi_##link;				\
+		if (!bl->head)						\
+			bl->tail = NULL;				\
+									\
+		bio->bi_##link = NULL;					\
+	}								\
+									\
+	return bio;							\
+}									\
+
+BIO_LIST_HELPERS(bio_list, next);
+
 /*
  * Increment chain count for the bio. Make sure the CHAIN flag update
  * is visible before the raised count.
-- 
2.29.2

