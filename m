Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2815F4B7FAB
	for <lists+linux-block@lfdr.de>; Wed, 16 Feb 2022 05:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245510AbiBPErI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Feb 2022 23:47:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344387AbiBPErI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 23:47:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECEF6F47DC
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 20:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644986816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sXL6gda84rSfFDQ/K0wQcHzXVEcSQqhmCEHnCICmMys=;
        b=KiD9m1DZ5Xuy1ywgUw+d72c7vnlGmXU5sOOQvdf5EZ05CmTTEw0PFQXIiIygU8cgxr9zhw
        ZEdB+BI9XpIFB84Y57mcqcqXVjF1QANy5MVAh/Yo5XUSRk4kWndO0iYQ+L5YvDF/cTAxMN
        wSB3EGRt7KBNwpdO+xjGJKhfhwxHeRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-S8LqXMh7M8q0Ix5yhpmr5w-1; Tue, 15 Feb 2022 23:46:54 -0500
X-MC-Unique: S8LqXMh7M8q0Ix5yhpmr5w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 921771006AA0;
        Wed, 16 Feb 2022 04:46:53 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99DAD79588;
        Wed, 16 Feb 2022 04:46:42 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ning Li <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 7/8] block: don't try to throttle split bio if iops limit isn't set
Date:   Wed, 16 Feb 2022 12:45:13 +0800
Message-Id: <20220216044514.2903784-8-ming.lei@redhat.com>
In-Reply-To: <20220216044514.2903784-1-ming.lei@redhat.com>
References: <20220216044514.2903784-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We need to throttle split bio in case of IOPS limit even though the
split bio has been marked as BIO_THROTTLED since block layer
accounts split bio actually.

If only throughput throttle is setup, no need to throttle any more
if BIO_THROTTLED is set since we have accounted & considered the
whole bio bytes already.

Add one flag of THROTL_TG_HAS_IOPS_LIMIT for serving this purpose.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-throttle.c | 21 ++++++++++++++-------
 block/blk-throttle.h | 11 +++++++++++
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index c7aa26d52e84..ec72eced24d2 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -41,11 +41,6 @@
 /* A workqueue to queue throttle related work */
 static struct workqueue_struct *kthrotld_workqueue;
 
-enum tg_state_flags {
-	THROTL_TG_PENDING	= 1 << 0,	/* on parent's pending tree */
-	THROTL_TG_WAS_EMPTY	= 1 << 1,	/* bio_lists[] became non-empty */
-};
-
 #define rb_entry_tg(node)	rb_entry((node), struct throtl_grp, rb_node)
 
 /* We measure latency for request size from <= 4k to >= 1M */
@@ -425,12 +420,24 @@ static void tg_update_has_rules(struct throtl_grp *tg)
 	struct throtl_grp *parent_tg = sq_to_tg(tg->service_queue.parent_sq);
 	struct throtl_data *td = tg->td;
 	int rw;
+	int has_iops_limit = 0;
+
+	for (rw = READ; rw <= WRITE; rw++) {
+		unsigned int iops_limit = tg_iops_limit(tg, rw);
 
-	for (rw = READ; rw <= WRITE; rw++)
 		tg->has_rules[rw] = (parent_tg && parent_tg->has_rules[rw]) ||
 			(td->limit_valid[td->limit_index] &&
 			 (tg_bps_limit(tg, rw) != U64_MAX ||
-			  tg_iops_limit(tg, rw) != UINT_MAX));
+			  iops_limit != UINT_MAX));
+
+		if (iops_limit != UINT_MAX)
+			has_iops_limit = 1;
+	}
+
+	if (has_iops_limit)
+		tg->flags |= THROTL_TG_HAS_IOPS_LIMIT;
+	else
+		tg->flags &= ~THROTL_TG_HAS_IOPS_LIMIT;
 }
 
 static void throtl_pd_online(struct blkg_policy_data *pd)
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index cb43f4417d6e..c996a15f290e 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -52,6 +52,12 @@ struct throtl_service_queue {
 	struct timer_list	pending_timer;	/* fires on first_pending_disptime */
 };
 
+enum tg_state_flags {
+	THROTL_TG_PENDING	= 1 << 0,	/* on parent's pending tree */
+	THROTL_TG_WAS_EMPTY	= 1 << 1,	/* bio_lists[] became non-empty */
+	THROTL_TG_HAS_IOPS_LIMIT = 1 << 2,	/* tg has iops limit */
+};
+
 enum {
 	LIMIT_LOW,
 	LIMIT_MAX,
@@ -170,6 +176,11 @@ static inline bool blk_throtl_bio(struct bio *bio)
 {
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
 
+	/* no need to throttle bps any more if the bio has been throttled */
+	if (bio_flagged(bio, BIO_THROTTLED) &&
+	    !(tg->flags & THROTL_TG_HAS_IOPS_LIMIT))
+		return false;
+
 	if (!tg->has_rules[bio_data_dir(bio)])
 		return false;
 
-- 
2.31.1

