Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72B3634D8E
	for <lists+linux-block@lfdr.de>; Wed, 23 Nov 2022 03:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiKWCFn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Nov 2022 21:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiKWCFm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 21:05:42 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150B08DA61
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 18:05:41 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NH4Fx0jl5z15Mlf;
        Wed, 23 Nov 2022 10:05:09 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 10:05:39 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 23 Nov
 2022 10:05:38 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <liwei391@huawei.com>, <linux-block@vger.kernel.org>,
        <drbd-dev@lists.linbit.com>, <axboe@kernel.dk>,
        <lars.ellenberg@linbit.com>, <christoph.boehmwalder@linbit.com>,
        <bobo.shaobowang@huawei.com>
Subject: [PATCH v3 2/2] drbd: destroy workqueue when drbd device was freed
Date:   Wed, 23 Nov 2022 10:03:55 +0800
Message-ID: <20221123020355.2470160-3-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123020355.2470160-1-bobo.shaobowang@huawei.com>
References: <20221123020355.2470160-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A submitter workqueue is dynamically allocated by init_submitter()
called by drbd_create_device(), we should destroy it when this
device is not needed or destroyed.

Fixes: 113fef9e20e0 ("drbd: prepare to queue write requests on a submit worker")
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---

v3:
  - add out_* label for destroy_workqueue().

 drivers/block/drbd/drbd_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 78cae4e75af1..677240232684 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2217,6 +2217,8 @@ void drbd_destroy_device(struct kref *kref)
 		kref_put(&peer_device->connection->kref, drbd_destroy_connection);
 		kfree(peer_device);
 	}
+	if (device->submit.wq)
+		destroy_workqueue(device->submit.wq);
 	kfree(device);
 	kref_put(&resource->kref, drbd_destroy_resource);
 }
@@ -2771,7 +2773,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 
 	err = add_disk(disk);
 	if (err)
-		goto out_idr_remove_from_resource;
+		goto out_destroy_workqueue;
 
 	/* inherit the connection state */
 	device->state.conn = first_connection(resource)->cstate;
@@ -2785,6 +2787,8 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	drbd_debugfs_device_add(device);
 	return NO_ERROR;
 
+out_destroy_workqueue:
+	destroy_workqueue(device->submit.wq);
 out_idr_remove_from_resource:
 	for_each_connection_safe(connection, n, resource) {
 		peer_device = idr_remove(&connection->peer_devices, vnr);
-- 
2.25.1

