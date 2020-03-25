Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18DC9192D55
	for <lists+linux-block@lfdr.de>; Wed, 25 Mar 2020 16:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgCYPs7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 Mar 2020 11:48:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgCYPs6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 11:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/Y6h21vVyW+YvRAdWeXSVKwOyNomcPVoTG00YiYqKhE=; b=t0I1vVdpCVqi94QUh0VyQnjb6O
        SHWMT6pnqykYS4dIFW2BtMeAjhIT/IazSI2AMV8DXiC6u1E90UU1Z578uT7st9UIard9y+HCvfNJn
        8LoB/Z4Z9a9Gga8TYxD+AxV8H+IbHopJpnV1S/WnP4dH9P2xM0Na9HpNfIOCYGnIoP3W51dMNH6h/
        k9GjTHYG2sKd0aJsebyPyET6oMn8MLhSkdA/aoL6cBuKnbhWJi1CE/Cv6lqvh+6iMJYTViboBp4vb
        joUqw9LQQLJ6X57e+HxXDGka7Jh7WMzmTu9fC4r/zBHkpCrESN00vInpQDMOnMqGQzEBnh+vJBYuj
        u7ueBdYw==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH8H3-0005Hy-JA; Wed, 25 Mar 2020 15:48:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] block: unexport get_gendisk
Date:   Wed, 25 Mar 2020 16:48:39 +0100
Message-Id: <20200325154843.1349040-6-hch@lst.de>
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

get_gendisk is not used by any modular code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 1e4855c8265a..6323cc789efa 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -980,7 +980,6 @@ struct gendisk *get_gendisk(dev_t devt, int *partno)
 	}
 	return disk;
 }
-EXPORT_SYMBOL(get_gendisk);
 
 /**
  * bdget_disk - do bdget() by gendisk and partition number
-- 
2.25.1

