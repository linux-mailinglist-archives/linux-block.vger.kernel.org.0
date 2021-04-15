Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255F53608EA
	for <lists+linux-block@lfdr.de>; Thu, 15 Apr 2021 14:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhDOMJ4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 15 Apr 2021 08:09:56 -0400
Received: from verein.lst.de ([213.95.11.211]:34501 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232678AbhDOMJ4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 08:09:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E715568BFE; Thu, 15 Apr 2021 14:09:30 +0200 (CEST)
Date:   Thu, 15 Apr 2021 14:09:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Karel Zak <kzak@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: no EBUSY on BLKRRPART, regression?
Message-ID: <20210415120930.GA32146@lst.de>
References: <20210415113114.zquxo2up5vltht6u@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415113114.zquxo2up5vltht6u@ws.net.home>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks like the switch to go through blkdev_get_by_dev means we
now ignore the return value from bdev_disk_changed.

Something like the untested patch below should fix it:

diff --git a/block/ioctl.c b/block/ioctl.c
index ff241e663c018f..8ba1ed8defd0bb 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -89,6 +89,8 @@ static int blkdev_reread_part(struct block_device *bdev, fmode_t mode)
 		return -EINVAL;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
+	if (bdev->bd_part_count)
+		return -EBUSY;
 
 	/*
 	 * Reopen the device to revalidate the driver state and force a
