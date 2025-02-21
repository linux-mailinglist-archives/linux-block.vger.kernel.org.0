Return-Path: <linux-block+bounces-17441-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A727A3EE8D
	for <lists+linux-block@lfdr.de>; Fri, 21 Feb 2025 09:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4D0E7A45C3
	for <lists+linux-block@lfdr.de>; Fri, 21 Feb 2025 08:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBFC204F8A;
	Fri, 21 Feb 2025 08:15:06 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5251204081;
	Fri, 21 Feb 2025 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125705; cv=none; b=QM9JzSLcniSMy+wG+6bomjKSc0dkHpm+OraWV0L3Kqap0g1qFSy5ubxzcQUzhd0B9F0y/dyJE0EDDYc21SoJ29rSKeA5t2kQXGvGis+FmHLaV0vkXJidSW7KaSRtg/p7igDSIByayG9oHsWBbHYnf3XHm+sx+Bufn5O504zl7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125705; c=relaxed/simple;
	bh=N0UfP5QlKELJCsqi9sDDnbLbts2YD1i7p9VUY508QCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BfqqEP9pNKQkJulLr+ajEnkN6a4IY33ulLGjwwm/qH13adGOup4hlu8RYz7Bzo53bmeL4xwHNXP2J1VovRDgaBTflmI57u3h9Vs2heMwU1zcliLbJh3RM+Ndn7UdxU5f8buIQcSc1YsCH8ZmTNbN8xMzxjT9imQPRd5MeGsM7Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YzjbL2hRvz4f3jXP;
	Fri, 21 Feb 2025 16:14:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0A9D51A16AA;
	Fri, 21 Feb 2025 16:15:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl_8NbhnHF3eEQ--.3944S11;
	Fri, 21 Feb 2025 16:14:59 +0800 (CST)
From: Zheng Qixing <zhengqixing@huaweicloud.com>
To: axboe@kernel.dk,
	song@kernel.org,
	colyli@kernel.org,
	yukuai3@huawei.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	dlemoal@kernel.org,
	yanjun.zhu@linux.dev,
	kch@nvidia.com,
	hare@suse.de,
	zhengqixing@huawei.com,
	john.g.garry@oracle.com,
	geliang@kernel.org,
	xni@redhat.com,
	colyli@suse.de
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 07/12] badblocks: try can_merge_front before overlap_front
Date: Fri, 21 Feb 2025 16:11:04 +0800
Message-Id: <20250221081109.734170-8-zhengqixing@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250221081109.734170-1-zhengqixing@huaweicloud.com>
References: <20250221081109.734170-1-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Gl_8NbhnHF3eEQ--.3944S11
X-Coremail-Antispam: 1UD129KBjvJXoW7trWxJFWUtF1UuF1UZw1kKrg_yoW8CF47pw
	nIvr1akrZ7tw13Wr43u3ZFqr1agrW8GFsrKa17Jw1FkryIvas3KF10q3WxKrWjqFZxAr1q
	qw15CFy0vFy8trJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI1v3UUUUU
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

From: Li Nan <linan122@huawei.com>

Regardless of whether overlap_front() returns true or false,
can_merge_front() will be executed first. Therefore, move
can_merge_front() in front of can_merge_front() to simplify code.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 block/badblocks.c | 48 ++++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 87267bae6836..bb46bab7e99f 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -905,39 +905,35 @@ static int _badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 		goto update_sectors;
 	}
 
+	if (can_merge_front(bb, prev, &bad)) {
+		len = front_merge(bb, prev, &bad);
+		added++;
+		hint = prev;
+		goto update_sectors;
+	}
+
 	if (overlap_front(bb, prev, &bad)) {
-		if (can_merge_front(bb, prev, &bad)) {
-			len = front_merge(bb, prev, &bad);
-			added++;
-		} else {
-			int extra = 0;
+		int extra = 0;
 
-			if (!can_front_overwrite(bb, prev, &bad, &extra)) {
-				if (extra > 0)
-					goto out;
+		if (!can_front_overwrite(bb, prev, &bad, &extra)) {
+			if (extra > 0)
+				goto out;
 
-				len = min_t(sector_t,
-					    BB_END(p[prev]) - s, sectors);
-				hint = prev;
-				goto update_sectors;
-			}
+			len = min_t(sector_t,
+				    BB_END(p[prev]) - s, sectors);
+			hint = prev;
+			goto update_sectors;
+		}
 
-			len = front_overwrite(bb, prev, &bad, extra);
-			added++;
-			bb->count += extra;
+		len = front_overwrite(bb, prev, &bad, extra);
+		added++;
+		bb->count += extra;
 
-			if (can_combine_front(bb, prev, &bad)) {
-				front_combine(bb, prev);
-				bb->count--;
-			}
+		if (can_combine_front(bb, prev, &bad)) {
+			front_combine(bb, prev);
+			bb->count--;
 		}
-		hint = prev;
-		goto update_sectors;
-	}
 
-	if (can_merge_front(bb, prev, &bad)) {
-		len = front_merge(bb, prev, &bad);
-		added++;
 		hint = prev;
 		goto update_sectors;
 	}
-- 
2.39.2


