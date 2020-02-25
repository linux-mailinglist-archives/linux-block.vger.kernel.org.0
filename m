Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94BCE16EF92
	for <lists+linux-block@lfdr.de>; Tue, 25 Feb 2020 21:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbgBYUCS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 Feb 2020 15:02:18 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:16699 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731480AbgBYUCR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 15:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582660937; x=1614196937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=cWa6Fn7t0zpgUPTzyy7cZ2J7YPrWlvJCca1owelSg8I=;
  b=Qf+LGa3vsYgn342XorIdZGTC3jMFPjjCaeD99AWOl6C+kOCwLeqAahSO
   x0ajxIlgdbyFSHxU++u4zo7HW+Lq2JGfb7cpDPL2Ssf25LNOhq7Wq6zJg
   9K290JmJBVqjMblEb7f6l5HimlE+/CqCmJL6wsYNvcVMbi0GWeNC968HX
   E=;
IronPort-SDR: 0CTfqoGrztyFkxdWl7N+5xyPS/L7yzb0LCX1wGufvVj4n5Lfie5aXLi34SDtZ1xsd6Elp+FXKS
 Vw9pMSA3ejrg==
X-IronPort-AV: E=Sophos;i="5.70,485,1574121600"; 
   d="scan'208";a="19066438"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 25 Feb 2020 20:02:14 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 23DF6A2E94;
        Tue, 25 Feb 2020 20:02:11 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 25 Feb 2020 20:01:42 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 25 Feb 2020 20:01:42 +0000
Received: from localhost (10.2.75.237) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 25 Feb 2020 20:01:42 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, <Chaitanya.Kulkarni@wdc.com>, <mst@redhat.com>,
        <jejb@linux.ibm.com>, <hch@lst.de>,
        Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v2 5/5] drivers/scsi/sd.c: Convert to use set_capacity_revalidate_and_notify
Date:   Tue, 25 Feb 2020 20:01:29 +0000
Message-ID: <20200225200129.6687-6-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200225200129.6687-1-sblbir@amazon.com>
References: <20200225200129.6687-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

block/genhd provides set_capacity_revalidate_and_notify() for sending RESIZE
notifications via uevents. This notification is newly added to scsi sd.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 drivers/scsi/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 8ca9299ffd36..707f47c0ec98 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3187,7 +3187,8 @@ static int sd_revalidate_disk(struct gendisk *disk)
 
 	sdkp->first_scan = 0;
 
-	set_capacity(disk, logical_to_sectors(sdp, sdkp->capacity));
+	set_capacity_revalidate_and_notify(disk,
+		logical_to_sectors(sdp, sdkp->capacity), false);
 	sd_config_write_same(sdkp);
 	kfree(buffer);
 
-- 
2.16.6

