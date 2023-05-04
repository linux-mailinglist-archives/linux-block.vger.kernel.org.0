Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D706F043A
	for <lists+linux-block@lfdr.de>; Thu, 27 Apr 2023 12:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243559AbjD0Kdr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 27 Apr 2023 06:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243051AbjD0Kdr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2023 06:33:47 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFEB4EC9
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 03:33:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vh7PZu-_1682591616;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0Vh7PZu-_1682591616)
          by smtp.aliyun-inc.com;
          Thu, 27 Apr 2023 18:33:42 +0800
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
To:     shinichiro.kawasaki@wdc.com, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: [PATCH blktests 0/2] blktests: Add ublk testcases
Date:   Thu, 27 Apr 2023 18:32:40 +0800
Message-Id: <20230427103242.31361-1-ZiyangZhang@linux.alibaba.com>
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

Ziyang Zhang (2):
  src/miniublk: add user recovery
  tests: Add ublk tests

 src/miniublk.c     | 207 +++++++++++++++++++++++++++++++++++++++++++--
 tests/ublk/001     |  39 +++++++++
 tests/ublk/001.out |   2 +
 tests/ublk/002     |  53 ++++++++++++
 tests/ublk/002.out |   2 +
 tests/ublk/003     |  43 ++++++++++
 tests/ublk/003.out |   2 +
 tests/ublk/004     |  63 ++++++++++++++
 tests/ublk/004.out |   2 +
 tests/ublk/005     |  66 +++++++++++++++
 tests/ublk/005.out |   2 +
 11 files changed, 472 insertions(+), 9 deletions(-)
 create mode 100644 tests/ublk/001
 create mode 100644 tests/ublk/001.out
 create mode 100644 tests/ublk/002
 create mode 100644 tests/ublk/002.out
 create mode 100644 tests/ublk/003
 create mode 100644 tests/ublk/003.out
 create mode 100644 tests/ublk/004
 create mode 100644 tests/ublk/004.out
 create mode 100644 tests/ublk/005
 create mode 100644 tests/ublk/005.out

-- 
2.31.1

