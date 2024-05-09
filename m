Return-Path: <linux-block+bounces-7175-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B918C0FF0
	for <lists+linux-block@lfdr.de>; Thu,  9 May 2024 14:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DFE1C22327
	for <lists+linux-block@lfdr.de>; Thu,  9 May 2024 12:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8826613B5B6;
	Thu,  9 May 2024 12:48:35 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D63A1FAA;
	Thu,  9 May 2024 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715258915; cv=none; b=SEgZWC+VEXprQWcUivVMuTHg3pvIUPOu7pB+8U48kyXv9zrl9O6ybz9HVAZ2JDyRNSn8gOMbNJTW2UpFGyv967vraN+VmB1bptl2OCWhc4mABxPauVvIqt/6JfPqXTDbuoQDnUs9eNCZuqZFaq+qYjMgGisaSYJnIBIBwlWLcaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715258915; c=relaxed/simple;
	bh=sZSzNB9H37MEPXqIR+iA9PYBkNUyh3pO2Ijg3kkZTKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZP32qWbT0wBKgHxazJgNjpg4vCT0UtE1stiXoENfBT5W+ijV4kvOrV0fiRnL7KwJ8nr2C5iBwiEVTlupNeZw5MORBNODtGkjBhechr5xMerp6EIqAlywb4YrVehqAumiAUIhagFVMJ1Cps0vFrE9w+vqVC9BQbrhTZya6Pvwg7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VZsJ44ngvz4f3n5n;
	Thu,  9 May 2024 20:48:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8E6F21A09E0;
	Thu,  9 May 2024 20:48:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6REdxjxmuxLDMA--.45709S4;
	Thu, 09 May 2024 20:48:30 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RESEND for-6.10/block] block: add plug while submitting IO
Date: Thu,  9 May 2024 20:38:25 +0800
Message-Id: <20240509123825.3225207-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6REdxjxmuxLDMA--.45709S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFW3Cw45WFW8ArWDJw45trb_yoW8Xr4Upr
	4Y93ZxKFWUWrs2vw48XFy7GF1ftF1DWr17Aay5ua9xtr1j9r4qqwnav348Za4rCr48WrW3
	Ar93Kr98Gw4xCrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

So that if caller didn't use plug, for example, __blkdev_direct_IO_simple()
and __blkdev_direct_IO_async(), block layer can still benefit from caching
nsec time in the plug.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9ead80d6c6f0..8566bbd8aeba 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -646,11 +646,13 @@ static void __submit_bio(struct bio *bio)
 static void __submit_bio_noacct(struct bio *bio)
 {
 	struct bio_list bio_list_on_stack[2];
+	struct blk_plug plug;
 
 	BUG_ON(bio->bi_next);
 
 	bio_list_init(&bio_list_on_stack[0]);
 	current->bio_list = bio_list_on_stack;
+	blk_start_plug(&plug);
 
 	do {
 		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
@@ -684,19 +686,23 @@ static void __submit_bio_noacct(struct bio *bio)
 		bio_list_merge(&bio_list_on_stack[0], &bio_list_on_stack[1]);
 	} while ((bio = bio_list_pop(&bio_list_on_stack[0])));
 
+	blk_finish_plug(&plug);
 	current->bio_list = NULL;
 }
 
 static void __submit_bio_noacct_mq(struct bio *bio)
 {
 	struct bio_list bio_list[2] = { };
+	struct blk_plug plug;
 
 	current->bio_list = bio_list;
+	blk_start_plug(&plug);
 
 	do {
 		__submit_bio(bio);
 	} while ((bio = bio_list_pop(&bio_list[0])));
 
+	blk_finish_plug(&plug);
 	current->bio_list = NULL;
 }
 
-- 
2.39.2


