Return-Path: <linux-block+bounces-24031-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4150EAFF840
	for <lists+linux-block@lfdr.de>; Thu, 10 Jul 2025 06:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2A75A34F2
	for <lists+linux-block@lfdr.de>; Thu, 10 Jul 2025 04:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67A02036FF;
	Thu, 10 Jul 2025 04:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Sxm2vCtj"
X-Original-To: linux-block@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94795469D
	for <linux-block@vger.kernel.org>; Thu, 10 Jul 2025 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752123347; cv=none; b=dQnJw9ovr4fMBFwGNtfGxJEOX556lJOuJ+EZ6T9bjwAkJR/lDD+0qj+L0F896GupQN7Fz8x7BceKOuyWlxkiDJOTecTBn7DiTv2EhaH6HVbhrg/iq60sSkfTy9NWpyTWOCCM4VX2oUb8VYSv3WU4VQHy/kX7GN4K5iTBfaqUY5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752123347; c=relaxed/simple;
	bh=W4wQogyCCWUQUkDwuNUovKZNbuJMF25aaFpWid01Dcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LLbSR6zTArBLHAiN2iAw+cnNdrcW86suBx6AnjxZFyTdnrOAd2efa+OO+d+KNZhOLw5bjvVtNNj9yj10aZEEGc7QgvXZOxOesdy4ZWqgA951ILgRb3USZTCy828pVdJ3A+cxdeZbaCq+deK6OvFYO6zi+DVNm+mrdidOX991fMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Sxm2vCtj; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752123345; x=1783659345;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W4wQogyCCWUQUkDwuNUovKZNbuJMF25aaFpWid01Dcc=;
  b=Sxm2vCtjy6pUnQVG4rvVx5dgQE3CNYlLhbRh/xVs2bEh8BxdMe895kAW
   TEfwIcJ841yH8TFXP8qZ8RLJhUW0BwceSDtPaioMNXVl2AvuqDYkcEMXt
   58ihDOJuh3YRitkHdESoFyMWExvNpIV3TdUaPHqJ8jELYdGn4YNaENtAF
   RlBDzDABRIOfkuDcqYaK8MEdEaf0KpE+oBvweWwdD53kgTvPrrWTfTMZo
   8Y5cKpeqXKGcHr1Wt/+ewRGSEaKZb8eZjFHLNG52duIAFhEDZ2fSullWK
   eJFs+LMfpHxopc3UM8l6n/kkHknNw9ZaCDzaOiWpyn8cbxwHlFVwn3mJf
   Q==;
X-CSE-ConnectionGUID: yzu/ED4oTLmhJG92JGyhAQ==
X-CSE-MsgGUID: kcRt8D3zRtO+HGBW1bD1YA==
X-IronPort-AV: E=Sophos;i="6.16,299,1744041600"; 
   d="scan'208";a="87384229"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2025 12:55:39 +0800
IronPort-SDR: 686f3933_6KFtUGdnWHaThGu7XflGGbqf2KD8ef6pM9E45REMpqBZzVR
 fBNni1nZZOed/Us474UJSsUYNOI1xhzEWu64KPQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2025 20:53:23 -0700
WDCIronportException: Internal
Received: from wdap-zxfl3uag54.ad.shared (HELO shinmob.flets-east.jp) ([10.224.163.73])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Jul 2025 21:55:38 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3] md/002: add atomic write tests for md/stacked devices
Date: Thu, 10 Jul 2025 13:55:37 +0900
Message-ID: <20250710045537.70498-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alan Adamson <alan.adamson@oracle.com>

Add a new test (md/002) to verify atomic write support for MD devices
(RAID 0, 1, and 10) stacked on top of SCSI devices using scsi_debug with
atomic write emulation enabled.

This test validates that atomic write sysfs attributes are correctly
propagated through MD layers, and that pwritev2() with RWF_ATOMIC
behaves as expected on these devices.

Specifically, the test checks:
    - That atomic write attributes in /sys/block/.../queue are consistent
      between MD and underlying SCSI devices
    - That atomic write limits are respected in user-space via xfs_io
    - That statx reports accurate atomic_write_unit_{min,max} values
    - That invalid writes (too small or too large) fail as expected
    - That chunk size affects max atomic write limits (for RAID 0/10)

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
This is the repost of the patch authored by Alan [1].

[1] https://lore.kernel.org/linux-block/20250605225725.3352708-1-alan.adamson@oracle.com/

Changes from v1:
* Replaced spaces for indent with tabs
* Removed unnecessary group_requires() call

Changes from v2:
* Added test for md_sysfs_atomic_unit_max_bytes divisible into md_chunk_size
* Added a Reviewed-by tag

 tests/md/002     | 245 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/md/002.out |  43 +++++++++
 2 files changed, 288 insertions(+)
 create mode 100755 tests/md/002
 create mode 100644 tests/md/002.out

diff --git a/tests/md/002 b/tests/md/002
new file mode 100755
index 0000000..79c0d15
--- /dev/null
+++ b/tests/md/002
@@ -0,0 +1,245 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Oracle and/or its affiliates
+#
+# Test SCSI Atomic Writes with MD devices
+
+. tests/scsi/rc
+. common/scsi_debug
+. common/xfs
+
+DESCRIPTION="test md atomic writes"
+QUICK=1
+
+requires() {
+	_have_kver 6 14 0
+	_have_program mdadm
+	_have_driver scsi_debug
+	_have_xfs_io_atomic_write
+}
+
+test() {
+	local scsi_debug_atomic_wr_max_length
+	local scsi_debug_atomic_wr_gran
+	local scsi_sysfs_atomic_max_bytes
+	local scsi_sysfs_atomic_unit_max_bytes
+	local scsi_sysfs_atomic_unit_min_bytes
+	local md_atomic_max_bytes
+	local md_atomic_min_bytes
+	local md_sysfs_max_hw_sectors_kb
+	local md_max_hw_bytes
+	local md_chunk_size
+	local md_sysfs_logical_block_size
+	local md_sysfs_atomic_max_bytes
+	local md_sysfs_atomic_unit_max_bytes
+	local md_sysfs_atomic_unit_min_bytes
+	local bytes_to_write
+	local bytes_written
+	local test_desc
+	local scsi_0
+	local scsi_1
+	local scsi_2
+	local scsi_3
+	local scsi_dev_sysfs
+	local md_dev
+	local md_dev_sysfs
+	local scsi_debug_params=(
+		delay=0
+		atomic_wr=1
+		num_tgts=1
+		add_host=4
+		per_host_store=true
+	)
+
+	echo "Running ${TEST_NAME}"
+
+	if ! _configure_scsi_debug "${scsi_debug_params[@]}"; then
+		return 1
+	fi
+
+	scsi_0="${SCSI_DEBUG_DEVICES[0]}"
+	scsi_1="${SCSI_DEBUG_DEVICES[1]}"
+	scsi_2="${SCSI_DEBUG_DEVICES[2]}"
+	scsi_3="${SCSI_DEBUG_DEVICES[3]}"
+
+	scsi_dev_sysfs="/sys/block/${scsi_0}"
+	scsi_sysfs_atomic_max_bytes=$(< "${scsi_dev_sysfs}"/queue/atomic_write_max_bytes)
+	scsi_sysfs_atomic_unit_max_bytes=$(< "${scsi_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
+	scsi_sysfs_atomic_unit_min_bytes=$(< "${scsi_dev_sysfs}"/queue/atomic_write_unit_min_bytes)
+	scsi_debug_atomic_wr_max_length=$(< /sys/module/scsi_debug/parameters/atomic_wr_max_length)
+	scsi_debug_atomic_wr_gran=$(< /sys/module/scsi_debug/parameters/atomic_wr_gran)
+
+	for raid_level in 0 1 10; do
+		if [ "$raid_level" = 10 ]
+		then
+			echo y | mdadm --create /dev/md/blktests_md --level=$raid_level \
+				--raid-devices=4 --force /dev/"${scsi_0}" /dev/"${scsi_1}" \
+				/dev/"${scsi_2}" /dev/"${scsi_3}" 2> /dev/null 1>&2
+		else
+			echo y | mdadm --create /dev/md/blktests_md --level=$raid_level \
+				--raid-devices=2 --force \
+				/dev/"${scsi_0}" /dev/"${scsi_1}" 2> /dev/null 1>&2
+		fi
+
+		md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
+		md_dev_sysfs="/sys/devices/virtual/block/${md_dev}"
+
+		md_sysfs_logical_block_size=$(< "${md_dev_sysfs}"/queue/logical_block_size)
+		md_sysfs_max_hw_sectors_kb=$(< "${md_dev_sysfs}"/queue/max_hw_sectors_kb)
+		md_max_hw_bytes=$(( "$md_sysfs_max_hw_sectors_kb" * 1024 ))
+		md_sysfs_atomic_max_bytes=$(< "${md_dev_sysfs}"/queue/atomic_write_max_bytes)
+		md_sysfs_atomic_unit_max_bytes=$(< "${md_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
+		md_sysfs_atomic_unit_min_bytes=$(< "${md_dev_sysfs}"/queue/atomic_write_unit_min_bytes)
+		md_atomic_max_bytes=$(( "$scsi_debug_atomic_wr_max_length" * "$md_sysfs_logical_block_size" ))
+		md_atomic_min_bytes=$(( "$scsi_debug_atomic_wr_gran" * "$md_sysfs_logical_block_size" ))
+
+		test_desc="TEST 1 RAID $raid_level - Verify md sysfs atomic attributes matches scsi"
+		if [ "$md_sysfs_atomic_unit_max_bytes" = "$scsi_sysfs_atomic_unit_max_bytes" ] &&
+			[ "$md_sysfs_atomic_unit_min_bytes" = "$scsi_sysfs_atomic_unit_min_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $md_sysfs_atomic_unit_max_bytes - $scsi_sysfs_atomic_unit_max_bytes -" \
+				"$md_sysfs_atomic_unit_min_bytes - $scsi_sysfs_atomic_unit_min_bytes "
+		fi
+
+		test_desc="TEST 2 RAID $raid_level - Verify sysfs atomic attributes"
+		if [ "$md_max_hw_bytes" -ge "$md_sysfs_atomic_max_bytes" ] &&
+			[ "$md_sysfs_atomic_max_bytes" -ge "$md_sysfs_atomic_unit_max_bytes" ] &&
+			[ "$md_sysfs_atomic_unit_max_bytes" -ge "$md_sysfs_atomic_unit_min_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $md_max_hw_bytes - $md_sysfs_max_hw_sectors_kb -" \
+				"$md_sysfs_atomic_max_bytes - $md_sysfs_atomic_unit_max_bytes -" \
+				"$md_sysfs_atomic_unit_min_bytes"
+		fi
+
+		test_desc="TEST 3 RAID $raid_level - Verify md sysfs_atomic_max_bytes is less than or equal "
+		test_desc+="scsi sysfs_atomic_max_bytes"
+		if [ "$md_sysfs_atomic_max_bytes" -le "$scsi_sysfs_atomic_max_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $md_sysfs_atomic_max_bytes - $scsi_sysfs_atomic_max_bytes"
+		fi
+
+		test_desc="TEST 4 RAID $raid_level - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length"
+		if (("$md_sysfs_atomic_unit_max_bytes" <= "$md_atomic_max_bytes"))
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $md_sysfs_atomic_unit_max_bytes - $md_atomic_max_bytes"
+		fi
+
+		test_desc="TEST 5 RAID $raid_level - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran"
+		if [ "$md_sysfs_atomic_unit_min_bytes" = "$md_atomic_min_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $md_sysfs_atomic_unit_min_bytes - $md_atomic_min_bytes"
+		fi
+
+		test_desc="TEST 6 RAID $raid_level - check statx stx_atomic_write_unit_min"
+		statx_atomic_min=$(run_xfs_io_xstat /dev/"$md_dev" "stat.atomic_write_unit_min")
+		if [ "$statx_atomic_min" = "$md_atomic_min_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $statx_atomic_min - $md_atomic_min_bytes"
+		fi
+
+		test_desc="TEST 7 RAID $raid_level - check statx stx_atomic_write_unit_max"
+		statx_atomic_max=$(run_xfs_io_xstat /dev/"$md_dev" "stat.atomic_write_unit_max")
+		if [ "$statx_atomic_max" = "$md_sysfs_atomic_unit_max_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $statx_atomic_max - $md_sysfs_atomic_unit_max_bytes"
+		fi
+
+		test_desc="TEST 8 RAID $raid_level - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with "
+		test_desc+="RWF_ATOMIC flag - pwritev2 should be succesful"
+		bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$md_sysfs_atomic_unit_max_bytes")
+		if [ "$bytes_written" = "$md_sysfs_atomic_unit_max_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $bytes_written - $md_sysfs_atomic_unit_max_bytes"
+		fi
+
+		test_desc="TEST 9 RAID $raid_level - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 "
+		test_desc+="bytes with RWF_ATOMIC flag - pwritev2 should not be succesful"
+		bytes_to_write=$(( "${md_sysfs_atomic_unit_max_bytes}" + 512 ))
+		bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$bytes_to_write")
+		if [ "$bytes_written" = "" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $bytes_written - $bytes_to_write"
+		fi
+
+		test_desc="TEST 10 RAID $raid_level - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes "
+		test_desc+="with RWF_ATOMIC flag - pwritev2 should be succesful"
+		bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$md_sysfs_atomic_unit_min_bytes")
+		if [ "$bytes_written" = "$md_sysfs_atomic_unit_min_bytes" ]
+		then
+			echo "$test_desc - pass"
+		else
+			echo "$test_desc - fail $bytes_written - $md_atomic_min_bytes"
+		fi
+
+		bytes_to_write=$(( "${md_sysfs_atomic_unit_min_bytes}" - "${md_sysfs_logical_block_size}" ))
+		test_desc="TEST 11 RAID $raid_level - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 "
+		test_desc+="bytes with RWF_ATOMIC flag - pwritev2 should fail"
+		if [ "$bytes_to_write" = 0 ]
+		then
+			echo "$test_desc - pass"
+		else
+			bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$bytes_to_write")
+			if [ "$bytes_written" = "" ]
+			then
+				echo "$test_desc - pass"
+			else
+				echo "$test_desc - fail $bytes_written - $bytes_to_write"
+			fi
+		fi
+
+		mdadm --stop /dev/md/blktests_md  2> /dev/null 1>&2
+
+		if [ "$raid_level" = 0 ] || [ "$raid_level" = 10 ]
+		then
+			md_chunk_size=$(( "$scsi_sysfs_atomic_unit_max_bytes" / 2048))
+
+			if [ "$raid_level" = 0 ]
+			then
+				echo y | mdadm --create /dev/md/blktests_md --level=$raid_level \
+					--raid-devices=2 --chunk="${md_chunk_size}"K --force \
+					/dev/"${scsi_0}" /dev/"${scsi_1}" 2> /dev/null 1>&2
+			else
+				echo y | mdadm --create /dev/md/blktests_md --level=$raid_level \
+					--raid-devices=4 --chunk="${md_chunk_size}"K --force \
+					/dev/"${scsi_0}" /dev/"${scsi_1}" \
+					/dev/"${scsi_2}" /dev/"${scsi_3}" 2> /dev/null 1>&2
+			fi
+
+			md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
+			md_dev_sysfs="/sys/devices/virtual/block/${md_dev}"
+			md_sysfs_atomic_unit_max_bytes=$(< "${md_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
+			test_desc="TEST 12 RAID $raid_level - Verify chunk size "
+			if [ "$md_chunk_size" -le "$md_sysfs_atomic_unit_max_bytes" ] && \
+				   (( md_sysfs_atomic_unit_max_bytes % md_chunk_size == 0 ))
+			then
+				echo "$test_desc - pass"
+			else
+				echo "$test_desc - fail $md_chunk_size - $md_sysfs_atomic_unit_max_bytes"
+			fi
+
+			mdadm --quiet --stop /dev/md/blktests_md
+		fi
+	done
+
+	_exit_scsi_debug
+
+	echo "Test complete"
+}
diff --git a/tests/md/002.out b/tests/md/002.out
new file mode 100644
index 0000000..6b0a431
--- /dev/null
+++ b/tests/md/002.out
@@ -0,0 +1,43 @@
+Running md/002
+TEST 1 RAID 0 - Verify md sysfs atomic attributes matches scsi - pass
+TEST 2 RAID 0 - Verify sysfs atomic attributes - pass
+TEST 3 RAID 0 - Verify md sysfs_atomic_max_bytes is less than or equal scsi sysfs_atomic_max_bytes - pass
+TEST 4 RAID 0 - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length - pass
+TEST 5 RAID 0 - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran - pass
+TEST 6 RAID 0 - check statx stx_atomic_write_unit_min - pass
+TEST 7 RAID 0 - check statx stx_atomic_write_unit_max - pass
+TEST 8 RAID 0 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
+pwrite: Invalid argument
+TEST 9 RAID 0 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 RAID 0 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
+pwrite: Invalid argument
+TEST 11 RAID 0 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 12 RAID 0 - Verify chunk size  - pass
+TEST 1 RAID 1 - Verify md sysfs atomic attributes matches scsi - pass
+TEST 2 RAID 1 - Verify sysfs atomic attributes - pass
+TEST 3 RAID 1 - Verify md sysfs_atomic_max_bytes is less than or equal scsi sysfs_atomic_max_bytes - pass
+TEST 4 RAID 1 - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length - pass
+TEST 5 RAID 1 - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran - pass
+TEST 6 RAID 1 - check statx stx_atomic_write_unit_min - pass
+TEST 7 RAID 1 - check statx stx_atomic_write_unit_max - pass
+TEST 8 RAID 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
+pwrite: Invalid argument
+TEST 9 RAID 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 RAID 1 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
+pwrite: Invalid argument
+TEST 11 RAID 1 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 RAID 10 - Verify md sysfs atomic attributes matches scsi - pass
+TEST 2 RAID 10 - Verify sysfs atomic attributes - pass
+TEST 3 RAID 10 - Verify md sysfs_atomic_max_bytes is less than or equal scsi sysfs_atomic_max_bytes - pass
+TEST 4 RAID 10 - check sysfs atomic_write_unit_max_bytes <= scsi_debug atomic_wr_max_length - pass
+TEST 5 RAID 10 - check sysfs atomic_write_unit_min_bytes = scsi_debug atomic_wr_gran - pass
+TEST 6 RAID 10 - check statx stx_atomic_write_unit_min - pass
+TEST 7 RAID 10 - check statx stx_atomic_write_unit_max - pass
+TEST 8 RAID 10 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
+pwrite: Invalid argument
+TEST 9 RAID 10 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + 512 bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 RAID 10 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should be succesful - pass
+pwrite: Invalid argument
+TEST 11 RAID 10 - perform a pwritev2 with a size of sysfs_atomic_unit_min_bytes - 512 bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 12 RAID 10 - Verify chunk size  - pass
+Test complete
-- 
2.50.0


