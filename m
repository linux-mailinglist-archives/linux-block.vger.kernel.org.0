Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04E960CF4A
	for <lists+linux-block@lfdr.de>; Tue, 25 Oct 2022 16:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiJYOkr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 Oct 2022 10:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiJYOkf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 10:40:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E52B7E80F
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=k1kg6IVEr0hlMFLZy31AHqcDsQHIna0GFSfhUFMmhEA=; b=3LnR/vgd7buHZbHSrq+RE2kmuL
        sRQOrlsaWil3U+RNxMQwToPoDJvmVgRwl0/MNTHiEIi2qteSxzN/b8psgikhiu/LYsJf6LIgmFo4F
        3s+17mZfCTpfceknWiEfNyd7wEDUeo7SEPEgjuZzojPIdMzlDkDG/ieoxAgLhkvvQtnJO/wFafY5y
        vF4LNuGHyhvHMR8luOR5ojaRDZTvo82xNtG8BQY3VuASRGcxluSUrEH/BYCH9uu17was14P7HJZZ9
        YFZKv7dJS+ZNLXlGI9DuSisNxV3UqXemtKVHbRfGKnD43LoW7zhC9lWtOyUIkdtYyh0Q+X9XLUhjM
        IoJEZi4Q==;
Received: from [12.47.128.130] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onL6M-005pmX-5N; Tue, 25 Oct 2022 14:40:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 05/17] nvme: don't remove namespaces in nvme_passthru_end
Date:   Tue, 25 Oct 2022 07:40:08 -0700
Message-Id: <20221025144020.260458-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025144020.260458-1-hch@lst.de>
References: <20221025144020.260458-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The call to nvme_remove_invalid_namespaces made sense when
nvme_passthru_end revalidated all namespaces and had to remove those that
didn't exist any more.  Since we don't revalidate from nvme_passthru_end
now, this call is entirely spurious.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8eb46ca9f6acf..50b440e1a0ca0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1118,7 +1118,6 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		nvme_unfreeze(ctrl);
 		nvme_mpath_unfreeze(ctrl->subsys);
 		mutex_unlock(&ctrl->subsys->lock);
-		nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
 		mutex_unlock(&ctrl->scan_lock);
 	}
 	if (effects & NVME_CMD_EFFECTS_CCC)
-- 
2.30.2

