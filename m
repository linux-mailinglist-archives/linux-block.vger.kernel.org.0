Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85CFD186A2C
	for <lists+linux-block@lfdr.de>; Mon, 16 Mar 2020 12:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbgCPLhu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 Mar 2020 07:37:50 -0400
Received: from verein.lst.de ([213.95.11.211]:53902 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730783AbgCPLhu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Mar 2020 07:37:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A9E1C68CEC; Mon, 16 Mar 2020 12:37:46 +0100 (CET)
Date:   Mon, 16 Mar 2020 12:37:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     He Zhe <zhe.he@windriver.com>
Cc:     Christoph Hellwig <hch@lst.de>, jack@suse.cz,
        Jens Axboe <axboe@kernel.dk>, viro@zeniv.linux.org.uk,
        bvanassche@acm.org, keith.busch@intel.com, tglx@linutronix.de,
        mwilck@suse.com, yuyufen@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: disk revalidation updates and OOM
Message-ID: <20200316113746.GA15930@lst.de>
References: <93b395e6-5c3f-0157-9572-af0f9094dbd7@windriver.com> <20200310074018.GB26381@lst.de> <75865e17-48f8-a63a-3a29-f995115ffcfc@windriver.com> <20200310162647.GA6361@lst.de> <f48683d9-7854-ba5f-da3a-7ef987a539b8@windriver.com> <20200311155458.GA24376@lst.de> <18bbb6cd-578e-5ead-f2cd-a8a01db17e29@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18bbb6cd-578e-5ead-f2cd-a8a01db17e29@windriver.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 16, 2020 at 07:01:09PM +0800, He Zhe wrote:
> > Do 142fe8f and 979c690d work with the build fix applied? (f0b870d
> > shouldn't be interesting for this case).
> 
> Sorry for slow reply.
> 
> With my build fix applied, the issue is triggered since 142fe8f.
> And I can see the endless loop of invalidate and revalidate...

Thanks.  Can you test the patch below that restores the previous
rather odd behavior of not clearing the capacity to 0 if partition
scanning is not enabled?


diff --git a/fs/block_dev.c b/fs/block_dev.c
index 69bf2fb6f7cd..daac27f4b821 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1520,10 +1520,13 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 	if (ret)
 		return ret;
 
-	if (invalidate)
-		set_capacity(disk, 0);
-	else if (disk->fops->revalidate_disk)
-		disk->fops->revalidate_disk(disk);
+	if (invalidate) {
+		if (disk_part_scan_enabled(disk))
+			set_capacity(disk, 0);
+	} else {
+		if (disk->fops->revalidate_disk)
+			disk->fops->revalidate_disk(disk);
+	}
 
 	check_disk_size_change(disk, bdev, !invalidate);
 
