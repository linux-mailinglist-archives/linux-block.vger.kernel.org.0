Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AC424269C
	for <lists+linux-block@lfdr.de>; Wed, 12 Aug 2020 10:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgHLISp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 Aug 2020 04:18:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726182AbgHLISn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 04:18:43 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 78950CF015B2BA49FB35;
        Wed, 12 Aug 2020 16:18:41 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 12 Aug 2020
 16:18:31 +0800
From:   Chao Leng <lengchao@huawei.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <lengchao@huawei.com>
Subject: [PATCH 0/3] improve nvme retry mechanism
Date:   Wed, 12 Aug 2020 16:18:31 +0800
Message-ID: <20200812081831.22097-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Nvme protocol define local retry and path error. Nvme retry mechanism
should not care blk status, just need use nvme status. The mechanism is:
non path related error will be retry local, path related error will be
treated by multipath. For nvme mulitpah or other multipath(like
dm-multipath), retry mechanism is same.

Chao Leng (3):
  nvme-core: fix io interrupt caused by non path error
  nvme-core: delete the dependency on blk status
  nvme-core: delete the dependency on REQ_FAILFAST_TRANSPORT

 drivers/nvme/host/core.c      | 24 ++++++++++++++++++------
 drivers/nvme/host/multipath.c | 11 +++--------
 drivers/nvme/host/nvme.h      |  5 ++---
 include/linux/nvme.h          |  9 +++++++++
 4 files changed, 32 insertions(+), 17 deletions(-)

-- 
2.16.4

