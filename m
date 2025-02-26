Return-Path: <linux-block+bounces-17737-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3C0A465FF
	for <lists+linux-block@lfdr.de>; Wed, 26 Feb 2025 17:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDD23BA6AE
	for <lists+linux-block@lfdr.de>; Wed, 26 Feb 2025 16:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1940C21D5BA;
	Wed, 26 Feb 2025 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KytmhZnk"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A7C21D3EF
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585540; cv=none; b=c1bVVpGZ83N7ryimMX3cB4W18Q3pvbqRWxdHg2CGJqhkv6DsSYYhku7J+EO8ve9BzkZIIGFennqcYclPR+IJLL5v/o7X+ldCoqfeJZTuk0GM5DuhBj8rdny0mGgYYXdIghTgEq5bw2V1iw/vkdaWd18ObzRccHZEeEbjKrJHAwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585540; c=relaxed/simple;
	bh=lVmdjTx9DPHEs4/ZixrF+Hcv29z2fxqJ1H+sQPn8zyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mdYZh0mMU1QMXossnKoK4QkOC2/kmhuoWL0PWAwfl9N+i1T9TRcXHaUU6WyKIft1PkSBR4Cn3TOsDJQpgK+5Uoc2s1QMsiNK1NbgCBt2YOKR5zg95twAA3MfLx479jfgMWgQ+cynyw28IWlGhsSEHI0p5Cki2EzRDgTzGZQ9lSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KytmhZnk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740585536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=46hmh7gDdbwl6kn/Gq2HdkYyqMLGwmt0/b3Oy+FeV4c=;
	b=KytmhZnkPDru/taHpodV54gL+GUeGbhG2TJv8zkNnTlqZYHEJp5pUORhrYNhTtnFmRm/Ix
	hLBnymsv4IQwWgim07CBzja3YLGM//PUKyNtYJPBBzO5C/XGpgNHMhZ02ZNlNodqjszSop
	85WldXP4fh++al4ngemBJakXM545mcE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-dYVtDb9RNHCBkeNNr_cAyA-1; Wed,
 26 Feb 2025 10:58:55 -0500
X-MC-Unique: dYVtDb9RNHCBkeNNr_cAyA-1
X-Mimecast-MFC-AGG-ID: dYVtDb9RNHCBkeNNr_cAyA_1740585533
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 759411809CA0;
	Wed, 26 Feb 2025 15:58:51 +0000 (UTC)
Received: from localhost (unknown [10.72.116.7])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C5161800357;
	Wed, 26 Feb 2025 15:58:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/3] selftests: add ublk selftests
Date: Wed, 26 Feb 2025 23:58:35 +0800
Message-ID: <20250226155841.2489284-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello Guys,

The 1st patch adds one ublk utility and one entry test.

The 2nd patch adds test over file backed ublk.

The 3rd patch adds test for ublk zero copy.

How to run:

	- make install
	- make headers_install INSTALL_HDR_PATH=/usr	# in case UAPI is changed
	- reboot
	- make -C tools/testing/selftests TARGETS=ublk run_test

Thanks,

V2:
	- fix one sqe allocation bug, so ublk zero copy with io_link can pass
	- dump log in case of error
	- add one more test for mkfs/mount on zero copy


Ming Lei (3):
  selftests: ublk: add kernel selftests for ublk
  selftests: ublk: add file backed ublk
  selftests: ublk: add ublk zero copy test

 MAINTAINERS                                  |    1 +
 tools/testing/selftests/Makefile             |    1 +
 tools/testing/selftests/ublk/.gitignore      |    3 +
 tools/testing/selftests/ublk/Makefile        |   15 +
 tools/testing/selftests/ublk/config          |    1 +
 tools/testing/selftests/ublk/kublk.c         | 1679 ++++++++++++++++++
 tools/testing/selftests/ublk/test_common.sh  |  112 ++
 tools/testing/selftests/ublk/test_loop_01.sh |   30 +
 tools/testing/selftests/ublk/test_loop_02.sh |   21 +
 tools/testing/selftests/ublk/test_loop_03.sh |   32 +
 tools/testing/selftests/ublk/test_loop_04.sh |   21 +
 tools/testing/selftests/ublk/test_null_01.sh |   18 +
 12 files changed, 1934 insertions(+)
 create mode 100644 tools/testing/selftests/ublk/.gitignore
 create mode 100644 tools/testing/selftests/ublk/Makefile
 create mode 100644 tools/testing/selftests/ublk/config
 create mode 100644 tools/testing/selftests/ublk/kublk.c
 create mode 100755 tools/testing/selftests/ublk/test_common.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_02.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_03.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_04.sh
 create mode 100755 tools/testing/selftests/ublk/test_null_01.sh

-- 
2.47.0


