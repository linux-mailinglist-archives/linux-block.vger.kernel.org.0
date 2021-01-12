Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FDE2F2704
	for <lists+linux-block@lfdr.de>; Tue, 12 Jan 2021 05:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbhALE1e (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 11 Jan 2021 23:27:34 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:44979 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730197AbhALE1e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 23:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610425652; x=1641961652;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/K+4iIdhdN6/XyCNWNrRk/WiBUNLc+deW46IIBiB8xI=;
  b=SrN9MVoecjLRoXv2M1jqX/YQTfmhAx2ZMB2KOtlv77x4AIdu2n/vh8Pm
   0gh6u8gtdeqZQx4OjFnNwN7HAmPbk4c7jKNh2TMz/otpAjMoKNgX3itub
   JKmRYG7a6LD8pZ14sHpeWep6yXuEsaW8nzRpCJNWI8u6L+mBVulNv3f7J
   97jHBCNhuyspL1JOUoBpyHkiar3oDI0xjTidY5PfvJ7XJXnGLk9XY1hvt
   CB2PUnfLiDvzsX4NFYLHIh+n5zPDewoJLVPkrekNv1glJRJICmIOgm+Rx
   vOTKD6caMW41VX1Ls8Z+Oecl03psWJ7MrAwyvIoav/GBDTYgLi/OPbnZ3
   w==;
IronPort-SDR: wu/1FdCw2YV65CMo9b0EorUa8CcBvVXgSirDWWk6tQgmrXum+N7vJrLR7bNy4a8uwRjz7gKbht
 A23EXknS9hOxzaqn7+todVIdzz2QYhaePr4vNqXmt1bnzYYltjqZB2pd+4ud8uAj718HyLe6UX
 E/liIZOQ5P5HgtfxfRJ6wWwssnIXwvAOfBsDOLaQYD8E94Iu5XW7tthPav+jk3g2Ce3GkuZOk9
 KPDhwZ2zmgmKzgFSyhaOMQB1VAR88t4a+GAqZJBOGQS/xkkYR/U+pMAYnFTdvBBLZXiap0NFjU
 nsI=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="157205951"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 12:26:27 +0800
IronPort-SDR: ZTv4s0gS7tJkCUuy+wJ6ts7ngF2V2l53vN+zO3++8wLIh7qqUQ2vxBp0KMdLbhKSKh1w4EQmJN
 YuRQ4NaB8HHjAmWcwWU8mid+gzT8ip3AoXymZ1wyBzJ0jCrNxWzdlRKPmNyCsB2aUShsSOwMUT
 I+FqicBlPo5hqiGF2neHor9g4RslmAiRaLB9hiDyX8L9TP47YUS9YTfZAAWB7T41EYBjKO1/54
 z/KbF3smn7h0RZj+63Gzr1DkdAOlVY89ifxaLfT69NohjyXhThncgKqUL9DrqNLhPezv3Ioh2m
 kvf3YW0atpQ7/5oKa1iXHvWT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 20:11:12 -0800
IronPort-SDR: 360JE/pxU/WTm+DQuRYP/Wcxhe2NZZIaXzgB6Y7msM5etKkm5IaMFTaduy6aftcNhvkD/EsxG9
 HIYwN+k20T3vA7MpRVOx3ZL7utc/8jGRyHFn4Y0G6iE0Bbf8LaY73i+7SsB39vtz4zSWWU0rif
 VnZtlSsA48M6sCboZ63VAsJsD3eqnm59oSFZsj5xGQ3u4VDbn5ROYu9B3vjYpTIcmZ9ZMHrvNk
 dcK0D0EMVTIGylWk+rdyPWUiUZiPepSOjZRtRAtlNktESS7O1sMqQqD2E4Lp2JpS59KfcP/Qf/
 vTs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 20:26:27 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V9 0/9] nvmet: add ZBD backend support
Date:   Mon, 11 Jan 2021 20:26:14 -0800
Message-Id: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
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

All the testcases are passing for the ZoneFS where ZBD exported with
NVMeOF backed by null_blk ZBD and null_blk ZBD without NVMeOF. Adding
test result below.

Note: This patch-series is based on the earlier posted patch series :-

[PATCH V2 0/4] nvmet: admin-cmd related cleanups and a fix
http://lists.infradead.org/pipermail/linux-nvme/2021-January/021729.html

-ck

Changes from V8:-

1. Rebase and retest on latest nvme-5.11.
2. Export ctrl->cap csi support only if CONFIG_BLK_DEV_ZONE is set.
3. Add a fix to admin ns-desc list handler for handling default csi.

Changes from V7:-

1. Just like what block layer provides an API for bio_init(), provide
   nvmet_bio_init() such that we move bio initialization code for
   nvme-read-write commands from bdev and zns backend into the centralize
   helper. 
2. With bdev/zns/file now we have three backends that are checking for
   req->sg_cnt and calling nvmet_check_transfer_len() before we process
   nvme-read-write commands. Move this duplicate code from three
   backeneds into the helper.
3. Export and use nvmet_bio_done() callback in
   nvmet_execute_zone_append() instead of the open coding the function.
   This also avoids code duplication for bio & request completion with
   error log page update.
4. Add zonefs tests log for dm linear device created on the top of SMR HDD
   exported with NVMeOF ZNS backend with the help of nvme-loop.

Changes from V6:-

1. Instead of calling report zones to find conventional zones in the 
   loop use the loop inside LLD blkdev_report_zones()->LLD_report_zones,
   that also simplifies the report zone callback.
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

Chaitanya Kulkarni (9):
  block: export bio_add_hw_pages()
  nvmet: add lba to sect conversion helpers
  nvmet: add NVM command set identifier support
  nvmet: add ZBD over ZNS backend support
  nvmet: add bio get helper for different backends
  nvmet: add bio init helper for different backends
  nvmet: add bio put helper for different backends
  nvmet: add common I/O length check helper
  nvmet: call nvmet_bio_done() for zone append

 block/bio.c                       |   1 +
 block/blk.h                       |   4 -
 drivers/nvme/target/Makefile      |   1 +
 drivers/nvme/target/admin-cmd.c   |  67 ++++--
 drivers/nvme/target/core.c        |  16 +-
 drivers/nvme/target/io-cmd-bdev.c |  67 +++---
 drivers/nvme/target/io-cmd-file.c |   7 +-
 drivers/nvme/target/nvmet.h       |  97 +++++++++
 drivers/nvme/target/passthru.c    |  11 +-
 drivers/nvme/target/zns.c         | 328 ++++++++++++++++++++++++++++++
 include/linux/blkdev.h            |   4 +
 11 files changed, 536 insertions(+), 67 deletions(-)
 create mode 100644 drivers/nvme/target/zns.c

* Zonefs Test log with dm-linear on the top of SMR HDD:-
--------------------------------------------------------------------------------

1. Test Zoned Block Device info :- 
--------------------------------------------------------------------------------

# fdisk  -l /dev/sdh
Disk /dev/sdh: 13.64 TiB, 15000173281280 bytes, 3662151680 sectors
Disk model: HGST HSH721415AL
Units: sectors of 1 * 4096 = 4096 bytes
Sector size (logical/physical): 4096 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
# cat /sys/block/sdh/queue/nr_zones
55880
# cat /sys/block/sdh/queue/zoned
host-managed
# cat /sys/block/sdh/queue/zone_append_max_bytes
688128

2. Creating NVMeOF target backed by dm-linear on the top of ZBD
--------------------------------------------------------------------------------

# ./zbdev.sh 1 dm-zbd
++ NQN=dm-zbd
++ echo '0 29022486528 linear /dev/sdh 274726912' | dmsetup create cksdh
9 directories, 4 files
++ mkdir /sys/kernel/config/nvmet/subsystems/dm-zbd
++ mkdir /sys/kernel/config/nvmet/subsystems/dm-zbd/namespaces/1
++ echo -n /dev/dm-0
++ cat /sys/kernel/config/nvmet/subsystems/dm-zbd/namespaces/1/device_path
/dev/dm-0
++ echo 1
++ mkdir /sys/kernel/config/nvmet/ports/1/
++ echo -n loop
++ echo -n 1
++ ln -s /sys/kernel/config/nvmet/subsystems/dm-zbd /sys/kernel/config/nvmet/ports/1/subsystems/
++ sleep 1
++ echo transport=loop,nqn=dm-zbd
++ sleep 1
++ dmesg -c
[233450.572565] nvmet: adding nsid 1 to subsystem dm-zbd
[233452.269477] nvmet: creating controller 1 for subsystem dm-zbd for NQN nqn.2014-08.org.nvmexpress:uuid:853d7e82-8018-44ce-8784-ab81e7465ad9.
[233452.283352] nvme nvme0: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.
[233452.292805] nvme nvme0: creating 8 I/O queues.
[233452.299210] nvme nvme0: new ctrl: "dm-zbd"

3. dm-linear and backend SMR HDD association :-
--------------------------------------------------------------------------------

# cat /sys/kernel/config/nvmet/subsystems/dm-zbd/namespaces/1/device_path 
/dev/dm-0
# dmsetup ls --tree
 cksdh (252:0)
	 └─ (8:112)
# lsblk | head -3
NAME    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sdh       8:112  0  13.6T  0 disk 
└─cksdh 252:0    0  13.5T  0 dm   

4. NVMeOF controller :- 
--------------------------------------------------------------------------------

# nvme list | tr -s ' ' ' '  
Node SN Model Namespace Usage Format FW Rev  
/dev/nvme0n1 8c6f348dcd64404c Linux 1 14.86 TB / 14.86 TB 4 KiB + 0 B 5.10.0nv

5. Zonefs tests results :-
--------------------------------------------------------------------------------

# ./zonefs-tests.sh /dev/nvme0n1 
Gathering information on /dev/nvme0n1...
zonefs-tests on /dev/nvme0n1:
  55356 zones (0 conventional zones, 55356 sequential zones)
  524288 512B sectors zone size (256 MiB)
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

* Without CONFIG_BLK_DEV_ZONED nvme tests :-
--------------------------------------------------------------------------------

#
# grep -i blk_dev_zoned .config
# CONFIG_BLK_DEV_ZONED is not set
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
#
# cdblktests 
# ./check tests/nvme/
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime    ...  27.640s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.145s  ...  10.147s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.713s  ...  1.712s
nvme/005 (reset local loopback target)                       [not run]
    nvme_core module does not have parameter multipath
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.111s  ...  0.115s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.081s  ...  0.069s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.690s  ...  1.727s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.659s  ...  1.661s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  28.781s  ...  30.166s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  253.831s  ...  238.774s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  40.003s  ...  68.076s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  272.649s  ...  283.720s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  21.772s  ...  21.397s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  21.908s  ...  18.622s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  15.860s  ...  18.313s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  16.470s  ...  18.374s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.665s  ...  1.890s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.681s  ...  1.982s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.645s  ...  1.913s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.648s  ...  1.956s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  2.063s  ...  2.553s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.692s  ...  2.588s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.643s  ...  1.656s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.640s  ...  1.668s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.643s  ...  1.961s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.641s  ...  1.677s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.648s  ...  1.868s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.982s  ...  2.703s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.308s  ...  0.328s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  5.432s  ...  7.495s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.053s  ...  0.046s

* With CONFIG_BLK_DEV_ZONED nvme and zonefs tests on membacked null_blk zoned :-
--------------------------------------------------------------------------------

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
#
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

