Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C59110D63B
	for <lists+linux-block@lfdr.de>; Fri, 29 Nov 2019 14:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfK2Nna (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 Nov 2019 08:43:30 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:43721 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfK2Nna (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Nov 2019 08:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575035010; x=1606571010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c6kyduALUMlhgXr7+NWpnW7lYxje+66n8zte1sjHPtQ=;
  b=jZI1p2tQm84hhNT9kA2BsYkOEJDBN+dzu2478xJfVE/S9A0hamYq8xyH
   p+wcMwnN2YZZYftb9/OfqNI/Ex0DFZjfV5Ff9RUltO8xz+hKMM2dzJf64
   GaPPS8Y8no1TFC2rKpKDQO4LHWvXDRWV3dxrNQiqefHU+1itoRrgYvN11
   A=;
IronPort-SDR: e313tRJFZvKq/8QfO6v7WwPLs4wfemBryy0e4hKh5dmdkHBgrPoM/p7KJ6uTkCfaGL2Pd6S3K8
 aRuogK46WYNw==
X-IronPort-AV: E=Sophos;i="5.69,257,1571702400"; 
   d="scan'208";a="10582565"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 29 Nov 2019 13:43:18 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id 04DBE282697;
        Fri, 29 Nov 2019 13:43:15 +0000 (UTC)
Received: from EX13D32EUB003.ant.amazon.com (10.43.166.165) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 29 Nov 2019 13:43:15 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D32EUB003.ant.amazon.com (10.43.166.165) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 29 Nov 2019 13:43:14 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Fri, 29 Nov 2019 13:43:12 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>
CC:     Paul Durrant <pdurrant@amazon.com>,
        Jan Beulich <jbeulich@suse.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2 1/2] xen/xenbus: reference count registered modules
Date:   Fri, 29 Nov 2019 13:43:05 +0000
Message-ID: <20191129134306.2738-2-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191129134306.2738-1-pdurrant@amazon.com>
References: <20191129134306.2738-1-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To prevent a module being removed whilst attached to a frontend, and
hence xenbus calling into potentially invalid text, take a reference on
the module before calling the probe() method (dropping it if unsuccessful)
and drop the reference after returning from the remove() method.

NOTE: This allows the ad-hoc reference counting in xen-netback to be
      removed. This will be done in a subsequent patch.

Suggested-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>

v2:
 - New in v2
---
 drivers/xen/xenbus/xenbus_probe.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 5b471889d723..5a4947690500 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -232,9 +232,11 @@ int xenbus_dev_probe(struct device *_dev)
 		return err;
 	}
 
+	__module_get(drv->driver.owner);
+
 	err = drv->probe(dev, id);
 	if (err)
-		goto fail;
+		goto fail_put;
 
 	err = watch_otherend(dev);
 	if (err) {
@@ -244,6 +246,8 @@ int xenbus_dev_probe(struct device *_dev)
 	}
 
 	return 0;
+fail_put:
+	module_put(drv->driver.owner);
 fail:
 	xenbus_dev_error(dev, err, "xenbus_dev_probe on %s", dev->nodename);
 	xenbus_switch_state(dev, XenbusStateClosed);
@@ -263,6 +267,8 @@ int xenbus_dev_remove(struct device *_dev)
 	if (drv->remove)
 		drv->remove(dev);
 
+	module_put(drv->driver.owner);
+
 	free_otherend_details(dev);
 
 	xenbus_switch_state(dev, XenbusStateClosed);
-- 
2.20.1

