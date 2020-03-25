Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFE01926B1
	for <lists+linux-block@lfdr.de>; Wed, 25 Mar 2020 12:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgCYLGH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 Mar 2020 07:06:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgCYLGG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 07:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mKRskZXjWa8XbmaAt5uCmOin8W8FxUnY6fEu88X3jYA=; b=eWYY/sTUoHkw9fFgRGxdkRcgAK
        HtyCAB5CbhEYE3ldA6sXz/bRSfhRZf8NZNCKrk2WpVUDo4WjemISdT4ggV8aiI4S+P+SO9pIDGI7z
        LQBCvM2EDfsnLW1QK3KPIwC/1Vhx9Izd8J6FEvgXBjjp82U3aX+KV0i/dX6hgat2krhCGUOufibtS
        i06knJB2f1wkG/mzfHSySDGsUskheBfWNGijPOaWH76a7USr1BJKBGXw9PI33j8L9++8xHJiXPmE3
        XSThBvokAarDYK/B2mELeMGZcXZ7OotC769Po51nInR5B8mDztAT5Oq848rR5hE8pWoO+/bSU1hK/
        QPbmeWvA==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH3rJ-000280-VB; Wed, 25 Mar 2020 11:06:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] block: unexport get_gendisk
Date:   Wed, 25 Mar 2020 12:03:35 +0100
Message-Id: <20200325110338.1029232-6-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325110338.1029232-1-hch@lst.de>
References: <20200325110338.1029232-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

get_gendisk is not used by any modular code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 144cb50e8eb3..214204c028df 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -953,7 +953,6 @@ struct gendisk *get_gendisk(dev_t devt, int *partno)
 	}
 	return disk;
 }
-EXPORT_SYMBOL(get_gendisk);
 
 /**
  * bdget_disk - do bdget() by gendisk and partition number
-- 
2.25.1

