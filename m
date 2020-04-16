Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B49A1AB988
	for <lists+linux-block@lfdr.de>; Thu, 16 Apr 2020 09:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438794AbgDPHQQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Apr 2020 03:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438101AbgDPHPi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 03:15:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1D9C0610D5;
        Thu, 16 Apr 2020 00:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=b7FtVufzfrDqdrI7Jtm65uDbDTAbyPNK71CKczufNq4=; b=VzBHyF2i45emK+0pREh3JHgnux
        92tmEhshbeZ3WWV6JXXTAXpZ96YCgM3wTaQNWcOwpOYloHGfhuMZFUNOYWJW0iceUP47oI7f+YsTa
        2W5m1eX4zf7tXpCo4tNoxsTAbJn5R3Ni3PEF3WtkmxY2Re+6F31ldzmvyFSCOIx6NmbfAbd3t8x1n
        V/QkrkQWcGIRgZ91DovFPzeYh61xpleJZyopSTm0XMlH7haCXCEmR1JsWMILPkA88VvxoF5/ff9XM
        C9GADxCYpLZsVN41pD69JvnkzFjdaBFT10A/dI9KfIFtH71qaNrJtUl74ovQvfch6sEoszJHqn1L0
        0vjjcSdA==;
Received: from [2001:4bb8:184:4aa1:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOykE-0003IA-Fn; Thu, 16 Apr 2020 07:15:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] bdi: add a ->dev_name field to struct backing_dev_info
Date:   Thu, 16 Apr 2020 09:15:14 +0200
Message-Id: <20200416071519.807660-4-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416071519.807660-1-hch@lst.de>
References: <20200416071519.807660-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Cache a copy of the name for the life time of the backing_dev_info
structure so that we can reference it even after unregistering.

Fixes: 68f23b89067f ("memcg: fix a crash in wb_workfn when a device disappears")
Reported-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/backing-dev-defs.h |  1 +
 mm/backing-dev.c                 | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 4fc87dee005a..249590bcccf7 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -220,6 +220,7 @@ struct backing_dev_info {
 	wait_queue_head_t wb_waitq;
 
 	struct device *dev;
+	const char *dev_name;
 	struct device *owner;
 
 	struct timer_list laptop_mode_wb_timer;
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index c2c44c89ee5d..4f6c05df72f9 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -938,9 +938,15 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 	if (bdi->dev)	/* The driver needs to use separate queues per device */
 		return 0;
 
-	dev = device_create_vargs(bdi_class, NULL, MKDEV(0, 0), bdi, fmt, args);
-	if (IS_ERR(dev))
+	bdi->dev_name = kvasprintf(GFP_KERNEL, fmt, args);
+	if (!bdi->dev_name)
+		return -ENOMEM;
+
+	dev = device_create(bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
+	if (IS_ERR(dev)) {
+		kfree(bdi->dev_name);
 		return PTR_ERR(dev);
+	}
 
 	cgwb_bdi_register(bdi);
 	bdi->dev = dev;
@@ -1034,6 +1040,7 @@ static void release_bdi(struct kref *ref)
 	WARN_ON_ONCE(bdi->dev);
 	wb_exit(&bdi->wb);
 	cgwb_bdi_exit(bdi);
+	kfree(bdi->dev_name);
 	kfree(bdi);
 }
 
@@ -1047,7 +1054,7 @@ const char *bdi_dev_name(struct backing_dev_info *bdi)
 {
 	if (!bdi || !bdi->dev)
 		return bdi_unknown_name;
-	return dev_name(bdi->dev);
+	return bdi->dev_name;
 }
 EXPORT_SYMBOL_GPL(bdi_dev_name);
 
-- 
2.25.1

