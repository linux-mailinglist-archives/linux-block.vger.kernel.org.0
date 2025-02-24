Return-Path: <linux-block+bounces-17546-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71290A42F19
	for <lists+linux-block@lfdr.de>; Mon, 24 Feb 2025 22:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64003AF32C
	for <lists+linux-block@lfdr.de>; Mon, 24 Feb 2025 21:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0EE1D2F42;
	Mon, 24 Feb 2025 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="aXPaLlEG"
X-Original-To: linux-block@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA81DD0F6
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432690; cv=none; b=TeioUI+HcBsCxaTc7SRmuHFckUgOwdgZ3pQKX9XbYpaJifuMxXyyKLSSnJvWFVtOOtPklb3y9vv1iCpawQklYN/C9DF5LH/nn2tDvDL5VtmOkzi3zdNhuLQ/7vjzBAxN0wt/6UjYICqZTj0tMyniRA301Gb4W8f0pg7nKq2Pz1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432690; c=relaxed/simple;
	bh=TpqIpTHEgRqyy6MkuloBhooOvhaIMOYl/sCLApQlu6o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oYPoAnWHRL4SWrCgp0OuEoa0KsSR1/dJmLb3XDHlL3qKoGpYE/DCrmScGjk77XLrLGSlGQiakbcM9rfNXgU/JbArfjOm/65EDQnvuoi6A2yLx5vCr5dk9fLGUL5gQPfa8X2Z9sWRaKagKKzjQGIZcZEjlbCzo3bpfA7K9u0xmlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=aXPaLlEG; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OIueGa016585
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 13:31:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=yrXtyhJQHQgiKxVcTH
	ZCZ9LdqBB8yXkvAT/69Jy1UE0=; b=aXPaLlEGR8CFEC8cRF3quwQDyPMV6FnJPs
	vwh4XN75sb7XlwCgeR3+s4f9QzRq7pZC03fteoUQKEyiGW9JjaBOZM78ptehCfw4
	KezlwTR5kx+ZmjvjdEjPXDC649CMLONUijyxF4JRAkDfhfGXvYr2wTHVh6w84Rsh
	Aj+WvlkdK9hNynof6iU1/oBGFBmga1TaTIH57DABDFugnufcODrHzTRXJwaexszs
	0juVOCdLPsVRWIRofQEaZFvHuyMQRpc2g3BnB7+2N9mRaSbguqdFzKk3FZVB/F9u
	9YjYfTDpP8ApKi6rcIyR/2FRFZaE3Hiyq8pYxh9MJr4UeTOQjxug==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 450xg0s6s4-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 13:31:27 -0800 (PST)
Received: from twshared29376.33.frc3.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 24 Feb 2025 21:31:16 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 4C96B1868C4E5; Mon, 24 Feb 2025 13:31:17 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <ming.lei@redhat.com>, <asml.silence@gmail.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <bernd@bsbernd.com>, <csander@purestorage.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 00/11] ublk zero copy support
Date: Mon, 24 Feb 2025 13:31:05 -0800
Message-ID: <20250224213116.3509093-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: BWBahLvjRtNPMspxkmlvyMG12-KJV9Rv
X-Proofpoint-GUID: BWBahLvjRtNPMspxkmlvyMG12-KJV9Rv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_10,2025-02-24_02,2024-11-22_01

From: Keith Busch <kbusch@kernel.org>

Changes from v4:

  A few cleanup prep patches from me and Pavel are at the beginning of
  this series.

  Uses Pavel's combined buffer lookup and import. This simplifies
  utilizing fixed buffers a bit later in the series, and obviates any
  need to generically handle fixed buffers. This also fixes up the net
  zero-copy notif assignemnet that Ming pointed out.

  Included the nvme uring_cmd fix for using kernel registered bvecs from
  Xinyu.

  Used speculative safe array indexes when registering a new bvec
  (Pavel).

  Encode the allowed direction as bit flags (Caleb, Pavel).

  Incorporated various cleanups suggested by Caleb.

Keith Busch (7):
  io_uring/rsrc: remove redundant check for valid imu
  io_uring/nop: reuse req->buf_index
  io_uring/rw: move fixed buffer import to issue path
  io_uring: add support for kernel registered bvecs
  ublk: zc register/unregister bvec
  io_uring: add abstraction for buf_table rsrc data
  io_uring: cache nodes and mapped buffers

Pavel Begunkov (3):
  io_uring/net: reuse req->buf_index for sendzc
  io_uring/nvme: pass issue_flags to io_uring_cmd_import_fixed()
  io_uring: combine buffer lookup and import

Xinyu Zhang (1):
  nvme: map uring_cmd data even if address is 0

 drivers/block/ublk_drv.c       | 117 +++++++++----
 drivers/nvme/host/ioctl.c      |  12 +-
 include/linux/io_uring/cmd.h   |  13 +-
 include/linux/io_uring_types.h |  24 ++-
 include/uapi/linux/ublk_cmd.h  |   4 +
 io_uring/fdinfo.c              |   8 +-
 io_uring/filetable.c           |   2 +-
 io_uring/net.c                 |  25 +--
 io_uring/nop.c                 |   7 +-
 io_uring/opdef.c               |   8 +-
 io_uring/register.c            |   2 +-
 io_uring/rsrc.c                | 304 +++++++++++++++++++++++++++------
 io_uring/rsrc.h                |  16 +-
 io_uring/rw.c                  |  52 +++---
 io_uring/rw.h                  |   4 +-
 io_uring/uring_cmd.c           |  28 +--
 16 files changed, 433 insertions(+), 193 deletions(-)

--=20
2.43.5


