Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540245259B1
	for <lists+linux-block@lfdr.de>; Fri, 13 May 2022 04:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376488AbiEMCVW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 May 2022 22:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244592AbiEMCVV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 May 2022 22:21:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB6E719D8;
        Thu, 12 May 2022 19:21:18 -0700 (PDT)
Received: from kwepemi100014.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kzskp2mkdzGpVV;
        Fri, 13 May 2022 10:18:26 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100014.china.huawei.com (7.221.188.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 10:21:16 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 10:21:15 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next v2 0/2] block, bfq: make bfq_has_work() more accurate
Date:   Fri, 13 May 2022 10:35:05 +0800
Message-ID: <20220513023507.2625717-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Changes in v2:
 - add reviewed-by tag for patch 1
 - use WRITE_ONCE() for updating of 'bfqd->queued' in patch 2

This patchset try to make bfq_has_work() more accurate, patch 1 is a
small problem found by code review.

BTW, I not sure why blk_mq_run_hw_queues() is called with 'bfqd->lock'
held, I think this is not necessary. And bfq_has_work() can be more
accurate by reading 'bfqd->queued' with 'bfqd->lock' held after patch 2.

Previous versions:
v1: https://lore.kernel.org/all/20220510131629.1964415-1-yukuai3@huawei.com/

Yu Kuai (2):
  block, bfq: protect 'bfqd->queued' by 'bfqd->lock'
  block, bfq: make bfq_has_work() more accurate

 block/bfq-iosched.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

-- 
2.31.1

