Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC94F2CB4F0
	for <lists+linux-block@lfdr.de>; Wed,  2 Dec 2020 07:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgLBGXg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Dec 2020 01:23:36 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:48080 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgLBGXg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 01:23:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606890215; x=1638426215;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+U3GdEDI7ytLsMd0GtYdOsJ0q+8o/7LcYvYBSUjzkp4=;
  b=Gq7wTAhdpP10hk8aztAhK23v3uHVrzQcEyIIh3+SjCIw7npTzhA22qn2
   tFW6FQgf/ousGtCqkQg2yhQlTA4UfeN6lf7Gtbd4EqgAlKvHQ0TBneJsj
   U7f8DXIyhdRR2lxSXCsGzwY0yVmVq8DCh04EiAAucyZQUTcjl5dHx7tKQ
   TvzUpNsO+lkLRxN0+eSgdW2hwe3LkCnBOvhmT/BArN3QnPeALF2whJO8L
   pyZsiFLJGPAcmjjeVe+48mHBNjMra5C0W3gaIDJuPHb2WgsuFkm2m2P/O
   lmD0C56WD1yS3pzeM1MBD+P95cBkNXUo9rLE0uYQNgy49alE+cZVE0UwQ
   Q==;
IronPort-SDR: 4H9NakpZyE6NkGKQkftP//RahuW6puX2zzytsJ08dJD5ZDOQsqNV6B6Hr8CMB1nwt72bvXCZmC
 UO5CiLLwFobKxIvH+y6WjUPNc/JYW4H7HGKYsnvCPzp6tgdVkp1rkSmxRJk+C5riZmMXgXmdrU
 sKs5rzI8kBTrhFY8fwjMqzbytLc3KlEuQ3jkyLmE4WFki8ma4m0aTS993Vz33gJveOUvG9riqI
 J5vO7b3YRhDLnyoOR3mRdqxzYthpS1omK4sv7IAHxcWevkk8MqYl9AZOwnXdzzVYXPWc5jFi1T
 Aqg=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; 
   d="scan'208";a="264126049"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 14:22:30 +0800
IronPort-SDR: ISZC3I7TOoGKLZflj4OMP/elqYDrvLhTRduqzGbk1QCFX900OpjR1fukpa/2B07ME061whgpr1
 wyEGRV0ZThxtGbweYyjMx4+h48sx9RMLE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 22:08:05 -0800
IronPort-SDR: 5gaJgnyq4tJtGlrJGLKj6SIPZVek34FGwWDOHm6IAhCvvCrlVHLCVT8RUdprTfoNOIAj2emDiY
 opmpLnYz9k3w==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Dec 2020 22:22:30 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        johannes.thumshirn@wdc.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V4 0/9] nvmet: add ZBD backend support
Date:   Tue,  1 Dec 2020 22:22:18 -0800
Message-Id: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
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
handle the ZBD devices which are not NVMe protocol compliant yet provide
NVMe ZNS interface.

This adds support to export the ZBDs (which are not NVMe drives) to host
the from target via NVMeOF using the host side ZNS interface.

The patch series is generated in bottom-top manner where, it first adds
prep patch and ZNS command-specific handlers on the top of genblk and 
updates the data structures, then one by one it wires up the admin cmds
in the order host calls them in namespace initializing sequence. Once
everything is ready, it wires-up the I/O command handlers. See below for 
patch-series overview.

All the testcases are passing for the ZoneFS with ZBD exported with NVMeOF
backed by null_blk ZBD and null_blk ZBD without NVMeOF.

Please consider this for nvme-5.11.

Regards,
Chaitanya

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
  block: allow bvec for zone append get pages
  nvmet: add ZNS support for bdev-ns
  nvmet: trim down id-desclist to use req->ns
  nvmet: add NVME_CSI_ZNS in ns-desc for zbdev
  nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
  nvmet: add cns-cs-ns in id-ctrl for ZNS bdev
  nvmet: add zns cmd effects to support zbdev
  nvmet: add zns bdev config support
  nvmet: add ZNS based I/O cmds handlers

 block/bio.c                       |   2 -
 drivers/nvme/target/Makefile      |   2 +-
 drivers/nvme/target/admin-cmd.c   |  38 ++-
 drivers/nvme/target/io-cmd-bdev.c |  12 +
 drivers/nvme/target/io-cmd-file.c |   2 +-
 drivers/nvme/target/nvmet.h       |  19 ++
 drivers/nvme/target/zns.c         | 417 ++++++++++++++++++++++++++++++
 7 files changed, 475 insertions(+), 17 deletions(-)
 create mode 100644 drivers/nvme/target/zns.c


Test Results :-
# nvme zns id-ctrl /dev/nvme
NVMe ZNS Identify Controller:
zasl    : 4
#
#
# nvme zns id-ctrl /dev/nvme1n1
NVMe ZNS Identify Controller:
zasl    : 4
# nvme zns id-ns /dev/nvme1n1
#
#
ZNS Command Set Identify Namespace:
zoc     : 0
ozcs    : 0
mar     : 0
mor     : 0
rrl     : 0
frl     : 0
lbafe  0: zsze:0x10000 zdes:0 (in use)
# 
#
#
# lsblk | grep null
nullb0            252:0    0    1G  0 disk 
# 
# 
# 
# ./zonefs-tests.sh /dev/nullb0 
Gathering information on /dev/nullb0...
zonefs-tests on /dev/nullb0:
  4 zones (0 conventional zones, 4 sequential zones)
  524288 512B sectors zone size (256 MiB)
  0 max open zones
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
# 
# 
# 
# ./zonefs-tests.sh /dev/nvme1n1 
Gathering information on /dev/nvme1n1...
zonefs-tests on /dev/nvme1n1:
  4 zones (0 conventional zones, 4 sequential zones)
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
-- 
2.22.1

