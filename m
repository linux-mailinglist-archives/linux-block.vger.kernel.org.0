Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73ED52D573
	for <lists+linux-block@lfdr.de>; Thu, 19 May 2022 16:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiESOCH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 May 2022 10:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbiESOBq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 10:01:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33564387A8;
        Thu, 19 May 2022 07:00:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B6C2321B99;
        Thu, 19 May 2022 14:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652968827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wTqudo5wQlyg1w3+A05CZWILaGIJg7yHzxFqv2JSStU=;
        b=w0ZLWhiuwju9XubSFtRcoXD4yjVT0PCiZWtheVeQ6sChohmbUDMjp2n38K0KG2X1nQZKVD
        zvrFl8hObz+qL8CXBedB816Y89rh+bjtoWkMqbmAjURCZvp7RdE5SbHtu6611E4ibJKrGF
        FcgPCwkYQSKYcftBqhp4/ZIEFanLw/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652968827;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wTqudo5wQlyg1w3+A05CZWILaGIJg7yHzxFqv2JSStU=;
        b=CnOTz4BqfGdcCNEc4CRKGEBskmazrBYgtn7hF32JXyw2Yw71UUalmExWQJvAaDmMJI1ueS
        9peAxosgquldp6AQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id A982A2C141;
        Thu, 19 May 2022 14:00:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 9AD545194577; Thu, 19 May 2022 16:00:27 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] blk-cgroup: provide stubs for blkcg_get_fc_appid()
Date:   Thu, 19 May 2022 16:00:21 +0200
Message-Id: <20220519140021.6905-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Provide stubs for blkcg_set_fc_appid() and  blkcg_get_fc_appid() to allow
for compilation with cgroups disabled.

Fixes: db05628435aa ("blk-cgroup: move blkcg_{get,set}_fc_appid out of line")
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/blk-cgroup.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 9f40dbc65f82..4756f4d2b8e7 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -33,6 +33,9 @@ void blkcg_unpin_online(struct cgroup_subsys_state *blkcg_css);
 struct list_head *blkcg_get_cgwb_list(struct cgroup_subsys_state *css);
 struct cgroup_subsys_state *bio_blkcg_css(struct bio *bio);
 
+int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_len);
+char *blkcg_get_fc_appid(struct bio *bio);
+
 #else	/* CONFIG_BLK_CGROUP */
 
 #define blkcg_root_css	((struct cgroup_subsys_state *)ERR_PTR(-EINVAL))
@@ -44,9 +47,15 @@ static inline struct cgroup_subsys_state *bio_blkcg_css(struct bio *bio)
 {
 	return NULL;
 }
+static inline int blkcg_set_fc_appid(char *app_id, u64 cgrp_id,
+				     size_t app_id_len)
+{
+	return -EINVAL;
+}
+static inline char *blkcg_get_fc_appid(struct bio *bio)
+{
+	return NULL;
+}
 #endif	/* CONFIG_BLK_CGROUP */
 
-int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_len);
-char *blkcg_get_fc_appid(struct bio *bio);
-
 #endif	/* _BLK_CGROUP_H */
-- 
2.29.2

