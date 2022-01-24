Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502B7497C2F
	for <lists+linux-block@lfdr.de>; Mon, 24 Jan 2022 10:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbiAXJj3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 Jan 2022 04:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbiAXJj1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jan 2022 04:39:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFE4C06173B
        for <linux-block@vger.kernel.org>; Mon, 24 Jan 2022 01:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZawJ1algKPlukHShVM2tAjaoIgYKHRil+Bsx7aw3PfU=; b=zvHjjrj58M/Ox0idEXynI73IJy
        qg0gFKsizqsJDlcx+mkgxExwR+PnTjBMqIrBhESfYkLs+02AsMKy2YL14eTcvaXrFKbJNHJt8ohd3
        Tr1eYj7IcVLiyeHRp/6pWKAtKmhFlxSYOj+KHOZuh8+GL/eDyUNFtHdZvOi+qvfkLzQyJQbf0UpIZ
        YtyjrePQN9HYChThZ8QVi+jW0C6vkzbixaZYTwky/XyvVDkJwlM3C5H0wJX8LMgnoklsH8nLI9T4Q
        AR+jAipeTPa41yhJFjs3vfb7h3HOh9T/UfSMDnmm0Ak3RXJSW8L0X73QEL4lnDNIqB5sEQiJ69+rY
        3hVJPUjg==;
Received: from [2001:4bb8:184:72a4:a337:a75f:a24e:7e39] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBvor-002pY7-W0; Mon, 24 Jan 2022 09:39:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: remove genhd.h
Date:   Mon, 24 Jan 2022 10:39:13 +0100
Message-Id: <20220124093913.742411-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124093913.742411-1-hch@lst.de>
References: <20220124093913.742411-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no good reason to keep genhd.h separate from the main blkdev.h
header that includes it.  So fold the contents of genhd.h into blkdev.h
and remove genhd.h entirely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/block/capability.rst  |   2 +-
 arch/m68k/atari/stdma.c             |   1 -
 arch/m68k/bvme6000/config.c         |   1 -
 arch/m68k/emu/nfblock.c             |   1 -
 arch/m68k/kernel/setup_mm.c         |   1 -
 arch/m68k/mvme147/config.c          |   1 -
 arch/m68k/mvme16x/config.c          |   1 -
 block/blk-cgroup.c                  |   1 -
 block/disk-events.c                 |   2 +-
 block/genhd.c                       |   1 -
 block/holder.c                      |   2 +-
 block/partitions/check.h            |   1 -
 block/partitions/core.c             |   1 -
 block/partitions/efi.h              |   1 -
 block/partitions/ldm.h              |   1 -
 block/sed-opal.c                    |   2 +-
 drivers/base/class.c                |   2 +-
 drivers/base/core.c                 |   2 +-
 drivers/base/devtmpfs.c             |   2 +-
 drivers/block/aoe/aoeblk.c          |   1 -
 drivers/block/aoe/aoecmd.c          |   1 -
 drivers/block/drbd/drbd_int.h       |   1 -
 drivers/block/mtip32xx/mtip32xx.c   |   1 -
 drivers/block/mtip32xx/mtip32xx.h   |   1 -
 drivers/block/rnbd/rnbd-srv-sysfs.c |   1 -
 drivers/block/sunvdc.c              |   1 -
 drivers/block/zram/zram_drv.c       |   1 -
 drivers/cdrom/gdrom.c               |   1 -
 drivers/char/random.c               |   2 +-
 drivers/md/bcache/super.c           |   1 -
 drivers/md/dm-core.h                |   1 -
 drivers/mtd/mtdswap.c               |   2 +-
 drivers/mtd/nand/raw/sharpsl.c      |   1 -
 drivers/nvdimm/blk.c                |   1 -
 drivers/nvdimm/btt.c                |   1 -
 drivers/nvdimm/btt_devs.c           |   1 -
 drivers/nvdimm/bus.c                |   1 -
 drivers/nvdimm/pfn_devs.c           |   1 -
 drivers/s390/block/dasd_int.h       |   1 -
 drivers/s390/block/scm_blk.c        |   1 -
 drivers/s390/block/scm_blk.h        |   1 -
 drivers/scsi/scsi_debug.c           |   1 -
 drivers/scsi/scsicam.c              |   1 -
 drivers/scsi/sd.c                   |   1 -
 drivers/scsi/sr.h                   |   1 -
 drivers/target/target_core_iblock.c |   1 -
 drivers/target/target_core_pscsi.c  |   1 -
 fs/btrfs/check-integrity.c          |   1 -
 fs/dax.c                            |   1 -
 fs/gfs2/sys.c                       |   2 +-
 fs/hfs/mdb.c                        |   2 +-
 fs/hfsplus/wrapper.c                |   1 -
 fs/ksmbd/vfs.c                      |   1 -
 fs/nfs/blocklayout/rpc_pipefs.c     |   1 -
 fs/nfsd/blocklayout.c               |   1 -
 include/linux/blkdev.h              | 273 +++++++++++++++++++++++++-
 include/linux/genhd.h               | 287 ----------------------------
 include/linux/part_stat.h           |   2 +-
 init/do_mounts.c                    |   1 -
 kernel/power/hibernate.c            |   1 -
 kernel/power/swap.c                 |   1 -
 security/integrity/ima/ima_policy.c |   1 -
 62 files changed, 282 insertions(+), 350 deletions(-)
 delete mode 100644 include/linux/genhd.h

diff --git a/Documentation/block/capability.rst b/Documentation/block/capability.rst
index 160a5148b915f..2ae7f064736ad 100644
--- a/Documentation/block/capability.rst
+++ b/Documentation/block/capability.rst
@@ -7,4 +7,4 @@ This file documents the sysfs file ``block/<disk>/capability``.
 ``capability`` is a bitfield, printed in hexadecimal, indicating which
 capabilities a specific block device supports:
 
-.. kernel-doc:: include/linux/genhd.h
+.. kernel-doc:: include/linux/blkdev.h
diff --git a/arch/m68k/atari/stdma.c b/arch/m68k/atari/stdma.c
index ba65f942d0c78..ce6818eff75ef 100644
--- a/arch/m68k/atari/stdma.c
+++ b/arch/m68k/atari/stdma.c
@@ -30,7 +30,6 @@
 
 #include <linux/types.h>
 #include <linux/kdev_t.h>
-#include <linux/genhd.h>
 #include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
diff --git a/arch/m68k/bvme6000/config.c b/arch/m68k/bvme6000/config.c
index 0c6feafbbd110..0fe0f3e888fb3 100644
--- a/arch/m68k/bvme6000/config.c
+++ b/arch/m68k/bvme6000/config.c
@@ -23,7 +23,6 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <linux/major.h>
-#include <linux/genhd.h>
 #include <linux/rtc.h>
 #include <linux/interrupt.h>
 #include <linux/bcd.h>
diff --git a/arch/m68k/emu/nfblock.c b/arch/m68k/emu/nfblock.c
index 9c57b245dc12a..267b02cc5655b 100644
--- a/arch/m68k/emu/nfblock.c
+++ b/arch/m68k/emu/nfblock.c
@@ -13,7 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/types.h>
-#include <linux/genhd.h>
 #include <linux/blkdev.h>
 #include <linux/hdreg.h>
 #include <linux/slab.h>
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index 49e573b943268..ee268055bdce3 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -16,7 +16,6 @@
 #include <linux/interrupt.h>
 #include <linux/fs.h>
 #include <linux/console.h>
-#include <linux/genhd.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/init.h>
diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
index dfd6202fd403e..db1430dc411f4 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -22,7 +22,6 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <linux/major.h>
-#include <linux/genhd.h>
 #include <linux/rtc.h>
 #include <linux/interrupt.h>
 
diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
index b4422c2dfbbf4..45a07ab3123ab 100644
--- a/arch/m68k/mvme16x/config.c
+++ b/arch/m68k/mvme16x/config.c
@@ -24,7 +24,6 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <linux/major.h>
-#include <linux/genhd.h>
 #include <linux/rtc.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 650f7e27989f1..671debbae9413 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -23,7 +23,6 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/slab.h>
-#include <linux/genhd.h>
 #include <linux/delay.h>
 #include <linux/atomic.h>
 #include <linux/ctype.h>
diff --git a/block/disk-events.c b/block/disk-events.c
index 8d5496e7592a5..aee25a7e1ab7d 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -4,7 +4,7 @@
  */
 #include <linux/export.h>
 #include <linux/moduleparam.h>
-#include <linux/genhd.h>
+#include <linux/blkdev.h>
 #include "blk.h"
 
 struct disk_events {
diff --git a/block/genhd.c b/block/genhd.c
index 626c8406f21a6..9b5e8501895fe 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -8,7 +8,6 @@
 #include <linux/module.h>
 #include <linux/ctype.h>
 #include <linux/fs.h>
-#include <linux/genhd.h>
 #include <linux/kdev_t.h>
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
diff --git a/block/holder.c b/block/holder.c
index 27cddce1b4461..8d750281a1cd9 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <linux/genhd.h>
+#include <linux/blkdev.h>
 #include <linux/slab.h>
 
 struct bd_holder_disk {
diff --git a/block/partitions/check.h b/block/partitions/check.h
index d5b28e309d64d..4ffa2359b1a37 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/pagemap.h>
 #include <linux/blkdev.h>
-#include <linux/genhd.h>
 #include "../blk.h"
 
 /*
diff --git a/block/partitions/core.c b/block/partitions/core.c
index c2a1635922b1c..2ef8dfa1e5c85 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -8,7 +8,6 @@
 #include <linux/major.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
-#include <linux/genhd.h>
 #include <linux/vmalloc.h>
 #include <linux/blktrace_api.h>
 #include <linux/raid/detect.h>
diff --git a/block/partitions/efi.h b/block/partitions/efi.h
index 8cc2b88d0aa85..84b9f36b9e479 100644
--- a/block/partitions/efi.h
+++ b/block/partitions/efi.h
@@ -13,7 +13,6 @@
 
 #include <linux/types.h>
 #include <linux/fs.h>
-#include <linux/genhd.h>
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/string.h>
diff --git a/block/partitions/ldm.h b/block/partitions/ldm.h
index 8693704dcf5e9..0a747a0c782d5 100644
--- a/block/partitions/ldm.h
+++ b/block/partitions/ldm.h
@@ -14,7 +14,6 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
-#include <linux/genhd.h>
 #include <linux/fs.h>
 #include <asm/unaligned.h>
 #include <asm/byteorder.h>
diff --git a/block/sed-opal.c b/block/sed-opal.c
index daafadbb88cae..9700197000f20 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -13,7 +13,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
-#include <linux/genhd.h>
+#include <linux/blkdev.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/sed-opal.h>
diff --git a/drivers/base/class.c b/drivers/base/class.c
index 7476f393df977..8feb85e186e3b 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -16,7 +16,7 @@
 #include <linux/kdev_t.h>
 #include <linux/err.h>
 #include <linux/slab.h>
-#include <linux/genhd.h>
+#include <linux/blkdev.h>
 #include <linux/mutex.h>
 #include "base.h"
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7bb957b118611..3d6430eb0c6a1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -21,7 +21,7 @@
 #include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/genhd.h>
+#include <linux/blkdev.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/netdevice.h>
diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index f41063ac1aee4..db5a03a0618ea 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -17,7 +17,7 @@
 #include <linux/syscalls.h>
 #include <linux/mount.h>
 #include <linux/device.h>
-#include <linux/genhd.h>
+#include <linux/blkdev.h>
 #include <linux/namei.h>
 #include <linux/fs.h>
 #include <linux/shmem_fs.h>
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 52484bcdedb92..8a91fcac6f829 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -12,7 +12,6 @@
 #include <linux/ioctl.h>
 #include <linux/slab.h>
 #include <linux/ratelimit.h>
-#include <linux/genhd.h>
 #include <linux/netdevice.h>
 #include <linux/mutex.h>
 #include <linux/export.h>
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 6af111f568e4a..cc11f89a0928f 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -10,7 +10,6 @@
 #include <linux/blk-mq.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
-#include <linux/genhd.h>
 #include <linux/moduleparam.h>
 #include <linux/workqueue.h>
 #include <linux/kthread.h>
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index f27d5b0f9a0bb..acb1ad3c06035 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -27,7 +27,6 @@
 #include <linux/major.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
-#include <linux/genhd.h>
 #include <linux/idr.h>
 #include <linux/dynamic_debug.h>
 #include <net/tcp.h>
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index e6005c2323281..cba956881d55c 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -19,7 +19,6 @@
 #include <linux/compat.h>
 #include <linux/fs.h>
 #include <linux/module.h>
-#include <linux/genhd.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/bio.h>
diff --git a/drivers/block/mtip32xx/mtip32xx.h b/drivers/block/mtip32xx/mtip32xx.h
index 88f4206310e4c..6816beb45352b 100644
--- a/drivers/block/mtip32xx/mtip32xx.h
+++ b/drivers/block/mtip32xx/mtip32xx.h
@@ -15,7 +15,6 @@
 #include <linux/rwsem.h>
 #include <linux/ata.h>
 #include <linux/interrupt.h>
-#include <linux/genhd.h>
 
 /* Offset of Subsystem Device ID in pci confoguration space */
 #define PCI_SUBSYSTEM_DEVICEID	0x2E
diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
index 4db98e0e76f0e..feaa76c5a3423 100644
--- a/drivers/block/rnbd/rnbd-srv-sysfs.c
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -13,7 +13,6 @@
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
 #include <linux/stat.h>
-#include <linux/genhd.h>
 #include <linux/list.h>
 #include <linux/moduleparam.h>
 #include <linux/device.h>
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 146d85d80e0e7..dd0a1a6fed296 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -9,7 +9,6 @@
 #include <linux/types.h>
 #include <linux/blk-mq.h>
 #include <linux/hdreg.h>
-#include <linux/genhd.h>
 #include <linux/cdrom.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cb253d80d72b9..342dbcb3f2208 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -22,7 +22,6 @@
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/device.h>
-#include <linux/genhd.h>
 #include <linux/highmem.h>
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index faead41709bcd..8e78b37d0f6a4 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/cdrom.h>
-#include <linux/genhd.h>
 #include <linux/bio.h>
 #include <linux/blk-mq.h>
 #include <linux/interrupt.h>
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 68613f0b68877..f206c87c62028 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -330,7 +330,7 @@
 #include <linux/poll.h>
 #include <linux/init.h>
 #include <linux/fs.h>
-#include <linux/genhd.h>
+#include <linux/blkdev.h>
 #include <linux/interrupt.h>
 #include <linux/mm.h>
 #include <linux/nodemask.h>
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 140f35dc0c457..c31a62b963f00 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -18,7 +18,6 @@
 #include <linux/blkdev.h>
 #include <linux/pagemap.h>
 #include <linux/debugfs.h>
-#include <linux/genhd.h>
 #include <linux/idr.h>
 #include <linux/kthread.h>
 #include <linux/workqueue.h>
diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index b855fef4f38a6..72d18c3fbf1f6 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -11,7 +11,6 @@
 
 #include <linux/kthread.h>
 #include <linux/ktime.h>
-#include <linux/genhd.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-crypto-profile.h>
 
diff --git a/drivers/mtd/mtdswap.c b/drivers/mtd/mtdswap.c
index e86b04bc1d6bb..dc7f1532a37f7 100644
--- a/drivers/mtd/mtdswap.c
+++ b/drivers/mtd/mtdswap.c
@@ -19,7 +19,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#include <linux/genhd.h>
+#include <linux/blkdev.h>
 #include <linux/swap.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
diff --git a/drivers/mtd/nand/raw/sharpsl.c b/drivers/mtd/nand/raw/sharpsl.c
index 5612ee628425b..52ce5162538a4 100644
--- a/drivers/mtd/nand/raw/sharpsl.c
+++ b/drivers/mtd/nand/raw/sharpsl.c
@@ -6,7 +6,6 @@
  *  Based on Sharp's NAND driver sharp_sl.c
  */
 
-#include <linux/genhd.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/delay.h>
diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index 228c33b8d1d69..c1db43524d755 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -6,7 +6,6 @@
 
 #include <linux/blkdev.h>
 #include <linux/fs.h>
-#include <linux/genhd.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/nd.h>
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index da3f007a12115..cbd994f7f1fe6 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -11,7 +11,6 @@
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/hdreg.h>
-#include <linux/genhd.h>
 #include <linux/sizes.h>
 #include <linux/ndctl.h>
 #include <linux/fs.h>
diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
index 8b52e5144f084..e5a58520d3982 100644
--- a/drivers/nvdimm/btt_devs.c
+++ b/drivers/nvdimm/btt_devs.c
@@ -4,7 +4,6 @@
  */
 #include <linux/blkdev.h>
 #include <linux/device.h>
-#include <linux/genhd.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 9dc7f3edd42b1..5bbe31b08581b 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -11,7 +11,6 @@
 #include <linux/blkdev.h>
 #include <linux/fcntl.h>
 #include <linux/async.h>
-#include <linux/genhd.h>
 #include <linux/ndctl.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 58eda16f5c534..c31e184bfa45e 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -5,7 +5,6 @@
 #include <linux/memremap.h>
 #include <linux/blkdev.h>
 #include <linux/device.h>
-#include <linux/genhd.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 8b458010f88a1..3b7af00a7825f 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -47,7 +47,6 @@
 #include <linux/module.h>
 #include <linux/wait.h>
 #include <linux/blkdev.h>
-#include <linux/genhd.h>
 #include <linux/hdreg.h>
 #include <linux/interrupt.h>
 #include <linux/log2.h>
diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index 61ecdcb2cc6af..2a9c0ddcade59 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -15,7 +15,6 @@
 #include <linux/module.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
-#include <linux/genhd.h>
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <asm/eadm.h>
diff --git a/drivers/s390/block/scm_blk.h b/drivers/s390/block/scm_blk.h
index a05a4297cfae2..af82b32147741 100644
--- a/drivers/s390/block/scm_blk.h
+++ b/drivers/s390/block/scm_blk.h
@@ -6,7 +6,6 @@
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
-#include <linux/genhd.h>
 #include <linux/list.h>
 
 #include <asm/debug.h>
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 2104973a35cd3..911cc72dd7acd 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -23,7 +23,6 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/string.h>
-#include <linux/genhd.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
diff --git a/drivers/scsi/scsicam.c b/drivers/scsi/scsicam.c
index 0ffdb8f2995f7..acdc0aceca5ef 100644
--- a/drivers/scsi/scsicam.c
+++ b/drivers/scsi/scsicam.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
-#include <linux/genhd.h>
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
 #include <linux/pagemap.h>
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 62eb9921cc947..2d648d27bfd71 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -38,7 +38,6 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/bio.h>
-#include <linux/genhd.h>
 #include <linux/hdreg.h>
 #include <linux/errno.h>
 #include <linux/idr.h>
diff --git a/drivers/scsi/sr.h b/drivers/scsi/sr.h
index 339c624e04d86..1609f02ed29ac 100644
--- a/drivers/scsi/sr.h
+++ b/drivers/scsi/sr.h
@@ -18,7 +18,6 @@
 #ifndef _SR_H
 #define _SR_H
 
-#include <linux/genhd.h>
 #include <linux/kref.h>
 #include <linux/mutex.h>
 
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index bf8ae4825a06e..6045678365a59 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -20,7 +20,6 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/bio.h>
-#include <linux/genhd.h>
 #include <linux/file.h>
 #include <linux/module.h>
 #include <linux/scatterlist.h>
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 807d06ecadee2..0fae71ac5cc8a 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -17,7 +17,6 @@
 #include <linux/blk_types.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/genhd.h>
 #include <linux/cdrom.h>
 #include <linux/ratelimit.h>
 #include <linux/module.h>
diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 7e9f90fa0388b..abac86a758401 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -78,7 +78,6 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
-#include <linux/genhd.h>
 #include <linux/blkdev.h>
 #include <linux/mm.h>
 #include <linux/string.h>
diff --git a/fs/dax.c b/fs/dax.c
index cd03485867a74..ab0978739eaaa 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -11,7 +11,6 @@
 #include <linux/buffer_head.h>
 #include <linux/dax.h>
 #include <linux/fs.h>
-#include <linux/genhd.h>
 #include <linux/highmem.h>
 #include <linux/memcontrol.h>
 #include <linux/mm.h>
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index a6002b2d146d8..d87ea98cf5350 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -15,7 +15,7 @@
 #include <linux/kobject.h>
 #include <linux/uaccess.h>
 #include <linux/gfs2_ondisk.h>
-#include <linux/genhd.h>
+#include <linux/blkdev.h>
 
 #include "gfs2.h"
 #include "incore.h"
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 5beb826524354..8082eb01127cd 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -9,7 +9,7 @@
  */
 
 #include <linux/cdrom.h>
-#include <linux/genhd.h>
+#include <linux/blkdev.h>
 #include <linux/nls.h>
 #include <linux/slab.h>
 
diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 51ae6f1eb4a55..4688cc7b36926 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -12,7 +12,6 @@
 #include <linux/fs.h>
 #include <linux/blkdev.h>
 #include <linux/cdrom.h>
-#include <linux/genhd.h>
 #include <asm/unaligned.h>
 
 #include "hfsplus_fs.h"
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 19d36393974ca..9cebb6ba555b6 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -11,7 +11,6 @@
 #include <linux/writeback.h>
 #include <linux/xattr.h>
 #include <linux/falloc.h>
-#include <linux/genhd.h>
 #include <linux/fsnotify.h>
 #include <linux/dcache.h>
 #include <linux/slab.h>
diff --git a/fs/nfs/blocklayout/rpc_pipefs.c b/fs/nfs/blocklayout/rpc_pipefs.c
index ef9db135c649c..6c977288cc288 100644
--- a/fs/nfs/blocklayout/rpc_pipefs.c
+++ b/fs/nfs/blocklayout/rpc_pipefs.c
@@ -27,7 +27,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/genhd.h>
 #include <linux/blkdev.h>
 
 #include "blocklayout.h"
diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index e5c0982a381de..b6d01d51a7465 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -4,7 +4,6 @@
  */
 #include <linux/exportfs.h>
 #include <linux/iomap.h>
-#include <linux/genhd.h>
 #include <linux/slab.h>
 #include <linux/pr.h>
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9c95df26fc26b..f4b662f246747 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1,9 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Portions Copyright (C) 1992 Drew Eckhardt
+ */
 #ifndef _LINUX_BLKDEV_H
 #define _LINUX_BLKDEV_H
 
-#include <linux/sched.h>
-#include <linux/genhd.h>
+#include <linux/types.h>
+#include <linux/blk_types.h>
+#include <linux/device.h>
 #include <linux/list.h>
 #include <linux/llist.h>
 #include <linux/minmax.h>
@@ -12,11 +16,15 @@
 #include <linux/wait.h>
 #include <linux/bio.h>
 #include <linux/gfp.h>
+#include <linux/kdev_t.h>
 #include <linux/rcupdate.h>
 #include <linux/percpu-refcount.h>
 #include <linux/blkzoned.h>
+#include <linux/sched.h>
 #include <linux/sbitmap.h>
 #include <linux/srcu.h>
+#include <linux/uuid.h>
+#include <linux/xarray.h>
 
 struct module;
 struct request_queue;
@@ -33,6 +41,10 @@ struct blk_queue_stats;
 struct blk_stat_callback;
 struct blk_crypto_profile;
 
+extern const struct device_type disk_type;
+extern struct device_type part_type;
+extern struct class block_class;
+
 /* Must be consistent with blk_mq_poll_stats_bkt() */
 #define BLK_MQ_POLL_STATS_BKTS 16
 
@@ -45,6 +57,144 @@ struct blk_crypto_profile;
  */
 #define BLKCG_MAX_POLS		6
 
+#define DISK_MAX_PARTS			256
+#define DISK_NAME_LEN			32
+
+#define PARTITION_META_INFO_VOLNAMELTH	64
+/*
+ * Enough for the string representation of any kind of UUID plus NULL.
+ * EFI UUID is 36 characters. MSDOS UUID is 11 characters.
+ */
+#define PARTITION_META_INFO_UUIDLTH	(UUID_STRING_LEN + 1)
+
+struct partition_meta_info {
+	char uuid[PARTITION_META_INFO_UUIDLTH];
+	u8 volname[PARTITION_META_INFO_VOLNAMELTH];
+};
+
+/**
+ * DOC: genhd capability flags
+ *
+ * ``GENHD_FL_REMOVABLE``: indicates that the block device gives access to
+ * removable media.  When set, the device remains present even when media is not
+ * inserted.  Shall not be set for devices which are removed entirely when the
+ * media is removed.
+ *
+ * ``GENHD_FL_HIDDEN``: the block device is hidden; it doesn't produce events,
+ * doesn't appear in sysfs, and can't be opened from userspace or using
+ * blkdev_get*. Used for the underlying components of multipath devices.
+ *
+ * ``GENHD_FL_NO_PART``: partition support is disabled.  The kernel will not
+ * scan for partitions from add_disk, and users can't add partitions manually.
+ *
+ */
+enum {
+	GENHD_FL_REMOVABLE			= 1 << 0,
+	GENHD_FL_HIDDEN				= 1 << 1,
+	GENHD_FL_NO_PART			= 1 << 2,
+};
+
+enum {
+	DISK_EVENT_MEDIA_CHANGE			= 1 << 0, /* media changed */
+	DISK_EVENT_EJECT_REQUEST		= 1 << 1, /* eject requested */
+};
+
+enum {
+	/* Poll even if events_poll_msecs is unset */
+	DISK_EVENT_FLAG_POLL			= 1 << 0,
+	/* Forward events to udev */
+	DISK_EVENT_FLAG_UEVENT			= 1 << 1,
+	/* Block event polling when open for exclusive write */
+	DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE	= 1 << 2,
+};
+
+struct disk_events;
+struct badblocks;
+
+struct blk_integrity {
+	const struct blk_integrity_profile	*profile;
+	unsigned char				flags;
+	unsigned char				tuple_size;
+	unsigned char				interval_exp;
+	unsigned char				tag_size;
+};
+
+struct gendisk {
+	/*
+	 * major/first_minor/minors should not be set by any new driver, the
+	 * block core will take care of allocating them automatically.
+	 */
+	int major;
+	int first_minor;
+	int minors;
+
+	char disk_name[DISK_NAME_LEN];	/* name of major driver */
+
+	unsigned short events;		/* supported events */
+	unsigned short event_flags;	/* flags related to event processing */
+
+	struct xarray part_tbl;
+	struct block_device *part0;
+
+	const struct block_device_operations *fops;
+	struct request_queue *queue;
+	void *private_data;
+
+	int flags;
+	unsigned long state;
+#define GD_NEED_PART_SCAN		0
+#define GD_READ_ONLY			1
+#define GD_DEAD				2
+#define GD_NATIVE_CAPACITY		3
+
+	struct mutex open_mutex;	/* open/close mutex */
+	unsigned open_partitions;	/* number of open partitions */
+
+	struct backing_dev_info	*bdi;
+	struct kobject *slave_dir;
+#ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
+	struct list_head slave_bdevs;
+#endif
+	struct timer_rand_state *random;
+	atomic_t sync_io;		/* RAID */
+	struct disk_events *ev;
+#ifdef  CONFIG_BLK_DEV_INTEGRITY
+	struct kobject integrity_kobj;
+#endif	/* CONFIG_BLK_DEV_INTEGRITY */
+#if IS_ENABLED(CONFIG_CDROM)
+	struct cdrom_device_info *cdi;
+#endif
+	int node_id;
+	struct badblocks *bb;
+	struct lockdep_map lockdep_map;
+	u64 diskseq;
+};
+
+static inline bool disk_live(struct gendisk *disk)
+{
+	return !inode_unhashed(disk->part0->bd_inode);
+}
+
+/*
+ * The gendisk is refcounted by the part0 block_device, and the bd_device
+ * therein is also used for device model presentation in sysfs.
+ */
+#define dev_to_disk(device) \
+	(dev_to_bdev(device)->bd_disk)
+#define disk_to_dev(disk) \
+	(&((disk)->part0->bd_device))
+
+#if IS_REACHABLE(CONFIG_CDROM)
+#define disk_to_cdi(disk)	((disk)->cdi)
+#else
+#define disk_to_cdi(disk)	NULL
+#endif
+
+static inline dev_t disk_devt(struct gendisk *disk)
+{
+	return MKDEV(disk->major, disk->first_minor);
+}
+
 static inline int blk_validate_block_size(unsigned long bsize)
 {
 	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
@@ -596,6 +746,118 @@ static inline unsigned int blk_queue_depth(struct request_queue *q)
 #define for_each_bio(_bio)		\
 	for (; _bio; _bio = _bio->bi_next)
 
+int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
+				 const struct attribute_group **groups);
+static inline int __must_check add_disk(struct gendisk *disk)
+{
+	return device_add_disk(NULL, disk, NULL);
+}
+void del_gendisk(struct gendisk *gp);
+void invalidate_disk(struct gendisk *disk);
+void set_disk_ro(struct gendisk *disk, bool read_only);
+void disk_uevent(struct gendisk *disk, enum kobject_action action);
+
+static inline int get_disk_ro(struct gendisk *disk)
+{
+	return disk->part0->bd_read_only ||
+		test_bit(GD_READ_ONLY, &disk->state);
+}
+
+static inline int bdev_read_only(struct block_device *bdev)
+{
+	return bdev->bd_read_only || get_disk_ro(bdev->bd_disk);
+}
+
+bool set_capacity_and_notify(struct gendisk *disk, sector_t size);
+bool disk_force_media_change(struct gendisk *disk, unsigned int events);
+
+void add_disk_randomness(struct gendisk *disk) __latent_entropy;
+void rand_initialize_disk(struct gendisk *disk);
+
+static inline sector_t get_start_sect(struct block_device *bdev)
+{
+	return bdev->bd_start_sect;
+}
+
+static inline sector_t bdev_nr_sectors(struct block_device *bdev)
+{
+	return bdev->bd_nr_sectors;
+}
+
+static inline loff_t bdev_nr_bytes(struct block_device *bdev)
+{
+	return (loff_t)bdev_nr_sectors(bdev) << SECTOR_SHIFT;
+}
+
+static inline sector_t get_capacity(struct gendisk *disk)
+{
+	return bdev_nr_sectors(disk->part0);
+}
+
+static inline u64 sb_bdev_nr_blocks(struct super_block *sb)
+{
+	return bdev_nr_sectors(sb->s_bdev) >>
+		(sb->s_blocksize_bits - SECTOR_SHIFT);
+}
+
+int bdev_disk_changed(struct gendisk *disk, bool invalidate);
+
+struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
+		struct lock_class_key *lkclass);
+void put_disk(struct gendisk *disk);
+struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass);
+
+/**
+ * blk_alloc_disk - allocate a gendisk structure
+ * @node_id: numa node to allocate on
+ *
+ * Allocate and pre-initialize a gendisk structure for use with BIO based
+ * drivers.
+ *
+ * Context: can sleep
+ */
+#define blk_alloc_disk(node_id)						\
+({									\
+	static struct lock_class_key __key;				\
+									\
+	__blk_alloc_disk(node_id, &__key);				\
+})
+void blk_cleanup_disk(struct gendisk *disk);
+
+int __register_blkdev(unsigned int major, const char *name,
+		void (*probe)(dev_t devt));
+#define register_blkdev(major, name) \
+	__register_blkdev(major, name, NULL)
+void unregister_blkdev(unsigned int major, const char *name);
+
+bool bdev_check_media_change(struct block_device *bdev);
+int __invalidate_device(struct block_device *bdev, bool kill_dirty);
+void set_capacity(struct gendisk *disk, sector_t size);
+
+#ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
+int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
+void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk);
+int bd_register_pending_holders(struct gendisk *disk);
+#else
+static inline int bd_link_disk_holder(struct block_device *bdev,
+				      struct gendisk *disk)
+{
+	return 0;
+}
+static inline void bd_unlink_disk_holder(struct block_device *bdev,
+					 struct gendisk *disk)
+{
+}
+static inline int bd_register_pending_holders(struct gendisk *disk)
+{
+	return 0;
+}
+#endif /* CONFIG_BLOCK_HOLDER_DEPRECATED */
+
+dev_t part_devt(struct gendisk *disk, u8 partno);
+void inc_diskseq(struct gendisk *disk);
+dev_t blk_lookup_devt(const char *name, int partno);
+void blk_request_module(dev_t devt);
 
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
@@ -1310,6 +1572,7 @@ void invalidate_bdev(struct block_device *bdev);
 int sync_blockdev(struct block_device *bdev);
 int sync_blockdev_nowait(struct block_device *bdev);
 void sync_bdevs(bool wait);
+void printk_all_partitions(void);
 #else
 static inline void invalidate_bdev(struct block_device *bdev)
 {
@@ -1325,7 +1588,11 @@ static inline int sync_blockdev_nowait(struct block_device *bdev)
 static inline void sync_bdevs(bool wait)
 {
 }
-#endif
+static inline void printk_all_partitions(void)
+{
+}
+#endif /* CONFIG_BLOCK */
+
 int fsync_bdev(struct block_device *bdev);
 
 int freeze_bdev(struct block_device *bdev);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
deleted file mode 100644
index aa4bd985dbe51..0000000000000
--- a/include/linux/genhd.h
+++ /dev/null
@@ -1,287 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_GENHD_H
-#define _LINUX_GENHD_H
-
-/*
- * 	genhd.h Copyright (C) 1992 Drew Eckhardt
- *	Generic hard disk header file by  
- * 		Drew Eckhardt
- *
- *		<drew@colorado.edu>
- */
-
-#include <linux/types.h>
-#include <linux/kdev_t.h>
-#include <linux/uuid.h>
-#include <linux/blk_types.h>
-#include <linux/device.h>
-#include <linux/xarray.h>
-
-extern const struct device_type disk_type;
-extern struct device_type part_type;
-extern struct class block_class;
-
-#define DISK_MAX_PARTS			256
-#define DISK_NAME_LEN			32
-
-#define PARTITION_META_INFO_VOLNAMELTH	64
-/*
- * Enough for the string representation of any kind of UUID plus NULL.
- * EFI UUID is 36 characters. MSDOS UUID is 11 characters.
- */
-#define PARTITION_META_INFO_UUIDLTH	(UUID_STRING_LEN + 1)
-
-struct partition_meta_info {
-	char uuid[PARTITION_META_INFO_UUIDLTH];
-	u8 volname[PARTITION_META_INFO_VOLNAMELTH];
-};
-
-/**
- * DOC: genhd capability flags
- *
- * ``GENHD_FL_REMOVABLE``: indicates that the block device gives access to
- * removable media.  When set, the device remains present even when media is not
- * inserted.  Shall not be set for devices which are removed entirely when the
- * media is removed.
- *
- * ``GENHD_FL_HIDDEN``: the block device is hidden; it doesn't produce events,
- * doesn't appear in sysfs, and can't be opened from userspace or using
- * blkdev_get*. Used for the underlying components of multipath devices.
- *
- * ``GENHD_FL_NO_PART``: partition support is disabled.  The kernel will not
- * scan for partitions from add_disk, and users can't add partitions manually.
- *
- */
-enum {
-	GENHD_FL_REMOVABLE			= 1 << 0,
-	GENHD_FL_HIDDEN				= 1 << 1,
-	GENHD_FL_NO_PART			= 1 << 2,
-};
-
-enum {
-	DISK_EVENT_MEDIA_CHANGE			= 1 << 0, /* media changed */
-	DISK_EVENT_EJECT_REQUEST		= 1 << 1, /* eject requested */
-};
-
-enum {
-	/* Poll even if events_poll_msecs is unset */
-	DISK_EVENT_FLAG_POLL			= 1 << 0,
-	/* Forward events to udev */
-	DISK_EVENT_FLAG_UEVENT			= 1 << 1,
-	/* Block event polling when open for exclusive write */
-	DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE	= 1 << 2,
-};
-
-struct disk_events;
-struct badblocks;
-
-struct blk_integrity {
-	const struct blk_integrity_profile	*profile;
-	unsigned char				flags;
-	unsigned char				tuple_size;
-	unsigned char				interval_exp;
-	unsigned char				tag_size;
-};
-
-struct gendisk {
-	/*
-	 * major/first_minor/minors should not be set by any new driver, the
-	 * block core will take care of allocating them automatically.
-	 */
-	int major;
-	int first_minor;
-	int minors;
-
-	char disk_name[DISK_NAME_LEN];	/* name of major driver */
-
-	unsigned short events;		/* supported events */
-	unsigned short event_flags;	/* flags related to event processing */
-
-	struct xarray part_tbl;
-	struct block_device *part0;
-
-	const struct block_device_operations *fops;
-	struct request_queue *queue;
-	void *private_data;
-
-	int flags;
-	unsigned long state;
-#define GD_NEED_PART_SCAN		0
-#define GD_READ_ONLY			1
-#define GD_DEAD				2
-#define GD_NATIVE_CAPACITY		3
-
-	struct mutex open_mutex;	/* open/close mutex */
-	unsigned open_partitions;	/* number of open partitions */
-
-	struct backing_dev_info	*bdi;
-	struct kobject *slave_dir;
-#ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
-	struct list_head slave_bdevs;
-#endif
-	struct timer_rand_state *random;
-	atomic_t sync_io;		/* RAID */
-	struct disk_events *ev;
-#ifdef  CONFIG_BLK_DEV_INTEGRITY
-	struct kobject integrity_kobj;
-#endif	/* CONFIG_BLK_DEV_INTEGRITY */
-#if IS_ENABLED(CONFIG_CDROM)
-	struct cdrom_device_info *cdi;
-#endif
-	int node_id;
-	struct badblocks *bb;
-	struct lockdep_map lockdep_map;
-	u64 diskseq;
-};
-
-static inline bool disk_live(struct gendisk *disk)
-{
-	return !inode_unhashed(disk->part0->bd_inode);
-}
-
-/*
- * The gendisk is refcounted by the part0 block_device, and the bd_device
- * therein is also used for device model presentation in sysfs.
- */
-#define dev_to_disk(device) \
-	(dev_to_bdev(device)->bd_disk)
-#define disk_to_dev(disk) \
-	(&((disk)->part0->bd_device))
-
-#if IS_REACHABLE(CONFIG_CDROM)
-#define disk_to_cdi(disk)	((disk)->cdi)
-#else
-#define disk_to_cdi(disk)	NULL
-#endif
-
-static inline dev_t disk_devt(struct gendisk *disk)
-{
-	return MKDEV(disk->major, disk->first_minor);
-}
-
-void disk_uevent(struct gendisk *disk, enum kobject_action action);
-
-/* block/genhd.c */
-int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
-				 const struct attribute_group **groups);
-static inline int __must_check add_disk(struct gendisk *disk)
-{
-	return device_add_disk(NULL, disk, NULL);
-}
-extern void del_gendisk(struct gendisk *gp);
-
-void invalidate_disk(struct gendisk *disk);
-
-void set_disk_ro(struct gendisk *disk, bool read_only);
-
-static inline int get_disk_ro(struct gendisk *disk)
-{
-	return disk->part0->bd_read_only ||
-		test_bit(GD_READ_ONLY, &disk->state);
-}
-
-static inline int bdev_read_only(struct block_device *bdev)
-{
-	return bdev->bd_read_only || get_disk_ro(bdev->bd_disk);
-}
-
-bool set_capacity_and_notify(struct gendisk *disk, sector_t size);
-bool disk_force_media_change(struct gendisk *disk, unsigned int events);
-
-/* drivers/char/random.c */
-extern void add_disk_randomness(struct gendisk *disk) __latent_entropy;
-extern void rand_initialize_disk(struct gendisk *disk);
-
-static inline sector_t get_start_sect(struct block_device *bdev)
-{
-	return bdev->bd_start_sect;
-}
-
-static inline sector_t bdev_nr_sectors(struct block_device *bdev)
-{
-	return bdev->bd_nr_sectors;
-}
-
-static inline loff_t bdev_nr_bytes(struct block_device *bdev)
-{
-	return (loff_t)bdev_nr_sectors(bdev) << SECTOR_SHIFT;
-}
-
-static inline sector_t get_capacity(struct gendisk *disk)
-{
-	return bdev_nr_sectors(disk->part0);
-}
-
-static inline u64 sb_bdev_nr_blocks(struct super_block *sb)
-{
-	return bdev_nr_sectors(sb->s_bdev) >>
-		(sb->s_blocksize_bits - SECTOR_SHIFT);
-}
-
-int bdev_disk_changed(struct gendisk *disk, bool invalidate);
-
-struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
-		struct lock_class_key *lkclass);
-extern void put_disk(struct gendisk *disk);
-struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass);
-
-/**
- * blk_alloc_disk - allocate a gendisk structure
- * @node_id: numa node to allocate on
- *
- * Allocate and pre-initialize a gendisk structure for use with BIO based
- * drivers.
- *
- * Context: can sleep
- */
-#define blk_alloc_disk(node_id)						\
-({									\
-	static struct lock_class_key __key;				\
-									\
-	__blk_alloc_disk(node_id, &__key);				\
-})
-void blk_cleanup_disk(struct gendisk *disk);
-
-int __register_blkdev(unsigned int major, const char *name,
-		void (*probe)(dev_t devt));
-#define register_blkdev(major, name) \
-	__register_blkdev(major, name, NULL)
-void unregister_blkdev(unsigned int major, const char *name);
-
-bool bdev_check_media_change(struct block_device *bdev);
-int __invalidate_device(struct block_device *bdev, bool kill_dirty);
-void set_capacity(struct gendisk *disk, sector_t size);
-
-#ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
-int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
-void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk);
-int bd_register_pending_holders(struct gendisk *disk);
-#else
-static inline int bd_link_disk_holder(struct block_device *bdev,
-				      struct gendisk *disk)
-{
-	return 0;
-}
-static inline void bd_unlink_disk_holder(struct block_device *bdev,
-					 struct gendisk *disk)
-{
-}
-static inline int bd_register_pending_holders(struct gendisk *disk)
-{
-	return 0;
-}
-#endif /* CONFIG_BLOCK_HOLDER_DEPRECATED */
-
-dev_t part_devt(struct gendisk *disk, u8 partno);
-void inc_diskseq(struct gendisk *disk);
-dev_t blk_lookup_devt(const char *name, int partno);
-void blk_request_module(dev_t devt);
-#ifdef CONFIG_BLOCK
-void printk_all_partitions(void);
-#else /* CONFIG_BLOCK */
-static inline void printk_all_partitions(void)
-{
-}
-#endif /* CONFIG_BLOCK */
-
-#endif /* _LINUX_GENHD_H */
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index 6f7949b2fd8dc..abeba356bc3f5 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_PART_STAT_H
 #define _LINUX_PART_STAT_H
 
-#include <linux/genhd.h>
+#include <linux/blkdev.h>
 #include <asm/local.h>
 
 struct disk_stats {
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 762b534978d95..7058e14ad5f70 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -8,7 +8,6 @@
 #include <linux/root_dev.h>
 #include <linux/security.h>
 #include <linux/delay.h>
-#include <linux/genhd.h>
 #include <linux/mount.h>
 #include <linux/device.h>
 #include <linux/init.h>
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e6af502c2fd77..a94044197c4a6 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -28,7 +28,6 @@
 #include <linux/gfp.h>
 #include <linux/syscore_ops.h>
 #include <linux/ctype.h>
-#include <linux/genhd.h>
 #include <linux/ktime.h>
 #include <linux/security.h>
 #include <linux/secretmem.h>
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index ad10359030a4c..f1bd031295752 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -16,7 +16,6 @@
 #include <linux/file.h>
 #include <linux/delay.h>
 #include <linux/bitops.h>
-#include <linux/genhd.h>
 #include <linux/device.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 320ca80aacab5..02882526ba9a3 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -16,7 +16,6 @@
 #include <linux/parser.h>
 #include <linux/slab.h>
 #include <linux/rculist.h>
-#include <linux/genhd.h>
 #include <linux/seq_file.h>
 #include <linux/ima.h>
 
-- 
2.30.2

