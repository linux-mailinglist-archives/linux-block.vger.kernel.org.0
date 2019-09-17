Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A29A1B4D47
	for <lists+linux-block@lfdr.de>; Tue, 17 Sep 2019 13:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfIQL4O (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Sep 2019 07:56:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfIQL4O (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 07:56:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F83137E88;
        Tue, 17 Sep 2019 11:56:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.70.39.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF67D19C4F;
        Tue, 17 Sep 2019 11:56:09 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v4 0/2] nbd: fix possible page fault for nbd disk
Date:   Tue, 17 Sep 2019 17:26:04 +0530
Message-Id: <20190917115606.13992-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 17 Sep 2019 11:56:14 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

V3:
- fix the case that when the NBD_CFLAG_DESTROY_ON_DISCONNECT bit is not set.
- add "nbd: rename the runtime flags as NBD_RT_ prefixed"

V4:
- Address the use after free bug from Mike's comments
- This has been test for 3 days, works well.


Xiubo Li (2):
  nbd: rename the runtime flags as NBD_RT_ prefixed
  nbd: fix possible page fault for nbd disk

 drivers/block/nbd.c | 108 +++++++++++++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 36 deletions(-)

-- 
2.21.0

