Return-Path: <linux-block+bounces-1541-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEC5822C57
	for <lists+linux-block@lfdr.de>; Wed,  3 Jan 2024 12:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C69B215DA
	for <lists+linux-block@lfdr.de>; Wed,  3 Jan 2024 11:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B2C18EA3;
	Wed,  3 Jan 2024 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eCxerWvJ"
X-Original-To: linux-block@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362E18EA1
	for <linux-block@vger.kernel.org>; Wed,  3 Jan 2024 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704282587; x=1735818587;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rpSonXXobhJN7F10wxs4AmNzlTcw1WjDMUak2XXGL3k=;
  b=eCxerWvJBVZ4gCps3HuNea3QAqJp2O4R5PujbFn7FImSQfRnfef7abNO
   mwt5GG42nZPC5fu/Vv785x8t1T81/JQccl9AaRTsYodhpVsH4xzEgY4e5
   IgX5quPTq9IUCz/S4sBTwFA8Rh/yrRz1oHqWGOgk3eZ7SP7Gk9BFytucv
   ymVpJOC0WdJRWfIXVsYlqXjlI7uT0IpYu6Zp3kd0pUdnZpgxht8vkE233
   KNroNcNbl5icKjWz7x0ebgZol7NEE27XVhQwvt4tvoOfhZXsIJW38ooSt
   crykLNdBryO1Aj4Zm/IwZqqRt3rMWzaAsWtKNzYk2Do4r1ut+mYAO6ioI
   A==;
X-CSE-ConnectionGUID: LmWn5isKSeK6+VfA4/rgKQ==
X-CSE-MsgGUID: 8lsVE4aKSWu/ePcApu/LmA==
X-IronPort-AV: E=Sophos;i="6.04,327,1695657600"; 
   d="scan'208";a="6081451"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2024 19:49:41 +0800
IronPort-SDR: GwzUIwHP3319/TYhxJZ8ixfp1Y4LyZnNYG7SmwpOQ4diIqJUae3sAT5ft8DoxYUsFEwQQAmMPD
 +Bo2Gob9vcIg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jan 2024 03:00:08 -0800
IronPort-SDR: gNTMLEpvhBOgrBMaRZHWYdMoI56dcjQH4mjSTMsDcGy+iGBeZ12t/VSg7kgOrPxoXjL4IGhp3f
 O/sbR1Rq/qMg==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Jan 2024 03:49:41 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/2] block/031: allow to run with built-in null_blk driver
Date: Wed,  3 Jan 2024 20:49:38 +0900
Message-ID: <20240103114940.3000366-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case block/031 now requires loadable null_blk driver. This series
allows it to run with built-in null_blk driver. The first patch prepares for it.
The second patch does the change.

Shin'ichiro Kawasaki (2):
  common/null_blk: introduce _have_null_blk_feature
  block/031: allow to run with built-in null_blk driver

 common/null_blk |  4 ++++
 tests/block/031 | 27 +++++++++++++++++++--------
 2 files changed, 23 insertions(+), 8 deletions(-)

-- 
2.43.0


