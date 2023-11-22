Return-Path: <linux-block+bounces-352-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3DC7F3BD4
	for <lists+linux-block@lfdr.de>; Wed, 22 Nov 2023 03:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BBC6B21724
	for <lists+linux-block@lfdr.de>; Wed, 22 Nov 2023 02:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F858BF3;
	Wed, 22 Nov 2023 02:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-block@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED011AC;
	Tue, 21 Nov 2023 18:37:11 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SZlkm3Sz2z4f3lg7;
	Wed, 22 Nov 2023 10:37:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B4CDA1A0484;
	Wed, 22 Nov 2023 10:37:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXWhBSaV1lNClcBg--.32716S4;
	Wed, 22 Nov 2023 10:37:08 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: ming.lei@redhat.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3 0/3] block: warn once for each partition in bio_check_ro()
Date: Wed, 22 Nov 2023 18:31:00 +0800
Message-Id: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXWhBSaV1lNClcBg--.32716S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GFW7WFWDtr4DKw4xury5XFb_yoWfKwb_CF
	yvkayfWr48Xa95CFWIyF15XrW09r4Iyr1UJFyDJrs7Xr17XF1DtrZrJ3y7WFsxWF47Cwn8
	JF18urW8Xr1IgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28lY4IEw2IIxx
	k0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK
	6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRi
	Pl1DUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes in v3:
 - add patch 1 from Ming, swap bd_inode layout with bd_openers and
 bd_size_lock;
 - change bd_flags from u32 to u16 in patch 2, prevent to affect layout of
 other fields;

Changes in v2:
 - don't use test/set_bit() for new field, because unsigned long will
 cause that some field can't be placed in the first cacheline(64 bytes),
 use unsigned int for new field and test/set/clear it like 'bio->bi_flags'.

Ming Lei (1):
  block: move .bd_inode into 1st cacheline of block_device

Yu Kuai (2):
  block: introduce new field bd_flags in block_device
  block: warn once for each partition in bio_check_ro()

 block/bdev.c              | 15 ++++++++-------
 block/blk-core.c          | 21 +++++++++++++++------
 block/genhd.c             | 15 +++++++++++----
 block/ioctl.c             |  6 +++++-
 include/linux/blk_types.h | 31 ++++++++++++++++++++++++-------
 include/linux/blkdev.h    |  5 +++--
 6 files changed, 66 insertions(+), 27 deletions(-)

-- 
2.39.2


