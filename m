Return-Path: <linux-block+bounces-18492-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA52A63E99
	for <lists+linux-block@lfdr.de>; Mon, 17 Mar 2025 05:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2DE3AC757
	for <lists+linux-block@lfdr.de>; Mon, 17 Mar 2025 04:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DF1215061;
	Mon, 17 Mar 2025 04:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuAqQmbC"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A80B1CAB3
	for <linux-block@vger.kernel.org>; Mon, 17 Mar 2025 04:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742186721; cv=none; b=Dc/YEinlVvjLGl/3Q2O/tQIQCzk5MJw9a9bKgwcziS0Dq3z27ZqZGiM9/2UGlMs5/VOxFU2qtj2FulKpgTXAa2Yvj/4+1Phrmq117YF7QEoNYUGDVQ1e1dpePDXAaHex9vpfkh3FW5TOhL2RZ57dB6gBFw0JUKAcwk0N95N84WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742186721; c=relaxed/simple;
	bh=SegGlhs5rUpbazr0P6rA5zofnxeczZspPIszZebPp0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3U2NpxN0UbCy/zM6DQnw0NkHS+mrbR94FQ+0y4Sfa+sHNq7xsOGaUXo7jHRvBWA9pImgenyPyFdkKC6cKalkLml3eOgb42Kk7USmxt1WNV8+8Qc/fwatas+nrA5JLFw7zSgdEnIG4eFfVnC8eX59wpCSRhkm7nYzWFOASMtels=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZuAqQmbC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742186718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWrD1i2oH26aPXh0nPETAOF3chlf/K1Pa5lwOz3u0UQ=;
	b=ZuAqQmbCe/DAutF1kB51Eh3DJJt2qNQmd9RlBV2pnqRheNyKc8FxzneI9+4N5X6zF692WH
	bkeAvX5F/iKYCq1Qtf1lm6SdPq1LLfNHX6iUyL8toJaslK3ormwyxc97YjOVjbaoA4eL0P
	0cYo3sC6LtKRiv0majhoALpb490Z9Fw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-1K0TQU_INa21wgKix8Saiw-1; Mon,
 17 Mar 2025 00:45:15 -0400
X-MC-Unique: 1K0TQU_INa21wgKix8Saiw-1
X-Mimecast-MFC-AGG-ID: 1K0TQU_INa21wgKix8Saiw_1742186714
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B5AD180AF50;
	Mon, 17 Mar 2025 04:45:13 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3FC1180175A;
	Mon, 17 Mar 2025 04:45:12 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 52H4jBD92200882
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 00:45:11 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 52H4jBhL2200881;
	Mon, 17 Mar 2025 00:45:11 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
        Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 5/6] dm: fix dm_blk_report_zones
Date: Mon, 17 Mar 2025 00:45:09 -0400
Message-ID: <20250317044510.2200856-6-bmarzins@redhat.com>
In-Reply-To: <20250317044510.2200856-1-bmarzins@redhat.com>
References: <20250317044510.2200856-1-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

If dm_get_live_table() returned NULL, dm_put_live_table() was never
called.  Also, if md->zone_revalidate_map is set, check that
dm_blk_report_zones() is being called from the process that set it in
__bind(). Otherwise the zone resources could change while accessing
them. Finally, it is possible that md->zone_revalidate_map will change
while calling this function. Only read it once, so that we are always
using the same value. Otherwise we might miss a call to
dm_put_live_table().

Fixes: f211268ed1f9b ("dm: Use the block layer zone append emulation")
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
---
 drivers/md/dm-core.h |  1 +
 drivers/md/dm-zone.c | 23 +++++++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 3637761f3585..f3a3f2ef6322 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -141,6 +141,7 @@ struct mapped_device {
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int nr_zones;
 	void *zone_revalidate_map;
+	struct task_struct *revalidate_map_task;
 #endif
 
 #ifdef CONFIG_IMA
diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 681058feb63b..11e19281bb64 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -56,24 +56,29 @@ int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
 {
 	struct mapped_device *md = disk->private_data;
 	struct dm_table *map;
-	int srcu_idx, ret;
+	struct dm_table *zone_revalidate_map = md->zone_revalidate_map;
+	int srcu_idx, ret = -EIO;
 
-	if (!md->zone_revalidate_map) {
-		/* Regular user context */
+	if (!zone_revalidate_map || md->revalidate_map_task != current) {
+		/*
+		 * Regular user context or
+		 * Zone revalidation during __bind() is in progress, but this
+		 * call is from a different process
+		 */
 		if (dm_suspended_md(md))
 			return -EAGAIN;
 
 		map = dm_get_live_table(md, &srcu_idx);
-		if (!map)
-			return -EIO;
 	} else {
 		/* Zone revalidation during __bind() */
-		map = md->zone_revalidate_map;
+		map = zone_revalidate_map;
 	}
 
-	ret = dm_blk_do_report_zones(md, map, sector, nr_zones, cb, data);
+	if (map)
+		ret = dm_blk_do_report_zones(md, map, sector, nr_zones, cb,
+					     data);
 
-	if (!md->zone_revalidate_map)
+	if (!zone_revalidate_map)
 		dm_put_live_table(md, srcu_idx);
 
 	return ret;
@@ -175,7 +180,9 @@ int dm_revalidate_zones(struct dm_table *t, struct request_queue *q)
 	 * our table for dm_blk_report_zones() to use directly.
 	 */
 	md->zone_revalidate_map = t;
+	md->revalidate_map_task = current;
 	ret = blk_revalidate_disk_zones(disk);
+	md->revalidate_map_task = NULL;
 	md->zone_revalidate_map = NULL;
 
 	if (ret) {
-- 
2.48.1


