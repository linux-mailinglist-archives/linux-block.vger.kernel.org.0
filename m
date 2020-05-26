Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADAF1C4BC7
	for <lists+linux-block@lfdr.de>; Tue,  5 May 2020 04:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgEECKO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 May 2020 22:10:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34269 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726549AbgEECKO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 22:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588644613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F++Yyk1HMgAa5x7l1igQ8d9RYnUZYTL3e386JmbDv9g=;
        b=KRClpeZyt5JOKDVpYudNF8HWMszgXTNscUFpQ4y78yTZ2vGocaGG32vNB0bWIKAcTnj1jt
        CMdJF3G84wDEscPmsEzh6q+Z1gtK5yLwAkPIlrzstdpDbkp2rsqjPr+EeasVU5dsx984RD
        8mpTqcslFCA4jaA5eIRK/R/eQYjTk5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-VXFdIzUBNX6JqZBlj4JqiQ-1; Mon, 04 May 2020 22:10:09 -0400
X-MC-Unique: VXFdIzUBNX6JqZBlj4JqiQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BDF11005510;
        Tue,  5 May 2020 02:10:07 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF53A5D9C9;
        Tue,  5 May 2020 02:09:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH V10 02/11] block: add helper for copying request
Date:   Tue,  5 May 2020 10:09:21 +0800
Message-Id: <20200505020930.1146281-3-ming.lei@redhat.com>
In-Reply-To: <20200505020930.1146281-1-ming.lei@redhat.com>
References: <20200505020930.1146281-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add one new helper of blk_rq_copy_request() to copy request, and the help=
er
will be used in this patch for re-submitting request, so make it as a blo=
ck
layer internal helper.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: dm-devel@redhat.com
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Tested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 31 ++++++++++++++++++-------------
 block/blk.h      |  2 ++
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1fe73051fec3..ec50d7e6be21 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1581,6 +1581,23 @@ void blk_rq_unprep_clone(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_rq_unprep_clone);
=20
+void blk_rq_copy_request(struct request *rq, struct request *rq_src)
+{
+	/* Copy attributes of the original request to the clone request. */
+	rq->__sector =3D blk_rq_pos(rq_src);
+	rq->__data_len =3D blk_rq_bytes(rq_src);
+	if (rq_src->rq_flags & RQF_SPECIAL_PAYLOAD) {
+		rq->rq_flags |=3D RQF_SPECIAL_PAYLOAD;
+		rq->special_vec =3D rq_src->special_vec;
+	}
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	rq->nr_integrity_segments =3D rq_src->nr_integrity_segments;
+#endif
+	rq->nr_phys_segments =3D rq_src->nr_phys_segments;
+	rq->ioprio =3D rq_src->ioprio;
+	rq->write_hint =3D rq_src->write_hint;
+}
+
 /**
  * blk_rq_prep_clone - Helper function to setup clone request
  * @rq: the request to be setup
@@ -1623,19 +1640,7 @@ int blk_rq_prep_clone(struct request *rq, struct r=
equest *rq_src,
 			rq->bio =3D rq->biotail =3D bio;
 	}
=20
-	/* Copy attributes of the original request to the clone request. */
-	rq->__sector =3D blk_rq_pos(rq_src);
-	rq->__data_len =3D blk_rq_bytes(rq_src);
-	if (rq_src->rq_flags & RQF_SPECIAL_PAYLOAD) {
-		rq->rq_flags |=3D RQF_SPECIAL_PAYLOAD;
-		rq->special_vec =3D rq_src->special_vec;
-	}
-#ifdef CONFIG_BLK_DEV_INTEGRITY
-	rq->nr_integrity_segments =3D rq_src->nr_integrity_segments;
-#endif
-	rq->nr_phys_segments =3D rq_src->nr_phys_segments;
-	rq->ioprio =3D rq_src->ioprio;
-	rq->write_hint =3D rq_src->write_hint;
+	blk_rq_copy_request(rq, rq_src);
=20
 	return 0;
=20
diff --git a/block/blk.h b/block/blk.h
index 73bd3b1c6938..73dd86dc8f47 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -120,6 +120,8 @@ static inline void blk_rq_bio_prep(struct request *rq=
, struct bio *bio,
 		rq->rq_disk =3D bio->bi_disk;
 }
=20
+void blk_rq_copy_request(struct request *rq, struct request *rq_src);
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 void blk_flush_integrity(void);
 bool __bio_integrity_endio(struct bio *);
--=20
2.25.2

