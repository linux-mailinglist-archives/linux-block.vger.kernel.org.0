Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2B6FC8FA
	for <lists+linux-block@lfdr.de>; Thu, 14 Nov 2019 15:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfKNOe7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 14 Nov 2019 09:34:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38588 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNOe7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 09:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AadK/uVv2luLfObdhk6LVZNYq7Lla1UkNW5Nzg6F338=; b=Mo6adILpA7YQu34J2rI0ixFzQB
        ya61nwQfWAN9nSjW1pm7ZLMuvUekB5gDlrmG2QXn7NnKtC73bB9qTqIHAJSLwzzp6ySDSi21Q33fw
        aGdji4ND0dlgh77sn9w8yZtZMGdUIGIVq6FjCh6z9HxdhDpa5XXYa6MElBzDayenOzwwNElrQkHEf
        ityD6/5A6lo77ocNZzLMS0DCKU5nqS68zurTxfstvAz2+uH5riO/9eyxGulFy8Wq5PdmbLSSjXflO
        QCId22iY1MQOj5do+XYfE1rlsMumnLc+b0sMoyMeEZZYE4d+WLIAkpT9YUsuSpLtbZnK3Tbu86Baq
        C7ZAMTzw==;
Received: from [2001:4bb8:180:3806:c70:4a89:bc61:6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVGD4-0004lc-GL; Thu, 14 Nov 2019 14:34:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 7/7] block: move setting bd_invalidated from flush_disk to check_disk_change
Date:   Thu, 14 Nov 2019 15:34:38 +0100
Message-Id: <20191114143438.14681-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114143438.14681-1-hch@lst.de>
References: <20191114143438.14681-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The only other caller of flush_disk instantly clears the flag, so don't
bother setting it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index ee63c2732fa2..f60739b5a24f 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1403,7 +1403,6 @@ static void flush_disk(struct block_device *bdev, bool kill_dirty)
 		       "resized disk %s\n",
 		       bdev->bd_disk ? bdev->bd_disk->disk_name : "");
 	}
-	bdev->bd_invalidated = 1;
 }
 
 /**
@@ -1491,6 +1490,7 @@ int check_disk_change(struct block_device *bdev)
 		return 0;
 
 	flush_disk(bdev, true);
+	bdev->bd_invalidated = 1;
 	if (bdops->revalidate_disk)
 		bdops->revalidate_disk(bdev->bd_disk);
 	return 1;
-- 
2.20.1

