Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A25A69C48F
	for <lists+linux-block@lfdr.de>; Mon, 20 Feb 2023 04:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjBTDrw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 19 Feb 2023 22:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjBTDrv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Feb 2023 22:47:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7381C9EEF
        for <linux-block@vger.kernel.org>; Sun, 19 Feb 2023 19:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676864823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Drb6tWmmCLnbOvvndV7moNll8fdr2bhDZ4NOqphQRbM=;
        b=C9huKKxRBUhxojLSPXaX491BxtKh5yd8t7IdEhkwk29J6awFoIMaIMQErJkn98A6E1+epR
        CbYX6AGGF4H8YGBYARN874LEukT8RiNXF4CvW8FbBybtA4UQgvFH28p2Ix971ExwUbgSAf
        dUdmvT8Ig/QlqKLn4UB7LiuZXHOiK6o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-b0UtJhwiO9KelrSkR8Cm8A-1; Sun, 19 Feb 2023 22:46:59 -0500
X-MC-Unique: b0UtJhwiO9KelrSkR8Cm8A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B69F1C05EC7;
        Mon, 20 Feb 2023 03:46:59 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA446492B11;
        Mon, 20 Feb 2023 03:46:55 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH blktests v3 0/2] blktests: add mini ublk source and blktests/033
Date:   Mon, 20 Feb 2023 11:46:47 +0800
Message-Id: <20230220034649.1522978-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st patch adds one mini ublk program, which only supports null &
loop targets.

The 2nd patch add blktests/033 for covering gendisk leak issue.

v3:
	- move minublk.c into src/
	- remove '-i' in top Makefile
	- fix commit log for 1/2
	- add 'udevadm settle' after adding device, so that the following
	test can be done reliably
	- fix _init_ublk()
	- redirect runtime log into $FULL
	- all are suggested by Shinichiro Kawasaki

v2:
	- cleanup & bugfix on miniublk.c
	- avoid ignoring build warning just for addressing missed liburing
	  or ublk kernel header
	- patch style fix
	- make 'make check' happy


Ming Lei (2):
  src: add mini ublk source code
  block/033: add test to cover gendisk leak

 common/ublk         |   35 ++
 src/.gitignore      |    1 +
 src/Makefile        |   18 +
 src/miniublk.c      | 1376 +++++++++++++++++++++++++++++++++++++++++++
 tests/block/033     |   41 ++
 tests/block/033.out |    2 +
 6 files changed, 1473 insertions(+)
 create mode 100644 common/ublk
 create mode 100644 src/miniublk.c
 create mode 100755 tests/block/033
 create mode 100644 tests/block/033.out

-- 
2.31.1

