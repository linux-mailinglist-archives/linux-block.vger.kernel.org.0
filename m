Return-Path: <linux-block+bounces-547-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2267F7FD426
	for <lists+linux-block@lfdr.de>; Wed, 29 Nov 2023 11:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32272832B7
	for <lists+linux-block@lfdr.de>; Wed, 29 Nov 2023 10:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E0E1B27C;
	Wed, 29 Nov 2023 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KaFKgob8"
X-Original-To: linux-block@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC6DCE
	for <linux-block@vger.kernel.org>; Wed, 29 Nov 2023 02:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701253907; x=1732789907;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8HN2bZpX2zrF+cScxbnudEtsdYHExaDVsjbPmD9hOVc=;
  b=KaFKgob8ZIAMbwOL01VeC2aWuyW6ElDIqxpJ+pDC14xevcf0h8g0sgbe
   kQEgEqzdZ33vZXWrVCKw//GdR9lgHwcT5eTDK2wI2b5/AJWt+vzAq3AUT
   SBeeYs5OGbz4bS/6LV5VgFF2KUlFS2d5mz+vpGuFnvaLujc1gMFVnVvji
   K3qRPD9n3fEhsR85yeks+pfOisZkVw066jndyihl032DPYmH9y8sX7Pm3
   f4tD8zKb++5CgTZs5MRVg7NTUmv4YwU8JA664iEu0El05FT5vSDfF7gNA
   v4adYQQOOrVERMBUQUqMaxlmB3uhshU8wRtI0PGveGQcZvxlXnxSLS/bH
   A==;
X-CSE-ConnectionGUID: 0fFLOi5NQWWCNXkW8zVzTQ==
X-CSE-MsgGUID: b7Eet3CvTnqsV7Rg748ehw==
X-IronPort-AV: E=Sophos;i="6.04,235,1695657600"; 
   d="scan'208";a="3614309"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2023 18:31:46 +0800
IronPort-SDR: SE+aAEqtAWt4TLx/xaZJyIqlYdfurmbcasLlTEt9pICEvuYiWISwcdLdvr5G2LI+gwnqu0vWgQ
 Aant9nb6no2Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2023 01:37:15 -0800
IronPort-SDR: t6PUQ6fqgIkM4R/5mjFgpbZVyTxz4HuhEeDCAtq3jxyCwwtLLxYX7VLSh22CNjmIP0AtafCXjL
 Hl3aXDB9Y0CQ==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Nov 2023 02:31:46 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/2] improve block/011
Date: Wed, 29 Nov 2023 19:31:43 +0900
Message-ID: <20231129103145.655612-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses two issues of the test case block/011. The first patch
avoids bad status of test target devices left after the test case. The second
patch caps very long test time of the test case.

Shin'ichiro Kawasaki (2):
  block/011: recover test target devices to online or live status
  block/011: set default timeout to 20 minutes

 tests/block/011 | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

-- 
2.43.0


