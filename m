Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA94C614DD6
	for <lists+linux-block@lfdr.de>; Tue,  1 Nov 2022 16:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiKAPIP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Nov 2022 11:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiKAPHx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 11:07:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CFD1E728
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 08:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+0iu+A0Po72NG6PsBiW6InjA/PL4RlYWhhZ8s6hwjKQ=; b=Y4v5OIc0tTDNx87TVR4V5J16uP
        m7Hys8t+VdOYhuqVUnB14wX/4vdYhUhsu1ixbsyb9/MNa13cB4Dh1+gO3pTXyVXoH3EZOksHo8O2F
        0n0kVkoyPxmAfiY9DLqbC5EsN+wJFbSncObpCP1nwdyHndGxoZ8mFF+/xIYMJIm98eJkEU6DNZhlc
        KrxtxD/oztyme6FhCI37+eOmHy9RwnVAVrcpW+IBWsIJZdJiGV9k1dXbx9eKme98OAq5KjKq4wv40
        Z3b1VPErwJH+lRrl9ybeVji6vegOaVIW3IeiPRgadC30GPE0chKzt6j1ZtcifuZRUrZl7rprBFw1N
        +pTKdpPQ==;
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opslL-005gj1-0g; Tue, 01 Nov 2022 15:01:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 05/14] nvme: remove the NVME_NS_DEAD check in nvme_validate_ns
Date:   Tue,  1 Nov 2022 16:00:41 +0100
Message-Id: <20221101150050.3510-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101150050.3510-1-hch@lst.de>
References: <20221101150050.3510-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

At the point where namespaces are marked dead, the controller is in a
non-live state and we won't get pass the identify commands.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 390f2a2db3238..871a8ab7ec199 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4333,10 +4333,6 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
 	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
 
-	if (test_bit(NVME_NS_DEAD, &ns->flags))
-		goto out;
-
-	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
 	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
 		dev_err(ns->ctrl->device,
 			"identifiers changed for nsid %d\n", ns->head->ns_id);
-- 
2.30.2

