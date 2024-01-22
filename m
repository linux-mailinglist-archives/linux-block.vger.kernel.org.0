Return-Path: <linux-block+bounces-2074-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ED8836119
	for <lists+linux-block@lfdr.de>; Mon, 22 Jan 2024 12:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC1A28CAB5
	for <lists+linux-block@lfdr.de>; Mon, 22 Jan 2024 11:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94CD3D0B5;
	Mon, 22 Jan 2024 11:07:39 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7E03D0B4
	for <linux-block@vger.kernel.org>; Mon, 22 Jan 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921659; cv=none; b=sYbBvD2QWS16QvuHahwdorSwuGiCVPAueWjWVCKjd7mmj7Ltu5FU/5Syh4eiC2HC0Xp6NI1UnUhY9yIOn4pddgeu6V1MCsriK675lGj+sXEdiB8HGnY+zYo5tg/fc3BZoWgM3UOU+ZvVLB5siffexvSQURI5pbNYOhNg4iEg1SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921659; c=relaxed/simple;
	bh=AdjZHcaMxR0kQSJ1Jqm5S2agNx0u5TuuEJoLvTn+y2c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nRP1G50rKUPdxbRi4Y9tNyE0JhNTZGgiIUEDPP8GdKLqsBK/2znAIeO4QX4aM/87xIiJ7tZtK1yLA7VPyvPHiaQoMQb7F4MlpjbVj4OIA+MOnkLBAdJgoCqDdjPpInj+QXIrOqaqC54tgQvvKDOOJnYWoWCFSowJKby94N4YhZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40MB7QJh062251;
	Mon, 22 Jan 2024 19:07:26 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TJS13282yz2RcY8P;
	Mon, 22 Jan 2024 19:00:07 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 22 Jan 2024 19:07:24 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <axboe@kernel.dk>, <mst@redhat.com>, <jasowang@redhat.com>
CC: <xuanzhuo@linux.alibaba.com>, <pbonzini@redhat.com>, <stefanha@redhat.com>,
        <virtualization@lists.linux.dev>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.sun@unisoc.com>,
        <zhiguo.niu@unisoc.com>, <hongyu.jin@unisoc.com>,
        <sunyibuaa@gmail.com>
Subject: [PATCH 0/2] Fix requests loss during virtio-blk device suspend
Date: Mon, 22 Jan 2024 19:07:20 +0800
Message-ID: <20240122110722.690223-1-yi.sun@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 40MB7QJh062251

When a virtio-blk device performs a large number of IO operations and
requires sleep at the same time, some requests may never be successfully
processed. 

It must be ensured that no requests in virtqueues before deleting.
The request becoming complete status means that the request has been removed
from the virtqueue.

Yi Sun (2):
  blk-mq: introduce blk_mq_tagset_wait_request_completed()
  virtio-blk: Ensure no requests in virtqueues before deleting vqs.

 block/blk-mq-tag.c         | 29 +++++++++++++++++++++++++++++
 drivers/block/virtio_blk.c |  6 ++++--
 include/linux/blk-mq.h     |  1 +
 3 files changed, 34 insertions(+), 2 deletions(-)

-- 
2.25.1


