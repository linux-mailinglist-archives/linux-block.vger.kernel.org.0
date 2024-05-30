Return-Path: <linux-block+bounces-7911-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F4D8D44DC
	for <lists+linux-block@lfdr.de>; Thu, 30 May 2024 07:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BCF1F21F86
	for <lists+linux-block@lfdr.de>; Thu, 30 May 2024 05:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2E5143C4F;
	Thu, 30 May 2024 05:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzpb+qx6"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113A9143881;
	Thu, 30 May 2024 05:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717047640; cv=none; b=HpQTIGzC0v42Vkr4ga/9yHfE+uLPNlWMvYpEuqjvkMk3BjDLVbcuoS3XahO//KazZY+8YOO5Klr3MX4b796yAiP3nd7f+cQ/PnQtOg3b4a/87EmUxzQYnGNfhm80bwioLrr0EtbAftyTyOCpiGT0AzUE1zywAUmD4sGgdTJKAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717047640; c=relaxed/simple;
	bh=E6LnrD/Hk+qwsUKIKG2RP/3T2NmB0ssI6Skdon50Tqc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XguER8dokKEngyoScSVl6r2YUI7kVSNt1q9bbYmMKOM6j2JnZLtf07ET8h1m83bKLfo6LBvHraKkJTSYqjYgeGpVmb3wtxoOA/Tp+tGsdL70CC/5IPsjaLqCtycnYJIp7ypaRbcOf3d/q6Q+69SoSILkYZuHtevjFs8p295rgQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzpb+qx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9729C2BBFC;
	Thu, 30 May 2024 05:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717047639;
	bh=E6LnrD/Hk+qwsUKIKG2RP/3T2NmB0ssI6Skdon50Tqc=;
	h=From:To:Subject:Date:From;
	b=uzpb+qx6XbnWy41QIy7mLh/J+3V7IH4JdLYsFwX/e4AXNkrFhUY/E8HtMMZ2f6hPA
	 Bks+2ZT+iRcLQH+zT3nZ8qtdwhrw4+hUJZXgrFR3KONtHJVZjrZM9fBmBXHwkDTHlk
	 vEd8LyPt550pvlsSpfHN9jIZZpjh5fqkI+SNFBaJsbFqL2rc/9LWmvDTJQ4HzqWzgJ
	 7TYWIJint/uH4XxQPvUaLZIUVwPcLuYxr0OqDnEH7iyLxDRhOMYt8PTy/qJ1cYU2Vt
	 ZAs7jHzPJE/1bD8wtlytTyPoCBYVDcE0nPlaVpCojXx0opPJcNcPfz+umaRgILbv4l
	 C6SrqDs+K7IbA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 0/4] Zone write plugging and DM zone fixes
Date: Thu, 30 May 2024 14:40:31 +0900
Message-ID: <20240530054035.491497-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch of this series fixes null_blk to avoid weird zone
configurations, namely, a zoned device with a last smaller zone with a
zone capacity smaller than the zone size. Related to this, the next 2
patches fix the handling by zone write plugging of zoned devices with a
last smaller zone. That was completely botched in the initial series.

Finally, the last patch addresses a long standing issue with zoned
device-mapper devices: no zone resource limits (max open and max active
zones limits) are not exposed to the user. This patch fixes that,
allowing for the limits of the underlying target devices to be exposed
with a warning for setups that lead to unreliable limits.

This is all based on block/block-6.10 branch and the last patch depends
on Christoph's recent DM queue limits fixes. While the last patch is
technically not really a fix for a recent bug, it would be nice to get
it in this cycle as the change in the max open zone limits introduced
with zone write plugging (i.e. expose a imax open zone limit of 128 for
devices with no open zones limits) is confusing zonefs tests causing
failures.

Damien Le Moal (4):
  null_blk: Do not allow runt zone with zone capacity smaller then zone size
  block: Fix validation of zoned device with a runt zone
  block: Fix zone write plugging handling of devices with a runt zone
  dm: Improve zone resource limits handling

 block/blk-zoned.c              |  47 ++++++--
 drivers/block/null_blk/zoned.c |  11 ++
 drivers/md/dm-zone.c           | 214 +++++++++++++++++++++++++++------
 include/linux/blkdev.h         |   1 +
 4 files changed, 225 insertions(+), 48 deletions(-)

-- 
2.45.1


