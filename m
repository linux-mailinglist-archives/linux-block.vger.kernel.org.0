Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3577D8AC1
	for <lists+linux-block@lfdr.de>; Thu, 26 Oct 2023 23:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjJZVo0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Oct 2023 17:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344882AbjJZVoQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Oct 2023 17:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2642DD5C
        for <linux-block@vger.kernel.org>; Thu, 26 Oct 2023 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698356508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2VCe6vdbWClz+JSHP8xKkLJYnJuJNX6zpMYbifB9jBc=;
        b=UL3XTl4LAtMkuXa2vcWKFHkqzWgd319FYSK7XkEuL++8BnE+pnNIB2eiWGTcoXC7zthpkn
        y8zB+pxjnywf4nKumss4q5ByjgZbg3ewLuAfUJD+QqWg0nxthM8xH2icMA8kwhilmHcMlH
        Dh20o1mczPoAAS+CJx4So2BMJLZvzDU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-efJD2pA_O6iEw58Be_2wAw-1; Thu, 26 Oct 2023 17:41:44 -0400
X-MC-Unique: efJD2pA_O6iEw58Be_2wAw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFC14185A783;
        Thu, 26 Oct 2023 21:41:43 +0000 (UTC)
Received: from pbitcolo-build-10.permabit.com (pbitcolo-build-10.permabit.lab.eng.bos.redhat.com [10.19.117.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5C942949;
        Thu, 26 Oct 2023 21:41:43 +0000 (UTC)
Received: by pbitcolo-build-10.permabit.com (Postfix, from userid 1138)
        id 8C6203003B; Thu, 26 Oct 2023 17:41:43 -0400 (EDT)
From:   Matthew Sakai <msakai@redhat.com>
To:     dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Cc:     Matthew Sakai <msakai@redhat.com>
Subject: [PATCH v4 39/39] dm vdo: enable configuration and building of dm-vdo
Date:   Thu, 26 Oct 2023 17:41:36 -0400
Message-Id: <20231026214136.1067410-40-msakai@redhat.com>
In-Reply-To: <20231026214136.1067410-1-msakai@redhat.com>
References: <20231026214136.1067410-1-msakai@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

dm-vdo targets are not supported for 32-bit configurations. A vdo target
typically requires 1 to 1.5 GB of memory at any given time, which is likely
a large fraction of the addressable memory of a 32-bit system. At the same
time, the amount of addressable storage attached to a 32-bit system may not
be large enough for deduplication to provide much benefit. Because of these
concerns, 32-bit platforms are deemed unlikely to benefit from using a vdo
target, so dm-vdo is targeted only at 64-bit platforms.

Co-developed-by: J. corwin Coburn <corwin@hurlbutnet.net>
Signed-off-by: J. corwin Coburn <corwin@hurlbutnet.net>
Co-developed-by: John Wiele <jwiele@redhat.com>
Signed-off-by: John Wiele <jwiele@redhat.com>
Signed-off-by: Matthew Sakai <msakai@redhat.com>
---
 drivers/md/Kconfig  | 16 ++++++++++++++++
 drivers/md/Makefile |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index b0a22e99bade..9fa9dec10292 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -521,6 +521,22 @@ config DM_FLAKEY
 	help
 	 A target that intermittently fails I/O for debugging purposes.
 
+config DM_VDO
+	tristate "VDO: deduplication and compression target"
+	depends on 64BIT
+	depends on BLK_DEV_DM
+	select DM_BUFIO
+	select LZ4_COMPRESS
+	select LZ4_DECOMPRESS
+	help
+	  This device mapper target presents a block device with
+	  deduplication, compression and thin-provisioning.
+
+	  To compile this code as a module, choose M here: the module will
+	  be called dm-vdo.
+
+	  If unsure, say N.
+
 config DM_VERITY
 	tristate "Verity target support"
 	depends on BLK_DEV_DM
diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 84291e38dca8..47444b393abb 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -25,6 +25,7 @@ dm-ebs-y	+= dm-ebs-target.o
 dm-era-y	+= dm-era-target.o
 dm-clone-y	+= dm-clone-target.o dm-clone-metadata.o
 dm-verity-y	+= dm-verity-target.o
+dm-vdo-y	+= dm-vdo-target.o $(patsubst drivers/md/dm-vdo/%.c,dm-vdo/%.o,$(wildcard $(src)/dm-vdo/*.c))
 dm-zoned-y	+= dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o
 
 md-mod-y	+= md.o md-bitmap.o
@@ -74,6 +75,7 @@ obj-$(CONFIG_DM_ZERO)		+= dm-zero.o
 obj-$(CONFIG_DM_RAID)		+= dm-raid.o
 obj-$(CONFIG_DM_THIN_PROVISIONING) += dm-thin-pool.o
 obj-$(CONFIG_DM_VERITY)		+= dm-verity.o
+obj-$(CONFIG_DM_VDO)            += dm-vdo.o
 obj-$(CONFIG_DM_CACHE)		+= dm-cache.o
 obj-$(CONFIG_DM_CACHE_SMQ)	+= dm-cache-smq.o
 obj-$(CONFIG_DM_EBS)		+= dm-ebs.o
-- 
2.40.0

