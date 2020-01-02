Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB68F12E37A
	for <lists+linux-block@lfdr.de>; Thu,  2 Jan 2020 08:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgABHx7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 2 Jan 2020 02:53:59 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:19249 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbgABHx7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 02:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1577951638; x=1609487638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=RlibLQQganA2BZ89ch7dSkDd5ROuDmDBz+7MfRKKRsw=;
  b=Vg4tM9WsSJ5EkkuakHUyAMxgZ2+Mbja2rMcFU/ET9tFFwx9FxI1MLjFD
   yiNG59A+gCAPJeOwkcY0+D6/pl+qPTqicV8llmCYKAVFkhrYlyCcKs+wT
   G+YC55SCupAwkyA31x4uJ3P6183zzknphFLdGWS31Z1GESQqlj0vSFRPD
   4=;
IronPort-SDR: PPLhSY4jNtRBa2o7qMz8aHt3QgFdThFlbslEB5/L+ZcMKItPHVxhHM7qn/Q5Y0LGcfjtOs8+LX
 D3R9mD+FVJHA==
X-IronPort-AV: E=Sophos;i="5.69,385,1571702400"; 
   d="scan'208";a="11240006"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 02 Jan 2020 07:53:57 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 93F49A1F00;
        Thu,  2 Jan 2020 07:53:54 +0000 (UTC)
Received: from EX13D01UWA003.ant.amazon.com (10.43.160.107) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 07:53:23 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13d01UWA003.ant.amazon.com (10.43.160.107) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 07:53:23 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 2 Jan 2020 07:53:22 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, <ssomesh@amazon.com>, <jejb@linux.ibm.com>,
        <hch@lst.de>, <mst@redhat.com>, <Chaitanya.Kulkarni@wdc.com>,
        Balbir Singh <sblbir@amazon.com>
Subject: [resend v1 4/5] drivers/nvme/host/core.c: Convert to use disk_set_capacity
Date:   Thu, 2 Jan 2020 07:53:14 +0000
Message-ID: <20200102075315.22652-5-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.5
In-Reply-To: <20200102075315.22652-1-sblbir@amazon.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

block/genhd provides disk_set_capacity() for sending
RESIZE notifications via uevents. This notification is
newly added to NVME devices

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 667f18f465be..cb214e914fc2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1808,7 +1808,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	    ns->lba_shift > PAGE_SHIFT)
 		capacity = 0;
 
-	set_capacity(disk, capacity);
+	disk_set_capacity(disk, capacity);
 
 	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(disk, ns);
-- 
2.16.5

