Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79B6350CA4
	for <lists+linux-block@lfdr.de>; Thu,  1 Apr 2021 04:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhDACWm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 31 Mar 2021 22:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233017AbhDACWW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Mar 2021 22:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617243742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hZt24CEARU6Yv/bHjbVY6KNYmBCmcBmLA9sEje63iJ8=;
        b=evm5G9T7feeqjVyqP2DYpJyTjjrVCixKL44277NYUR+814hJvb216TzAI204wcA5X5Q/pG
        6TaugnT/X8WgL9LleudjSScX2i6n6Q9RjPn/2Qxn3P8DHTNIYGgsFoU3Ic4V1nsjqzCrX5
        d2vrfbfur08nWvd5QWHazxr55c2vcIs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-iFST3lehNjKiBzPSR8MCSA-1; Wed, 31 Mar 2021 22:22:16 -0400
X-MC-Unique: iFST3lehNjKiBzPSR8MCSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C91D91005D5C;
        Thu,  1 Apr 2021 02:22:14 +0000 (UTC)
Received: from localhost (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4ADCD1378E;
        Thu,  1 Apr 2021 02:22:03 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 12/12] dm: support IO polling for bio-based dm device
Date:   Thu,  1 Apr 2021 10:19:27 +0800
Message-Id: <20210401021927.343727-13-ming.lei@redhat.com>
In-Reply-To: <20210401021927.343727-1-ming.lei@redhat.com>
References: <20210401021927.343727-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jeffle Xu <jefflexu@linux.alibaba.com>

IO polling is enabled when all underlying target devices are capable
of IO polling. The sanity check supports the stacked device model, in
which one dm device may be build upon another dm device. In this case,
the mapped device will check if the underlying dm target device
supports IO polling.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/dm-table.c         | 24 ++++++++++++++++++++++++
 drivers/md/dm.c               | 14 ++++++++++++++
 include/linux/device-mapper.h |  1 +
 3 files changed, 39 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 95391f78b8d5..a8f3575fb118 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1509,6 +1509,12 @@ struct dm_target *dm_table_find_target(struct dm_table *t, sector_t sector)
 	return &t->targets[(KEYS_PER_NODE * n) + k];
 }
 
+static int device_not_poll_capable(struct dm_target *ti, struct dm_dev *dev,
+				   sector_t start, sector_t len, void *data)
+{
+	return !blk_queue_poll(bdev_get_queue(dev->bdev));
+}
+
 /*
  * type->iterate_devices() should be called when the sanity check needs to
  * iterate and check all underlying data devices. iterate_devices() will
@@ -1559,6 +1565,11 @@ static int count_device(struct dm_target *ti, struct dm_dev *dev,
 	return 0;
 }
 
+int dm_table_supports_poll(struct dm_table *t)
+{
+	return !dm_table_any_dev_attr(t, device_not_poll_capable, NULL);
+}
+
 /*
  * Check whether a table has no data devices attached using each
  * target's iterate_devices method.
@@ -2079,6 +2090,19 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 
 	dm_update_keyslot_manager(q, t);
 	blk_queue_update_readahead(q);
+
+	/*
+	 * Check for request-based device is remained to
+	 * dm_mq_init_request_queue()->blk_mq_init_allocated_queue().
+	 * For bio-based device, only set QUEUE_FLAG_POLL when all underlying
+	 * devices supporting polling.
+	 */
+	if (__table_type_bio_based(t->type)) {
+		if (dm_table_supports_poll(t))
+			blk_queue_flag_set(QUEUE_FLAG_POLL, q);
+		else
+			blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
+	}
 }
 
 unsigned int dm_table_get_num_targets(struct dm_table *t)
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 50b693d776d6..dacc988045c9 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1720,6 +1720,19 @@ static blk_qc_t dm_submit_bio(struct bio *bio)
 	return ret;
 }
 
+static bool dm_poll_capable(struct gendisk *disk)
+{
+	int ret, srcu_idx;
+	struct mapped_device *md = disk->private_data;
+	struct dm_table *t;
+
+	t = dm_get_live_table(md, &srcu_idx);
+	ret = dm_table_supports_poll(t);
+	dm_put_live_table(md, srcu_idx);
+
+	return ret;
+}
+
 /*-----------------------------------------------------------------
  * An IDR is used to keep track of allocated minor numbers.
  *---------------------------------------------------------------*/
@@ -3132,6 +3145,7 @@ static const struct pr_ops dm_pr_ops = {
 };
 
 static const struct block_device_operations dm_blk_dops = {
+	.poll_capable = dm_poll_capable,
 	.submit_bio = dm_submit_bio,
 	.open = dm_blk_open,
 	.release = dm_blk_close,
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 7f4ac87c0b32..31bfd6f70013 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -538,6 +538,7 @@ unsigned int dm_table_get_num_targets(struct dm_table *t);
 fmode_t dm_table_get_mode(struct dm_table *t);
 struct mapped_device *dm_table_get_md(struct dm_table *t);
 const char *dm_table_device_name(struct dm_table *t);
+int dm_table_supports_poll(struct dm_table *t);
 
 /*
  * Trigger an event.
-- 
2.29.2

