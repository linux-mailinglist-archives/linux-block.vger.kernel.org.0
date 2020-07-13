Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419EF21D605
	for <lists+linux-block@lfdr.de>; Mon, 13 Jul 2020 14:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgGMMfR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 13 Jul 2020 08:35:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:33078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgGMMfR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jul 2020 08:35:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1124AC91;
        Mon, 13 Jul 2020 12:35:17 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>
Subject: [PATCH 0/2] two generic block layer fixes for 5.9 
Date:   Mon, 13 Jul 2020 20:35:09 +0800
Message-Id: <20200713123511.19441-1-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

These two patches are posted for a while, and have reviewed by several
other developers. Could you please to take them for Linux v5.9 ?

Thanks in advance.

Coly Li
---

Coly Li (2):
  block: change REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_ALL to be odd
    numbers
  block: improve discard bio alignment in __blkdev_issue_discard()

 block/blk-lib.c           | 25 +++++++++++++++++++++++--
 block/blk.h               | 14 ++++++++++++++
 include/linux/blk_types.h |  8 ++++----
 3 files changed, 41 insertions(+), 6 deletions(-)

-- 
2.26.2

