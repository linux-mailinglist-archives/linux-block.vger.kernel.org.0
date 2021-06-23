Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED86A3B1D19
	for <lists+linux-block@lfdr.de>; Wed, 23 Jun 2021 17:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhFWPF7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 23 Jun 2021 11:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhFWPF7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 11:05:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA4FC061574
        for <linux-block@vger.kernel.org>; Wed, 23 Jun 2021 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WKxDoeRIkCXSSsjsUYE8A9fYbi97yUT4NAod0S2S7ps=; b=JlbVlNGKXqiXxWuEnlcDab7w9s
        Tan0Ssb5ovTomygAvPz4X96Hbcubkc7hpFXvAbAU2F4TNGyEvjJDUzHEznEe14JOvNxYancriewpc
        1hjfXLJbk9IOlcoosrp3IUY4nqjEAyanq+Y78xhBxisUPOEPBQ0p7z+R2aip5JhoigFdorJRVsOdK
        9ivGwbyGGq3ZFtvzJ67vGEWbm845Y4fn5X0cUUJqFsKC47y4gTQ9sLIk+yI4vFiEM1wrs+SfdbMwN
        kySYdNRjJTsMnMiP5s5Kz9j80ruH1iyu2YU9pRdBGP0N/MLrKUj3Iuftl07AF+2lRCr4dEgrJjWb3
        AD15hsSg==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw4Oz-00FY2b-Fi; Wed, 23 Jun 2021 15:02:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
Subject: [PATCH 7/9] loop: don't allow deleting an unspecified loop device
Date:   Wed, 23 Jun 2021 16:59:06 +0200
Message-Id: <20210623145908.92973-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623145908.92973-1-hch@lst.de>
References: <20210623145908.92973-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Passing a negative index to loop_lookup while return any unbound device.
Doing that for a delete does not make much sense, so add check to
explicitly reject that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 01d393a60b37..58fc29f1b1ae 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2235,6 +2235,11 @@ static int loop_control_remove(int idx)
 {
 	struct loop_device *lo;
 	int ret;
+
+	if (idx < 0) {
+		pr_warn("deleting an unspecified loop device is not supported.\n");
+		return -EINVAL;
+	}
 		
 	ret = mutex_lock_killable(&loop_ctl_mutex);
 	if (ret)
-- 
2.30.2

