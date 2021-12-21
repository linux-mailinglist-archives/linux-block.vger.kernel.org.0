Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2885E47BE08
	for <lists+linux-block@lfdr.de>; Tue, 21 Dec 2021 11:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhLUKPV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Dec 2021 05:15:21 -0500
Received: from verein.lst.de ([213.95.11.211]:46349 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232648AbhLUKPV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 05:15:21 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9958668AFE; Tue, 21 Dec 2021 11:15:17 +0100 (CET)
Date:   Tue, 21 Dec 2021 11:15:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: fix error handling for device_add_disk
Message-ID: <20211221101517.GA13416@lst.de>
References: <c614deb3-ce75-635e-a311-4f4fc7aa26e3@i-love.sakura.ne.jp> <20211216161806.GA31879@lst.de> <20211216161928.GB31879@lst.de> <c3e48497-480b-79e8-b483-b50667eb9bbf@i-love.sakura.ne.jp> <20211221100811.GA10674@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221100811.GA10674@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 21, 2021 at 11:08:11AM +0100, Christoph Hellwig wrote:
> On Fri, Dec 17, 2021 at 07:37:43PM +0900, Tetsuo Handa wrote:
> > Well, I don't think that we can remove this blk_free_ext_minor() call, for
> > this call is releasing disk->first_minor rather than MINOR(bdev->bd_dev).
> > 
> > Since bdev_add(disk->part0, MKDEV(disk->major, disk->first_minor)) is not
> > called when reaching the out_free_ext_minor label,
> > 
> > 	if (MAJOR(bdev->bd_dev) == BLOCK_EXT_MAJOR)
> > 		blk_free_ext_minor(MINOR(bdev->bd_dev));
> > 
> > in bdev_free_inode() will not be called because MAJOR(bdev->bd_dev) == 0
> > because bdev->bd_dev == 0.
> > 
> > I think we can apply this patch as-is...
> 
> With the patch as-is we'll still leak disk->ev if device_add fails.
> Something like the patch below should solve that by moving the disk->ev
> allocation later and always cleaning it up through disk->release:

Sorry, this still had the extra return.

diff --git a/block/genhd.c b/block/genhd.c
index 3c139a1b6f049..603db5d6f10c0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -442,10 +442,6 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 		disk->first_minor = ret;
 	}
 
-	ret = disk_alloc_events(disk);
-	if (ret)
-		goto out_free_ext_minor;
-
 	/* delay uevents, until we scanned partition table */
 	dev_set_uevent_suppress(ddev, 1);
 
@@ -456,7 +452,12 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 		ddev->devt = MKDEV(disk->major, disk->first_minor);
 	ret = device_add(ddev);
 	if (ret)
-		goto out_disk_release_events;
+		goto out_free_ext_minor;
+
+	ret = disk_alloc_events(disk);
+	if (ret)
+		goto out_device_del;
+
 	if (!sysfs_deprecated) {
 		ret = sysfs_create_link(block_depr, &ddev->kobj,
 					kobject_name(&ddev->kobj));
@@ -538,8 +539,6 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 		sysfs_remove_link(block_depr, dev_name(ddev));
 out_device_del:
 	device_del(ddev);
-out_disk_release_events:
-	disk_release_events(disk);
 out_free_ext_minor:
 	if (disk->major == BLOCK_EXT_MAJOR)
 		blk_free_ext_minor(disk->first_minor);
