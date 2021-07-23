Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511D23D4072
	for <lists+linux-block@lfdr.de>; Fri, 23 Jul 2021 20:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbhGWSQL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 23 Jul 2021 14:16:11 -0400
Received: from smtp107.ord1d.emailsrvr.com ([184.106.54.107]:34135 "EHLO
        smtp107.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229878AbhGWSQL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jul 2021 14:16:11 -0400
X-Greylist: delayed 526 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jul 2021 14:16:11 EDT
X-Auth-ID: markh@compro.net
Received: by smtp6.relay.ord1d.emailsrvr.com (Authenticated sender: markh-AT-compro.net) with ESMTPSA id 579C6E027F;
        Fri, 23 Jul 2021 14:47:56 -0400 (EDT)
From:   Mark Hounschell <markh@compro.net>
Subject: [BUG] FLOPPY DRIVER since 5.10.20
Reply-To: markh@compro.net
To:     linux-block@vger.kernel.org,
        Linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Denis Efremov <efremov@linux.com>, Jiri Kosina <jkosina@suse.cz>,
        Mark Hounschell <dmarkh@cfl.rr.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Organization: Compro Computer Svcs.
Message-ID: <de10cb47-34d1-5a88-7751-225ca380f735@compro.net>
Date:   Fri, 23 Jul 2021 14:47:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Classification-ID: c9e847c2-38a7-4e9c-914b-8fd45db953aa-1-1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


These 2 incremental patches, patch-5.10.19-20 and patch-5.11.2-3 have 
broken the user land fd = open("/dev/fd0", (O_RDWR | O_NDELAY)); 
functionality.

Since FOREVER before the patch, when using O_NDELAY, one could open the 
floppy device with no media inserted or even with write protected media 
without error. "Read-only file system" status is returned only when we 
actually tried to write to it. We have software still in use today that 
relies on this functionality.

After the patch, if no media is in the drive the open fails with "no 
such device or address". If the floppy media is write protected the open 
fails with "Read-only file system".

This is certainly drastically changing user land usage incorrectly IMHO.

I think the commit is commit 8a0c014cd20516ade9654fc13b51345ec58e7be8
It is the only reference to the floppy driver in ChangeLog-5.10.20. 
However this change log entry actually sounds like it fixes the very 
issue I am reporting.

Here is the patch from the 5.10.19-20 change.

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 7df79ae6b0a1e..295da442329f3 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4120,23 +4120,23 @@ static int floppy_open(struct block_device 
*bdev, fmode_t mode)
         if (fdc_state[FDC(drive)].rawcmd == 1)
                 fdc_state[FDC(drive)].rawcmd = 2;

-       if (!(mode & FMODE_NDELAY)) {
-               if (mode & (FMODE_READ|FMODE_WRITE)) {
-                       drive_state[drive].last_checked = 0;
-                       clear_bit(FD_OPEN_SHOULD_FAIL_BIT,
-                                 &drive_state[drive].flags);
-                       if (bdev_check_media_change(bdev))
-                               floppy_revalidate(bdev->bd_disk);
-                       if (test_bit(FD_DISK_CHANGED_BIT, 
&drive_state[drive].flags))
-                               goto out;
-                       if (test_bit(FD_OPEN_SHOULD_FAIL_BIT, 
&drive_state[drive].flags))
-                               goto out;
-               }
-               res = -EROFS;
-               if ((mode & FMODE_WRITE) &&
-                   !test_bit(FD_DISK_WRITABLE_BIT, 
&drive_state[drive].flags))
+       if (mode & (FMODE_READ|FMODE_WRITE)) {
+               drive_state[drive].last_checked = 0;
+               clear_bit(FD_OPEN_SHOULD_FAIL_BIT, 
&drive_state[drive].flags);
+               if (bdev_check_media_change(bdev))
+                       floppy_revalidate(bdev->bd_disk);
+               if (test_bit(FD_DISK_CHANGED_BIT, 
&drive_state[drive].flags))
+                       goto out;
+               if (test_bit(FD_OPEN_SHOULD_FAIL_BIT, 
&drive_state[drive].flags))
                         goto out;
         }
+
+       res = -EROFS;
+
+       if ((mode & FMODE_WRITE) &&
+                       !test_bit(FD_DISK_WRITABLE_BIT, 
&drive_state[drive].flags))
+               goto out;
+
         mutex_unlock(&open_lock);
         mutex_unlock(&floppy_mutex);
         return 0;

Regards
Mark
