Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8517E22CBCA
	for <lists+linux-block@lfdr.de>; Fri, 24 Jul 2020 19:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgGXRRU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Jul 2020 13:17:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45765 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726381AbgGXRRS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jul 2020 13:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595611037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X0buJHSrkh+I+Rp+R9nG+KdqCDEy/CQ4RAkkP1NBj9Q=;
        b=Tlq6UCxaLIHTYgC42ffpCvgdu5SZ+gGZBZyaHnwrjygwnhdFb09/W0zmCfq43QPMGlMn+f
        5NHuYEpdEBzsudID+hM3fUYAlvuTZmLYh+T3JV6efDXB790eVfNyTdYZobfevOTNAuhpSL
        gFGEG1cK6sqGn9D/Bf6GMZrtsIPijkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-dwpUV2gQPf2WEQ1e6Y2zfg-1; Fri, 24 Jul 2020 13:17:14 -0400
X-MC-Unique: dwpUV2gQPf2WEQ1e6Y2zfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2299800C64;
        Fri, 24 Jul 2020 17:17:12 +0000 (UTC)
Received: from sulaco.redhat.com (unknown [10.3.128.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A54174F64;
        Fri, 24 Jul 2020 17:17:11 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
To:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, b.zolnierkie@samsung.com,
        axboe@kernel.dk
Subject: [v4 02/11] create_syslog_header: Add durable name
Date:   Fri, 24 Jul 2020 12:16:57 -0500
Message-Id: <20200724171706.1550403-3-tasleson@redhat.com>
In-Reply-To: <20200724171706.1550403-1-tasleson@redhat.com>
References: <20200724171706.1550403-1-tasleson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This gets us a persistent durable name for code that logs messages in the
block layer that have the appropriate callbacks setup for durable name.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 drivers/base/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 511b7d2fc916..964690572a89 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3754,6 +3754,7 @@ create_syslog_header(const struct device *dev, char *hdr, size_t hdrlen)
 {
 	const char *subsys;
 	size_t pos = 0;
+	int dlen;
 
 	if (dev->class)
 		subsys = dev->class->name;
@@ -3796,6 +3797,10 @@ create_syslog_header(const struct device *dev, char *hdr, size_t hdrlen)
 				"DEVICE=+%s:%s", subsys, dev_name(dev));
 	}
 
+	dlen = dev_durable_name(dev, hdr + (pos + 1), hdrlen - (pos + 1));
+	if (dlen)
+		pos += dlen + 1;
+
 	if (pos >= hdrlen)
 		goto overflow;
 
-- 
2.26.2

