Return-Path: <linux-block+bounces-1491-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B07081F5AE
	for <lists+linux-block@lfdr.de>; Thu, 28 Dec 2023 08:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1F01C21C71
	for <lists+linux-block@lfdr.de>; Thu, 28 Dec 2023 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DFA5253;
	Thu, 28 Dec 2023 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X5x8LsO7"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05924402;
	Thu, 28 Dec 2023 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VWcP0rXhfX4Tpyx1C2oTgUUfvY4Ov9XACS1uYCYkWFQ=; b=X5x8LsO7IbK30BlWll4bAl3Yu2
	Nnr3tA/pxO8vsdt95yX0T0Q8hK8zlKjtyIne9PfNa/QpFv3DxlYmaw0dfBNLve4dcBqemC24gFNC9
	13KjhR6yKGz38gr4V7JnC3VE0UK5BRuY2ihthkLKu1L9p3OCoU5XPux906ciahlC8CQe6IWePcLzK
	N86XdM/D8Bp+bphasOmls48841EPT5uTfur6iAjw7teAqGFPyM/vJssNVlfQtS/oZKUfKlT+JwNbl
	GLzxCHVQOCxvhIgcIN5zpuDd2/4yBRvkbQ8RyQLyK3IetO4EH/aY1zgjN5/A+KOF+sjJx1I4u9N8m
	toSELIfw==;
Received: from 213-147-167-209.nat.highway.webapn.at ([213.147.167.209] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIlFK-00GMr8-11;
	Thu, 28 Dec 2023 07:56:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-um@lists.infradead.org,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: [PATCH 2/9] bcache: discard_granularity should not be smaller than a sector
Date: Thu, 28 Dec 2023 07:55:38 +0000
Message-Id: <20231228075545.362768-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231228075545.362768-1-hch@lst.de>
References: <20231228075545.362768-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Just like all block I/O, discards are in units of sectors.  Thus setting a
smaller than sector size discard limit in case of > 512 byte sectors in
bcache doesn't make sense.  Always set the discard granularity to 512
bytes instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index bfe1685dbae574..ecc1447f202a42 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -954,7 +954,7 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
 	q->limits.max_segment_size	= UINT_MAX;
 	q->limits.max_segments		= BIO_MAX_VECS;
 	blk_queue_max_discard_sectors(q, UINT_MAX);
-	q->limits.discard_granularity	= 512;
+	q->limits.discard_granularity	= block_size;
 	q->limits.io_min		= block_size;
 	q->limits.logical_block_size	= block_size;
 	q->limits.physical_block_size	= block_size;
-- 
2.39.2


