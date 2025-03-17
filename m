Return-Path: <linux-block+bounces-18495-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63240A63E9F
	for <lists+linux-block@lfdr.de>; Mon, 17 Mar 2025 05:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B8B188E50A
	for <lists+linux-block@lfdr.de>; Mon, 17 Mar 2025 04:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B18214A9A;
	Mon, 17 Mar 2025 04:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDkAyRk6"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA83215067
	for <linux-block@vger.kernel.org>; Mon, 17 Mar 2025 04:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742186722; cv=none; b=s+qHG0UXZJE92pxo4B14hkqfx+UspIGy71nK21guDQWnaYTKEGltdty5nkZknMoFmFedvpOBu4MkkZdHu1iw1M0xWQK36jfcc+2RoSpHL4NlJWRJQJFMyp1cIaCsrpMmVkYOOE5a+ZByaWkgOfak5zaaw77CiYXJlkfvQ0+Wpvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742186722; c=relaxed/simple;
	bh=GoKIo/F8qyucTWMwO2wHhQc4AHJwM/VbRbCvZVViJ0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pM/lvKMuhJf8djbG8LNaxxe3+cgRGvh+N7JnCt7RQEaav5m8LI0K5GXSi64QuAIitr5fHqw2UsUO/cFGqKN5VlFEkJTuyflRwXvmsni1ZdAlY1SO4rxn+f9o/dIMjsS46k1XD4IBbSKVrDG1/DShPEQEPggC8Ah/+dCOK1vlE0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDkAyRk6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742186719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XWFvjdUagLHD3tqpy0jXDJgrxvdDpx/9JdTokXNQ/Qk=;
	b=fDkAyRk6v52oBHJt50PJXVv1UVGeIwHESAsVOngVYNnJFOXD2fQOk14CfifO0DxVdp29fE
	Q1V/SXKDWMD1KiUok+ez32UuyzPc4sIrZgyNUBsgsJVc1Q4w8SRLuM2Xv8GtdwZwjZiOIf
	ZPFgNburzv7tqGpqRQVrUnckj5PmA9M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-g3drYAMBOJ6Xz9pjCU9PkQ-1; Mon,
 17 Mar 2025 00:45:15 -0400
X-MC-Unique: g3drYAMBOJ6Xz9pjCU9PkQ-1
X-Mimecast-MFC-AGG-ID: g3drYAMBOJ6Xz9pjCU9PkQ_1742186714
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8235D19560B3;
	Mon, 17 Mar 2025 04:45:13 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41E90180174E;
	Mon, 17 Mar 2025 04:45:11 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 52H4jArY2200862
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 00:45:10 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 52H4jAS72200861;
	Mon, 17 Mar 2025 00:45:10 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
        Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 0/6] dm: fix issues with swapping dm tables
Date: Mon, 17 Mar 2025 00:45:04 -0400
Message-ID: <20250317044510.2200856-1-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

There were multiple places in dm's __bind() function where it could fail
and not completely roll back, leaving the device using the the old
table, but with device limits and resources from the new table.
Additionally, unused mempools for request-based devices were not always
freed immediately.

Finally, there were a number of issues with switching zoned tables that
emulate zone append (in other words, dm-crypt on top of zoned devices).
dm_blk_report_zones() could be called while the device was suspended and
modifying zoned resources or could possibly fail to end a srcu read
section.  More importantly, blk_revalidate_disk_zones() would never get
called when updating a zoned table. This could cause the dm device to
see the wrong zone write offsets, not have a large enough zwplugs
reserved in its mempool, or read invalid memory when checking the
conventional zones bitmap.

This patchset fixes these issues. It deals with the problems around
blk_revalidate_disk_zones() by only calling it for devices that have no 
zone write plug resources. This will always correctly update the zoned
settings. If a device has zone write plug resources, calling
blk_revalidate_disk_zones() will not correctly update them in many
cases, so DM simply doesn't call it for devices with zone write plug
resources. Instead of allowing people to load tables that can break the
device, like currently happens, DM disallosw any table reloads that
change the zoned setting for devices that already have zone write plug
resources.

Specifically, if a device already has zone plug resources allocated, it
can only switch to another zoned table that also emulates zone append.
Also, it cannot change the device size or the zone size. There are some
tweaks to make sure that a device can always switch to an error target.

Changes in V2:
- Made queue_limits_set() optionally return the old limits (grabbed
  while holding the limits_lock), and used this in
  dm_table_set_restrictions()
- dropped changes to disk_free_zone_resources() and the
  blk_revalidate_disk_zones() code path (removed patches 0005 & 0006)
- Instead of always calling blk_revalidate_disk_zones(), disallow
  changes that would change zone settings if the device has
  zone write plug resources (final patch).

Benjamin Marzinski (6):
  dm: don't change md if dm_table_set_restrictions() fails
  dm: free table mempools if not used in __bind
  block: make queue_limits_set() optionally return old limits
  dm: handle failures in dm_table_set_restrictions
  dm: fix dm_blk_report_zones
  dm: limit swapping tables for devices with zone write plugs

 block/blk-settings.c   |  9 ++++-
 drivers/md/dm-core.h   |  1 +
 drivers/md/dm-table.c  | 66 ++++++++++++++++++++++++++-------
 drivers/md/dm-zone.c   | 84 +++++++++++++++++++++++++++++-------------
 drivers/md/dm.c        | 36 +++++++++++-------
 drivers/md/dm.h        |  6 +++
 drivers/md/md-linear.c |  2 +-
 drivers/md/raid0.c     |  2 +-
 drivers/md/raid1.c     |  2 +-
 drivers/md/raid10.c    |  2 +-
 drivers/md/raid5.c     |  2 +-
 include/linux/blkdev.h |  3 +-
 12 files changed, 154 insertions(+), 61 deletions(-)

-- 
2.48.1


