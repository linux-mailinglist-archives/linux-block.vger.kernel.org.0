Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5ACAF5D2
	for <lists+linux-block@lfdr.de>; Wed, 11 Sep 2019 08:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfIKGcy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Sep 2019 02:32:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39509 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726838AbfIKGcy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 02:32:54 -0400
X-UUID: 4e66592c783140c8bbda8526dd1f5ce8-20190911
X-UUID: 4e66592c783140c8bbda8526dd1f5ce8-20190911
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1938147088; Wed, 11 Sep 2019 14:32:47 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Sep 2019 14:32:46 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Sep 2019 14:32:46 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <martin.petersen@oracle.com>, <axboe@kernel.dk>,
        <jejb@linux.ibm.com>, <matthias.bgg@gmail.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kuohong.wang@mediatek.com>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <andy.teng@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v1 2/2] scsi: core: remove dummy q->dev check
Date:   Wed, 11 Sep 2019 14:32:42 +0800
Message-ID: <1568183562-18241-3-git-send-email-stanley.chu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1568183562-18241-1-git-send-email-stanley.chu@mediatek.com>
References: <1568183562-18241-1-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently blk_set_runtime_active() is checking if q->dev is null by
itself, thus remove the same checking in its user: scsi_dev_type_resume().

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/scsi/scsi_pm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_pm.c b/drivers/scsi/scsi_pm.c
index 74ded5f3c236..3717eea37ecb 100644
--- a/drivers/scsi/scsi_pm.c
+++ b/drivers/scsi/scsi_pm.c
@@ -94,8 +94,7 @@ static int scsi_dev_type_resume(struct device *dev,
 		if (!err && scsi_is_sdev_device(dev)) {
 			struct scsi_device *sdev = to_scsi_device(dev);
 
-			if (sdev->request_queue->dev)
-				blk_set_runtime_active(sdev->request_queue);
+			blk_set_runtime_active(sdev->request_queue);
 		}
 	}
 
-- 
2.18.0

