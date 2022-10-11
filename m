Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFFC5FB921
	for <lists+linux-block@lfdr.de>; Tue, 11 Oct 2022 19:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiJKRZz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 11 Oct 2022 13:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiJKRZy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Oct 2022 13:25:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CE53205B
        for <linux-block@vger.kernel.org>; Tue, 11 Oct 2022 10:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665509152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5vHkI1D0I1xI6a4Gv+3LouMlybo3cvhcPYtH+nmf3p8=;
        b=ahr5ORC7qfpt/yT0IIDpp4Qpv+hZnxKFb23mwxEVG93+HUHuXOAzCe+yQ06OCeoMWAremR
        bGnigdWuSeMk6uvVOljTQdXC47M+6gwYJuMCjrme/T8UqqE8jMMsmIODePC89t2imiu228
        YqRW6Egq3eiRi8zYSoehaEwLWsfMibc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-IZs9eNupMruY913wgHscjQ-1; Tue, 11 Oct 2022 13:25:46 -0400
X-MC-Unique: IZs9eNupMruY913wgHscjQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EE79185A7A8;
        Tue, 11 Oct 2022 17:25:46 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 700A4477F5F;
        Tue, 11 Oct 2022 17:25:44 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     bvanassche@acm.org, shinichiro.kawasaki@wdc.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests] common/multipath-over-rdma: fix has_soft_rdma checking when mlx card as netdev
Date:   Wed, 12 Oct 2022 01:24:54 +0800
Message-Id: <20221011172454.310389-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The mlx dev will be ignored in has_soft_rdma when it was used as netdev,
add more filter keywords.

link mlx5_0/1 state ACTIVE physical_state LINK_UP netdev enp33s0f0np0
link mlx5_1/1 state DOWN physical_state DISABLED netdev enp33s0f1np1

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 common/multipath-over-rdma | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index fb820d6..6b9629a 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -387,7 +387,7 @@ all_primary_gids() {
 # Check whether or not an rdma_rxe or siw instance has been associated with
 # network interface $1.
 has_soft_rdma() {
-	rdma link | grep -q " netdev $1[[:blank:]]*\$"
+	rdma link | grep -q "link $1.*netdev $1[[:blank:]]*\$"
 }
 
 # Load the rdma_rxe or siw kernel module and associate it with all network
-- 
2.34.1

