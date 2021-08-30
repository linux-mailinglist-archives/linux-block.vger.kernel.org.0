Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC773FAFDE
	for <lists+linux-block@lfdr.de>; Mon, 30 Aug 2021 04:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbhH3CkG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 29 Aug 2021 22:40:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40874 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236258AbhH3CkD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Aug 2021 22:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630291150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=taHSf4Hv3WzkHLo9IBdaFioBgxlUVbwKiCeAMwQZU8A=;
        b=ftxohNv6JfcM3B11L+adJWeWv5lygIBG7DglgpCpNUmCgZ1+0LG0AIeU3Jqs7xdLAMh3Nc
        VCE6dBAzZcoJznYVqnrZsgaZBK0wAbK68XMyl7t6AgwAirnd9Ucg29owQpESl1F3ImnGtj
        7D6CWGNvDR15XBHDDAxbbwkou/pIeeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-sGGsSWo4PWiqq9s9qbz23A-1; Sun, 29 Aug 2021 22:38:59 -0400
X-MC-Unique: sGGsSWo4PWiqq9s9qbz23A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65025CC629;
        Mon, 30 Aug 2021 02:38:58 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCA6960C9F;
        Mon, 30 Aug 2021 02:38:51 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] block/001: don't exit test with pending async scan
Date:   Mon, 30 Aug 2021 10:38:44 +0800
Message-Id: <20210830023844.1870471-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have to run scan and delete together, otherwise pending async
may prevent scsi_debug from being unloaded, and cause failure of
'modprobe: FATAL: Module scsi_debug is in use.'

Fix the issue by always running both scan and delete together.

Fixes: f3bcd8c ("block/001: wait until device is added")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tests/block/001 | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tests/block/001 b/tests/block/001
index c26792b..be33962 100755
--- a/tests/block/001
+++ b/tests/block/001
@@ -29,13 +29,8 @@ stress_scsi_debug() {
 		scan="${scan//:/ }"
 		while [[ ! -e "$TMPDIR/stop" ]]; do
 			echo "${scan}" > "/sys/class/scsi_host/host${host}/scan"
-			while [[ ! -e "$TMPDIR/stop" ]]; do
-				if [[ -d "/sys/class/scsi_device/${target}" ]]; then
-					echo 1 > "/sys/class/scsi_device/${target}/device/delete"
-					break
-				fi
-				sleep 0.01
-			done
+			while [[ ! -d "/sys/class/scsi_device/${target}" ]]; do sleep 0.01; done
+			echo 1 > "/sys/class/scsi_device/${target}/device/delete"
 		done
 		) &
 	done
-- 
2.31.1

