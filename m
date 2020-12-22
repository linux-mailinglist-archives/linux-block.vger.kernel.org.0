Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6442D2DA7ED
	for <lists+linux-block@lfdr.de>; Tue, 15 Dec 2020 07:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgLOGEZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Dec 2020 01:04:25 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50677 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgLOGES (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Dec 2020 01:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608012256; x=1639548256;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2WugzsOj7JoyEePPoxnKJP23IEn9DHkc3JSd2Xia2UU=;
  b=Bx+kW5Ous/R4wTZ+w8DwJjbJ0DB+6tqLbLZ+bAuRbUA74wXoSvlIcGKj
   Z/92WgLDTc1iBM8Odvn5ki8ocU4GCgrp6yBiTJ1HdWOtUmpXJHWw6LBtE
   8J+3tksr+vgCChckm+hPNasyq1ojX+OEW7dCUFsJGeJFHr2XdBP0mcAAy
   eDTaPHeDQxrdxVI6Pk3IMYcPNNTgDd08ALAd8wJEaBv09+/d8oPAN4Ns6
   wP927Bd3lkCe9q53K7dzCeJPiyROEk4hmYjxNuSI2Bn8w4XWXaGkkZiVp
   pfV8q7Era7G5omCFWQkCnyyslY6zvAvdMv9Id2HFj/EgmN9i1I/MUWRmM
   Q==;
IronPort-SDR: Mb0EkbyFCcv3Aq2mM9FLEARqNLQfELIerEnHpA5jrTHXe2apr4mpSVkmmToF0ThZXjcKEqxUcI
 S/KPHUAjX8NT3dgkdOHrcaxikUQIHHglpQ+esMP1aeMy2lKha2xD4HIOl278cFLNmaikOkONxx
 jCM9DANnb+q+Flrkgp/BUC3saCulfOteVJiwGArZ7NzjJpZW7sg7f9mTsZrX45M/HZgt2LgGLj
 CnHW9s3gGb0aAvZCPyduMXPN02FhE5acB3BAl8MSH/WJaD2vkB1ckVbE2+VvhrpzEae8BevKGP
 HHA=
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400"; 
   d="scan'208";a="159618762"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2020 14:03:07 +0800
IronPort-SDR: uzupCdA9JH+DvGutCpkQhUaUcQlN5ofjl+f659zsjuBiqLzEc+GuXZaBeTGMXqOt8K5QMOPyEO
 RUdqQUWEwOgg5CF5FM3Qh3pHTh4SclcP10Mz8RardNcTJ+bnbtJdzz4jdsqO6hLYMsSzmp42Jg
 87EBz1wiI4j51awuLVGtDU6tZIWI8xRmt1nRQNpCdn5gqEAS/3vvcyaxdLbbqZ5z02irkauxZq
 /9+s1/FUnri18H31ojmcuGlMGUH3tMbK1okZmgBx4+qa7yBtP5rtJsNnELT2TdzHlwh396F1gE
 jEAtKL/nNJXfVnoDaLcH16lO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 21:46:50 -0800
IronPort-SDR: j9eLVM6VGwlue9tAm5lJTGdAR2hr8xHuCj6DxtEwU++z2OG1C9ggfuuqLHsccelCFVN6T+1E/S
 sPv33Evf3ov5eug4yQn1qaruOuiyRc1L8T1e1nsKjhvM/MFbv4ePxXWh/JIbgAKG5hc9a9O0eb
 KfLvcdIgPXd9l7GeqgQq0L/QxsPm0OFzoRzuzFpqyvmufx1ZDMXFlbQK0TwtLNUQXY5A6A5L5t
 NlQxcaO8yMFaQnl3bJUgrZGSHHt+Uq9QOVNU3JxPpfwMdM0h+Ix7DDdrE6swE255WEdkI7S3vP
 VbA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Dec 2020 22:03:08 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V7 0/6] nvmet: add ZBD backend support
Date:   Mon, 14 Dec 2020 22:02:59 -0800
Message-Id: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

NVMeOF Host is capable of handling the NVMe Protocol based Zoned Block
Devices (ZBD) in the Zoned Namespaces (ZNS) mode with the passthru
backend. There is no support for a generic block device backend to
handle the ZBD devices which are not NVMe protocol compliant.

This adds support to export the ZBDs (which are not NVMe drives) to host
the from target via NVMeOF using the host side ZNS interface.

The patch series is generated in bottom-top manner where, it first adds
prep patch and ZNS command-specific handlers on the top of genblk and 
updates the data structures, then one by one it wires up the admin cmds
in the order host calls them in namespace initializing sequence. Once
everything is ready, it wires-up the I/O command handlers. See below for
patch-series overview.

All the testcases are passing for the nvme blktests with non ZBD target
device and with ZoneFS where ZBD exported with NVMeOF backed by
null_blk ZBD and null_blk ZBD without NVMeOF. Adding test result below.

Note: This patch-series is based on the earlier posted patch series :-

[PATCH 0/4] nvmet: admin-cmd related cleanups and a fix

http://lists.infradead.org/pipermail/linux-nvme/2020-December/021501.html

Regards,
Chaitanya

Changes from V6:-

1. Instead of calling report zones to find conventional zones in the 
   loop use the loop inside LLD report zones that also simplifies the
   report zone callback for zbd backend.
2. Use -EOPNOTSUPP in the nvmet_bdev_validate_zns_zones_cb() to avoid
   checkpatch warning when conventional zone is found. 
2. Fix the bug in nvmet_bdev_has_conv_zones().
3. Remove conditional operators in the nvmet_bdev_execute_zone_append().

Changes from V5:-

1.  Use bio->bi_iter.bi_sector for result of the REQ_OP_ZONE_APPEND
    command.
2.  Add endianness to the helper nvmet_sect_to_lba().
3.  Make bufsize u32 in zone mgmt recv command handler.
4.  Add __GFP_ZERO for report zone data buffer to return clean buffer.

Changes from V4:-

1.  Don't use bio_iov_iter_get_pages() instead add a patch to export
    bio_add_hw_page() and call it directly for zone append.
2.  Add inline vector optimization for append bio.
3.  Update the commit logs for the patches.
4.  Remove ZNS related identify data structures, use individual members.
5.  Add a comment for macro NVMET_MPSMIN_SHIFT.
6.  Remove nvmet_bdev() helper.
7.  Move the command set identifier code into common code.
8.  Use IS_ENABLED() and move helpers fomr zns.c into common code.
9.  Add a patch to support Command Set identifiers.
10. Open code nvmet_bdev_validate_zns_zones().
11. Remove the per namespace min zasl calculation and don't allow
    namespaces with zasl value > the first ns zasl value.
12. Move the stubs into the header file.
13. Add lba to/from sector conversion helpers and update the
    io-cmd-bdev.c to avoid the code duplication.
14. Add everything into one patch for zns command handlers and 
    respective calls from the target code.
15. Remove the trim ns-desclist admin callback patch from this series.
16. Add bio get and put helpers patches to reduce the duplicate code in
    generic bdev, passthru, and generic zns backend.

Changes from V3:-

1.  Get rid of the bio_max_zasl check.
2.  Remove extra lines.
4.  Remove the block layer api export patch.
5.  Remove the bvec check in the bio_iov_iter_get_pages() for
    REQ_OP_ZONE_APPEND so that we can reuse the code.

Changes from V2:-

1.  Move conventional zone bitmap check into 
    nvmet_bdev_validate_zns_zones(). 
2.  Don't use report zones call to check the runt zone.
3.  Trim nvmet_zasl() helper.
4.  Fix typo in the nvmet_zns_update_zasl().
5.  Remove the comment and fix the mdts calculation in
    nvmet_execute_identify_cns_cs_ctrl().
6.  Use u64 for bufsize in nvmet_bdev_execute_zone_mgmt_recv().
7.  Remove nvmet_zones_to_desc_size() and fix the nr_zones
    calculation.
8.  Remove the op variable in nvmet_bdev_execute_zone_append().
9.  Fix the nr_zones calculation nvmet_bdev_execute_zone_mgmt_recv().
10. Update cover letter subject.

Changes from V1:-

1.  Remove the nvmet-$(CONFIG_BLK_DEV_ZONED) += zns.o.
2.  Mark helpers inline.
3.  Fix typos in the comments and update the comments.
4.  Get rid of the curly brackets.
5.  Don't allow drives with last smaller zones.
6.  Calculate the zasl as a function of ax_zone_append_sectors,
    bio_max_pages so we don't have to split the bio.
7.  Add global subsys->zasl and update the zasl when new namespace
    is enabled.
8.  Rmove the loop in the nvmet_bdev_execute_zone_mgmt_recv() and
    move functionality in to the report zone callback.
9.  Add goto for default case in nvmet_bdev_execute_zone_mgmt_send().
10. Allocate the zones buffer with zones size instead of bdev nr_zones.

Chaitanya Kulkarni (6):
  block: export bio_add_hw_pages()
  nvmet: add lba to sect conversion helpers
  nvmet: add NVM command set identifier support
  nvmet: add ZBD over ZNS backend support
  nvmet: add bio get helper for different backends
  nvmet: add bio put helper for different backends

 block/bio.c                       |   1 +
 block/blk.h                       |   4 -
 drivers/nvme/target/Makefile      |   1 +
 drivers/nvme/target/admin-cmd.c   |  59 ++++--
 drivers/nvme/target/core.c        |  14 +-
 drivers/nvme/target/io-cmd-bdev.c |  51 +++--
 drivers/nvme/target/nvmet.h       |  71 +++++++
 drivers/nvme/target/passthru.c    |  11 +-
 drivers/nvme/target/zns.c         | 335 ++++++++++++++++++++++++++++++
 include/linux/blkdev.h            |   4 +
 10 files changed, 503 insertions(+), 48 deletions(-)
 create mode 100644 drivers/nvme/target/zns.c

Without CONFIG_BLK_DEV_ZONED nvme tests :-
# grep -i blk_dev_zoned .config
# CONFIG_BLK_DEV_ZONED is not set
# gitlog -6 
2dc9be4cc588 (HEAD -> nvme-5.11) nvmet: add bio put helper for different backends
72836658a6cf nvmet: add bio get helper for different backends
c1c1819074b6 nvmet: add ZBD over ZNS backend support
428548cd91ff nvmet: add NVM command set identifier support
fba6fbaf6e2a nvmet: add lba to sect conversion helpers
70c9a4c94d5a block: export bio_add_hw_pages()
# makej M=drivers/nvme/ clean 
  CLEAN   drivers/nvme//Module.symvers
# makej M=drivers/nvme/ 
  CC [M]  drivers/nvme//host/core.o
  CC [M]  drivers/nvme//host/trace.o
  CC [M]  drivers/nvme//host/lightnvm.o
  CC [M]  drivers/nvme//target/core.o
  CC [M]  drivers/nvme//host/hwmon.o
  CC [M]  drivers/nvme//target/configfs.o
  CC [M]  drivers/nvme//host/pci.o
  CC [M]  drivers/nvme//target/admin-cmd.o
  CC [M]  drivers/nvme//host/fabrics.o
  CC [M]  drivers/nvme//host/rdma.o
  CC [M]  drivers/nvme//target/fabrics-cmd.o
  CC [M]  drivers/nvme//target/discovery.o
  CC [M]  drivers/nvme//host/fc.o
  CC [M]  drivers/nvme//target/io-cmd-file.o
  CC [M]  drivers/nvme//host/tcp.o
  CC [M]  drivers/nvme//target/io-cmd-bdev.o
  CC [M]  drivers/nvme//target/passthru.o
  CC [M]  drivers/nvme//target/trace.o
  CC [M]  drivers/nvme//target/loop.o
  CC [M]  drivers/nvme//target/rdma.o
  CC [M]  drivers/nvme//target/fc.o
  CC [M]  drivers/nvme//target/fcloop.o
  CC [M]  drivers/nvme//target/tcp.o
  LD [M]  drivers/nvme//target/nvme-loop.o
  LD [M]  drivers/nvme//target/nvme-fcloop.o
  LD [M]  drivers/nvme//target/nvmet-tcp.o
  LD [M]  drivers/nvme//host/nvme-fabrics.o
  LD [M]  drivers/nvme//host/nvme.o
  LD [M]  drivers/nvme//host/nvme-rdma.o
  LD [M]  drivers/nvme//target/nvmet-rdma.o
  LD [M]  drivers/nvme//target/nvmet.o
  LD [M]  drivers/nvme//target/nvmet-fc.o
  LD [M]  drivers/nvme//host/nvme-tcp.o
  LD [M]  drivers/nvme//host/nvme-fc.o
  LD [M]  drivers/nvme//host/nvme-core.o
  MODPOST drivers/nvme//Module.symvers
  CC [M]  drivers/nvme//host/nvme-core.mod.o
  CC [M]  drivers/nvme//host/nvme-fabrics.mod.o
  CC [M]  drivers/nvme//host/nvme-fc.mod.o
  CC [M]  drivers/nvme//host/nvme-rdma.mod.o
  CC [M]  drivers/nvme//host/nvme-tcp.mod.o
  CC [M]  drivers/nvme//host/nvme.mod.o
  CC [M]  drivers/nvme//target/nvme-fcloop.mod.o
  CC [M]  drivers/nvme//target/nvme-loop.mod.o
  CC [M]  drivers/nvme//target/nvmet-fc.mod.o
  CC [M]  drivers/nvme//target/nvmet-rdma.mod.o
  CC [M]  drivers/nvme//target/nvmet-tcp.mod.o
  CC [M]  drivers/nvme//target/nvmet.mod.o
  LD [M]  drivers/nvme//target/nvme-fcloop.ko
  LD [M]  drivers/nvme//host/nvme-tcp.ko
  LD [M]  drivers/nvme//host/nvme-core.ko
  LD [M]  drivers/nvme//target/nvmet-tcp.ko
  LD [M]  drivers/nvme//target/nvme-loop.ko
  LD [M]  drivers/nvme//target/nvmet-fc.ko
  LD [M]  drivers/nvme//host/nvme-fabrics.ko
  LD [M]  drivers/nvme//host/nvme-fc.ko
  LD [M]  drivers/nvme//target/nvmet-rdma.ko
  LD [M]  drivers/nvme//host/nvme-rdma.ko
  LD [M]  drivers/nvme//host/nvme.ko
  LD [M]  drivers/nvme//target/nvmet.ko
# cdblktests 
# ./check tests/nvme/
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  24.923s  ...  24.625s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.141s  ...  10.143s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  2.446s  ...  2.444s
nvme/005 (reset local loopback target)                       [not run]
    nvme_core module does not have parameter multipath
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.113s  ...  0.103s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.068s  ...  0.066s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  2.477s  ...  2.477s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  2.447s  ...  2.428s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  21.695s  ...  27.905s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  11.413s  ...  252.685s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime    ...  50.439s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  268.947s  ...  275.912s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  21.977s  ...  22.190s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  20.816s  ...  21.174s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  13.469s  ...  13.774s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  14.086s  ...  13.420s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  2.418s  ...  2.416s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  2.477s  ...  2.474s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  2.410s  ...  2.403s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  2.412s  ...  2.404s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  2.861s  ...  2.863s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  2.486s  ...  2.471s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  2.430s  ...  2.411s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  2.412s  ...  2.395s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  2.450s  ...  2.420s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  2.416s  ...  2.401s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  2.418s  ...  2.405s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  2.759s  ...  2.732s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.347s  ...  0.345s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  13.480s  ...  13.432s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.039s  ...  0.039s


With CONFIG_BLK_DEV_ZONED nvme and zonefs tests :-
# grep -i blk_dev_zoned .config
CONFIG_BLK_DEV_ZONED=y
# make M=drivers/nvme/ clean 
  CLEAN   drivers/nvme//Module.symvers
# make M=drivers/nvme/ 
  CC [M]  drivers/nvme//host/core.o
  CC [M]  drivers/nvme//host/trace.o
  CC [M]  drivers/nvme//host/lightnvm.o
  CC [M]  drivers/nvme//host/zns.o
  CC [M]  drivers/nvme//host/hwmon.o
  LD [M]  drivers/nvme//host/nvme-core.o
  CC [M]  drivers/nvme//host/pci.o
  LD [M]  drivers/nvme//host/nvme.o
  CC [M]  drivers/nvme//host/fabrics.o
  LD [M]  drivers/nvme//host/nvme-fabrics.o
  CC [M]  drivers/nvme//host/rdma.o
  LD [M]  drivers/nvme//host/nvme-rdma.o
  CC [M]  drivers/nvme//host/fc.o
  LD [M]  drivers/nvme//host/nvme-fc.o
  CC [M]  drivers/nvme//host/tcp.o
  LD [M]  drivers/nvme//host/nvme-tcp.o
  CC [M]  drivers/nvme//target/core.o
  CC [M]  drivers/nvme//target/configfs.o
  CC [M]  drivers/nvme//target/admin-cmd.o
  CC [M]  drivers/nvme//target/fabrics-cmd.o
  CC [M]  drivers/nvme//target/discovery.o
  CC [M]  drivers/nvme//target/io-cmd-file.o
  CC [M]  drivers/nvme//target/io-cmd-bdev.o
  CC [M]  drivers/nvme//target/passthru.o
  CC [M]  drivers/nvme//target/zns.o
  CC [M]  drivers/nvme//target/trace.o
  LD [M]  drivers/nvme//target/nvmet.o
  CC [M]  drivers/nvme//target/loop.o
  LD [M]  drivers/nvme//target/nvme-loop.o
  CC [M]  drivers/nvme//target/rdma.o
  LD [M]  drivers/nvme//target/nvmet-rdma.o
  CC [M]  drivers/nvme//target/fc.o
  LD [M]  drivers/nvme//target/nvmet-fc.o
  CC [M]  drivers/nvme//target/fcloop.o
  LD [M]  drivers/nvme//target/nvme-fcloop.o
  CC [M]  drivers/nvme//target/tcp.o
  LD [M]  drivers/nvme//target/nvmet-tcp.o
  MODPOST drivers/nvme//Module.symvers
  CC [M]  drivers/nvme//host/nvme-core.mod.o
  LD [M]  drivers/nvme//host/nvme-core.ko
  CC [M]  drivers/nvme//host/nvme-fabrics.mod.o
  LD [M]  drivers/nvme//host/nvme-fabrics.ko
  CC [M]  drivers/nvme//host/nvme-fc.mod.o
  LD [M]  drivers/nvme//host/nvme-fc.ko
  CC [M]  drivers/nvme//host/nvme-rdma.mod.o
  LD [M]  drivers/nvme//host/nvme-rdma.ko
  CC [M]  drivers/nvme//host/nvme-tcp.mod.o
  LD [M]  drivers/nvme//host/nvme-tcp.ko
  CC [M]  drivers/nvme//host/nvme.mod.o
  LD [M]  drivers/nvme//host/nvme.ko
  CC [M]  drivers/nvme//target/nvme-fcloop.mod.o
  LD [M]  drivers/nvme//target/nvme-fcloop.ko
  CC [M]  drivers/nvme//target/nvme-loop.mod.o
  LD [M]  drivers/nvme//target/nvme-loop.ko
  CC [M]  drivers/nvme//target/nvmet-fc.mod.o
  LD [M]  drivers/nvme//target/nvmet-fc.ko
  CC [M]  drivers/nvme//target/nvmet-rdma.mod.o
  LD [M]  drivers/nvme//target/nvmet-rdma.ko
  CC [M]  drivers/nvme//target/nvmet-tcp.mod.o
  LD [M]  drivers/nvme//target/nvmet-tcp.ko
  CC [M]  drivers/nvme//target/nvmet.mod.o
  LD [M]  drivers/nvme//target/nvmet.ko
# 
# cdblktests 
# ./check tests/nvme/
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  24.378s  ...  24.636s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.133s  ...  10.152s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  2.463s  ...  2.478s
nvme/005 (reset local loopback target)                       [not run]
    nvme_core module does not have parameter multipath
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.095s  ...  0.122s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.065s  ...  0.079s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  2.473s  ...  2.501s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  2.460s  ...  2.424s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  24.526s  ...  28.015s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  265.967s  ...  282.717s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  44.665s  ...  48.124s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  261.739s  ...  352.331s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  21.268s  ...  22.013s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  18.820s  ...  22.104s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  13.899s  ...  14.322s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  14.322s  ...  14.031s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  2.450s  ...  2.444s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  2.475s  ...  2.489s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  2.410s  ...  2.448s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  2.441s  ...  2.439s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  2.864s  ...  2.863s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  2.465s  ...  2.446s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  2.416s  ...  2.411s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  2.419s  ...  2.748s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  2.422s  ...  2.410s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  2.456s  ...  2.462s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  2.427s  ...  2.429s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  2.751s  ...  2.755s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.346s  ...  0.357s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  13.601s  ...  13.591s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.039s  ...  0.059s
# cdzonefstest 
# cdnvme
# cdzonefstest 
# ./zonefs-tests.sh /dev/nvme1n1 
Gathering information on /dev/nvme1n1...
zonefs-tests on /dev/nvme1n1:
  16 zones (0 conventional zones, 16 sequential zones)
  131072 512B sectors zone size (64 MiB)
  1 max open zones
Running tests
  Test 0010:  mkzonefs (options)                                   ... PASS
  Test 0011:  mkzonefs (force format)                              ... PASS
  Test 0012:  mkzonefs (invalid device)                            ... PASS
  Test 0013:  mkzonefs (super block zone state)                    ... PASS
  Test 0020:  mount (default)                                      ... PASS
  Test 0021:  mount (invalid device)                               ... PASS
  Test 0022:  mount (check mount directory sub-directories)        ... PASS
  Test 0023:  mount (options)                                      ... PASS
  Test 0030:  Number of files (default)                            ... PASS
  Test 0031:  Number of files (aggr_cnv)                           ... skip
  Test 0032:  Number of files using stat (default)                 ... PASS
  Test 0033:  Number of files using stat (aggr_cnv)                ... PASS
  Test 0034:  Number of blocks using stat (default)                ... PASS
  Test 0035:  Number of blocks using stat (aggr_cnv)               ... PASS
  Test 0040:  Files permissions (default)                          ... PASS
  Test 0041:  Files permissions (aggr_cnv)                         ... skip
  Test 0042:  Files permissions (set value)                        ... PASS
  Test 0043:  Files permissions (set value + aggr_cnv)             ... skip
  Test 0050:  Files owner (default)                                ... PASS
  Test 0051:  Files owner (aggr_cnv)                               ... skip
  Test 0052:  Files owner (set value)                              ... PASS
  Test 0053:  Files owner (set value + aggr_cnv)                   ... skip
  Test 0060:  Files size (default)                                 ... PASS
  Test 0061:  Files size (aggr_cnv)                                ... skip
  Test 0070:  Conventional file truncate                           ... skip
  Test 0071:  Conventional file truncate (aggr_cnv)                ... skip
  Test 0072:  Conventional file unlink                             ... skip
  Test 0073:  Conventional file unlink (aggr_cnv)                  ... skip
  Test 0074:  Conventional file random write                       ... skip
  Test 0075:  Conventional file random write (direct)              ... skip
  Test 0076:  Conventional file random write (aggr_cnv)            ... skip
  Test 0077:  Conventional file random write (aggr_cnv, direct)    ... skip
  Test 0078:  Conventional file mmap read/write                    ... skip
  Test 0079:  Conventional file mmap read/write (aggr_cnv)         ... skip
  Test 0080:  Sequential file truncate                             ... PASS
  Test 0081:  Sequential file unlink                               ... PASS
  Test 0082:  Sequential file buffered write IO                    ... PASS
  Test 0083:  Sequential file overwrite                            ... PASS
  Test 0084:  Sequential file unaligned write (sync IO)            ... PASS
  Test 0085:  Sequential file unaligned write (async IO)           ... PASS
  Test 0086:  Sequential file append (sync)                        ... PASS
  Test 0087:  Sequential file append (async)                       ... PASS
  Test 0088:  Sequential file random read                          ... PASS
  Test 0089:  Sequential file mmap read/write                      ... PASS
  Test 0090:  sequential file 4K synchronous write                 ... PASS
  Test 0091:  Sequential file large synchronous write              ... PASS

46 / 46 tests passed

-- 
2.22.1

