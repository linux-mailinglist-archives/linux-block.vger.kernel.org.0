Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DF47D3AE3
	for <lists+linux-block@lfdr.de>; Mon, 23 Oct 2023 17:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjJWPfe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Oct 2023 11:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjJWPfd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Oct 2023 11:35:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463A4FF
        for <linux-block@vger.kernel.org>; Mon, 23 Oct 2023 08:35:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A0CC433C7;
        Mon, 23 Oct 2023 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698075329;
        bh=fH4SCucmRm0Dpealhrq8QQXyN3HUPdOvQLvE5BNX+GY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nmoWdPdH1GBf7OK6yvOXyb9F6yB6WlV9/NY8YICFqsTOR+LThQIgWFUId/LgdQA/g
         7knnUoh5n44tGOhcUzzvdSmpbWirwO2mOGybJyxSq4MDOy0SYbPeRy4dwjULLjm2O7
         fNgtfXAE/oRQw80h5fIAnS1/4ulZEmyJkGokMtXsX12LTdEofnrpL6GKbPw0adS0No
         kkGzN9aLxLm995DZQ15wbQxfuv6LedIi84+RnEipUQnYoDA+inUZw+LcBe3sdFRSL1
         ZtnJ0UReyKzWHd0WMJzWf7R7+8UP/k6Ns0FYAmL2nxfqaf3sH2ntHHFYUakqmVD5Nh
         of6ypakXy+PYg==
Date:   Mon, 23 Oct 2023 17:35:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: loop change deprecation bdev->bd_holder_lock
Message-ID: <20231023-fungieren-erbschaft-0486c1eab011@brauner>
References: <20231018152924.3858-1-jack@suse.cz>
 <20231019-galopp-zeltdach-b14b7727f269@brauner>
 <ZTExy7YTFtToAOOx@infradead.org>
 <20231020-enthusiasmus-vielsagend-463a7c821bf3@brauner>
 <20231020120436.jgxdlawibpfuprnz@quack3>
 <20231023-ausgraben-berichten-d747aa50d876@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023-ausgraben-berichten-d747aa50d876@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 23, 2023 at 09:40:44AM +0200, Christian Brauner wrote:
> > I agree that it breaks the original usecase for LOOP_CHANGE_FD. I'd say it
> > also shows nobody is likely using LOOP_CHANGE_FD anymore. Maybe time to try
> > deprecating it?
> 
> Yeah, why don't we try that. In it's current form the concept isn't very
> useful and arguably is broken which no one has really noticed for years.
> 
> * codesearch.debian.net has zero users
> * codesearch on github has zero users
> * cs.android.com has zero users
> 
> Only definitions, strace, ltp, and stress-ng that sort of test this
> functionality. I say we try to deprecate this.

I just realized that if we're able to deprecate LOOP_CHANGE_FD we remove
one of the most problematic/weird cases for partitions and filesystems.

So right now, we can attach a filesystem image to a loop device and then
have partitions be claimed by different filesystems:

* create an image with two partitions
* format first partition as xfs, second as ext4

sudo losetup -f --show --read-only -P img1
sudo mount /dev/loop0p1 /mnt1
sudo mount /dev/loop0p2 /mnt2

What happens here is all very wrong afaict. When we issue, e.g., a
change fd event on the first partition:

sudo ./loop_change_fd /dev/loop0p1 img2

we call disk_force_media_change() but that only works on disk->part0
which means that we don't even cleanly shutdown the filesystem on the
partition we're trying to mess around with.

Later on we then completely fall on our faces when we fail to remove the
partitions because they're still in active use.

So I guess, ideally, we'd really force removal of the partitions and
shut down the filesystem but we can't easily do that because of locking
requirements where we can't acquire s_umount beneath open_mutex. Plus,
this wouldn't fit with the original semantics.

There's probably ways around this but I don't think that's actually
worth it for LOOP_CHANGE_FD. The places where forced removal of
partitions really matters is del_gendisk(). And there we've got it
working correctly and are able to actually remove partitions that still
have active users.

For now, we should give up any pretense that disk_force_media_change()
does anything useful for loop change fd and simply remove it completely.
It's either useless, or it breaks the original semantics of loop change
fd although I don't think anyone's ever used it the way I described
above.

So?

From 0d9b5c4963791f0c3ba8529ca56233be87122c59 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Oct 2023 17:24:56 +0200
Subject: [PATCH] loop: drop disk_force_media_change()

The disk_force_media_change() call is currently only useful for
filesystems and in that case it's not very useful. Consider attaching a
filesystem image to a loop device and then have partitions be claimed by
different filesystems:

* create an image with two partitions
* format first partition as xfs, second as ext4

sudo losetup -f --show --read-only -P img1
sudo mount /dev/loop0p1 /mnt1
sudo mount /dev/loop0p2 /mnt2

When we issue e.g., a loop change fd event on the first partition:

sudo ./loop_change_fd /dev/loop0p1 img2

we call disk_force_media_change() but that only works on disk->part0
which means that we don't even cleanly shutdown the filesystem on the
partition we're trying to mess around with.

Later on we then completely fall on our faces when we fail to remove the
partitions because they're still in active use.

Give up any pretense that disk_force_media_change() does anything useful
for loop change fd and simply remove it completely. It's either useless,
or it's meaningless for the original semantics of loop change fd. Anyone
who uses this is on their own anyway.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/block/loop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9f2d412fc560..87c98e35abac 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -603,7 +603,8 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 		goto out_err;
 
 	/* and ... switch */
-	disk_force_media_change(lo->lo_disk);
+	invalidate_bdev(lo->lo_disk->part0);
+	set_bit(GD_NEED_PART_SCAN, &lo->lo_disk->state);
 	blk_mq_freeze_queue(lo->lo_queue);
 	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
 	lo->lo_backing_file = file;
-- 
2.34.1

