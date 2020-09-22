Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07427273FEF
	for <lists+linux-block@lfdr.de>; Tue, 22 Sep 2020 12:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgIVKw5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Sep 2020 06:52:57 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:30357 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgIVKw5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 06:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600771977; x=1632307977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=o7irTIbRXOJQafppIl9QY5dF6CNyW4qaMo6zKmMJeVI=;
  b=OEKlQRT7CVLleMg6gHeMvBDjQrPE0UIqMsYk4NcwpE6Fv2iAZvKYOnS9
   qiBsTdZcitYWZemVaJG1tIfoqjNGH6bkMFlUZ4nFZr6rnuRUoT1PprQGz
   J7vfpfFvU2nNJmx8hgpgMieLuwkizmOtaxnkfWGNOocODBDjg57dyxiDe
   k=;
X-IronPort-AV: E=Sophos;i="5.77,290,1596499200"; 
   d="scan'208";a="70055190"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 22 Sep 2020 10:52:55 +0000
Received: from EX13D31EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 99DC9A1F35;
        Tue, 22 Sep 2020 10:52:52 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.35) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 22 Sep 2020 10:52:46 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <konrad.wilk@oracle.com>, <roger.pau@citrix.com>, <jgross@suse.com>
CC:     SeongJae Park <sjpark@amazon.de>, <axboe@kernel.dk>,
        <aliguori@amazon.com>, <amit@kernel.org>, <mheyne@amazon.de>,
        <pdurrant@amazon.co.uk>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] xen-blkfront: Apply changed parameter name to the document
Date:   Tue, 22 Sep 2020 12:52:09 +0200
Message-ID: <20200922105209.5284-4-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922105209.5284-1-sjpark@amazon.com>
References: <20200922105209.5284-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.35]
X-ClientProxiedBy: EX13D14UWB003.ant.amazon.com (10.43.161.162) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Commit 14e710fe7897 ("xen-blkfront: rename indirect descriptor
parameter") changed the name of the module parameter for the maximum
amount of segments in indirect requests but missed updating the
document.  This commit updates the document.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/ABI/testing/sysfs-driver-xen-blkfront | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkfront b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
index 9c31334cb2e6..28008905615f 100644
--- a/Documentation/ABI/testing/sysfs-driver-xen-blkfront
+++ b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
@@ -1,4 +1,4 @@
-What:           /sys/module/xen_blkfront/parameters/max
+What:           /sys/module/xen_blkfront/parameters/max_indirect_segments
 Date:           June 2013
 KernelVersion:  3.11
 Contact:        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
-- 
2.17.1

