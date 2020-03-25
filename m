Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87DD7192D48
	for <lists+linux-block@lfdr.de>; Wed, 25 Mar 2020 16:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgCYPsy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 Mar 2020 11:48:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgCYPsx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 11:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TTLXlT8evnV8+ZCJBAKdzLsv3I2osjU4+uK3KcQlS5M=; b=ElJfq5XMGvHnSmkTwJAJq1tyhQ
        zSuslS6OUq/T3yGga8p4+LClDGqVZ5IqM6nKtWN/yiN7w62bS3Tw/6gqE//1qGP2TW8t12emQj8jb
        FtWJFxiBDZMeUgHZd5RbrdEgIvzjhH9RSxgCMEFMzieCk/dB2ZMvz5Z1S0vBM5aLjgDgWdHoqTkLB
        0TlywjCkJ7uu6MGl7+nvnGdcx7wOgTmI77U6TNDG5NVAHb+7M67U+dZ3dxRY0ZK9qaja+p218li2i
        oLGk6dPstsrTLJry+TC7tJ/md1bb9Y2BNmgFhwn3QXES9zO7bND9/mWaOng+QRbURj9V4QHqDPw9p
        w9d9nvZw==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH8Gy-0005Gf-Pj; Wed, 25 Mar 2020 15:48:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] block: unexport disk_get_part
Date:   Wed, 25 Mar 2020 16:48:37 +0100
Message-Id: <20200325154843.1349040-4-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325154843.1349040-1-hch@lst.de>
References: <20200325154843.1349040-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

disk_get_part is not used by any modular code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 5f9df331822a..0ee74b7e01f4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -217,7 +217,6 @@ struct hd_struct *disk_get_part(struct gendisk *disk, int partno)
 
 	return part;
 }
-EXPORT_SYMBOL_GPL(disk_get_part);
 
 /**
  * disk_part_iter_init - initialize partition iterator
-- 
2.25.1

