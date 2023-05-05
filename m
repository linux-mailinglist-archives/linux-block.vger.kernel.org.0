Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B65F6F7B7C
	for <lists+linux-block@lfdr.de>; Fri,  5 May 2023 05:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjEED20 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 4 May 2023 23:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEED2Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2023 23:28:25 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D5C7EFD
        for <linux-block@vger.kernel.org>; Thu,  4 May 2023 20:28:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VhnGANk_1683257289;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VhnGANk_1683257289)
          by smtp.aliyun-inc.com;
          Fri, 05 May 2023 11:28:20 +0800
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
To:     shinichiro.kawasaki@wdc.com, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH V2 blktests 0/2] blktests: Add ublk testcases
Date:   Fri,  5 May 2023 11:28:06 +0800
Message-Id: <20230505032808.356768-1-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
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

V2:
- Check parameters in recovery
- Add one small delay before deleting device
- Write informative description

Ziyang Zhang (2):
  src/miniublk: add user recovery
  tests: Add ublk tests

 common/ublk        |  10 +-
 src/miniublk.c     | 269 ++++++++++++++++++++++++++++++++++++++++++---
 tests/ublk/001     |  48 ++++++++
 tests/ublk/001.out |   2 +
 tests/ublk/002     |  63 +++++++++++
 tests/ublk/002.out |   2 +
 tests/ublk/003     |  48 ++++++++
 tests/ublk/003.out |   2 +
 tests/ublk/004     |  50 +++++++++
 tests/ublk/004.out |   2 +
 tests/ublk/005     |  79 +++++++++++++
 tests/ublk/005.out |   2 +
 tests/ublk/006     |  83 ++++++++++++++
 tests/ublk/006.out |   2 +
 tests/ublk/rc      |  15 +++
 15 files changed, 661 insertions(+), 16 deletions(-)
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

