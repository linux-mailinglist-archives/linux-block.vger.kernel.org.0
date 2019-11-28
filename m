Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEF410C2AB
	for <lists+linux-block@lfdr.de>; Thu, 28 Nov 2019 04:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfK1DCV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 27 Nov 2019 22:02:21 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:56692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727545AbfK1DCV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 22:02:21 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BA070D72F2AF38C42A0D;
        Thu, 28 Nov 2019 11:02:19 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 28 Nov 2019
 11:02:09 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <philipp.reisner@linbit.com>, <lars.ellenberg@linbit.com>,
        <axboe@kernel.dk>, <drbd-dev@lists.linbit.com>,
        <linux-block@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 0/3] drivers/block: Remove unneeded semicolon
Date:   Thu, 28 Nov 2019 11:09:29 +0800
Message-ID: <1574910572-42062-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

zhengbin (3):
  drbd: Remove unneeded semicolon
  block: sunvdc: Remove unneeded semicolon
  ataflop: Remove unneeded semicolon

 drivers/block/ataflop.c       | 2 +-
 drivers/block/drbd/drbd_req.c | 2 +-
 drivers/block/sunvdc.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--
2.7.4

