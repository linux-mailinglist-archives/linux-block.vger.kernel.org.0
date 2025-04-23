Return-Path: <linux-block+bounces-20284-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0545DA97CD3
	for <lists+linux-block@lfdr.de>; Wed, 23 Apr 2025 04:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7B61B60CE7
	for <lists+linux-block@lfdr.de>; Wed, 23 Apr 2025 02:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C872641F9;
	Wed, 23 Apr 2025 02:33:26 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCC725D8E1
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 02:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745375606; cv=none; b=Z4TbbfARb21iFfENLRk8AjceT0vrdHlkYYLw4vpGlDoQnVISduGaW9ipq+QZGSUTpCg8kXwTE/RiPzqMewSScpOBy3TLLvPwuy/kVUrIGACqcLrY4VbWzQtyC7K4kl7WkN9+XNnMKg607hkM8H5GO0QjyNxWwOvo8XQl/Imkq4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745375606; c=relaxed/simple;
	bh=gPPLmmNElcjPeNj4howmRlYLXxGtOS9laQ398yOewxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7CpzqQ1EJRU8J+STDWya1tPEf6GpH+C5qGx1CHYFVnLU1c5T+iZT74A/kfBkhL/xnqN7vGNVnPs3HHtrdVmNgqggrJL9ZfgrfvmC0UMpjpQnX5hzOhjbcDIxS91l3h/CE5jREWz9z2OHFCGRn0UAvTmcj3baDIGqP27eTDvvMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zj36w6jVjz4f3jJ5
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 10:32:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DC6B21A06D7
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 10:33:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgB3219rUQhoCGcsKQ--.37591S7;
	Wed, 23 Apr 2025 10:33:20 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: yangerkun@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huaweicloud.com,
	ming.lei@redhat.com,
	tj@kernel.org
Subject: [PATCH V4 3/7] blk-throttle: Split throtl_charge_bio() into bps and iops functions
Date: Wed, 23 Apr 2025 10:22:57 +0800
Message-ID: <20250423022301.3354136-4-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250423022301.3354136-1-wozizhi@huaweicloud.com>
References: <20250423022301.3354136-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3219rUQhoCGcsKQ--.37591S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXr45KF43tF1Uuw4fJF1UZFb_yoW5Wr4rpa
	yUCwsxGw4kJrsrKrsxXF17GFZ5ta1xAry2krZxG3y5AanF9w1Dtw1DZryrAFWUZFZ3Wwn7
	ZF90qw17G3WUJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU9J5rUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

Split throtl_charge_bio() to facilitate subsequent patches that will
separately charge bps and iops after queue separation.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-throttle.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 00f99c417647..0c12ad9b4aaa 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -736,6 +736,20 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
 	return jiffy_wait;
 }
 
+static void throtl_charge_bps_bio(struct throtl_grp *tg, struct bio *bio)
+{
+	unsigned int bio_size = throtl_bio_data_size(bio);
+
+	/* Charge the bio to the group */
+	if (!bio_flagged(bio, BIO_BPS_THROTTLED))
+		tg->bytes_disp[bio_data_dir(bio)] += bio_size;
+}
+
+static void throtl_charge_iops_bio(struct throtl_grp *tg, struct bio *bio)
+{
+	tg->io_disp[bio_data_dir(bio)]++;
+}
+
 /*
  * If previous slice expired, start a new one otherwise renew/extend existing
  * slice to make sure it is at least throtl_slice interval long since now. New
@@ -808,18 +822,6 @@ static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
 	return max(bps_wait, iops_wait);
 }
 
-static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
-{
-	bool rw = bio_data_dir(bio);
-	unsigned int bio_size = throtl_bio_data_size(bio);
-
-	/* Charge the bio to the group */
-	if (!bio_flagged(bio, BIO_BPS_THROTTLED))
-		tg->bytes_disp[rw] += bio_size;
-
-	tg->io_disp[rw]++;
-}
-
 /**
  * throtl_add_bio_tg - add a bio to the specified throtl_grp
  * @bio: bio to add
@@ -906,7 +908,8 @@ static void tg_dispatch_one_bio(struct throtl_grp *tg, bool rw)
 	bio = throtl_pop_queued(&sq->queued[rw], &tg_to_put);
 	sq->nr_queued[rw]--;
 
-	throtl_charge_bio(tg, bio);
+	throtl_charge_bps_bio(tg, bio);
+	throtl_charge_iops_bio(tg, bio);
 
 	/*
 	 * If our parent is another tg, we just need to transfer @bio to
@@ -1633,7 +1636,8 @@ bool __blk_throtl_bio(struct bio *bio)
 	while (true) {
 		if (tg_within_limit(tg, bio, rw)) {
 			/* within limits, let's charge and dispatch directly */
-			throtl_charge_bio(tg, bio);
+			throtl_charge_bps_bio(tg, bio);
+			throtl_charge_iops_bio(tg, bio);
 
 			/*
 			 * We need to trim slice even when bios are not being
@@ -1656,7 +1660,8 @@ bool __blk_throtl_bio(struct bio *bio)
 			 * control algorithm is adaptive, and extra IO bytes
 			 * will be throttled for paying the debt
 			 */
-			throtl_charge_bio(tg, bio);
+			throtl_charge_bps_bio(tg, bio);
+			throtl_charge_iops_bio(tg, bio);
 		} else {
 			/* if above limits, break to queue */
 			break;
-- 
2.46.1


