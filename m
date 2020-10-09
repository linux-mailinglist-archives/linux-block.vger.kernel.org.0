Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1091E2880AD
	for <lists+linux-block@lfdr.de>; Fri,  9 Oct 2020 05:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbgJIDX1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 8 Oct 2020 23:23:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729318AbgJIDX0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 23:23:26 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1F21E982E6B38E65CB67;
        Fri,  9 Oct 2020 11:23:24 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 11:23:20 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hch@lst.de>
Subject: [RESEND PATCH v2 0/7] some improvements and cleanups for block
Date:   Thu, 8 Oct 2020 23:26:26 -0400
Message-ID: <20201009032633.83645-1-yuyufen@huawei.com>
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

Yufen Yu (7):
  block: invoke blk_mq_exit_sched no matter whether have .exit_sched
  block: remove redundant mq check
  block: use helper function to test queue register
  blk-mq: use helper function to test hw stopped
  block: fix comment and add lockdep assert
  block: get rid of unnecessary local variable
  blk-mq: get rid of the dead flush handle code path

 block/blk-iocost.c   |  2 +-
 block/blk-mq-sched.c |  6 ------
 block/blk-mq.c       |  2 +-
 block/blk-sysfs.c    |  5 +----
 block/elevator.c     | 23 ++++++++---------------
 5 files changed, 11 insertions(+), 27 deletions(-)

-- 
2.25.4

