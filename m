Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC422F0B5E
	for <lists+linux-block@lfdr.de>; Mon, 11 Jan 2021 04:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbhAKDHu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 10 Jan 2021 22:07:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726176AbhAKDHt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 22:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610334383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E5K5X/RaZpT+CgPadRJDATcqPMVFDQG1b7rxg/tR3lQ=;
        b=WUe2tikYvqSU3RuyOmxC+01JP6cDALBrXvs1n1VbUJHh6OgkbPTyb/PoS9w/xsXNvfbLqD
        cog+NqUkYMGsOlU/Rz2B5Zk/KfWaUb34clXImhKyGBJnDk4NmuAmZXKHrzwC+cCOZqEp3s
        UEWtTCGuqe2ntReTyfdISREtmSiHlbg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-DCnL898NPt-LIyf10y0QYw-1; Sun, 10 Jan 2021 22:06:22 -0500
X-MC-Unique: DCnL898NPt-LIyf10y0QYw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B82E59;
        Mon, 11 Jan 2021 03:06:21 +0000 (UTC)
Received: from localhost (ovpn-12-180.pek2.redhat.com [10.72.12.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE6381349A;
        Mon, 11 Jan 2021 03:06:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 2/6] block: don't pass BIOSET_NEED_BVECS for q->bio_split
Date:   Mon, 11 Jan 2021 11:05:53 +0800
Message-Id: <20210111030557.4154161-3-ming.lei@redhat.com>
In-Reply-To: <20210111030557.4154161-1-ming.lei@redhat.com>
References: <20210111030557.4154161-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

q->bio_split is only used by bio_split() for fast cloning bio, and no
need to allocate bvecs, so remove this flag.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7663a9b94b80..00d415be74e6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -531,7 +531,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 	if (q->id < 0)
 		goto fail_q;
 
-	ret = bioset_init(&q->bio_split, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
+	ret = bioset_init(&q->bio_split, BIO_POOL_SIZE, 0, 0);
 	if (ret)
 		goto fail_id;
 
-- 
2.28.0

