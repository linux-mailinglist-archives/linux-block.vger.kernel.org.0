Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8281515EAE5
	for <lists+linux-block@lfdr.de>; Fri, 14 Feb 2020 18:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391766AbgBNQLW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 14 Feb 2020 11:11:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391487AbgBNQLV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 11:11:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BB472469D;
        Fri, 14 Feb 2020 16:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696680;
        bh=o2SSratsKeLW5BDF4DIAFp+zHraaHnFQYUKoplhPdFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8RK7YIi0yx2u/QI4L1BAqBrzvpjAlfvVbKdhv4MC4VfAR/0MIe7fKKULHj28kGMH
         JhPIq8MpGUATlftBYtBLFTmwUbZq98Nwds/JpFR75oJXt9GxcyM2HGhHY0iDMPEnmz
         8xdnOpKD07pQNOuUKd/SV5/nFrPTyiHYTO1g6YJw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Bob Liu <bob.liu@oracle.com>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 448/459] brd: check and limit max_part par
Date:   Fri, 14 Feb 2020 11:01:38 -0500
Message-Id: <20200214160149.11681-448-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Zhiqiang Liu <liuzhiqiang26@huawei.com>

[ Upstream commit c8ab422553c81a0eb070329c63725df1cd1425bc ]

In brd_init func, rd_nr num of brd_device are firstly allocated
and add in brd_devices, then brd_devices are traversed to add each
brd_device by calling add_disk func. When allocating brd_device,
the disk->first_minor is set to i * max_part, if rd_nr * max_part
is larger than MINORMASK, two different brd_device may have the same
devt, then only one of them can be successfully added.
when rmmod brd.ko, it will cause oops when calling brd_exit.

Follow those steps:
  # modprobe brd rd_nr=3 rd_size=102400 max_part=1048576
  # rmmod brd
then, the oops will appear.

Oops log:
[  726.613722] Call trace:
[  726.614175]  kernfs_find_ns+0x24/0x130
[  726.614852]  kernfs_find_and_get_ns+0x44/0x68
[  726.615749]  sysfs_remove_group+0x38/0xb0
[  726.616520]  blk_trace_remove_sysfs+0x1c/0x28
[  726.617320]  blk_unregister_queue+0x98/0x100
[  726.618105]  del_gendisk+0x144/0x2b8
[  726.618759]  brd_exit+0x68/0x560 [brd]
[  726.619501]  __arm64_sys_delete_module+0x19c/0x2a0
[  726.620384]  el0_svc_common+0x78/0x130
[  726.621057]  el0_svc_handler+0x38/0x78
[  726.621738]  el0_svc+0x8/0xc
[  726.622259] Code: aa0203f6 aa0103f7 aa1e03e0 d503201f (7940e260)

Here, we add brd_check_and_reset_par func to check and limit max_part par.

--
V5->V6:
 - remove useless code

V4->V5:(suggested by Ming Lei)
 - make sure max_part is not larger than DISK_MAX_PARTS

V3->V4:(suggested by Ming Lei)
 - remove useless change
 - add one limit of max_part

V2->V3: (suggested by Ming Lei)
 - clear .minors when running out of consecutive minor space in brd_alloc
 - remove limit of rd_nr

V1->V2:
 - add more checks in brd_check_par_valid as suggested by Ming Lei.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Reviewed-by: Bob Liu <bob.liu@oracle.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/brd.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index c548a5a6c1a00..79f18cfa7049f 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -470,6 +470,25 @@ static struct kobject *brd_probe(dev_t dev, int *part, void *data)
 	return kobj;
 }
 
+static inline void brd_check_and_reset_par(void)
+{
+	if (unlikely(!max_part))
+		max_part = 1;
+
+	/*
+	 * make sure 'max_part' can be divided exactly by (1U << MINORBITS),
+	 * otherwise, it is possiable to get same dev_t when adding partitions.
+	 */
+	if ((1U << MINORBITS) % max_part != 0)
+		max_part = 1UL << fls(max_part);
+
+	if (max_part > DISK_MAX_PARTS) {
+		pr_info("brd: max_part can't be larger than %d, reset max_part = %d.\n",
+			DISK_MAX_PARTS, DISK_MAX_PARTS);
+		max_part = DISK_MAX_PARTS;
+	}
+}
+
 static int __init brd_init(void)
 {
 	struct brd_device *brd, *next;
@@ -493,8 +512,7 @@ static int __init brd_init(void)
 	if (register_blkdev(RAMDISK_MAJOR, "ramdisk"))
 		return -EIO;
 
-	if (unlikely(!max_part))
-		max_part = 1;
+	brd_check_and_reset_par();
 
 	for (i = 0; i < rd_nr; i++) {
 		brd = brd_alloc(i);
-- 
2.20.1

