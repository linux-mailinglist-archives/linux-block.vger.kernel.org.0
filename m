Return-Path: <linux-block+bounces-919-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 815DA80C276
	for <lists+linux-block@lfdr.de>; Mon, 11 Dec 2023 08:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B831C209A7
	for <lists+linux-block@lfdr.de>; Mon, 11 Dec 2023 07:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B3C208A2;
	Mon, 11 Dec 2023 07:57:45 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07601CE;
	Sun, 10 Dec 2023 23:57:41 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SpYxs0PPxz4f3jHf;
	Mon, 11 Dec 2023 15:57:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3AFC21A0AF2;
	Mon, 11 Dec 2023 15:57:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgCnqxHwwHZlw69ZDQ--.3210S6;
	Mon, 11 Dec 2023 15:57:38 +0800 (CST)
From: linan666@huaweicloud.com
To: song@kernel.org,
	axboe@kernel.dk
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 2/2] md: don't account sync_io if iostats of the disk is disabled
Date: Mon, 11 Dec 2023 15:56:14 +0800
Message-Id: <20231211075614.1850003-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211075614.1850003-1-linan666@huaweicloud.com>
References: <20231211075614.1850003-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnqxHwwHZlw69ZDQ--.3210S6
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWxKF4kKr1xuF15XryDAwb_yoW8GFWrpF
	W8JFyayryjqw45ua4UZ34Dua4rG3srK39rArW7A393ZFy3JrnxGrWfWayqqryDWFyrWFWa
	va4DJrZ8ua10yr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0J5FUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

If iostats is disabled, disk_stats will not be updated and
part_stat_read_accum() only returns a constant value. In this case,
continuing to count sync_io and to check is_mddev_idle() is no longer
meaningful.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/md.h | 3 ++-
 drivers/md/md.c | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index 1a4f976951c1..d57e765b4ec2 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -589,7 +589,8 @@ static inline void md_sync_acct(struct block_device *bdev, unsigned long nr_sect
 
 static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
 {
-	md_sync_acct(bio->bi_bdev, nr_sectors);
+	if (blk_queue_io_stat(disk—>queue))
+		md_sync_acct(bio->bi_bdev, nr_sectors);
 }
 
 struct md_personality
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 1d71b2a9af03..9a3610bcc75f 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8502,6 +8502,10 @@ static int is_mddev_idle(struct mddev *mddev, int init)
 	rcu_read_lock();
 	rdev_for_each_rcu(rdev, mddev) {
 		struct gendisk *disk = rdev->bdev->bd_disk;
+
+		if (blk_queue_io_stat(disk—>queue))
+			continue;
+
 		curr_events =
 			(long long)part_stat_read_accum(disk->part0, sectors) -
 			      atomic64_read(&disk->sync_io);
-- 
2.39.2


