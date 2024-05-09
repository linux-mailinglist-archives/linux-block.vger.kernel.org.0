Return-Path: <linux-block+bounces-7153-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 747318C09D9
	for <lists+linux-block@lfdr.de>; Thu,  9 May 2024 04:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4411F22DA0
	for <lists+linux-block@lfdr.de>; Thu,  9 May 2024 02:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0C2146A67;
	Thu,  9 May 2024 02:40:34 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8083113CA9C
	for <linux-block@vger.kernel.org>; Thu,  9 May 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715222434; cv=none; b=Ps0K1DfKY0FQx2aY8MykodoapDqABNOPaLnnYOM5Bwv6fSowU292dbSvkKwEtgasayev34RkrQsGRiJeCW141QgZ95dN0YCizZGL5nXiqkLNbTWi68T5v03Hknr09FJ5QnG1Sz+glXLYSQ9QjV5wQPM5yru6qnKML2bEXCU491A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715222434; c=relaxed/simple;
	bh=lEewC/Whf/QntDU1BLQrxCoQoo0Ce9K5wSuMQsc8PaA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TAyzttiaNQO2cVf6dNHxp6wABNqpkwcs4Udv3XXTBNkRMuBGA17lcYil1OMlY6PliGdZ0l5RL18G1xzoZ45LPR6J6Xpc+1FDbB69priFcwTg1ugccBLbe8DHjHrgBzDiQtY2wFP/6UCtU/uTktSHOkd6KGMPFnqqcWdCo3S5M8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4492dhtm051819;
	Thu, 9 May 2024 10:39:43 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VZbkD2Xj6z2PGl6X;
	Thu,  9 May 2024 10:36:36 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 9 May 2024 10:39:40 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox
	<willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo
	<tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>, <linux-mm@kvack.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, Zhaoyang Huang <huangzhaoyang@gmail.com>,
        <steve.kang@unisoc.com>
Subject: [RFC PATCH 0/2] introduce budgt control in readahead
Date: Thu, 9 May 2024 10:39:35 +0800
Message-ID: <20240509023937.1090421-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 4492dhtm051819

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Over-limit bw value is observed during fio test in the throttling group
which caused by over-sized bio as there is no control on ra->size during
readahead. This series patches would like to introduce the helper
function to provide the bytes limit and apply it on readahead.

Please find below for the fio test result on v6.6 which presents 2%-10%
improvement for BW and lat. Besides, we can also observed stable BW
instantaneous value during the test.

blkio.throttle.read_bps_device = 1MB/s
   before:  read: IOPS=223, BW=894KiB/s (915kB/s)(175MiB/200919msec)
   after :  read: IOPS=239, BW=960KiB/s (983kB/s)(153MiB/163105msec)

   before:  clat (usec): min=4, max=16795k, avg=4468.74, stdev=265746.14
            lat  (usec): min=6, max=16795k, avg=4470.57, stdev=265746.14
   after :  clat (usec): min=11, max=209193, avg=4105.22, stdev=27188.04
            lat  (usec): min=16, max=209197, avg=4120.03, stdev=27188.04


blkio.throttle.read_bps_device = 10MB/s
   before:  read: IOPS=2380, BW=9524KiB/s (9752kB/s)(1007MiB/108311msec)
   after :  read: IOPS=2438, BW=9754KiB/s (9989kB/s)(1680MiB/176405msec)

   before:  clat (usec): min=4, max=201817, avg=399.58, stdev=8268.85
            lat  (usec): min=6, max=201819, avg=402.10, stdev=8268.85
   after :  clat (usec): min=4, max=2494.6k, avg=412.72, stdev=25783.51
            lat  (usec): min=6, max=2494.6k, avg=414.48, stdev=25783.51

Zhaoyang Huang (2):
  block: introduce helper function to calculate bps budgt
  mm: introduce budgt control in readahead

 block/blk-throttle.c       | 44 ++++++++++++++++++++++++++++++++++++++
 include/linux/blk-cgroup.h | 10 +++++++++
 mm/readahead.c             | 33 ++++++++++++++++++++--------
 3 files changed, 78 insertions(+), 9 deletions(-)

-- 
2.25.1


