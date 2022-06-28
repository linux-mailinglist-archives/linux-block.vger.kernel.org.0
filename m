Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE8D55E607
	for <lists+linux-block@lfdr.de>; Tue, 28 Jun 2022 18:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346748AbiF1Ogm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Jun 2022 10:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346391AbiF1Ogm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 10:36:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758932A429
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 07:36:41 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LXRwZ6dJwz9swG;
        Tue, 28 Jun 2022 22:35:58 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 22:36:38 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tj@kernel.org>, <jack@suse.cz>, <hch@lst.de>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 0/2] blk-cgroup: duplicated code refactor
Date:   Tue, 28 Jun 2022 22:49:19 +0800
Message-ID: <20220628144921.2190275-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Two duplicated code segment refactors. No functional change.

Jason Yan (2):
  blk-cgroup: factor out blkcg_iostat_update()
  blk-cgroup: factor out blkcg_free_all_cpd()

 block/blk-cgroup.c | 73 ++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 35 deletions(-)

-- 
2.31.1

