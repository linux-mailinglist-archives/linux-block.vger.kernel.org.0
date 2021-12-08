Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E4746C9C5
	for <lists+linux-block@lfdr.de>; Wed,  8 Dec 2021 01:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbhLHBBU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Dec 2021 20:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239014AbhLHBBD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Dec 2021 20:01:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7273AC061746;
        Tue,  7 Dec 2021 16:57:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 84829CE1F5B;
        Wed,  8 Dec 2021 00:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAD4C341CA;
        Wed,  8 Dec 2021 00:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638925048;
        bh=8+APaLFjTajCgb6OWAqt3RT21EQ6OfqSDcoEgjOcS14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nCaLlafaHUSVO9mv+gMEKd49AmoQLENHfpiyWdWwKdENkO/Yi6+rVTxg6zO8X60Qo
         jU3uO0Pw75IEMVpL9vz17qzD/cRC/NUFYnepF8KjC7pKD0so4gEh5I0ppZNGyrjekj
         Mv26nb3em1+lMAIGTwOgo40t2ajiaYWpib58vlwUUDWYYY/XaDsvsPjR+FSAwwGd6g
         oLQUUp0nPNhHBTMbwg2H0jl5e29v3o5Hfg7D1UOkGkivYIRVBa28OZTw/iyS+au7hc
         N3c/IUFQ7CDu1dfiMFyrUGdnw6xWwGg48CqPGppOptzKP29B12sNufWDGX7TaGiJqT
         AtyFYzAtCjnCQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 4/8] docs: sysfs-block: fill in missing documentation from queue-sysfs.rst
Date:   Tue,  7 Dec 2021 16:56:36 -0800
Message-Id: <20211208005640.102814-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208005640.102814-1-ebiggers@kernel.org>
References: <20211208005640.102814-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

sysfs documentation is supposed to go in Documentation/ABI/.
However, /sys/block/<disk>/queue/* are documented in
Documentation/block/queue-sysfs.rst, and sometimes redundantly in
Documentation/ABI/stable/sysfs-block too.

Let's consolidate this documentation into Documentation/ABI/.

Therefore, copy the relevant docs from queue-sysfs.rst into sysfs-block.

This primarily means adding the 25 missing files that were documented in
queue-sysfs.rst only, as well as mentioning the RO/RW status of files.

Documentation/ABI/ requires "Date" and "Contact" fields.  For the Date
fields, I used the date of the commit which added support for each file.
For the "Contact" fields, I used linux-block.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/ABI/stable/sysfs-block | 482 +++++++++++++++++++++------
 1 file changed, 381 insertions(+), 101 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index c70fce6b76c17..de3b86a3dfa55 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -46,7 +46,7 @@ Description:
 		The value type is unsigned int.
 		Cf. Documentation/block/stat.rst which contains a single value for
 		requests in flight.
-		This is related to nr_requests in Documentation/block/queue-sysfs.rst
+		This is related to /sys/block/<disk>/queue/nr_requests
 		and for SCSI device also its queue_depth.
 
 
@@ -134,207 +134,487 @@ Description:
 		same as the format of /sys/block/<disk>/stat.
 
 
+What:		/sys/block/<disk>/queue/add_random
+Date:		June 2010
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] This file allows to turn off the disk entropy contribution.
+		Default value of this file is '1'(on).
+
+
 What:		/sys/block/<disk>/queue/chunk_sectors
 Date:		September 2016
 Contact:	Hannes Reinecke <hare@suse.com>
 Description:
-		chunk_sectors has different meaning depending on the type
+		[RO] chunk_sectors has different meaning depending on the type
 		of the disk. For a RAID device (dm-raid), chunk_sectors
-		indicates the size in 512B sectors of the RAID volume
-		stripe segment. For a zoned block device, either
-		host-aware or host-managed, chunk_sectors indicates the
-		size in 512B sectors of the zones of the device, with
-		the eventual exception of the last zone of the device
-		which may be smaller.
+		indicates the size in 512B sectors of the RAID volume stripe
+		segment. For a zoned block device, either host-aware or
+		host-managed, chunk_sectors indicates the size in 512B sectors
+		of the zones of the device, with the eventual exception of the
+		last zone of the device which may be smaller.
+
+
+What:		/sys/block/<disk>/queue/dax
+Date:		June 2016
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] This file indicates whether the device supports Direct
+		Access (DAX), used by CPU-addressable storage to bypass the
+		pagecache.  It shows '1' if true, '0' if not.
 
 
 What:		/sys/block/<disk>/queue/discard_granularity
 Date:		May 2011
 Contact:	Martin K. Petersen <martin.petersen@oracle.com>
 Description:
-		Devices that support discard functionality may
-		internally allocate space using units that are bigger
-		than the logical block size. The discard_granularity
-		parameter indicates the size of the internal allocation
-		unit in bytes if reported by the device. Otherwise the
-		discard_granularity will be set to match the device's
-		physical block size. A discard_granularity of 0 means
-		that the device does not support discard functionality.
+		[RO] Devices that support discard functionality may internally
+		allocate space using units that are bigger than the logical
+		block size. The discard_granularity parameter indicates the size
+		of the internal allocation unit in bytes if reported by the
+		device. Otherwise the discard_granularity will be set to match
+		the device's physical block size. A discard_granularity of 0
+		means that the device does not support discard functionality.
 
 
 What:		/sys/block/<disk>/queue/discard_max_bytes
 Date:		May 2011
 Contact:	Martin K. Petersen <martin.petersen@oracle.com>
 Description:
-		Devices that support discard functionality may have
-		internal limits on the number of bytes that can be
-		trimmed or unmapped in a single operation. Some storage
-		protocols also have inherent limits on the number of
-		blocks that can be described in a single command. The
-		discard_max_bytes parameter is set by the device driver
-		to the maximum number of bytes that can be discarded in
-		a single operation. Discard requests issued to the
-		device must not exceed this limit. A discard_max_bytes
-		value of 0 means that the device does not support
-		discard functionality.
+		[RW] While discard_max_hw_bytes is the hardware limit for the
+		device, this setting is the software limit. Some devices exhibit
+		large latencies when large discards are issued, setting this
+		value lower will make Linux issue smaller discards and
+		potentially help reduce latencies induced by large discard
+		operations.
+
+
+What:		/sys/block/<disk>/queue/discard_max_hw_bytes
+Date:		July 2015
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] Devices that support discard functionality may have
+		internal limits on the number of bytes that can be trimmed or
+		unmapped in a single operation.  The `discard_max_hw_bytes`
+		parameter is set by the device driver to the maximum number of
+		bytes that can be discarded in a single operation.  Discard
+		requests issued to the device must not exceed this limit.  A
+		`discard_max_hw_bytes` value of 0 means that the device does not
+		support discard functionality.
 
 
 What:		/sys/block/<disk>/queue/discard_zeroes_data
 Date:		May 2011
 Contact:	Martin K. Petersen <martin.petersen@oracle.com>
 Description:
-		Will always return 0.  Don't rely on any specific behavior
+		[RO] Will always return 0.  Don't rely on any specific behavior
 		for discards, and don't read this file.
 
 
+What:		/sys/block/<disk>/queue/fua
+Date:		May 2018
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] Whether or not the block driver supports the FUA flag for
+		write requests.  FUA stands for Force Unit Access. If the FUA
+		flag is set that means that write requests must bypass the
+		volatile cache of the storage device.
+
+
+What:		/sys/block/<disk>/queue/hw_sector_size
+Date:		January 2008
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] This is the hardware sector size of the device, in bytes.
+
+
+What:		/sys/block/<disk>/queue/independent_access_ranges/
+Date:		October 2021
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] The presence of this sub-directory of the
+		/sys/block/xxx/queue/ directory indicates that the device is
+		capable of executing requests targeting different sector ranges
+		in parallel. For instance, single LUN multi-actuator hard-disks
+		will have an independent_access_ranges directory if the device
+		correctly advertizes the sector ranges of its actuators.
+
+		The independent_access_ranges directory contains one directory
+		per access range, with each range described using the sector
+		(RO) attribute file to indicate the first sector of the range
+		and the nr_sectors (RO) attribute file to indicate the total
+		number of sectors in the range starting from the first sector of
+		the range.  For example, a dual-actuator hard-disk will have the
+		following independent_access_ranges entries.::
+
+			$ tree /sys/block/<disk>/queue/independent_access_ranges/
+			/sys/block/<disk>/queue/independent_access_ranges/
+			|-- 0
+			|   |-- nr_sectors
+			|   `-- sector
+			`-- 1
+			    |-- nr_sectors
+			    `-- sector
+
+		The sector and nr_sectors attributes use 512B sector unit,
+		regardless of the actual block size of the device. Independent
+		access ranges do not overlap and include all sectors within the
+		device capacity. The access ranges are numbered in increasing
+		order of the range start sector, that is, the sector attribute
+		of range 0 always has the value 0.
+
+
+What:		/sys/block/<disk>/queue/io_poll
+Date:		November 2015
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] When read, this file shows whether polling is enabled (1)
+		or disabled (0).  Writing '0' to this file will disable polling
+		for this device.  Writing any non-zero value will enable this
+		feature.
+
+
+What:		/sys/block/<disk>/queue/io_poll_delay
+Date:		November 2016
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] If polling is enabled, this controls what kind of polling
+		will be performed. It defaults to -1, which is classic polling.
+		In this mode, the CPU will repeatedly ask for completions
+		without giving up any time.  If set to 0, a hybrid polling mode
+		is used, where the kernel will attempt to make an educated guess
+		at when the IO will complete. Based on this guess, the kernel
+		will put the process issuing IO to sleep for an amount of time,
+		before entering a classic poll loop. This mode might be a little
+		slower than pure classic polling, but it will be more efficient.
+		If set to a value larger than 0, the kernel will put the process
+		issuing IO to sleep for this amount of microseconds before
+		entering classic polling.
+
+
 What:		/sys/block/<disk>/queue/io_timeout
 Date:		November 2018
 Contact:	Weiping Zhang <zhangweiping@didiglobal.com>
 Description:
-		io_timeout is the request timeout in milliseconds. If a request
-		does not complete in this time then the block driver timeout
-		handler is invoked. That timeout handler can decide to retry
-		the request, to fail it or to start a device recovery strategy.
+		[RW] io_timeout is the request timeout in milliseconds. If a
+		request does not complete in this time then the block driver
+		timeout handler is invoked. That timeout handler can decide to
+		retry the request, to fail it or to start a device recovery
+		strategy.
+
+
+What:		/sys/block/<disk>/queue/iostats
+Date:		January 2009
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] This file is used to control (on/off) the iostats
+		accounting of the disk.
 
 
 What:		/sys/block/<disk>/queue/logical_block_size
 Date:		May 2009
 Contact:	Martin K. Petersen <martin.petersen@oracle.com>
 Description:
-		This is the smallest unit the storage device can
-		address.  It is typically 512 bytes.
+		[RO] This is the smallest unit the storage device can address.
+		It is typically 512 bytes.
 
 
 What:		/sys/block/<disk>/queue/max_active_zones
 Date:		July 2020
 Contact:	Niklas Cassel <niklas.cassel@wdc.com>
 Description:
-		For zoned block devices (zoned attribute indicating
+		[RO] For zoned block devices (zoned attribute indicating
 		"host-managed" or "host-aware"), the sum of zones belonging to
 		any of the zone states: EXPLICIT OPEN, IMPLICIT OPEN or CLOSED,
 		is limited by this value. If this value is 0, there is no limit.
 
+		If the host attempts to exceed this limit, the driver should
+		report this error with BLK_STS_ZONE_ACTIVE_RESOURCE, which user
+		space may see as the EOVERFLOW errno.
+
+
+What:		/sys/block/<disk>/queue/max_discard_segments
+Date:		February 2017
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] The maximum number of DMA scatter/gather entries in a
+		discard request.
+
+
+What:		/sys/block/<disk>/queue/max_hw_sectors_kb
+Date:		September 2004
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] This is the maximum number of kilobytes supported in a
+		single data transfer.
+
+
+What:		/sys/block/<disk>/queue/max_integrity_segments
+Date:		September 2010
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] Maximum number of elements in a DMA scatter/gather list
+		with integrity data that will be submitted by the block layer
+		core to the associated block driver.
+
 
 What:		/sys/block/<disk>/queue/max_open_zones
 Date:		July 2020
 Contact:	Niklas Cassel <niklas.cassel@wdc.com>
 Description:
-		For zoned block devices (zoned attribute indicating
+		[RO] For zoned block devices (zoned attribute indicating
 		"host-managed" or "host-aware"), the sum of zones belonging to
-		any of the zone states: EXPLICIT OPEN or IMPLICIT OPEN,
-		is limited by this value. If this value is 0, there is no limit.
+		any of the zone states: EXPLICIT OPEN or IMPLICIT OPEN, is
+		limited by this value. If this value is 0, there is no limit.
+
+
+What:		/sys/block/<disk>/queue/max_sectors_kb
+Date:		September 2004
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] This is the maximum number of kilobytes that the block
+		layer will allow for a filesystem request. Must be smaller than
+		or equal to the maximum size allowed by the hardware.
+
+
+What:		/sys/block/<disk>/queue/max_segment_size
+Date:		March 2010
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] Maximum size in bytes of a single element in a DMA
+		scatter/gather list.
+
+
+What:		/sys/block/<disk>/queue/max_segments
+Date:		March 2010
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] Maximum number of elements in a DMA scatter/gather list
+		that is submitted to the associated block driver.
 
 
 What:		/sys/block/<disk>/queue/minimum_io_size
 Date:		April 2009
 Contact:	Martin K. Petersen <martin.petersen@oracle.com>
 Description:
-		Storage devices may report a granularity or preferred
-		minimum I/O size which is the smallest request the
-		device can perform without incurring a performance
-		penalty.  For disk drives this is often the physical
-		block size.  For RAID arrays it is often the stripe
-		chunk size.  A properly aligned multiple of
-		minimum_io_size is the preferred request size for
-		workloads where a high number of I/O operations is
-		desired.
+		[RO] Storage devices may report a granularity or preferred
+		minimum I/O size which is the smallest request the device can
+		perform without incurring a performance penalty.  For disk
+		drives this is often the physical block size.  For RAID arrays
+		it is often the stripe chunk size.  A properly aligned multiple
+		of minimum_io_size is the preferred request size for workloads
+		where a high number of I/O operations is desired.
 
 
 What:		/sys/block/<disk>/queue/nomerges
 Date:		January 2010
 Contact:	linux-block@vger.kernel.org
 Description:
-		Standard I/O elevator operations include attempts to
-		merge contiguous I/Os. For known random I/O loads these
-		attempts will always fail and result in extra cycles
-		being spent in the kernel. This allows one to turn off
-		this behavior on one of two ways: When set to 1, complex
-		merge checks are disabled, but the simple one-shot merges
-		with the previous I/O request are enabled. When set to 2,
-		all merge tries are disabled. The default value is 0 -
-		which enables all types of merge tries.
+		[RW] Standard I/O elevator operations include attempts to merge
+		contiguous I/Os. For known random I/O loads these attempts will
+		always fail and result in extra cycles being spent in the
+		kernel. This allows one to turn off this behavior on one of two
+		ways: When set to 1, complex merge checks are disabled, but the
+		simple one-shot merges with the previous I/O request are
+		enabled. When set to 2, all merge tries are disabled. The
+		default value is 0 - which enables all types of merge tries.
+
+
+What:		/sys/block/<disk>/queue/nr_requests
+Date:		July 2003
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] This controls how many requests may be allocated in the
+		block layer for read or write requests. Note that the total
+		allocated number may be twice this amount, since it applies only
+		to reads or writes (not the accumulated sum).
+
+		To avoid priority inversion through request starvation, a
+		request queue maintains a separate request pool per each cgroup
+		when CONFIG_BLK_CGROUP is enabled, and this parameter applies to
+		each such per-block-cgroup request pool.  IOW, if there are N
+		block cgroups, each request queue may have up to N request
+		pools, each independently regulated by nr_requests.
 
 
 What:		/sys/block/<disk>/queue/nr_zones
 Date:		November 2018
 Contact:	Damien Le Moal <damien.lemoal@wdc.com>
 Description:
-		nr_zones indicates the total number of zones of a zoned block
-		device ("host-aware" or "host-managed" zone model). For regular
-		block devices, the value is always 0.
+		[RO] nr_zones indicates the total number of zones of a zoned
+		block device ("host-aware" or "host-managed" zone model). For
+		regular block devices, the value is always 0.
 
 
 What:		/sys/block/<disk>/queue/optimal_io_size
 Date:		April 2009
 Contact:	Martin K. Petersen <martin.petersen@oracle.com>
 Description:
-		Storage devices may report an optimal I/O size, which is
-		the device's preferred unit for sustained I/O.  This is
-		rarely reported for disk drives.  For RAID arrays it is
-		usually the stripe width or the internal track size.  A
-		properly aligned multiple of optimal_io_size is the
-		preferred request size for workloads where sustained
-		throughput is desired.  If no optimal I/O size is
-		reported this file contains 0.
+		[RO] Storage devices may report an optimal I/O size, which is
+		the device's preferred unit for sustained I/O.  This is rarely
+		reported for disk drives.  For RAID arrays it is usually the
+		stripe width or the internal track size.  A properly aligned
+		multiple of optimal_io_size is the preferred request size for
+		workloads where sustained throughput is desired.  If no optimal
+		I/O size is reported this file contains 0.
 
 
 What:		/sys/block/<disk>/queue/physical_block_size
 Date:		May 2009
 Contact:	Martin K. Petersen <martin.petersen@oracle.com>
 Description:
-		This is the smallest unit a physical storage device can
-		write atomically.  It is usually the same as the logical
-		block size but may be bigger.  One example is SATA
-		drives with 4KB sectors that expose a 512-byte logical
-		block size to the operating system.  For stacked block
-		devices the physical_block_size variable contains the
-		maximum physical_block_size of the component devices.
+		[RO] This is the smallest unit a physical storage device can
+		write atomically.  It is usually the same as the logical block
+		size but may be bigger.  One example is SATA drives with 4KB
+		sectors that expose a 512-byte logical block size to the
+		operating system.  For stacked block devices the
+		physical_block_size variable contains the maximum
+		physical_block_size of the component devices.
+
+
+What:		/sys/block/<disk>/queue/read_ahead_kb
+Date:		May 2004
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] Maximum number of kilobytes to read-ahead for filesystems
+		on this block device.
+
+
+What:		/sys/block/<disk>/queue/rotational
+Date:		January 2009
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] This file is used to stat if the device is of rotational
+		type or non-rotational type.
+
+
+What:		/sys/block/<disk>/queue/rq_affinity
+Date:		September 2008
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] If this option is '1', the block layer will migrate request
+		completions to the cpu "group" that originally submitted the
+		request. For some workloads this provides a significant
+		reduction in CPU cycles due to caching effects.
+
+		For storage configurations that need to maximize distribution of
+		completion processing setting this option to '2' forces the
+		completion to run on the requesting cpu (bypassing the "group"
+		aggregation logic).
+
+
+What:		/sys/block/<disk>/queue/scheduler
+Date:		October 2004
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] When read, this file will display the current and available
+		IO schedulers for this block device. The currently active IO
+		scheduler will be enclosed in [] brackets. Writing an IO
+		scheduler name to this file will switch control of this block
+		device to that new IO scheduler. Note that writing an IO
+		scheduler name to this file will attempt to load that IO
+		scheduler module, if it isn't already present in the system.
+
+
+What:		/sys/block/<disk>/queue/throttle_sample_time
+Date:		March 2017
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] This is the time window that blk-throttle samples data, in
+		millisecond.  blk-throttle makes decision based on the
+		samplings. Lower time means cgroups have more smooth throughput,
+		but higher CPU overhead. This exists only when
+		CONFIG_BLK_DEV_THROTTLING_LOW is enabled.
+
+
+What:		/sys/block/<disk>/queue/wbt_lat_usec
+Date:		November 2016
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] If the device is registered for writeback throttling, then
+		this file shows the target minimum read latency. If this latency
+		is exceeded in a given window of time (see wb_window_usec), then
+		the writeback throttling will start scaling back writes. Writing
+		a value of '0' to this file disables the feature. Writing a
+		value of '-1' to this file resets the value to the default
+		setting.
+
+
+What:		/sys/block/<disk>/queue/write_cache
+Date:		April 2016
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RW] When read, this file will display whether the device has
+		write back caching enabled or not. It will return "write back"
+		for the former case, and "write through" for the latter. Writing
+		to this file can change the kernels view of the device, but it
+		doesn't alter the device state. This means that it might not be
+		safe to toggle the setting from "write back" to "write through",
+		since that will also eliminate cache flushes issued by the
+		kernel.
 
 
 What:		/sys/block/<disk>/queue/write_same_max_bytes
 Date:		January 2012
 Contact:	Martin K. Petersen <martin.petersen@oracle.com>
 Description:
-		Some devices support a write same operation in which a
+		[RO] Some devices support a write same operation in which a
 		single data block can be written to a range of several
-		contiguous blocks on storage. This can be used to wipe
-		areas on disk or to initialize drives in a RAID
-		configuration. write_same_max_bytes indicates how many
-		bytes can be written in a single write same command. If
-		write_same_max_bytes is 0, write same is not supported
-		by the device.
+		contiguous blocks on storage. This can be used to wipe areas on
+		disk or to initialize drives in a RAID configuration.
+		write_same_max_bytes indicates how many bytes can be written in
+		a single write same command. If write_same_max_bytes is 0, write
+		same is not supported by the device.
 
 
 What:		/sys/block/<disk>/queue/write_zeroes_max_bytes
 Date:		November 2016
 Contact:	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
 Description:
-		Devices that support write zeroes operation in which a
-		single request can be issued to zero out the range of
-		contiguous blocks on storage without having any payload
-		in the request. This can be used to optimize writing zeroes
-		to the devices. write_zeroes_max_bytes indicates how many
-		bytes can be written in a single write zeroes command. If
-		write_zeroes_max_bytes is 0, write zeroes is not supported
-		by the device.
+		[RO] Devices that support write zeroes operation in which a
+		single request can be issued to zero out the range of contiguous
+		blocks on storage without having any payload in the request.
+		This can be used to optimize writing zeroes to the devices.
+		write_zeroes_max_bytes indicates how many bytes can be written
+		in a single write zeroes command. If write_zeroes_max_bytes is
+		0, write zeroes is not supported by the device.
+
+
+What:		/sys/block/<disk>/queue/zone_append_max_bytes
+Date:		May 2020
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] This is the maximum number of bytes that can be written to
+		a sequential zone of a zoned block device using a zone append
+		write operation (REQ_OP_ZONE_APPEND). This value is always 0 for
+		regular block devices.
+
+
+What:		/sys/block/<disk>/queue/zone_write_granularity
+Date:		January 2021
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] This indicates the alignment constraint, in bytes, for
+		write operations in sequential zones of zoned block devices
+		(devices with a zoned attributed that reports "host-managed" or
+		"host-aware"). This value is always 0 for regular block devices.
 
 
 What:		/sys/block/<disk>/queue/zoned
 Date:		September 2016
 Contact:	Damien Le Moal <damien.lemoal@wdc.com>
 Description:
-		zoned indicates if the device is a zoned block device
-		and the zone model of the device if it is indeed zoned.
-		The possible values indicated by zoned are "none" for
-		regular block devices and "host-aware" or "host-managed"
-		for zoned block devices. The characteristics of
-		host-aware and host-managed zoned block devices are
-		described in the ZBC (Zoned Block Commands) and ZAC
-		(Zoned Device ATA Command Set) standards. These standards
-		also define the "drive-managed" zone model. However,
-		since drive-managed zoned block devices do not support
-		zone commands, they will be treated as regular block
-		devices and zoned will report "none".
+		[RO] zoned indicates if the device is a zoned block device and
+		the zone model of the device if it is indeed zoned.  The
+		possible values indicated by zoned are "none" for regular block
+		devices and "host-aware" or "host-managed" for zoned block
+		devices. The characteristics of host-aware and host-managed
+		zoned block devices are described in the ZBC (Zoned Block
+		Commands) and ZAC (Zoned Device ATA Command Set) standards.
+		These standards also define the "drive-managed" zone model.
+		However, since drive-managed zoned block devices do not support
+		zone commands, they will be treated as regular block devices and
+		zoned will report "none".
 
 
 What:		/sys/block/<disk>/stat
-- 
2.34.1

