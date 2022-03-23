Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D91F4E5386
	for <lists+linux-block@lfdr.de>; Wed, 23 Mar 2022 14:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244507AbiCWNvP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 23 Mar 2022 09:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242760AbiCWNvP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Mar 2022 09:51:15 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E4246B0C;
        Wed, 23 Mar 2022 06:49:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V8.x0oe_1648043380;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0V8.x0oe_1648043380)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Mar 2022 21:49:41 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, bostroesser@gmail.com
Subject: [PATCH v2 0/3] three bug fixes about tcmu page fault handle
Date:   Wed, 23 Mar 2022 21:49:37 +0800
Message-Id: <20220323134940.31463-1-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Xiaoguang Wang (3):
  scsi: target: tcmu: Fix possible page UAF
  scsi: target: tcmu: Fix possible data corruption
  scsi: target: tcmu: Use address_space->invalidate_lock

 drivers/target/target_core_user.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

-- 
2.14.4.44.g2045bb6

