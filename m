Return-Path: <linux-block+bounces-17616-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B4CA44103
	for <lists+linux-block@lfdr.de>; Tue, 25 Feb 2025 14:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433A117EFB5
	for <lists+linux-block@lfdr.de>; Tue, 25 Feb 2025 13:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E1C268C47;
	Tue, 25 Feb 2025 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HR2qLO6F"
X-Original-To: linux-block@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09365267AF3
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490297; cv=none; b=cpExqkpzMLAhJTZRlhe98Ip2cIeJxiaSU22XhGJvnYxp10q23XzbA0hZt0XJiPa+Vj+oj96eClyKkv3UicesssXEZU4Fq/CEKZFDdHYV8Hq/V/ifIM+MzytGBnk8PVxdjVQnhB4WEpPxaSKcQgEuPHlKsG9ADNcIurmaQ5u6Eiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490297; c=relaxed/simple;
	bh=IQREbOGeWT8m5L5ip7VwrxZbHna4AuVXHzngUblJ/QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qa9R14nfiQdKDiCkOGB6zGBn9EJ3cp0IDvjkiLrRlVAtyUyQPt96K8GrPnu8Be/Cjm195I/z0s/wR4F+44HhEgmbpT7tbDGA6wqyLSDfGqQib8FH8syNrg3AG7Ddstb+oGPZbd7wQE5RPbEctp9Otp0axE46BFFmEWBdIZOBdBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HR2qLO6F; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P6QmEZ020937;
	Tue, 25 Feb 2025 13:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pBe56FFSPMuvw4JNc
	F/XBS4NavXBvX6j67J9paVU0vs=; b=HR2qLO6FhjODkkm96FhzUPOtWC7Fz5h7G
	x1VLsVDP8XAkUxPFUG8Zw93krpC6XdRojqvewA7nPYLWk+atxgQwSibo/6CPFAF9
	b54wzcFYJ1zT2jwGoj0UzX4KjfstOfFDS5dtXmlAcMRtpMIRAU4j7kN7wOsbkRlB
	lboKOfctCZiG8iKSi+SIZk+HvSTJkqS9hsMbL3Z8jk569biFZYRz9EFLuyTTvQL/
	kuwsATQv9D2RobWMZAlDbPujhnNXi3v1rb52ipIqCFzFzHA4cttDPPdw8QVi81sk
	Dv+KK6JluT8W9JvuLdrMVqsRuX9sgsBmFsSoVV4jrzN1PK3g0OCZg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4518k6a0be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 13:31:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51PARK73026965;
	Tue, 25 Feb 2025 13:31:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdkcyxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 13:31:23 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51PDVLfa32506492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 13:31:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5934620043;
	Tue, 25 Feb 2025 13:31:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08AE220040;
	Tue, 25 Feb 2025 13:31:18 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.156.112])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2025 13:31:17 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, hare@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
Subject: [PATCHv4 1/7] block: acquire q->limits_lock while reading sysfs attributes
Date: Tue, 25 Feb 2025 19:00:36 +0530
Message-ID: <20250225133110.1441035-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250225133110.1441035-1-nilay@linux.ibm.com>
References: <20250225133110.1441035-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1KYAI3jzIVkTkZgdMXn9JQwZx8EIqua6
X-Proofpoint-GUID: 1KYAI3jzIVkTkZgdMXn9JQwZx8EIqua6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502250092

There're few sysfs attributes(RW) whose store method is protected
with q->limits_lock, however the corresponding show method of these
attributes run holding q->sysfs_lock and that doesn't make sense
as ideally the show method of these attributes should also run
holding q->limits_lock instead of q->sysfs_lock. Hence update the
show method of these sysfs attributes so that reading of these
attributes acquire q->limits_lock instead of q->sysfs_lock.

Similarly, there're few sysfs attributes(RO) whose show method is
currently protected with q->sysfs_lock however updates to these
attributes could occur using atomic limit update APIs such as queue_
limits_start_update() and queue_limits_commit_update() which run
holding q->limits_lock. So that means that reading these attributes
holding q->sysfs_lock doesn't make sense. Hence update the show method
of these sysfs attributes(RO) such that they run with holding q->
limits_lock instead of q->sysfs_lock.

We have defined a new macro QUEUE_LIM_RO_ENTRY() which uses new ->show_
limit() method and it runs holding q->limits_lock. All existing sysfs
attributes(RO) which needs protection using q->limits_lock while
reading have been now updated to use this new macro for initialization.

Also, the existing QUEUE_LIM_RW_ENTRY() is updated to use new ->show_
limit() method for reading attributes instead of existing ->show()
method. As ->show_limit() runs holding q->limits_lock, the existing
sysfs attributes(RW) requiring protection are now inherently protected
using q->limits_lock instead of q->sysfs_lock.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-sysfs.c | 102 +++++++++++++++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 37 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 6f548a4376aa..eba5121690af 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -23,9 +23,12 @@
 struct queue_sysfs_entry {
 	struct attribute attr;
 	ssize_t (*show)(struct gendisk *disk, char *page);
+	ssize_t (*show_limit)(struct gendisk *disk, char *page);
+
 	ssize_t (*store)(struct gendisk *disk, const char *page, size_t count);
 	int (*store_limit)(struct gendisk *disk, const char *page,
 			size_t count, struct queue_limits *lim);
+
 	void (*load_module)(struct gendisk *disk, const char *page, size_t count);
 };
 
@@ -412,10 +415,16 @@ static struct queue_sysfs_entry _prefix##_entry = {	\
 	.store	= _prefix##_store,			\
 };
 
+#define QUEUE_LIM_RO_ENTRY(_prefix, _name)			\
+static struct queue_sysfs_entry _prefix##_entry = {	\
+	.attr		= { .name = _name, .mode = 0444 },	\
+	.show_limit	= _prefix##_show,			\
+}
+
 #define QUEUE_LIM_RW_ENTRY(_prefix, _name)			\
 static struct queue_sysfs_entry _prefix##_entry = {	\
 	.attr		= { .name = _name, .mode = 0644 },	\
-	.show		= _prefix##_show,			\
+	.show_limit	= _prefix##_show,			\
 	.store_limit	= _prefix##_store,			\
 }
 
@@ -430,39 +439,39 @@ static struct queue_sysfs_entry _prefix##_entry = {		\
 QUEUE_RW_ENTRY(queue_requests, "nr_requests");
 QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
 QUEUE_LIM_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
-QUEUE_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
-QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
-QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
-QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
+QUEUE_LIM_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
+QUEUE_LIM_RO_ENTRY(queue_max_segments, "max_segments");
+QUEUE_LIM_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
+QUEUE_LIM_RO_ENTRY(queue_max_segment_size, "max_segment_size");
 QUEUE_RW_LOAD_MODULE_ENTRY(elv_iosched, "scheduler");
 
-QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
-QUEUE_RO_ENTRY(queue_physical_block_size, "physical_block_size");
-QUEUE_RO_ENTRY(queue_chunk_sectors, "chunk_sectors");
-QUEUE_RO_ENTRY(queue_io_min, "minimum_io_size");
-QUEUE_RO_ENTRY(queue_io_opt, "optimal_io_size");
+QUEUE_LIM_RO_ENTRY(queue_logical_block_size, "logical_block_size");
+QUEUE_LIM_RO_ENTRY(queue_physical_block_size, "physical_block_size");
+QUEUE_LIM_RO_ENTRY(queue_chunk_sectors, "chunk_sectors");
+QUEUE_LIM_RO_ENTRY(queue_io_min, "minimum_io_size");
+QUEUE_LIM_RO_ENTRY(queue_io_opt, "optimal_io_size");
 
-QUEUE_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
-QUEUE_RO_ENTRY(queue_discard_granularity, "discard_granularity");
-QUEUE_RO_ENTRY(queue_max_hw_discard_sectors, "discard_max_hw_bytes");
+QUEUE_LIM_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
+QUEUE_LIM_RO_ENTRY(queue_discard_granularity, "discard_granularity");
+QUEUE_LIM_RO_ENTRY(queue_max_hw_discard_sectors, "discard_max_hw_bytes");
 QUEUE_LIM_RW_ENTRY(queue_max_discard_sectors, "discard_max_bytes");
 QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 
-QUEUE_RO_ENTRY(queue_atomic_write_max_sectors, "atomic_write_max_bytes");
-QUEUE_RO_ENTRY(queue_atomic_write_boundary_sectors,
+QUEUE_LIM_RO_ENTRY(queue_atomic_write_max_sectors, "atomic_write_max_bytes");
+QUEUE_LIM_RO_ENTRY(queue_atomic_write_boundary_sectors,
 		"atomic_write_boundary_bytes");
-QUEUE_RO_ENTRY(queue_atomic_write_unit_max, "atomic_write_unit_max_bytes");
-QUEUE_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min_bytes");
+QUEUE_LIM_RO_ENTRY(queue_atomic_write_unit_max, "atomic_write_unit_max_bytes");
+QUEUE_LIM_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min_bytes");
 
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
-QUEUE_RO_ENTRY(queue_max_write_zeroes_sectors, "write_zeroes_max_bytes");
-QUEUE_RO_ENTRY(queue_max_zone_append_sectors, "zone_append_max_bytes");
-QUEUE_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
+QUEUE_LIM_RO_ENTRY(queue_max_write_zeroes_sectors, "write_zeroes_max_bytes");
+QUEUE_LIM_RO_ENTRY(queue_max_zone_append_sectors, "zone_append_max_bytes");
+QUEUE_LIM_RO_ENTRY(queue_zone_write_granularity, "zone_write_granularity");
 
-QUEUE_RO_ENTRY(queue_zoned, "zoned");
+QUEUE_LIM_RO_ENTRY(queue_zoned, "zoned");
 QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
-QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
-QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
+QUEUE_LIM_RO_ENTRY(queue_max_open_zones, "max_open_zones");
+QUEUE_LIM_RO_ENTRY(queue_max_active_zones, "max_active_zones");
 
 QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
 QUEUE_LIM_RW_ENTRY(queue_iostats_passthrough, "iostats_passthrough");
@@ -470,16 +479,16 @@ QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
 QUEUE_RW_ENTRY(queue_poll, "io_poll");
 QUEUE_RW_ENTRY(queue_poll_delay, "io_poll_delay");
 QUEUE_LIM_RW_ENTRY(queue_wc, "write_cache");
-QUEUE_RO_ENTRY(queue_fua, "fua");
-QUEUE_RO_ENTRY(queue_dax, "dax");
+QUEUE_LIM_RO_ENTRY(queue_fua, "fua");
+QUEUE_LIM_RO_ENTRY(queue_dax, "dax");
 QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
-QUEUE_RO_ENTRY(queue_virt_boundary_mask, "virt_boundary_mask");
-QUEUE_RO_ENTRY(queue_dma_alignment, "dma_alignment");
+QUEUE_LIM_RO_ENTRY(queue_virt_boundary_mask, "virt_boundary_mask");
+QUEUE_LIM_RO_ENTRY(queue_dma_alignment, "dma_alignment");
 
 /* legacy alias for logical_block_size: */
 static struct queue_sysfs_entry queue_hw_sector_size_entry = {
-	.attr = {.name = "hw_sector_size", .mode = 0444 },
-	.show = queue_logical_block_size_show,
+	.attr		= {.name = "hw_sector_size", .mode = 0444 },
+	.show_limit	= queue_logical_block_size_show,
 };
 
 QUEUE_LIM_RW_ENTRY(queue_rotational, "rotational");
@@ -561,7 +570,9 @@ QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
 
 /* Common attributes for bio-based and request-based queues. */
 static struct attribute *queue_attrs[] = {
-	&queue_ra_entry.attr,
+	/*
+	 * Attributes which are protected with q->limits_lock.
+	 */
 	&queue_max_hw_sectors_entry.attr,
 	&queue_max_sectors_entry.attr,
 	&queue_max_segments_entry.attr,
@@ -577,37 +588,46 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_granularity_entry.attr,
 	&queue_max_discard_sectors_entry.attr,
 	&queue_max_hw_discard_sectors_entry.attr,
-	&queue_discard_zeroes_data_entry.attr,
 	&queue_atomic_write_max_sectors_entry.attr,
 	&queue_atomic_write_boundary_sectors_entry.attr,
 	&queue_atomic_write_unit_min_entry.attr,
 	&queue_atomic_write_unit_max_entry.attr,
-	&queue_write_same_max_entry.attr,
 	&queue_max_write_zeroes_sectors_entry.attr,
 	&queue_max_zone_append_sectors_entry.attr,
 	&queue_zone_write_granularity_entry.attr,
 	&queue_rotational_entry.attr,
 	&queue_zoned_entry.attr,
-	&queue_nr_zones_entry.attr,
 	&queue_max_open_zones_entry.attr,
 	&queue_max_active_zones_entry.attr,
-	&queue_nomerges_entry.attr,
 	&queue_iostats_passthrough_entry.attr,
 	&queue_iostats_entry.attr,
 	&queue_stable_writes_entry.attr,
 	&queue_add_random_entry.attr,
-	&queue_poll_entry.attr,
 	&queue_wc_entry.attr,
 	&queue_fua_entry.attr,
 	&queue_dax_entry.attr,
-	&queue_poll_delay_entry.attr,
 	&queue_virt_boundary_mask_entry.attr,
 	&queue_dma_alignment_entry.attr,
+
+	/*
+	 * Attributes which are protected with q->sysfs_lock.
+	 */
+	&queue_ra_entry.attr,
+	&queue_discard_zeroes_data_entry.attr,
+	&queue_write_same_max_entry.attr,
+	&queue_nr_zones_entry.attr,
+	&queue_nomerges_entry.attr,
+	&queue_poll_entry.attr,
+	&queue_poll_delay_entry.attr,
+
 	NULL,
 };
 
 /* Request-based queue attributes that are not relevant for bio-based queues. */
 static struct attribute *blk_mq_queue_attrs[] = {
+	/*
+	 * Attributes which are protected with q->sysfs_lock.
+	 */
 	&queue_requests_entry.attr,
 	&elv_iosched_entry.attr,
 	&queue_rq_affinity_entry.attr,
@@ -666,8 +686,16 @@ queue_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
 	ssize_t res;
 
-	if (!entry->show)
+	if (!entry->show && !entry->show_limit)
 		return -EIO;
+
+	if (entry->show_limit) {
+		mutex_lock(&disk->queue->limits_lock);
+		res = entry->show_limit(disk, page);
+		mutex_unlock(&disk->queue->limits_lock);
+		return res;
+	}
+
 	mutex_lock(&disk->queue->sysfs_lock);
 	res = entry->show(disk, page);
 	mutex_unlock(&disk->queue->sysfs_lock);
-- 
2.47.1


