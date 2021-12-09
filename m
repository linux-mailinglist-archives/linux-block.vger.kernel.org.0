Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5C546DF96
	for <lists+linux-block@lfdr.de>; Thu,  9 Dec 2021 01:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241561AbhLIAnp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 8 Dec 2021 19:43:45 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:49318 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241329AbhLIAnf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Dec 2021 19:43:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1940FCE241C;
        Thu,  9 Dec 2021 00:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7185C341CA;
        Thu,  9 Dec 2021 00:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639010399;
        bh=LcRULFDl6YUhiE/QDw/ugAUBdimroPYiC5+uQNSitts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XIogTA/wQRzTRijhhnLcju/5gJOlFT8ipwOwTyldhJA9xDeSRFS+BusNacD1Tkxhg
         B3gtXZKjZPK+Kg8k4GZZJgVgrt0NrqcQ9zbXFz7SrX0gkkJVSD9D3uAmY8pKmB0Zwr
         QpQb+K/bKueycfWGzg2yygUE5rUTi7ONRST8WET1zgq2RuHP5ZicNkFU2B73yCeDMY
         ussuXRxhwUp08DOCAXmonlj1KQLGoQy+FEmngclo+aK782D1pFo6sdtza2HckngBds
         co51LAvP4XJtzK2SsqF+7FzkobGJ7K44klIFl2b5Hs4BimswM76XoIXNUTJM1iUjA3
         maGXqxe6u75sA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 2/8] docs: sysfs-block: sort alphabetically
Date:   Wed,  8 Dec 2021 16:38:27 -0800
Message-Id: <20211209003833.6396-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209003833.6396-1-ebiggers@kernel.org>
References: <20211209003833.6396-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Sort the documentation for the files alphabetically by file path so that
there is a logical order and it's clear where to add new files.

With two small exceptions, this patch doesn't change the documentation
itself and just reorders it:

- In /sys/block/<disk>/<part>/stat, I replaced <part> with <partition>
  to be consistent with the other files.
- The description for /sys/block/<disk>/<part>/stat referred to another
  file "above", which I reworded.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/ABI/stable/sysfs-block | 385 ++++++++++++++-------------
 1 file changed, 203 insertions(+), 182 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index b16b0c45a272e..9febd53a5ebe8 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -1,31 +1,37 @@
-What:		/sys/block/<disk>/stat
-Date:		February 2008
-Contact:	Jerome Marchand <jmarchan@redhat.com>
+What:		/sys/block/<disk>/alignment_offset
+Date:		April 2009
+Contact:	Martin K. Petersen <martin.petersen@oracle.com>
 Description:
-		The /sys/block/<disk>/stat files displays the I/O
-		statistics of disk <disk>. They contain 11 fields:
+		Storage devices may report a physical block size that is
+		bigger than the logical block size (for instance a drive
+		with 4KB physical sectors exposing 512-byte logical
+		blocks to the operating system).  This parameter
+		indicates how many bytes the beginning of the device is
+		offset from the disk's natural alignment.
 
-		==  ==============================================
-		 1  reads completed successfully
-		 2  reads merged
-		 3  sectors read
-		 4  time spent reading (ms)
-		 5  writes completed
-		 6  writes merged
-		 7  sectors written
-		 8  time spent writing (ms)
-		 9  I/Os currently in progress
-		10  time spent doing I/Os (ms)
-		11  weighted time spent doing I/Os (ms)
-		12  discards completed
-		13  discards merged
-		14  sectors discarded
-		15  time spent discarding (ms)
-		16  flush requests completed
-		17  time spent flushing (ms)
-		==  ==============================================
 
-		For more details refer Documentation/admin-guide/iostats.rst
+What:		/sys/block/<disk>/discard_alignment
+Date:		May 2011
+Contact:	Martin K. Petersen <martin.petersen@oracle.com>
+Description:
+		Devices that support discard functionality may
+		internally allocate space in units that are bigger than
+		the exported logical block size. The discard_alignment
+		parameter indicates how many bytes the beginning of the
+		device is offset from the internal allocation unit's
+		natural alignment.
+
+
+What:		/sys/block/<disk>/diskseq
+Date:		February 2021
+Contact:	Matteo Croce <mcroce@microsoft.com>
+Description:
+		The /sys/block/<disk>/diskseq files reports the disk
+		sequence number, which is a monotonically increasing
+		number assigned to every drive.
+		Some devices, like the loop device, refresh such number
+		every time the backing file is changed.
+		The value type is 64 bit unsigned.
 
 
 What:		/sys/block/<disk>/inflight
@@ -44,26 +50,12 @@ Description:
 		and for SCSI device also its queue_depth.
 
 
-What:		/sys/block/<disk>/diskseq
-Date:		February 2021
-Contact:	Matteo Croce <mcroce@microsoft.com>
-Description:
-		The /sys/block/<disk>/diskseq files reports the disk
-		sequence number, which is a monotonically increasing
-		number assigned to every drive.
-		Some devices, like the loop device, refresh such number
-		every time the backing file is changed.
-		The value type is 64 bit unsigned.
-
-
-What:		/sys/block/<disk>/<part>/stat
-Date:		February 2008
-Contact:	Jerome Marchand <jmarchan@redhat.com>
+What:		/sys/block/<disk>/integrity/device_is_integrity_capable
+Date:		July 2014
+Contact:	Martin K. Petersen <martin.petersen@oracle.com>
 Description:
-		The /sys/block/<disk>/<part>/stat files display the
-		I/O statistics of partition <part>. The format is the
-		same as the above-written /sys/block/<disk>/stat
-		format.
+		Indicates whether a storage device is capable of storing
+		integrity metadata. Set if the device is T10 PI-capable.
 
 
 What:		/sys/block/<disk>/integrity/format
@@ -74,6 +66,15 @@ Description:
 		E.g. T10-DIF-TYPE1-CRC.
 
 
+What:		/sys/block/<disk>/integrity/protection_interval_bytes
+Date:		July 2015
+Contact:	Martin K. Petersen <martin.petersen@oracle.com>
+Description:
+		Describes the number of data bytes which are protected
+		by one integrity tuple. Typically the device's logical
+		block size.
+
+
 What:		/sys/block/<disk>/integrity/read_verify
 Date:		June 2008
 Contact:	Martin K. Petersen <martin.petersen@oracle.com>
@@ -91,21 +92,6 @@ Description:
 		512 bytes of data.
 
 
-What:		/sys/block/<disk>/integrity/device_is_integrity_capable
-Date:		July 2014
-Contact:	Martin K. Petersen <martin.petersen@oracle.com>
-Description:
-		Indicates whether a storage device is capable of storing
-		integrity metadata. Set if the device is T10 PI-capable.
-
-What:		/sys/block/<disk>/integrity/protection_interval_bytes
-Date:		July 2015
-Contact:	Martin K. Petersen <martin.petersen@oracle.com>
-Description:
-		Describes the number of data bytes which are protected
-		by one integrity tuple. Typically the device's logical
-		block size.
-
 What:		/sys/block/<disk>/integrity/write_generate
 Date:		June 2008
 Contact:	Martin K. Petersen <martin.petersen@oracle.com>
@@ -114,16 +100,6 @@ Description:
 		generate checksums for write requests bound for
 		devices that support receiving integrity metadata.
 
-What:		/sys/block/<disk>/alignment_offset
-Date:		April 2009
-Contact:	Martin K. Petersen <martin.petersen@oracle.com>
-Description:
-		Storage devices may report a physical block size that is
-		bigger than the logical block size (for instance a drive
-		with 4KB physical sectors exposing 512-byte logical
-		blocks to the operating system).  This parameter
-		indicates how many bytes the beginning of the device is
-		offset from the disk's natural alignment.
 
 What:		/sys/block/<disk>/<partition>/alignment_offset
 Date:		April 2009
@@ -136,76 +112,6 @@ Description:
 		indicates how many bytes the beginning of the partition
 		is offset from the disk's natural alignment.
 
-What:		/sys/block/<disk>/queue/logical_block_size
-Date:		May 2009
-Contact:	Martin K. Petersen <martin.petersen@oracle.com>
-Description:
-		This is the smallest unit the storage device can
-		address.  It is typically 512 bytes.
-
-What:		/sys/block/<disk>/queue/physical_block_size
-Date:		May 2009
-Contact:	Martin K. Petersen <martin.petersen@oracle.com>
-Description:
-		This is the smallest unit a physical storage device can
-		write atomically.  It is usually the same as the logical
-		block size but may be bigger.  One example is SATA
-		drives with 4KB sectors that expose a 512-byte logical
-		block size to the operating system.  For stacked block
-		devices the physical_block_size variable contains the
-		maximum physical_block_size of the component devices.
-
-What:		/sys/block/<disk>/queue/minimum_io_size
-Date:		April 2009
-Contact:	Martin K. Petersen <martin.petersen@oracle.com>
-Description:
-		Storage devices may report a granularity or preferred
-		minimum I/O size which is the smallest request the
-		device can perform without incurring a performance
-		penalty.  For disk drives this is often the physical
-		block size.  For RAID arrays it is often the stripe
-		chunk size.  A properly aligned multiple of
-		minimum_io_size is the preferred request size for
-		workloads where a high number of I/O operations is
-		desired.
-
-What:		/sys/block/<disk>/queue/optimal_io_size
-Date:		April 2009
-Contact:	Martin K. Petersen <martin.petersen@oracle.com>
-Description:
-		Storage devices may report an optimal I/O size, which is
-		the device's preferred unit for sustained I/O.  This is
-		rarely reported for disk drives.  For RAID arrays it is
-		usually the stripe width or the internal track size.  A
-		properly aligned multiple of optimal_io_size is the
-		preferred request size for workloads where sustained
-		throughput is desired.  If no optimal I/O size is
-		reported this file contains 0.
-
-What:		/sys/block/<disk>/queue/nomerges
-Date:		January 2010
-Contact:
-Description:
-		Standard I/O elevator operations include attempts to
-		merge contiguous I/Os. For known random I/O loads these
-		attempts will always fail and result in extra cycles
-		being spent in the kernel. This allows one to turn off
-		this behavior on one of two ways: When set to 1, complex
-		merge checks are disabled, but the simple one-shot merges
-		with the previous I/O request are enabled. When set to 2,
-		all merge tries are disabled. The default value is 0 -
-		which enables all types of merge tries.
-
-What:		/sys/block/<disk>/discard_alignment
-Date:		May 2011
-Contact:	Martin K. Petersen <martin.petersen@oracle.com>
-Description:
-		Devices that support discard functionality may
-		internally allocate space in units that are bigger than
-		the exported logical block size. The discard_alignment
-		parameter indicates how many bytes the beginning of the
-		device is offset from the internal allocation unit's
-		natural alignment.
 
 What:		/sys/block/<disk>/<partition>/discard_alignment
 Date:		May 2011
@@ -218,6 +124,30 @@ Description:
 		partition is offset from the internal allocation unit's
 		natural alignment.
 
+
+What:		/sys/block/<disk>/<partition>/stat
+Date:		February 2008
+Contact:	Jerome Marchand <jmarchan@redhat.com>
+Description:
+		The /sys/block/<disk>/<partition>/stat files display the
+		I/O statistics of partition <partition>. The format is the
+		same as the format of /sys/block/<disk>/stat.
+
+
+What:		/sys/block/<disk>/queue/chunk_sectors
+Date:		September 2016
+Contact:	Hannes Reinecke <hare@suse.com>
+Description:
+		chunk_sectors has different meaning depending on the type
+		of the disk. For a RAID device (dm-raid), chunk_sectors
+		indicates the size in 512B sectors of the RAID volume
+		stripe segment. For a zoned block device, either
+		host-aware or host-managed, chunk_sectors indicates the
+		size in 512B sectors of the zones of the device, with
+		the eventual exception of the last zone of the device
+		which may be smaller.
+
+
 What:		/sys/block/<disk>/queue/discard_granularity
 Date:		May 2011
 Contact:	Martin K. Petersen <martin.petersen@oracle.com>
@@ -231,6 +161,7 @@ Description:
 		physical block size. A discard_granularity of 0 means
 		that the device does not support discard functionality.
 
+
 What:		/sys/block/<disk>/queue/discard_max_bytes
 Date:		May 2011
 Contact:	Martin K. Petersen <martin.petersen@oracle.com>
@@ -247,6 +178,7 @@ Description:
 		value of 0 means that the device does not support
 		discard functionality.
 
+
 What:		/sys/block/<disk>/queue/discard_zeroes_data
 Date:		May 2011
 Contact:	Martin K. Petersen <martin.petersen@oracle.com>
@@ -254,6 +186,111 @@ Description:
 		Will always return 0.  Don't rely on any specific behavior
 		for discards, and don't read this file.
 
+
+What:		/sys/block/<disk>/queue/io_timeout
+Date:		November 2018
+Contact:	Weiping Zhang <zhangweiping@didiglobal.com>
+Description:
+		io_timeout is the request timeout in milliseconds. If a request
+		does not complete in this time then the block driver timeout
+		handler is invoked. That timeout handler can decide to retry
+		the request, to fail it or to start a device recovery strategy.
+
+
+What:		/sys/block/<disk>/queue/logical_block_size
+Date:		May 2009
+Contact:	Martin K. Petersen <martin.petersen@oracle.com>
+Description:
+		This is the smallest unit the storage device can
+		address.  It is typically 512 bytes.
+
+
+What:		/sys/block/<disk>/queue/max_active_zones
+Date:		July 2020
+Contact:	Niklas Cassel <niklas.cassel@wdc.com>
+Description:
+		For zoned block devices (zoned attribute indicating
+		"host-managed" or "host-aware"), the sum of zones belonging to
+		any of the zone states: EXPLICIT OPEN, IMPLICIT OPEN or CLOSED,
+		is limited by this value. If this value is 0, there is no limit.
+
+
+What:		/sys/block/<disk>/queue/max_open_zones
+Date:		July 2020
+Contact:	Niklas Cassel <niklas.cassel@wdc.com>
+Description:
+		For zoned block devices (zoned attribute indicating
+		"host-managed" or "host-aware"), the sum of zones belonging to
+		any of the zone states: EXPLICIT OPEN or IMPLICIT OPEN,
+		is limited by this value. If this value is 0, there is no limit.
+
+
+What:		/sys/block/<disk>/queue/minimum_io_size
+Date:		April 2009
+Contact:	Martin K. Petersen <martin.petersen@oracle.com>
+Description:
+		Storage devices may report a granularity or preferred
+		minimum I/O size which is the smallest request the
+		device can perform without incurring a performance
+		penalty.  For disk drives this is often the physical
+		block size.  For RAID arrays it is often the stripe
+		chunk size.  A properly aligned multiple of
+		minimum_io_size is the preferred request size for
+		workloads where a high number of I/O operations is
+		desired.
+
+
+What:		/sys/block/<disk>/queue/nomerges
+Date:		January 2010
+Contact:
+Description:
+		Standard I/O elevator operations include attempts to
+		merge contiguous I/Os. For known random I/O loads these
+		attempts will always fail and result in extra cycles
+		being spent in the kernel. This allows one to turn off
+		this behavior on one of two ways: When set to 1, complex
+		merge checks are disabled, but the simple one-shot merges
+		with the previous I/O request are enabled. When set to 2,
+		all merge tries are disabled. The default value is 0 -
+		which enables all types of merge tries.
+
+
+What:		/sys/block/<disk>/queue/nr_zones
+Date:		November 2018
+Contact:	Damien Le Moal <damien.lemoal@wdc.com>
+Description:
+		nr_zones indicates the total number of zones of a zoned block
+		device ("host-aware" or "host-managed" zone model). For regular
+		block devices, the value is always 0.
+
+
+What:		/sys/block/<disk>/queue/optimal_io_size
+Date:		April 2009
+Contact:	Martin K. Petersen <martin.petersen@oracle.com>
+Description:
+		Storage devices may report an optimal I/O size, which is
+		the device's preferred unit for sustained I/O.  This is
+		rarely reported for disk drives.  For RAID arrays it is
+		usually the stripe width or the internal track size.  A
+		properly aligned multiple of optimal_io_size is the
+		preferred request size for workloads where sustained
+		throughput is desired.  If no optimal I/O size is
+		reported this file contains 0.
+
+
+What:		/sys/block/<disk>/queue/physical_block_size
+Date:		May 2009
+Contact:	Martin K. Petersen <martin.petersen@oracle.com>
+Description:
+		This is the smallest unit a physical storage device can
+		write atomically.  It is usually the same as the logical
+		block size but may be bigger.  One example is SATA
+		drives with 4KB sectors that expose a 512-byte logical
+		block size to the operating system.  For stacked block
+		devices the physical_block_size variable contains the
+		maximum physical_block_size of the component devices.
+
+
 What:		/sys/block/<disk>/queue/write_same_max_bytes
 Date:		January 2012
 Contact:	Martin K. Petersen <martin.petersen@oracle.com>
@@ -267,6 +304,7 @@ Description:
 		write_same_max_bytes is 0, write same is not supported
 		by the device.
 
+
 What:		/sys/block/<disk>/queue/write_zeroes_max_bytes
 Date:		November 2016
 Contact:	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
@@ -280,6 +318,7 @@ Description:
 		write_zeroes_max_bytes is 0, write zeroes is not supported
 		by the device.
 
+
 What:		/sys/block/<disk>/queue/zoned
 Date:		September 2016
 Contact:	Damien Le Moal <damien.lemoal@wdc.com>
@@ -297,50 +336,32 @@ Description:
 		zone commands, they will be treated as regular block
 		devices and zoned will report "none".
 
-What:		/sys/block/<disk>/queue/nr_zones
-Date:		November 2018
-Contact:	Damien Le Moal <damien.lemoal@wdc.com>
-Description:
-		nr_zones indicates the total number of zones of a zoned block
-		device ("host-aware" or "host-managed" zone model). For regular
-		block devices, the value is always 0.
 
-What:		/sys/block/<disk>/queue/max_active_zones
-Date:		July 2020
-Contact:	Niklas Cassel <niklas.cassel@wdc.com>
-Description:
-		For zoned block devices (zoned attribute indicating
-		"host-managed" or "host-aware"), the sum of zones belonging to
-		any of the zone states: EXPLICIT OPEN, IMPLICIT OPEN or CLOSED,
-		is limited by this value. If this value is 0, there is no limit.
-
-What:		/sys/block/<disk>/queue/max_open_zones
-Date:		July 2020
-Contact:	Niklas Cassel <niklas.cassel@wdc.com>
+What:		/sys/block/<disk>/stat
+Date:		February 2008
+Contact:	Jerome Marchand <jmarchan@redhat.com>
 Description:
-		For zoned block devices (zoned attribute indicating
-		"host-managed" or "host-aware"), the sum of zones belonging to
-		any of the zone states: EXPLICIT OPEN or IMPLICIT OPEN,
-		is limited by this value. If this value is 0, there is no limit.
+		The /sys/block/<disk>/stat files displays the I/O
+		statistics of disk <disk>. They contain 11 fields:
 
-What:		/sys/block/<disk>/queue/chunk_sectors
-Date:		September 2016
-Contact:	Hannes Reinecke <hare@suse.com>
-Description:
-		chunk_sectors has different meaning depending on the type
-		of the disk. For a RAID device (dm-raid), chunk_sectors
-		indicates the size in 512B sectors of the RAID volume
-		stripe segment. For a zoned block device, either
-		host-aware or host-managed, chunk_sectors indicates the
-		size in 512B sectors of the zones of the device, with
-		the eventual exception of the last zone of the device
-		which may be smaller.
+		==  ==============================================
+		 1  reads completed successfully
+		 2  reads merged
+		 3  sectors read
+		 4  time spent reading (ms)
+		 5  writes completed
+		 6  writes merged
+		 7  sectors written
+		 8  time spent writing (ms)
+		 9  I/Os currently in progress
+		10  time spent doing I/Os (ms)
+		11  weighted time spent doing I/Os (ms)
+		12  discards completed
+		13  discards merged
+		14  sectors discarded
+		15  time spent discarding (ms)
+		16  flush requests completed
+		17  time spent flushing (ms)
+		==  ==============================================
 
-What:		/sys/block/<disk>/queue/io_timeout
-Date:		November 2018
-Contact:	Weiping Zhang <zhangweiping@didiglobal.com>
-Description:
-		io_timeout is the request timeout in milliseconds. If a request
-		does not complete in this time then the block driver timeout
-		handler is invoked. That timeout handler can decide to retry
-		the request, to fail it or to start a device recovery strategy.
+		For more details refer Documentation/admin-guide/iostats.rst
-- 
2.34.1

