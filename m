Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E9D3A0B7D
	for <lists+linux-block@lfdr.de>; Wed,  9 Jun 2021 06:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhFIEjF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Jun 2021 00:39:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:50728 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231335AbhFIEjF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Jun 2021 00:39:05 -0400
IronPort-SDR: eilapuEZOLwWLM6p/L+Mz7tcTBnAmyPsZYNlbf7/3WbPdapOSFvWrTotgx57p9DEzGSxp52U6E
 FTVsVZAquVlw==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="205026800"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="205026800"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 21:37:09 -0700
IronPort-SDR: GtTIlozdkUHp57XpVKcomFMjONL4/eMcCqkCfAzw6RbY8Bcc56JI4KZYq20LgX6dQc3hzUheyv
 MnYUONbLL8Lw==
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="552542206"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 21:37:09 -0700
Subject: [PATCH] libnvdimm/pmem: Fix pmem_pagemap_cleanup compile warning
From:   Dan Williams <dan.j.williams@intel.com>
To:     axboe@kernel.dk
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Tue, 08 Jun 2021 21:37:09 -0700
Message-ID: <162321342919.2151549.7438715629081965798.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <20210609135237.22bde319@canb.auug.org.au>
References: <20210609135237.22bde319@canb.auug.org.au>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The recent fix to pmem_pagemap_cleanup() to solve a NULL pointer
dereference with the queue_to_disk() helper neglected to remove the @q
variable when queue_to_disk() was replaced.

Drop the conversion of @pgmap to its containing 'struct request_queue'
since pgmap->owner supersedes the need to reference @q.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 80b58f4e9f4a ("libnvdimm/pmem: Fix blk_cleanup_disk() usage")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/pmem.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index fc6b78dd2d24..1e0615b8565e 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -335,8 +335,6 @@ static const struct attribute_group *pmem_attribute_groups[] = {
 
 static void pmem_pagemap_cleanup(struct dev_pagemap *pgmap)
 {
-	struct request_queue *q =
-		container_of(pgmap->ref, struct request_queue, q_usage_counter);
 	struct pmem_device *pmem = pgmap->owner;
 
 	blk_cleanup_disk(pmem->disk);

