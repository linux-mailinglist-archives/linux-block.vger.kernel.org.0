Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688142C509F
	for <lists+linux-block@lfdr.de>; Thu, 26 Nov 2020 09:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgKZIgH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Nov 2020 03:36:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726392AbgKZIgG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 03:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606379765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b1JUCFxP98Y6dqOjE3XLdXL2MOBEQrR1ym0p8vqzfFo=;
        b=BfAQfk0tCcs7moiIFrXKljdemJaV2ArY9msdRTlKA+2XaPEWf7wjhtoHFoDjsmJov4b6MY
        UX/ddyxx9f5XjH6EzArRmaVOun59WoU3qZ2bRLy9by7xLw0MUmu3vwFEAzDh2+A4zpJOCZ
        gjBBsL5Kep2nuY3bBgCL+HLi+mIh1R4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15--JoODfOmPliVtZxArPpDmg-1; Thu, 26 Nov 2020 03:36:03 -0500
X-MC-Unique: -JoODfOmPliVtZxArPpDmg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A277B9A229;
        Thu, 26 Nov 2020 08:36:01 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C84E819C66;
        Thu, 26 Nov 2020 08:35:59 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@osandov.com, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
Subject: [PATCH V3 blktests 2/5] tests/nvmeof-mp/rc: run nvmeof-mp tests if we set multipath=N
Date:   Thu, 26 Nov 2020 16:35:29 +0800
Message-Id: <20201126083532.27509-3-yi.zhang@redhat.com>
In-Reply-To: <20201126083532.27509-1-yi.zhang@redhat.com>
References: <20201126083532.27509-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To enable it, just do bellow step before we run it:
$ echo "options nvme_core multipath=N" >/etc/modprobe.d/nvme.conf

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvmeof-mp/rc | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index d7a7c87..c77526f 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -16,9 +16,11 @@ group_requires() {
 
 	# Since the nvmeof-mp tests are based on the dm-mpath driver, these
 	# tests are incompatible with the NVME_MULTIPATH kernel configuration
-	# option.
-	if _have_kernel_option NVME_MULTIPATH; then
-		SKIP_REASON="CONFIG_NVME_MULTIPATH has been set in .config"
+	# option with multipathing enabled in the nvme_core kernel module.
+	if _have_kernel_option NVME_MULTIPATH && \
+		_have_module_param_value nvme_core multipath Y; then
+		SKIP_REASON="CONFIG_NVME_MULTIPATH has been set in .config \
+and multipathing has been enabled in the nvme_core kernel module"
 		return
 	fi
 
-- 
2.21.0

