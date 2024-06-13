Return-Path: <linux-block+bounces-8751-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD5F906160
	for <lists+linux-block@lfdr.de>; Thu, 13 Jun 2024 03:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557BF1C2106B
	for <lists+linux-block@lfdr.de>; Thu, 13 Jun 2024 01:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D863E12C7E3;
	Thu, 13 Jun 2024 01:50:21 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610462942A;
	Thu, 13 Jun 2024 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243421; cv=none; b=BvWOduqaGKwu3Glv5ZAQ5bSdlypRDLXWTUCEL1XFAlQV2wdespRS09QMNuunp4r/N/aeNx7zDVqA3aLq8oiTlW58P2lisb2da7wLvvqmnFpkzmkakiF8lbQ5cWk+pwkajjNu30Icu4sgMFd3UR1sukiAhhC3a4zNMRU8iQhuJPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243421; c=relaxed/simple;
	bh=tZUIxhOq1oKPyDJOnOD+wPtc0ZFLCgzV17pH25xpNdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DIX5OMzLwkzXgXrkWiUF/KXssmSZNUuA6gA3MkJA3LERze0Wv0UNCJf4sF5WfIoTHT6TR4uxoGRCyRlGnndOoXPF3P2tG7mTAyWYuEtCzFkQnFvp+s+FvNIQGLzrvfkjXVrB0LTs/JqW1PNa1LDEgTQQqcBS73+pDCXs3vNhpuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W052H47vdz4f3jXl;
	Thu, 13 Jun 2024 09:49:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9D35C1A0572;
	Thu, 13 Jun 2024 09:50:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFNUGpm3eFSPQ--.6570S8;
	Thu, 13 Jun 2024 09:50:09 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	josef@toxicpanda.com,
	gregkh@linuxfoundation.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC -next 4/7] blk-iocost: factor out helpers to handle params from ioc_qos_write()
Date: Thu, 13 Jun 2024 09:49:34 +0800
Message-Id: <20240613014937.1326020-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613014937.1326020-1-yukuai1@huaweicloud.com>
References: <20240613014937.1326020-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBFNUGpm3eFSPQ--.6570S8
X-Coremail-Antispam: 1UD129KBjvJXoW3JrW5tr4DJw1kKF4kCF1kAFb_yoWxGryxpF
	Wru3sxt3y8Xrs29r1Iqr4xA3WYk397Wrn7JFWfGrySqr12yrnYq3W8CFy8uFWrJrZ3Gr1U
	JFWrtF4UGrWxCrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
	UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

Currently the procedures are:

1) parse input disk and open the disk;
2) get ioc, if this is the first writer, init iocost;
3) init qos params, by copying from ioc;
4) parse input qos params;
5) update qos params to ioc;

This patch just factor out step 3-5 into separate helpers, there are no
functional changes, and prepare for fulture optimizations:

- move step 3-4 before setp 2, and don't init iocost for invalid input
  qos params;
- add a new input, and support to free iocost after step 4;
- support to build iocost as kernel module;

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-iocost.c | 155 ++++++++++++++++++++++++++-------------------
 1 file changed, 91 insertions(+), 64 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 690ca99dfaca..253143005086 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3206,45 +3206,24 @@ static const match_table_t qos_tokens = {
 	{ NR_QOS_PARAMS,	NULL		},
 };
 
-static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
-			     size_t nbytes, loff_t off)
-{
-	struct blkg_conf_ctx ctx;
-	struct gendisk *disk;
-	struct ioc *ioc;
+struct ioc_qos_params {
 	u32 qos[NR_QOS_PARAMS];
-	bool enable, user;
-	char *body, *p;
-	int ret;
-
-	blkg_conf_init(&ctx, input);
-
-	ret = blkg_conf_open_bdev(&ctx);
-	if (ret)
-		goto err;
-
-	body = ctx.body;
-	disk = ctx.bdev->bd_disk;
-	if (!queue_is_mq(disk->queue)) {
-		ret = -EOPNOTSUPP;
-		goto err;
-	}
-
-	ioc = q_to_ioc(disk->queue);
-	if (!ioc) {
-		ret = blk_iocost_init(disk);
-		if (ret)
-			goto err;
-		ioc = q_to_ioc(disk->queue);
-	}
+	bool enable;
+	bool user;
+};
 
-	blk_mq_freeze_queue(disk->queue);
-	blk_mq_quiesce_queue(disk->queue);
+static void ioc_qos_params_init(struct ioc *ioc, struct ioc_qos_params *params)
+{
+	memcpy(params->qos, ioc->params.qos, sizeof(params->qos));
+	params->enable = ioc->enabled;
+	params->user = ioc->user_qos_params;
+}
 
-	spin_lock_irq(&ioc->lock);
-	memcpy(qos, ioc->params.qos, sizeof(qos));
-	enable = ioc->enabled;
-	user = ioc->user_qos_params;
+static int ioc_qos_params_parse(struct blkg_conf_ctx *ctx,
+				struct ioc_qos_params *params)
+{
+	char *body = ctx->body;
+	char *p;
 
 	while ((p = strsep(&body, " \t\n"))) {
 		substring_t args[MAX_OPT_ARGS];
@@ -3258,17 +3237,17 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 		switch (match_token(p, qos_ctrl_tokens, args)) {
 		case QOS_ENABLE:
 			if (match_u64(&args[0], &v))
-				goto einval;
-			enable = v;
+				return -EINVAL;
+			params->enable = v;
 			continue;
 		case QOS_CTRL:
 			match_strlcpy(buf, &args[0], sizeof(buf));
 			if (!strcmp(buf, "auto"))
-				user = false;
+				params->user = false;
 			else if (!strcmp(buf, "user"))
-				user = true;
+				params->user = true;
 			else
-				goto einval;
+				return -EINVAL;
 			continue;
 		}
 
@@ -3278,61 +3257,110 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 		case QOS_WPPM:
 			if (match_strlcpy(buf, &args[0], sizeof(buf)) >=
 			    sizeof(buf))
-				goto einval;
+				return -EINVAL;
 			if (cgroup_parse_float(buf, 2, &v))
-				goto einval;
+				return -EINVAL;
 			if (v < 0 || v > 10000)
-				goto einval;
-			qos[tok] = v * 100;
+				return -EINVAL;
+			params->qos[tok] = v * 100;
 			break;
 		case QOS_RLAT:
 		case QOS_WLAT:
 			if (match_u64(&args[0], &v))
-				goto einval;
-			qos[tok] = v;
+				return -EINVAL;
+			params->qos[tok] = v;
 			break;
 		case QOS_MIN:
 		case QOS_MAX:
 			if (match_strlcpy(buf, &args[0], sizeof(buf)) >=
 			    sizeof(buf))
-				goto einval;
+				return -EINVAL;
 			if (cgroup_parse_float(buf, 2, &v))
-				goto einval;
+				return -EINVAL;
 			if (v < 0)
-				goto einval;
-			qos[tok] = clamp_t(s64, v * 100,
-					   VRATE_MIN_PPM, VRATE_MAX_PPM);
+				return -EINVAL;
+			params->qos[tok] = clamp_t(s64, v * 100,
+						   VRATE_MIN_PPM,
+						   VRATE_MAX_PPM);
 			break;
 		default:
-			goto einval;
+			return -EINVAL;
 		}
-		user = true;
+		params->user = true;
 	}
 
-	if (qos[QOS_MIN] > qos[QOS_MAX])
-		goto einval;
+	if (params->qos[QOS_MIN] > params->qos[QOS_MAX])
+		return -EINVAL;
+
+	return 0;
+}
 
-	if (enable && !ioc->enabled) {
+static void ioc_qos_params_update(struct gendisk *disk, struct ioc *ioc,
+				  struct ioc_qos_params *params)
+{
+	if (params->enable && !ioc->enabled) {
 		blk_stat_enable_accounting(disk->queue);
 		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
 		ioc->enabled = true;
-	} else if (!enable && ioc->enabled) {
+	} else if (!params->enable && ioc->enabled) {
 		blk_stat_disable_accounting(disk->queue);
 		blk_queue_flag_clear(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
 		ioc->enabled = false;
 	}
 
-	if (user) {
-		memcpy(ioc->params.qos, qos, sizeof(qos));
+	if (params->user) {
+		memcpy(ioc->params.qos, params->qos, sizeof(params->qos));
 		ioc->user_qos_params = true;
 	} else {
 		ioc->user_qos_params = false;
 	}
 
 	ioc_refresh_params(ioc, true);
+}
+
+static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
+			     size_t nbytes, loff_t off)
+{
+	struct ioc_qos_params params;
+	struct blkg_conf_ctx ctx;
+	struct gendisk *disk;
+	struct ioc *ioc;
+	int ret;
+
+	blkg_conf_init(&ctx, input);
+
+	ret = blkg_conf_open_bdev(&ctx);
+	if (ret)
+		goto err;
+
+	disk = ctx.bdev->bd_disk;
+	if (!queue_is_mq(disk->queue)) {
+		ret = -EOPNOTSUPP;
+		goto err;
+	}
+
+	ioc = q_to_ioc(disk->queue);
+	if (!ioc) {
+		ret = blk_iocost_init(disk);
+		if (ret)
+			goto err;
+		ioc = q_to_ioc(disk->queue);
+	}
+
+	blk_mq_freeze_queue(disk->queue);
+	blk_mq_quiesce_queue(disk->queue);
+
+	spin_lock_irq(&ioc->lock);
+	ioc_qos_params_init(ioc, &params);
+
+	ret = ioc_qos_params_parse(&ctx, &params);
+	if (ret)
+		goto err_parse;
+
+	ioc_qos_params_update(disk, ioc, &params);
 	spin_unlock_irq(&ioc->lock);
 
-	if (enable)
+	if (params.enable)
 		wbt_disable_default(disk);
 	else
 		wbt_enable_default(disk);
@@ -3342,13 +3370,12 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 
 	blkg_conf_exit(&ctx);
 	return nbytes;
-einval:
+
+err_parse:
 	spin_unlock_irq(&ioc->lock);
 
 	blk_mq_unquiesce_queue(disk->queue);
 	blk_mq_unfreeze_queue(disk->queue);
-
-	ret = -EINVAL;
 err:
 	blkg_conf_exit(&ctx);
 	return ret;
-- 
2.39.2


