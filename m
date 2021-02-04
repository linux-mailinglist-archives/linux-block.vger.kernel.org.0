Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0168C30ECFF
	for <lists+linux-block@lfdr.de>; Thu,  4 Feb 2021 08:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhBDHIn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 4 Feb 2021 02:08:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12020 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbhBDHIe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 02:08:34 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DWV2t4N1QzjJqw;
        Thu,  4 Feb 2021 15:06:30 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Thu, 4 Feb 2021
 15:07:41 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <Markus.Elfring@web.de>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <sunke32@huawei.com>
Subject: [PATCH v4 0/2] fix a NULL pointer bug and simplify the code
Date:   Thu, 4 Feb 2021 02:09:08 -0500
Message-ID: <20210204070910.1401239-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

v4: Share exception handling code for if branches and 
	move put_nbd adjustment to a separate patch.
v3: Do not use unlock and add put_nbd.
v2: Use jump target unlock.

Sun Ke (2):
  nbd: Fix NULL pointer in flush_workqueue
  nbd: share exception handling code by goto put_nbd

 drivers/block/nbd.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.25.4

