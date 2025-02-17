Return-Path: <linux-block+bounces-17254-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B133DA36218
	for <lists+linux-block@lfdr.de>; Fri, 14 Feb 2025 16:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6592718961FB
	for <lists+linux-block@lfdr.de>; Fri, 14 Feb 2025 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE64267382;
	Fri, 14 Feb 2025 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ArsodE3S"
X-Original-To: linux-block@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852692673A0
	for <linux-block@vger.kernel.org>; Fri, 14 Feb 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547840; cv=none; b=UArp4GVm9703NN2qBtxjAJxoZK+bsh8I2cJkZO34ehGnKyUix5F0IhJLCBm1+nD7vmU0+mU9ULIL/HLs84lP3InvbzbdJBXEER20/hVz2AlrOvgxTabyq54ccNbylQQOE9EQyQTOtI2ndt/+pIn9d5lgCvVS7GAFB7bEEBHvxgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547840; c=relaxed/simple;
	bh=JtRO7/9akkUnGPuKN29F1CC7He+e5OifRG0AcXByYn8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dfFD01a8TrBbaNUGqcinWkPqt721tNMzVW5esXdf7VmiMClrKaBFFDiCxZfA2trITldFxmk5xo97qR7ze56J36WT50XNyQaYfUTr82EC3PnQZZqRKKWr7jh/W+YmIKgctOZHw6ptfwe3zxvdp3sp2190w6jhB5rfgXLNi/i2E14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ArsodE3S; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EE0Kcd004277
	for <linux-block@vger.kernel.org>; Fri, 14 Feb 2025 07:43:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=Uz7QnoVRYxAuthHNdb
	2dhFCRervR6/2B0R/MoeaQpJ0=; b=ArsodE3Sux/ohfNuWwUr38AHFDWhvwkKP9
	a5Azn911GRsB3vtBhhgDJvfNZ42zlUtWsJ5BSMTVFd+V7FtR2Q26k45tUs6rxoe9
	heJ9ApI5E+Iy7p0WLpNpwLiHW43mR9qNZgvJYEXTggTGP/Y7UgYfsvVw6tDvH5GN
	Wazhve5PtAE+odz8zeS4qFL6XqaRk8E8Hci9O/r4q/z/xFuY8CLxaCH7BMTDpo9q
	/zlhDRscnI3JxRgyRVQtj7NOxKY8hppKW6Hygqq+MjedCfaXO0F/Dhxk1Fp8WTKe
	jZD5fwEuBOgMByBuG+/rzrbC1ipVi44D5OisEcqPiLMp4rqJ2cXw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44t1nu2nrt-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 14 Feb 2025 07:43:57 -0800 (PST)
Received: from twshared40462.17.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 14 Feb 2025 15:43:52 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 1D16D18060B56; Fri, 14 Feb 2025 07:43:49 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <ming.lei@redhat.com>, <asml.silence@gmail.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <bernd@bsbernd.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/5] ublk zero-copy support
Date: Fri, 14 Feb 2025 07:43:43 -0800
Message-ID: <20250214154348.2952692-1-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: rDJ4_fVkBnqFh-MK6_KwJfb_S2_QOzlE
X-Proofpoint-GUID: rDJ4_fVkBnqFh-MK6_KwJfb_S2_QOzlE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01

From: Keith Busch <kbusch@kernel.org>

Changes from v2:

 This one allows you to use the IOSQE_LINK_FLAG so you can strictly
 order the sequence.

 No special "KBUF" node type. We use the 'release' callback to tell the
 difference now.

 Moved the 'release' callback from the node to the imu where it belongs.

Keith Busch (5):
  io_uring: move fixed buffer import to issue path
  io_uring: add support for kernel registered bvecs
  ublk: zc register/unregister bvec
  io_uring: add abstraction for buf_table rsrc data
  io_uring: cache nodes and mapped buffers

 drivers/block/ublk_drv.c       | 137 +++++++++++++-----
 include/linux/io_uring.h       |   1 +
 include/linux/io_uring_types.h |  33 +++--
 include/uapi/linux/ublk_cmd.h  |   4 +
 io_uring/fdinfo.c              |   8 +-
 io_uring/filetable.c           |   2 +-
 io_uring/io_uring.c            |  19 +++
 io_uring/net.c                 |  25 +---
 io_uring/nop.c                 |  22 +--
 io_uring/register.c            |   2 +-
 io_uring/rsrc.c                | 257 ++++++++++++++++++++++++++-------
 io_uring/rsrc.h                |   4 +-
 io_uring/rw.c                  |  45 ++++--
 io_uring/uring_cmd.c           |  16 +-
 14 files changed, 409 insertions(+), 166 deletions(-)

--=20
2.43.5


