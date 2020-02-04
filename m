Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB921514A2
	for <lists+linux-block@lfdr.de>; Tue,  4 Feb 2020 04:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgBDDbk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 3 Feb 2020 22:31:40 -0500
Received: from mx2.didiglobal.com ([111.202.154.82]:11872 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1727090AbgBDDbk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 22:31:40 -0500
X-ASG-Debug-ID: 1580787094-0e40884f73171f140001-Cu09wu
Received: from mail.didiglobal.com (bogon [172.20.36.143]) by bsf01.didichuxing.com with ESMTP id fiqcEvVRpsbRbBJm; Tue, 04 Feb 2020 11:31:34 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 11:31:34 +0800
Date:   Tue, 4 Feb 2020 11:31:33 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>, <hch@lst.de>,
        <bvanassche@acm.org>, <kbusch@kernel.org>,
        <minwoo.im.dev@gmail.com>, <tglx@linutronix.de>,
        <ming.lei@redhat.com>, <edmund.nadolski@intel.com>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
Subject: [PATCH v5 3/4] nvme-pci: rename module parameter write_queues to
 read_queues
Message-ID: <2ff979c6ee5469ae4f6f652e95974e3cf6bce99a.1580786525.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v5 3/4] nvme-pci: rename module parameter write_queues to
 read_queues
Mail-Followup-To: axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        bvanassche@acm.org, kbusch@kernel.org, minwoo.im.dev@gmail.com,
        tglx@linutronix.de, ming.lei@redhat.com, edmund.nadolski@intel.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <cover.1580786525.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1580786525.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS02.didichuxing.com (172.20.36.211) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bogon[172.20.36.143]
X-Barracuda-Start-Time: 1580787094
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 2764
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.79763
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now nvme support three type hardware queues, read, poll and default,
this patch rename write_queues to read_queues to set the number of
read queues more explicitly. This patch alos is prepared for nvme
support WRR(weighted round robin) that we can get the number of
each queue type easily.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 drivers/nvme/host/pci.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e460c7310187..1002f3f0349c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -68,10 +68,10 @@ static int io_queue_depth = 1024;
 module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
 MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
 
-static unsigned int write_queues;
-module_param(write_queues, uint, 0644);
-MODULE_PARM_DESC(write_queues,
-	"Number of queues to use for writes. If not set, reads and writes "
+static unsigned int read_queues;
+module_param(read_queues, uint, 0644);
+MODULE_PARM_DESC(read_queues,
+	"Number of queues to use for read. If not set, reads and writes "
 	"will share a queue set.");
 
 static unsigned int poll_queues;
@@ -211,7 +211,7 @@ struct nvme_iod {
 
 static unsigned int max_io_queues(void)
 {
-	return num_possible_cpus() + write_queues + poll_queues;
+	return num_possible_cpus() + read_queues + poll_queues;
 }
 
 static unsigned int max_queue_count(void)
@@ -2016,18 +2016,16 @@ static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
 	 * If only one interrupt is available or 'write_queue' == 0, combine
 	 * write and read queues.
 	 *
-	 * If 'write_queues' > 0, ensure it leaves room for at least one read
+	 * If 'read_queues' > 0, ensure it leaves room for at least one write
 	 * queue.
 	 */
-	if (!nrirqs) {
+	if (!nrirqs || nrirqs == 1) {
 		nrirqs = 1;
 		nr_read_queues = 0;
-	} else if (nrirqs == 1 || !write_queues) {
-		nr_read_queues = 0;
-	} else if (write_queues >= nrirqs) {
-		nr_read_queues = 1;
+	} else if (read_queues >= nrirqs) {
+		nr_read_queues = nrirqs - 1;
 	} else {
-		nr_read_queues = nrirqs - write_queues;
+		nr_read_queues = read_queues;
 	}
 
 	dev->io_queues[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
@@ -3143,7 +3141,7 @@ static int __init nvme_init(void)
 	BUILD_BUG_ON(sizeof(struct nvme_delete_queue) != 64);
 	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
 
-	write_queues = min(write_queues, num_possible_cpus());
+	read_queues = min(read_queues, num_possible_cpus());
 	poll_queues = min(poll_queues, num_possible_cpus());
 	return pci_register_driver(&nvme_driver);
 }
-- 
2.14.1

