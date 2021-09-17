Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CA840F034
	for <lists+linux-block@lfdr.de>; Fri, 17 Sep 2021 05:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243222AbhIQDLR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Sep 2021 23:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243600AbhIQDLR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 23:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631848195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=n9ORYpjzpwp6Ym/dMpPDG+8FjhqIkwMtITEMI6byja0=;
        b=hxtR0YR3eGHDMlmUHMPVXExJC8tE/mDmSIzZL8GmIHg1ljmdB3an3iKOOqb8v9IwaSWmYz
        eWMRRLJETmrRqre7UmsK8TS+xq0WVniqscWu4ToRac+P61xj9WrP0Yq3h7iSMd78DbthbM
        T9eSoJKt6osRQiR0l0/M2+WkmuzBAac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-XDDPBJQaO7SluvD-owoirA-1; Thu, 16 Sep 2021 23:09:53 -0400
X-MC-Unique: XDDPBJQaO7SluvD-owoirA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79749824FA6;
        Fri, 17 Sep 2021 03:09:32 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D090510013D7;
        Fri, 17 Sep 2021 03:09:30 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     bvanassche@acm.org, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH V2 blktests] nvmeof-mp/001: fix failure when CONFIG_NVME_HWMON enabled
Date:   Fri, 17 Sep 2021 11:09:11 +0800
Message-Id: <20210917030911.25646-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

skip checking ng0n1/hwmon5 in count_devices

$ use_siw=1  ./check nvmeof-mp/001
nvmeof-mp/001 (Log in and log out)                           [failed]
    runtime  3.695s  ...  4.002s
    --- tests/nvmeof-mp/001.out	2021-09-12 05:35:17.866892187 -0400
    +++ /root/blktests/results/nodev/nvmeof-mp/001.out.bad	2021-09-12 06:49:25.621880616 -0400
    @@ -1,3 +1,3 @@
     Configured NVMe target driver
    -count_devices(): 1 <> 1
    +count_devices(): 3 <> 1
     Passed
$ ls -l /sys/class/nvme-fabrics/ctl/*/*/device
lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/hwmon5/device -> ../../nvme0
lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/ng0n1/device -> ../../nvme0
lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/nvme0n1/device -> ../../nvme0

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
V2: update regex to hwmon[0-9]+|ng[0-9]+n[0-9]+

---
 tests/nvmeof-mp/001 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/nvmeof-mp/001 b/tests/nvmeof-mp/001
index 69f1e24..f3e6394 100755
--- a/tests/nvmeof-mp/001
+++ b/tests/nvmeof-mp/001
@@ -11,6 +11,7 @@ count_devices() {
 	local d devs=0
 
 	for d in /sys/class/nvme-fabrics/ctl/*/*/device; do
+		[[ "$d" =~ hwmon[0-9]+|ng[0-9]+n[0-9]+ ]] && continue
 		[ -d "$d" ] && ((devs++))
 	done
 	echo "$devs"
-- 
2.21.3

