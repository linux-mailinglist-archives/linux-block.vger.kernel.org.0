Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067886A1C63
	for <lists+linux-block@lfdr.de>; Fri, 24 Feb 2023 13:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBXMqL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Feb 2023 07:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBXMqK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Feb 2023 07:46:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244462ED68
        for <linux-block@vger.kernel.org>; Fri, 24 Feb 2023 04:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677242723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=51KkY8swrw5fC/EzGQ0gAPuupuMaN2l1bOuC0wXhO3g=;
        b=deIbvQphEMj/0AoUvJBjgtct1YOHcT0gMIXp11aut1t1J6vqMOa8UsTJK52VmEXteEBmnl
        BDWKW5BlkKJTzpQZ4UICJOso1pCl2CB4aMd6GRAHmrVY9GmitLpYUTJibSb7kOGWgc1Xog
        xHS0bTc8+O4JAt8TE9bY4h4LoOaAnms=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-v1ERrkvSNwitknDODdXsEw-1; Fri, 24 Feb 2023 07:45:12 -0500
X-MC-Unique: v1ERrkvSNwitknDODdXsEw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B15A81C05B00;
        Fri, 24 Feb 2023 12:45:11 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 229B2C15BAD;
        Fri, 24 Feb 2023 12:45:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH blktests v4 0/2] blktests: add mini ublk source and blktests/033
Date:   Fri, 24 Feb 2023 20:45:00 +0800
Message-Id: <20230224124502.1720278-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

v4:
	- fix one error handling bug in src/miniublk.c
	- patch style improvement on src/miniublk.c
	- both are suggested by Chaitanya Kulkarni

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
 src/miniublk.c      | 1367 +++++++++++++++++++++++++++++++++++++++++++
 tests/block/033     |   41 ++
 tests/block/033.out |    2 +
 6 files changed, 1464 insertions(+)
 create mode 100644 common/ublk
 create mode 100644 src/miniublk.c
 create mode 100755 tests/block/033
 create mode 100644 tests/block/033.out

-- 
2.31.1

