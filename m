Return-Path: <linux-block+bounces-9804-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F26A1929024
	for <lists+linux-block@lfdr.de>; Sat,  6 Jul 2024 05:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7864D1F21F99
	for <lists+linux-block@lfdr.de>; Sat,  6 Jul 2024 03:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72975C8F6;
	Sat,  6 Jul 2024 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0Ja/wnm"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB07C156
	for <linux-block@vger.kernel.org>; Sat,  6 Jul 2024 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720235417; cv=none; b=SxCFkdx/0evAJwbqHlPJQ+VH6fPzeNFY+4NPgs5zQMD1FpcoAQc4g4bk8Rx0jBH8rSXSmwadsbaWSYIkMaEngHXRAicEdefYd5aPOijrB4w0oer1NoJoWxOmpjAm8EQiqwT59b7Id6qrn7F/hgWUmcvy7MpbUervqM4NMoRQch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720235417; c=relaxed/simple;
	bh=Nnb1sSBc0cWzD8H9bgfqK+gmem0wJV6C9FFtaw2evNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hvQfcxPKuRoTvXZI71hKfbMKnHecJGziKbf+AewQqQsIsnlWg0VFvJiiotkRv9tInVMW//joJfx+LsD0a0gn1Z5cD3NTJYde4W89lFrbq4NnvejeM+L0E6Zq8fHBaKhgYXAC3YeELVvUer3ZaNXmiglSFo582kXsSRsIuOAejSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D0Ja/wnm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720235414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=434DiSFQXKq329N9tWEEhIDlMJCLfG5cdGiEfNmfExk=;
	b=D0Ja/wnmccIFbhhTX0YPJ42Yccih6zPZgIMxqFqMtkyWlIEQBSwZZu1L6GBbgn/SRHKun3
	VVVvtQ0rGG1c+O1gZZ8bmhFNCMX4dF0TQcYL8q297leTc1HhhRLFzsEZv8QrFx1vm7plIo
	gxemZ3qAH7a2yf2doA7uoeK62ArrTDY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-w6KeHqoRNQ2Db9-w51naXw-1; Fri,
 05 Jul 2024 23:10:11 -0400
X-MC-Unique: w6KeHqoRNQ2Db9-w51naXw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDAE81956088;
	Sat,  6 Jul 2024 03:10:09 +0000 (UTC)
Received: from localhost (unknown [10.72.112.32])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 78DDF3000184;
	Sat,  6 Jul 2024 03:10:07 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 0/8] io_uring: support sqe group and provide group kbuf
Date: Sat,  6 Jul 2024 11:09:50 +0800
Message-ID: <20240706031000.310430-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello,

The 1st 3 patches are cleanup, and prepare for adding sqe group.

The 4th patch supports generic sqe group which is like link chain, but
allows each sqe in group to be issued in parallel and the group shares
same IO_LINK & IO_DRAIN boundary, so N:M dependency can be supported with
sqe group & io link together. sqe group changes nothing on
IOSQE_IO_LINK.

The 5th patch supports one variant of sqe group: allow members to depend
on group leader, so that kernel resource lifetime can be aligned with
group leader or group, then any kernel resource can be shared in this
sqe group, and can be used in generic device zero copy.

The 6th & 7th patches supports providing sqe group buffer via the sqe
group variant.

The 8th patch supports ublk zero copy based on io_uring providing sqe
group buffer.

Tests:

1) pass liburing test
- make runtests

2) write/pass two sqe group test cases:

https://github.com/axboe/liburing/compare/master...ming1:liburing:sqe_group_v2

- covers related sqe flags combination and linking groups, both nop and
one multi-destination file copy.

- cover failure handling test: fail leader IO or member IO in both single
  group and linked groups, which is done in each sqe flags combination
  test

3) ublksrv zero copy:

ublksrv userspace implements zero copy by sqe group & provide group
kbuf:

	git clone https://github.com/ublk-org/ublksrv.git -b group-provide-buf_v2
	make test T=loop/009:nbd/061	#ublk zc tests

When running 64KB/512KB block size test on ublk-loop('ublk add -t loop --buffered_io -f $backing'),
it is observed that perf is doubled.

Any comments are welcome!

V4:
	- address most comments from Pavel
	- fix request double free
	- don't use io_req_commit_cqe() in io_req_complete_defer()
	- make members' REQ_F_INFLIGHT discoverable
	- use common assembling check in submission code path
	- drop patch 3 and don't move REQ_F_CQE_SKIP out of io_free_req()
	- don't set .accept_group_kbuf for net send zc, in which members
	  need to be queued after buffer notification is got, and can be
	  enabled in future
	- add .grp_leader field via union, and share storage with .grp_link
	- move .grp_refs into one hole of io_kiocb, so that one extra
	cacheline isn't needed for io_kiocb
	- cleanup & document improvement

V3:
	- add IORING_FEAT_SQE_GROUP
	- simplify group completion, and minimize change on io_req_complete_defer()
	- simplify & cleanup io_queue_group_members()
	- fix many failure handling issues
	- cover failure handling code in added liburing tests
	- remove RFC

V2:
	- add generic sqe group, suggested by Kevin Wolf
	- add REQ_F_SQE_GROUP_DEP which is based on IOSQE_SQE_GROUP, for sharing
	  kernel resource in group wide, suggested by Kevin Wolf
	- remove sqe ext flag, and use the last bit for IOSQE_SQE_GROUP(Pavel),
	in future we still can extend sqe flags with one uring context flag
	- initialize group requests via submit state pattern, suggested by Pavel
	- all kinds of cleanup & bug fixes

Ming Lei (8):
  io_uring: add io_link_req() helper
  io_uring: add io_submit_fail_link() helper
  io_uring: add helper of io_req_commit_cqe()
  io_uring: support SQE group
  io_uring: support sqe group with members depending on leader
  io_uring: support providing sqe group buffer
  io_uring/uring_cmd: support provide group kernel buffer
  ublk: support provide io buffer

 drivers/block/ublk_drv.c       | 158 ++++++++++++-
 include/linux/io_uring/cmd.h   |   7 +
 include/linux/io_uring_types.h |  54 +++++
 include/uapi/linux/io_uring.h  |  11 +-
 include/uapi/linux/ublk_cmd.h  |   7 +-
 io_uring/io_uring.c            | 392 +++++++++++++++++++++++++++++----
 io_uring/io_uring.h            |  24 ++
 io_uring/kbuf.c                |  60 +++++
 io_uring/kbuf.h                |  13 ++
 io_uring/net.c                 |  23 +-
 io_uring/opdef.c               |   4 +
 io_uring/opdef.h               |   2 +
 io_uring/rw.c                  |  20 +-
 io_uring/timeout.c             |   2 +
 io_uring/uring_cmd.c           |  28 +++
 15 files changed, 752 insertions(+), 53 deletions(-)

-- 
2.42.0


