Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A2A70F18A
	for <lists+linux-block@lfdr.de>; Wed, 24 May 2023 10:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbjEXI4H (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 May 2023 04:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239901AbjEXI4F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 04:56:05 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D19A97
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 01:56:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VjNZ7Hc_1684918556;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VjNZ7Hc_1684918556)
          by smtp.aliyun-inc.com;
          Wed, 24 May 2023 16:56:01 +0800
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
To:     shinichiro.kawasaki@wdc.com, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V3 blktests 0/2] blktests: Add ublk testcases
Date:   Wed, 24 May 2023 16:55:39 +0800
Message-Id: <20230524085541.20482-1-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

ublk can passthrough I/O requests to userspce daemons. It is very important
to test ublk crash handling since the userspace part is not reliable.
Especially we should test removing device, killing ublk daemons and user
recovery feature.

The first patch add user recovery support in miniublk.

The second patch add five new tests for ublk to cover above cases.

V3:
- run "make check" to avoid warnings
- cleanup code
- just choose ext4 to make ublk/003 more reliable

V2:
- Check parameters in recovery
- Add one small delay before deleting device
- Write informative description

Ziyang Zhang (2):
  src/miniublk: add user recovery
  tests: Add ublk tests
Ziyang Zhang (2):
  src/miniublk: add user recovery
  tests: Add ublk tests

 common/ublk        |  10 +-
 src/miniublk.c     | 269 ++++++++++++++++++++++++++++++++++++++++++---
 tests/ublk/001     |  47 ++++++++
 tests/ublk/001.out |   2 +
 tests/ublk/002     |  62 +++++++++++
 tests/ublk/002.out |   2 +
 tests/ublk/003     |  52 +++++++++
 tests/ublk/003.out |   2 +
 tests/ublk/004     |  49 +++++++++
 tests/ublk/004.out |   2 +
 tests/ublk/005     |  77 +++++++++++++
 tests/ublk/005.out |   2 +
 tests/ublk/006     |  81 ++++++++++++++
 tests/ublk/006.out |   2 +
 tests/ublk/rc      |  17 +++
 15 files changed, 660 insertions(+), 16 deletions(-)
 create mode 100755 tests/ublk/001
 create mode 100644 tests/ublk/001.out
 create mode 100755 tests/ublk/002
 create mode 100644 tests/ublk/002.out
 create mode 100755 tests/ublk/003
 create mode 100644 tests/ublk/003.out
 create mode 100755 tests/ublk/004
 create mode 100644 tests/ublk/004.out
 create mode 100755 tests/ublk/005
 create mode 100644 tests/ublk/005.out
 create mode 100755 tests/ublk/006
 create mode 100644 tests/ublk/006.out
 create mode 100644 tests/ublk/rc

-- 
2.31.1

