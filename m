Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED95615C6D
	for <lists+linux-block@lfdr.de>; Wed,  2 Nov 2022 07:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiKBGs6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Nov 2022 02:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKBGs5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 02:48:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFC425F6
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 23:48:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 426096732D; Wed,  2 Nov 2022 07:48:54 +0100 (CET)
Date:   Wed, 2 Nov 2022 07:48:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: [PATCH 8/7] block: don't claim devices that are not live in
 bd_link_disk_holder
Message-ID: <20221102064854.GA8950@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For gendisk that are not live or their partitions, the bd_holder_dir
pointer is not valid and the kobject might not have been allocated
yet or freed already.  Check that the disk is live before creating the
linkage and error out otherwise.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/holder.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/holder.c b/block/holder.c
index a8c355b9d0806..a8806bbed2112 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -66,6 +66,11 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
 		return -EINVAL;
 
 	mutex_lock(&disk->open_mutex);
+	/* bd_holder_dir is only valid for live disks */
+	if (!disk_live(bdev->bd_disk)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
 
 	WARN_ON_ONCE(!bdev->bd_holder);
 
-- 
2.30.2

