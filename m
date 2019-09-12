Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75322B0A69
	for <lists+linux-block@lfdr.de>; Thu, 12 Sep 2019 10:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfILIfd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Sep 2019 04:35:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45693 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725940AbfILIfd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Sep 2019 04:35:33 -0400
X-UUID: 3dac9119a87e4e8da46e61abb8454e60-20190912
X-UUID: 3dac9119a87e4e8da46e61abb8454e60-20190912
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1103634065; Thu, 12 Sep 2019 16:35:30 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Sep 2019 16:35:28 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Sep 2019 16:35:28 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <martin.petersen@oracle.com>, <axboe@kernel.dk>,
        <jejb@linux.ibm.com>, <matthias.bgg@gmail.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kuohong.wang@mediatek.com>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <andy.teng@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v2] fixup null q->dev checking in both block and scsi layer
Date:   Thu, 12 Sep 2019 16:35:26 +0800
Message-ID: <1568277328-4597-1-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some devices may skip blk_pm_runtime_init() and have null pointer in its request_queue->dev. For example, SCSI devices of UFS Well-Known LUNs.

Currently the null pointer is checked by the user of blk_set_runtime_active(), i.e., scsi_dev_type_resume(). It is better to check it by blk_set_runtime_active() itself instead of by its users.

v1 => v2:
- Change if style in blk_set_runtime_active() (Jens)

Stanley Chu (2):
  block: bypass blk_set_runtime_active for uninitialized q->dev
  scsi: core: remove dummy q->dev check

 block/blk-pm.c         | 12 +++++++-----
 drivers/scsi/scsi_pm.c |  3 +--
 2 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.18.0

