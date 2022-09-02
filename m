Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479B65AABF3
	for <lists+linux-block@lfdr.de>; Fri,  2 Sep 2022 12:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiIBKBP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 2 Sep 2022 06:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbiIBKBO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Sep 2022 06:01:14 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8615584ED8
        for <linux-block@vger.kernel.org>; Fri,  2 Sep 2022 03:01:02 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662112861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2Pr8jM55qb5ld6DpXyfbjKa/xMjtyBHJWaNZZNA6UCY=;
        b=fNSp2gFHBdxYbBn6c9SS81+eKe5XmTY431mrVYKc2YAdsMcnMziPuYF5iuO89dYNdaTtFT
        bZfG/sY4tK5gS2FufQ1kCRvOSilEmZ9azYpm0O3Nj5KgvNm2ar4CasLlrtpqBsQztukYwV
        d9jr+TDvsb6a89OWw6fuhfabwDZeCdw=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH V2 0/3] Small changes for rnbd-srv
Date:   Fri,  2 Sep 2022 18:00:52 +0800
Message-Id: <20220902100055.25724-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Pls review if the new added comment in the first patch is appropriate.

Thanks,
Guoqing

V2 changes:

1. modifiy the first one to add comment in rnbd_srv_rdma_ev

Guoqing Jiang (3):
  rnbd-srv: add comment in rnbd_srv_rdma_ev
  rnbd-srv: make process_msg_close returns void
  rnbd-srv: remove redundant setting of blk_open_flags

 drivers/block/rnbd/rnbd-srv-dev.c |  1 -
 drivers/block/rnbd/rnbd-srv.c     | 12 ++++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.31.1

