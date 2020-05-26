Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23781D059A
	for <lists+linux-block@lfdr.de>; Wed, 13 May 2020 05:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgEMDsa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 May 2020 23:48:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57560 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727107AbgEMDsa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 23:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589341708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zUZPLfWZn3fld2xI1a3x9XAmLNIS7ylvd5r6IkvTnfg=;
        b=jWXYQO4MnByPxP8xpJbaEEtzej2mHVwbfHEJpA6K1o3+TZ3cDwRijv7Kc5cjZ78XEtU2CS
        pVvzGI6EZIjWSfItq1tC7ygDRlyOgSHp4hYgymph16rDtcplM2weYfYw210YJm4TAk0Fg6
        ZwUJyUnpIFFC7dJV0bXONt0oUSwjs3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-4r1AASByObidgY0VU987OQ-1; Tue, 12 May 2020 23:48:26 -0400
X-MC-Unique: 4r1AASByObidgY0VU987OQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 173BB107ACCA;
        Wed, 13 May 2020 03:48:25 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F99A10013D9;
        Wed, 13 May 2020 03:48:14 +0000 (UTC)
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
Subject: [PATCH V11 01/12] block: clone nr_integrity_segments and write_hint in blk_rq_prep_clone
Date:   Wed, 13 May 2020 11:47:52 +0800
Message-Id: <20200513034803.1844579-2-ming.lei@redhat.com>
In-Reply-To: <20200513034803.1844579-1-ming.lei@redhat.com>
References: <20200513034803.1844579-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So far blk_rq_prep_clone() is only used for setup one underlying cloned
request from dm-rq request. block intetrity can be enabled for both dm-rq
and the underlying queues, so it is reasonable to clone rq's
nr_integrity_segments. Also write_hint is from bio, it should have been
cloned too.

So clone nr_integrity_segments and write_hint in blk_rq_prep_clone.

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
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index cf5b2163edfe..08ee92baa451 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1669,8 +1669,12 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 		rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
 		rq->special_vec = rq_src->special_vec;
 	}
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	rq->nr_integrity_segments = rq_src->nr_integrity_segments;
+#endif
 	rq->nr_phys_segments = rq_src->nr_phys_segments;
 	rq->ioprio = rq_src->ioprio;
+	rq->write_hint = rq_src->write_hint;
 
 	return 0;
 
-- 
2.25.2

