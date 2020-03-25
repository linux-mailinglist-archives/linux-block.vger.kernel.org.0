Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5957A191E95
	for <lists+linux-block@lfdr.de>; Wed, 25 Mar 2020 02:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgCYBbD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Mar 2020 21:31:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:46620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbgCYBbD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 21:31:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D9EF7ADDD;
        Wed, 25 Mar 2020 01:31:01 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 0/1] bcache: 2nd wave patch for Linux v5.7-rc1 
Date:   Wed, 25 Mar 2020 09:30:56 +0800
Message-Id: <20200325013057.114340-1-colyli@suse.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch fixes a compiling problem reported by the kernel test
robot. Please take it for the Linux v5.7-rc1 patches.

Thanks.

Coly Li
---

Coly Li (1):
  bcache: remove dupplicated declaration from btree.h

 drivers/md/bcache/btree.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

-- 
2.25.0

