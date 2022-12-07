Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C2E6459DB
	for <lists+linux-block@lfdr.de>; Wed,  7 Dec 2022 13:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiLGMeO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 7 Dec 2022 07:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLGMeN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Dec 2022 07:34:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D274EC33
        for <linux-block@vger.kernel.org>; Wed,  7 Dec 2022 04:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670416402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SdIPaZi/4OEvJCdwRDsHN3Selt5P6ocdnjCUOkOaLME=;
        b=HF+YzPUCHcot4UnRsl6Tevysw/xtGiBlGbxlbeij7t19Y2+jxljgJIIP92NdASRzb2nbae
        GA68JXNIIk4ueIWOLMNWbyQakAD5uzlMqxbUREPbOfIdIN8gCNRh9Q3EZa/+xQbDVAfoOk
        Ks9PAtOpbjGFFdbBRUCbceewkN3j2cU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-OChNuCyRPhmmkaF84TTcAw-1; Wed, 07 Dec 2022 07:33:19 -0500
X-MC-Unique: OChNuCyRPhmmkaF84TTcAw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C03CD1C0897B;
        Wed,  7 Dec 2022 12:33:18 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8AB5492B04;
        Wed,  7 Dec 2022 12:33:16 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 1/6] ublk_drv: remove nr_aborted_queues from ublk_device
Date:   Wed,  7 Dec 2022 20:33:00 +0800
Message-Id: <20221207123305.937678-2-ming.lei@redhat.com>
In-Reply-To: <20221207123305.937678-1-ming.lei@redhat.com>
References: <20221207123305.937678-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No one uses 'nr_aborted_queues' any more, so remove it.

Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e9de9d846b73..30db5e5edac4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -159,7 +159,6 @@ struct ublk_device {
 
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
-	atomic_t		nr_aborted_queues;
 
 	/*
 	 * Our ubq->daemon may be killed without any notification, so
-- 
2.31.1

