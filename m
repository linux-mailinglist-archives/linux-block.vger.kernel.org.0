Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE152E6CDA
	for <lists+linux-block@lfdr.de>; Tue, 29 Dec 2020 01:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgL2AqW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 28 Dec 2020 19:46:22 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59439 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgL2AqW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Dec 2020 19:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1609202782; x=1640738782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ezL6V6NMqQIWE2QVha8BmyK8DY1N7+/8nwnAW62YYlo=;
  b=pYc5dokmJzRqybzCXejWyM2A8a0sqW3bDRtiG61PuapQCCTuT5z3w/fD
   oXCuL6jwum6iMBXrcRYLSTErARpYcPc5pdAbOPUY/LN7Rc5eTqZOX4cv0
   75LZnoFwS2W9lxIvA/P3KiXAJlghh9LEYQcczHEoXuk3DUmKGEqt0YA2C
   WsST4qcbpFQgJWP4YTYiKcdmkCanif9Vc4+pJpB/+5+eZ5t7sVqVXda+W
   I5q7r/r7xwvHHdLBAUrDm3FFpmHySwaPp73YtSW0X7/QWvgCHkmxqqwAR
   iUT5QPeLm7IhE+sk8JaiudnXv6HW3Dc9chDPS4faPUM4az4uSL4q+HOlg
   g==;
IronPort-SDR: qTwLAzZXUsG6sB3KALzqlvHGKJ74RUqHByvNlLvg7PL2saKUmChSvUtEjGYF56sr0GJJBtiMYc
 qLUgFCt0iDPrIBqQKl6acL8/ZySsdgEnDF1jujMvXmssaAL1lIGaiZHHrinhI8hbO3LGCRfHkk
 UkvrBeJmqfOWCoCL+E7A8/sYVLW9zLa/OB4TrolZ/XFXtEiICtlay3QW2HRqjEQHTzrJ7L31y9
 pk++eoAwb1SPLHlAPsAdzEFGBCsEumuLWLRVF7jvG0c8+STnZScLvo2Io639BIu7A30YLYxsnx
 v58=
X-IronPort-AV: E=Sophos;i="5.78,456,1599494400"; 
   d="scan'208";a="156192851"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Dec 2020 08:44:37 +0800
IronPort-SDR: Jtgk4xggTmENZPvnbuI7vd+jzyRlrNiEB/0iplmV1QrbSgd1VJ5O0/VGhTW32+3Kv9PPX6N/cl
 Qqn7L5yZhXz7jfldWjQ0WnsG06EkBK+8gNq9tUq5YajxOxna7OfZhUipVjd1v2jNKlo+xsrfLF
 FDIQ2aGdBX8UjsqRQxzFY/ytVD1knxRQe0gQXPM2D1akkZjo3k0Vi/uUGXpskDiUQaR2TeKjoo
 mmTT47EYXSoseWc12rWIr/fe0W8m2q1nvmB2qprFzWsis5WFgf6t1y3T8xOVOBIQH+8RQ6/bhA
 l5xNcWiJI+2Bbghsjg7Rnrf9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 16:29:40 -0800
IronPort-SDR: 1Ti+oaVHmw+W+nGgackVSCDnja8seKkV24ZUrlyYl2pvL0EJ4ZhUF0WoQwYrS2JNvXKhXSsqXy
 9E1OOXvpWgJzopRPgzkOmueSMvU8bFSJizV46i7LmuBW/K2+Iv5R+3AbWujRNSQBGwMmoMOC1y
 4LkqjhC5cViAPBXGRdjl99+Ny2eNxsF+J8GcMfMrLESJx0dS8xHc1xro0tbRd8VW1jnXlZD6cH
 eTPngfOLRpIf9sJ8Dg68Q1aUH8u0KZ3O5RJ4V1fP2Zx63x2mwztqczXDAloTceLKMKFvwCckgG
 UVY=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com ([10.149.52.189])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Dec 2020 16:44:36 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3 1/2] common/rc: Check both max_active_zones and max_open_zones
Date:   Tue, 29 Dec 2020 09:44:33 +0900
Message-Id: <20201229004434.927644-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201229004434.927644-1-shinichiro.kawasaki@wdc.com>
References: <20201229004434.927644-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Linux kernel 5.9 introduced new sysfs attributes max_active_zones and
max_open_zones for zoned block devices. Max_open_zones is the limit of
number of zones in open status. Max_active_zones is the limit of number
of zones in open or closed status. Currently, the helper function
_test_dev_max_active_zones() checks only max_active_zones, but it is not
enough. When the device has max_open_zones, check for max_active_zones
can not avoid the errors for write operations.

To avoid the error, improve the function _test_dev_max_active_zones() to
check the limits both. Rename it to _test_dev_max_open_active_zones().
When one of the limits is available for the test target device, return
it. If both limits are available, return smaller limit.

Also modify block/004 and zbd/003 to call the renamed helper function
and update comment description.

Fixes: e6981bb2d9ce ("common/rc: Add _test_dev_max_active_zones() helper function")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 common/rc       | 19 ++++++++++++++++---
 tests/block/004 |  2 +-
 tests/zbd/003   |  6 +++---
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/common/rc b/common/rc
index d396fb5..a837542 100644
--- a/common/rc
+++ b/common/rc
@@ -280,11 +280,24 @@ _test_dev_is_partition() {
 	[[ -n ${TEST_DEV_PART_SYSFS} ]]
 }
 
-_test_dev_max_active_zones() {
+# Return max open zones or max active zones of the test target device.
+# If the device has both, return smaller value.
+_test_dev_max_open_active_zones() {
+	local -i moz=0
+	local -i maz=0
+
+	if [[ -r "${TEST_DEV_SYSFS}/queue/max_open_zones" ]]; then
+		moz=$(_test_dev_queue_get max_open_zones)
+	fi
+
 	if [[ -r "${TEST_DEV_SYSFS}/queue/max_active_zones" ]]; then
-		_test_dev_queue_get max_active_zones
+		maz=$(_test_dev_queue_get max_active_zones)
+	fi
+
+	if ((!moz)) || ((maz && maz < moz)); then
+		echo "${maz}"
 	else
-		echo 0
+		echo "${moz}"
 	fi
 }
 
diff --git a/tests/block/004 b/tests/block/004
index 6eff6ce..a7cec95 100755
--- a/tests/block/004
+++ b/tests/block/004
@@ -26,7 +26,7 @@ test_device() {
 	if _test_dev_is_zoned; then
 		_test_dev_queue_set scheduler deadline
 		opts+=("--direct=1" "--zonemode=zbd")
-		opts+=("--max_open_zones=$(_test_dev_max_active_zones)")
+		opts+=("--max_open_zones=$(_test_dev_max_open_active_zones)")
 	fi
 
 	FIO_PERF_FIELDS=("write iops")
diff --git a/tests/zbd/003 b/tests/zbd/003
index 1e92e81..7f4fa2c 100755
--- a/tests/zbd/003
+++ b/tests/zbd/003
@@ -30,10 +30,10 @@ test_device() {
 
 	echo "Running ${TEST_NAME}"
 
-	# When the test device has max_active_zone limit, reset all zones. This
-	# ensures the write operations in this test case do not open zones
+	# When the test device has max_open/active_zones limit, reset all zones.
+	# This ensures the write operations in this test case do not open zones
 	# beyond the limit.
-	(($(_test_dev_max_active_zones))) && blkzone reset "${TEST_DEV}"
+	(($(_test_dev_max_open_active_zones))) && blkzone reset "${TEST_DEV}"
 
 	# Get physical block size as dd block size to meet zoned block device
 	# requirement
-- 
2.28.0

