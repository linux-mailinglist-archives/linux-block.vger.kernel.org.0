Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980B423F9DF
	for <lists+linux-block@lfdr.de>; Sun,  9 Aug 2020 01:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgHHXio (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 8 Aug 2020 19:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbgHHXio (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 8 Aug 2020 19:38:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E95E20791;
        Sat,  8 Aug 2020 23:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929923;
        bh=e+cCX1kCUnp2ZXOTEUBKxZuN1Pa8Zaukh3V2xB+LMOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MT0jjmkTv48SbpWdmcDgszR4KeV6NOzxeWIMXUpYy7gr0TI+EHI7jTbCw5MU6e8UU
         CsftHP2JsudyOhmf0uDnMWXhGEsgR5rEcDOdt9WNk/QwfIig7poZexuJ2BXEY6HQC5
         QpIifKeSJqfdzhpprf3VYGvPWejs/GfTl/u+aCOo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 58/58] block: don't do revalidate zones on invalid devices
Date:   Sat,  8 Aug 2020 19:37:24 -0400
Message-Id: <20200808233724.3618168-58-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233724.3618168-1-sashal@kernel.org>
References: <20200808233724.3618168-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

[ Upstream commit 1a1206dc4cf02cee4b5cbce583ee4c22368b4c28 ]

When we loose a device for whatever reason while (re)scanning zones, we
trip over a NULL pointer in blk_revalidate_zone_cb, like in the following
log:

sd 0:0:0:0: [sda] 3418095616 4096-byte logical blocks: (14.0 TB/12.7 TiB)
sd 0:0:0:0: [sda] 52156 zones of 65536 logical blocks
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 37 00 00 08
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] REPORT ZONES start lba 1065287680 failed
sd 0:0:0:0: [sda] REPORT ZONES: Result: hostbyte=0x00 driverbyte=0x08
sd 0:0:0:0: [sda] Sense Key : 0xb [current]
sd 0:0:0:0: [sda] ASC=0x0 ASCQ=0x6
sda: failed to revalidate zones
sd 0:0:0:0: [sda] 0 4096-byte logical blocks: (0 B/0 B)
sda: detected capacity change from 14000519643136 to 0
==================================================================
BUG: KASAN: null-ptr-deref in blk_revalidate_zone_cb+0x1b7/0x550
Write of size 8 at addr 0000000000000010 by task kworker/u4:1/58

CPU: 1 PID: 58 Comm: kworker/u4:1 Not tainted 5.8.0-rc1 #692
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
Workqueue: events_unbound async_run_entry_fn
Call Trace:
 dump_stack+0x7d/0xb0
 ? blk_revalidate_zone_cb+0x1b7/0x550
 kasan_report.cold+0x5/0x37
 ? blk_revalidate_zone_cb+0x1b7/0x550
 check_memory_region+0x145/0x1a0
 blk_revalidate_zone_cb+0x1b7/0x550
 sd_zbc_parse_report+0x1f1/0x370
 ? blk_req_zone_write_trylock+0x200/0x200
 ? sectors_to_logical+0x60/0x60
 ? blk_req_zone_write_trylock+0x200/0x200
 ? blk_req_zone_write_trylock+0x200/0x200
 sd_zbc_report_zones+0x3c4/0x5e0
 ? sd_dif_config_host+0x500/0x500
 blk_revalidate_disk_zones+0x231/0x44d
 ? _raw_write_lock_irqsave+0xb0/0xb0
 ? blk_queue_free_zone_bitmaps+0xd0/0xd0
 sd_zbc_read_zones+0x8cf/0x11a0
 sd_revalidate_disk+0x305c/0x64e0
 ? __device_add_disk+0x776/0xf20
 ? read_capacity_16.part.0+0x1080/0x1080
 ? blk_alloc_devt+0x250/0x250
 ? create_object.isra.0+0x595/0xa20
 ? kasan_unpoison_shadow+0x33/0x40
 sd_probe+0x8dc/0xcd2
 really_probe+0x20e/0xaf0
 __driver_attach_async_helper+0x249/0x2d0
 async_run_entry_fn+0xbe/0x560
 process_one_work+0x764/0x1290
 ? _raw_read_unlock_irqrestore+0x30/0x30
 worker_thread+0x598/0x12f0
 ? __kthread_parkme+0xc6/0x1b0
 ? schedule+0xed/0x2c0
 ? process_one_work+0x1290/0x1290
 kthread+0x36b/0x440
 ? kthread_create_worker_on_cpu+0xa0/0xa0
 ret_from_fork+0x22/0x30
==================================================================

When the device is already gone we end up with the following scenario:
The device's capacity is 0 and thus the number of zones will be 0 as well. When
allocating the bitmap for the conventional zones, we then trip over a NULL
pointer.

So if we encounter a zoned block device with a 0 capacity, don't dare to
revalidate the zones sizes.

Fixes: 6c6b35491422 ("block: set the zone size in blk_revalidate_disk_zones atomically")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index f87956e0dcafb..0dd17a6d00989 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -478,6 +478,9 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	if (WARN_ON_ONCE(!queue_is_mq(q)))
 		return -EIO;
 
+	if (!get_capacity(disk))
+		return -EIO;
+
 	/*
 	 * Ensure that all memory allocations in this context are done as if
 	 * GFP_NOIO was specified.
-- 
2.25.1

