Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8212708BA8
	for <lists+linux-block@lfdr.de>; Fri, 19 May 2023 00:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjERWeH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 May 2023 18:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjERWd7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 18:33:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BE110C3
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 15:33:53 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d18d772bdso1473219b3a.3
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 15:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684449233; x=1687041233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53DvRMWPmvqpZEh7bhBmmthp7JIKrTPR0tF/ow6Evi8=;
        b=XrJEv8xVtxY89NI5Ntuf0LOI+b4Nx1Kr8BmMTPSnZecgX7NNjFHZac3KR54OYRBMiH
         kNGM5K36cynsBwZ0sCfC5uwtxRboPfqHwnso9NQTpWDHvQGMFsGd4R88qZvKJjvErFIw
         6UScGIYmSn0LceKda7yWHQ/jMK7A7nF+B10E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684449233; x=1687041233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53DvRMWPmvqpZEh7bhBmmthp7JIKrTPR0tF/ow6Evi8=;
        b=lRaERPUdQ4PAYUO0DwGAporCklpJp71hv5vsNNI5Yq8rai8cQM25pNAGzvpd03CeJn
         PNQXWA8HPmhtaOjiexEe2i+lxfzXJ0b7CPb6kv9YFgPV2dHjS3uu/4q8UfnIJXzMGmUE
         VDWNHY7iM4g3925oETUtcDEi3WEyYcvBNrpRvvj8FXpIKgroaM0bD6H6UEJnNaRW+PQu
         xydubvf3f4ejHYlI9BmVJhGITAzILSKz3+S74XBVqW8gKxeKgbFL8ssUTk1U2ypBrREH
         tp41mPCyJErqiQ9U0xuVPY2CYJmgZEal3VNVXZVD3Wqhf66uQplh33HSvcnbu8No450X
         g0Aw==
X-Gm-Message-State: AC+VfDyDmyOSUOOJ9ICcqzw22SI9JskW+l+xrBqi7P+NiG80WBqARHNb
        7whF12cliUn1Z8TN7lMF8wic2g==
X-Google-Smtp-Source: ACHHUZ65R8Fbu4K326Zp3Eap82ir7Xy3Cqihm8qDqoy/CWU1eLDIaCKa9mLY98fAoT9Yt20Im9TYWg==
X-Received: by 2002:a17:902:e541:b0:1a6:6f3f:bc3 with SMTP id n1-20020a170902e54100b001a66f3f0bc3mr596683plf.57.1684449232977;
        Thu, 18 May 2023 15:33:52 -0700 (PDT)
Received: from sarthakkukreti-glaptop.corp.google.com ([100.107.238.113])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902b10400b001aafb802efbsm1996502plr.12.2023.05.18.15.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 15:33:52 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v7 1/5] block: Don't invalidate pagecache for invalid falloc modes
Date:   Thu, 18 May 2023 15:33:22 -0700
Message-ID: <20230518223326.18744-2-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230518223326.18744-1-sarthakkukreti@chromium.org>
References: <20230518223326.18744-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only call truncate_bdev_range() if the fallocate mode is
supported. This fixes a bug where data in the pagecache
could be invalidated if the fallocate() was called on the
block device with an invalid mode.

Fixes: 25f4c41415e5 ("block: implement (some of) fallocate for block devices")
Cc: stable@vger.kernel.org
Reported-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 block/fops.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index d2e6be4e3d1c..4c70fdc546e7 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -648,24 +648,35 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
 	filemap_invalidate_lock(inode->i_mapping);
 
-	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file->f_mode, start, end);
-	if (error)
-		goto fail;
-
+	/*
+	 * Invalidate the page cache, including dirty pages, for valid
+	 * de-allocate mode calls to fallocate().
+	 */
 	switch (mode) {
 	case FALLOC_FL_ZERO_RANGE:
 	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOUNMAP);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL,
 					     BLKDEV_ZERO_NOFALLBACK);
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+		if (error)
+			goto fail;
+
 		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					     len >> SECTOR_SHIFT, GFP_KERNEL);
 		break;
-- 
2.40.1.698.g37aff9b760-goog

