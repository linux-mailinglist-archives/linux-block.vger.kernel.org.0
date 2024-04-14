Return-Path: <linux-block+bounces-5912-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6803989B4F8
	for <lists+linux-block@lfdr.de>; Mon,  8 Apr 2024 03:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCEF281440
	for <lists+linux-block@lfdr.de>; Mon,  8 Apr 2024 01:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DB17F8;
	Mon,  8 Apr 2024 01:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrABZLKG"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE117EC
	for <linux-block@vger.kernel.org>; Mon,  8 Apr 2024 01:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712538231; cv=none; b=b1YftV32xaEcvrhJOCdFXHmD9DMWe3HwriMtUP8qJjoR1uYFePGPkBxPpsVieJ8UVEsMBG8Wvlj9lPVmFe9jI5Y7AxG2hCJNNlDYuyIUJJzKoBRs8uGFgTzlH72hD8gvOURLOo2HERKQJDsUdMCUrLoWCItBaZ8Sz6/vhunhsgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712538231; c=relaxed/simple;
	bh=G0ph6cunqh4BI6Y7mYEhiHK5wINeUPpcYlZGTzhqYbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nuWFVjLaWoi2IAHLIBTGz9/homdVZ57d4KsKsp8H6+QMsobKap7frpft/H8PkmG27VR0Wp9QfogJJlddxLOQbd8rRK7OMnidANMQBmR3g+4rSGkSLY7+9ALHlgwqjhlSJyFAPDsEDc9zmErvnDhgK63GQiOcE81yrfqKYfcCWBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KrABZLKG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712538227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e8K243zL1aTj20e6zB2be6Ol4gw5iNqR4+sc1tizRwM=;
	b=KrABZLKGGP5EKZa2VIWhQxxNWFd9XrWZxhZ71e8kulv6jHngtioA4Kyn/k8VKVFNlAD1xN
	dbUkuTXz9PyDbBbXZf368073ZBBAFLrvnQ7c+SADlB41J5uVYQ8HFXF1NJQR5Qu8amLUM8
	amwHy7u4XB8xwm2ncUAiFalpt7moLSk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-r1tLUudLP0y-v9nKZNhYog-1; Sun,
 07 Apr 2024 21:03:41 -0400
X-MC-Unique: r1tLUudLP0y-v9nKZNhYog-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D06329AB426;
	Mon,  8 Apr 2024 01:03:41 +0000 (UTC)
Received: from localhost (unknown [10.72.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9CE1D400EBB;
	Mon,  8 Apr 2024 01:03:39 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 0/9] io_uring: support sqe group and provide group kbuf
Date: Mon,  8 Apr 2024 09:03:13 +0800
Message-ID: <20240408010322.4104395-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Hello,

This patch adds sqe user ext flags, generic sqe group usage, and
provide group kbuf based on sqe group. sqe group provides one efficient
way to share resource among one group of sqes, such as, it can be for
implementing multiple copying(copy data from single source to multiple
destinations) via single syscall.

Finally implements provide group kbuf for uring command, and ublk use this
for supporting zero copy, and actually this feature can be used to support
generic device zero copy.

The last liburing patch adds helpers for using sqe group, also adds
tests for sqe group. 

ublksrv userspace implements zero copy by sqe group & provide group
kbuf:

	https://github.com/ublk-org/ublksrv/commits/group-provide-buf/
	git clone https://github.com/ublk-org/ublksrv.git -b group-provide-buf

	make test T=loop/009:nbd/061:nbd/062	#ublk zc tests

Any comments are welcome!

Ming Lei (9):
  io_uring: net: don't check sqe->__pad2[0] for send zc
  io_uring: support user sqe ext flags
  io_uring: add helper for filling cqes in
    __io_submit_flush_completions()
  io_uring: add one output argument to io_submit_sqe
  io_uring: support SQE group
  io_uring: support providing sqe group buffer
  io_uring/uring_cmd: support provide group kernel buffer
  ublk: support provide io buffer
  liburing: support sqe ext_flags & sqe group

 drivers/block/ublk_drv.c       | 156 ++++++++++++++++++-
 include/linux/io_uring/cmd.h   |   9 ++
 include/linux/io_uring_types.h |  46 +++++-
 include/uapi/linux/io_uring.h  |  24 ++-
 include/uapi/linux/ublk_cmd.h  |   7 +-
 io_uring/filetable.h           |   2 +-
 io_uring/io_uring.c            | 268 +++++++++++++++++++++++++++++----
 io_uring/io_uring.h            |  17 ++-
 io_uring/kbuf.c                |  62 ++++++++
 io_uring/kbuf.h                |  12 ++
 io_uring/net.c                 |  31 +++-
 io_uring/opdef.c               |   5 +
 io_uring/opdef.h               |   2 +
 io_uring/rw.c                  |  20 ++-
 io_uring/uring_cmd.c           |  25 ++-
 15 files changed, 640 insertions(+), 46 deletions(-)

-- 
2.42.0


