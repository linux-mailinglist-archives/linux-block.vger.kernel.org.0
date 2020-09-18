Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF0526EA9F
	for <lists+linux-block@lfdr.de>; Fri, 18 Sep 2020 03:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIRBrd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 17 Sep 2020 21:47:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13282 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbgIRBrd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Sep 2020 21:47:33 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6E0E3356F3FF3728B20A;
        Fri, 18 Sep 2020 09:47:31 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 09:47:21 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>,
        <yuyufen@huawei.com>
Subject: [PATCH 0/4] some improvements and clean-up for block 
Date:   Thu, 17 Sep 2020 21:47:02 -0400
Message-ID: <20200918014706.1962485-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

  This series contains improvement for elevator exit, removing
  wrong comments and clean-up code.

Yufen Yu (4):
  block: invoke blk_mq_exit_sched no matter whether have .exit_sched
  block: use common interface blk_queue_registered()
  block: fix comment and add lockdep assert
  block: get rid of unnecessary local variable

 block/blk-iocost.c |  2 +-
 block/blk-sysfs.c  |  5 +----
 block/elevator.c   | 19 ++++++-------------
 3 files changed, 8 insertions(+), 18 deletions(-)

-- 
2.25.4

