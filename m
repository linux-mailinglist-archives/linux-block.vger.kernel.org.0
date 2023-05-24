Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C447470EECD
	for <lists+linux-block@lfdr.de>; Wed, 24 May 2023 09:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbjEXHB2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 May 2023 03:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239716AbjEXHBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 03:01:06 -0400
Received: from out-35.mta0.migadu.com (out-35.mta0.migadu.com [91.218.175.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002801BD
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 00:00:47 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684911645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=t3lPM5xXIMIoaxyh4LLdBvHk5UXIQtgrLDlVAWR1t1c=;
        b=guuLblQSvsK83DG6Jpmkye+yMDJL2YxJoWnGUuAnpgZjHKUpIQKW/w+TvDWEtPd8GQsOn5
        w1CYttrvng3+xCOaml6U7LAPNqY+aXYrD690oi6aBBsshDxuEs8m+eXTiZt/ta+V6ZfeKz
        SEnYGJ92JDLbRdQp25doT1B26DvE5n0=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH V2 0/8] misc patches for rnbd
Date:   Wed, 24 May 2023 15:00:18 +0800
Message-Id: <20230524070026.2932-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

V2 changes:
1. two patches are dropped
2. collect tags from Jack
3. replace "int mode" with "enum rnbd_access_mode" in the 3rd one

Hi,

This series mostly do cleanup and other trival things, pls review.

Thanks,
Guoqing

Guoqing Jiang (8):
  block/rnbd: kill rnbd_flags_supported
  block/rnbd-srv: remove unused header
  block/rnbd: introduce rnbd_access_modes
  block/rnbd-srv: no need to check sess_dev
  block/rnbd-srv: rename one member in rnbd_srv_dev
  block/rnbd-srv: init ret with 0 instead of -EPERM
  block/rnbd-srv: init err earlier in rnbd_srv_init_module
  block/rnbd-srv: make process_msg_sess_info returns void

 drivers/block/rnbd/Makefile         |  6 ++--
 drivers/block/rnbd/rnbd-clt-sysfs.c |  4 +--
 drivers/block/rnbd/rnbd-common.c    | 23 ---------------
 drivers/block/rnbd/rnbd-proto.h     | 31 ++++++--------------
 drivers/block/rnbd/rnbd-srv-sysfs.c |  3 +-
 drivers/block/rnbd/rnbd-srv.c       | 44 +++++++++++++----------------
 drivers/block/rnbd/rnbd-srv.h       |  2 +-
 7 files changed, 34 insertions(+), 79 deletions(-)
 delete mode 100644 drivers/block/rnbd/rnbd-common.c

-- 
2.35.3

