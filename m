Return-Path: <linux-block+bounces-503-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E15497FBA2C
	for <lists+linux-block@lfdr.de>; Tue, 28 Nov 2023 13:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A82E2824B3
	for <lists+linux-block@lfdr.de>; Tue, 28 Nov 2023 12:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9C05646A;
	Tue, 28 Nov 2023 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-block@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1A4D56;
	Tue, 28 Nov 2023 04:31:15 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SfhdT2rlNz4f3jHc;
	Tue, 28 Nov 2023 20:31:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4B8191A08B8;
	Tue, 28 Nov 2023 20:31:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgA3iA6J3WVlx1KyCA--.18580S4;
	Tue, 28 Nov 2023 20:31:07 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@lst.de,
	ming.lei@redhat.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v4 0/2] block: warn once for each partition in bio_check_ro()
Date: Tue, 28 Nov 2023 20:30:25 +0800
Message-Id: <20231128123027.971610-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3iA6J3WVlx1KyCA--.18580S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1kKFWrXF1xuw45AF1xAFb_yoWfCrc_ua
	9Yk3yIgwnxXan5CFWIyF45XrWI9r4xGw4UXFyDtr47XryrXFs0qFZrCry7uws8GFsxC3s3
	AF47u3y8Xr12gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Changes in v4:
 - remove the patch to add 'bd_flags', and add a new field 'bool
 bd_ro_warned' in patch 2. 'bd_flags' will be added once 'bd_inode' is
 removed from other thread.

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

Yu Kuai (1):
  block: warn once for each partition in bio_check_ro()

 block/blk-core.c          | 14 +++++++++++---
 include/linux/blk_types.h |  4 +++-
 2 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.39.2


