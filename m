Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EAE609A5C
	for <lists+linux-block@lfdr.de>; Mon, 24 Oct 2022 08:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJXGPd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 Oct 2022 02:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiJXGOp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Oct 2022 02:14:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3D760CBF
        for <linux-block@vger.kernel.org>; Sun, 23 Oct 2022 23:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666592048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RswB510iQnL61XzrmzYzoOFaNhqJWXGUpuiXL9j46Jc=;
        b=AECQHPnMP9LH5qYO0oboaPLqdVX411mjtG22I1iJhKkeL8V5Q9rI/iGZE5FGXJqfj6gztN
        PqpfZTS8VWf/SZGHYpTuqITJa+jpinkCjuDgVoE8pKqP3VECnKwBOADF8V660AlKj8NFBm
        gZm9z62E+gSgPRxxpiNyQTEyhMH+FvQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-udukxtUXM5m9tNaSxq2Msg-1; Mon, 24 Oct 2022 02:14:06 -0400
X-MC-Unique: udukxtUXM5m9tNaSxq2Msg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0121A1010428;
        Mon, 24 Oct 2022 06:14:06 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61B5C2022EA4;
        Mon, 24 Oct 2022 06:14:01 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 1/3] common/xfs: set the minimal log size 64m during mkfs.xfs
Date:   Mon, 24 Oct 2022 14:13:17 +0800
Message-Id: <20221024061319.1133470-2-yi.zhang@redhat.com>
In-Reply-To: <20221024061319.1133470-1-yi.zhang@redhat.com>
References: <20221024061319.1133470-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Update to use the new minimum xfs log size 64MB which introudced from
xfsprogs v5.19.0:

$ mkfs.xfs -l size=32m -f /dev/nvme0n1
Log size must be at least 64MB.
Usage: mkfs.xfs
/* blocksize */		[-b size=num]
/* config file */	[-c options=xxx]
/* metadata */		[-m crc=0|1,finobt=0|1,uuid=xxx,rmapbt=0|1,reflink=0|1,
			    inobtcount=0|1,bigtime=0|1]
/* data subvol */	[-d agcount=n,agsize=n,file,name=xxx,size=num,
			    (sunit=value,swidth=value|su=num,sw=num|noalign),
			    sectsize=num
/* force overwrite */	[-f]
/* inode size */	[-i perblock=n|size=num,maxpct=n,attr=0|1|2,
			    projid32bit=0|1,sparse=0|1,nrext64=0|1]
/* no discard */	[-K]
/* log subvol */	[-l agnum=n,internal,size=num,logdev=xxx,version=n
			    sunit=value|su=num,sectsize=num,lazy-count=0|1]
/* label */		[-L label (maximum 12 characters)]
/* naming */		[-n size=num,version=2|ci,ftype=0|1]
/* no-op info only */	[-N]
/* prototype file */	[-p fname]
/* quiet */		[-q]
/* realtime subvol */	[-r extsize=num,size=num,rtdev=xxx]
/* sectorsize */	[-s size=num]
/* version */		[-V]
			devicename
<devicename> is required unless -d name=xxx is given.
<num> is xxx (bytes), xxxs (sectors), xxxb (fs blocks), xxxk (xxx KiB),
      xxxm (xxx MiB), xxxg (xxx GiB), xxxt (xxx TiB) or xxxp (xxx PiB).
<value> is xxx (512 byte blocks).

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 common/xfs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/xfs b/common/xfs
index 210c924..846a5ef 100644
--- a/common/xfs
+++ b/common/xfs
@@ -16,7 +16,7 @@ _xfs_mkfs_and_mount() {
 
 	mkdir -p "${mount_dir}"
 	umount "${mount_dir}"
-	mkfs.xfs -l size=32m -f "${bdev}"
+	mkfs.xfs -l size=64m -f "${bdev}"
 	mount "${bdev}" "${mount_dir}"
 }
 
-- 
2.34.1

