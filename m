Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311D742D5A6
	for <lists+linux-block@lfdr.de>; Thu, 14 Oct 2021 11:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhJNJHd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 14 Oct 2021 05:07:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229994AbhJNJHc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 05:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634202328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oMWPMqU7gk/+N3iNFaV+79Yi0W3twmcpJsUg5C85gDg=;
        b=c6rbvrIK6s/YChg2BSEYsU6AXEGqvNMV4QRNiyjis8KhuRfjMXang/birchQfpH/MCMzxA
        dXEgfPH07+G0ouqD/XTnNI5ano01dM3+Gd/l+ANP33C1V9IMLsXM7gogqZozK5UP3Lp+/5
        1SLiAIA17pJSOAevLbM64LlpVGhJJaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-OSY2_JyaPVe5zF2HaJsh6g-1; Thu, 14 Oct 2021 05:05:24 -0400
X-MC-Unique: OSY2_JyaPVe5zF2HaJsh6g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B18E8100CCC8;
        Thu, 14 Oct 2021 09:05:13 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D5D319724;
        Thu, 14 Oct 2021 09:05:12 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@osandov.com, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests] tests/srp: fix module loading issue during srp tests
Date:   Thu, 14 Oct 2021 17:04:55 +0800
Message-Id: <20211014090455.7949-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The ib_isert/ib_srpt modules will be automatically loaded after the first
 time rdma_rxe/siw setup, which will lead srp tests fail.

$ modprobe rdma_rxe
$ echo eno1 >/sys/module/rdma_rxe/parameters/add
$ lsmod | grep -E "ib_srpt|iscsi_target_mod|ib_isert"
ib_srpt               167936  0
ib_isert              139264  0
iscsi_target_mod      843776  1 ib_isert
target_core_mod      1069056  3 iscsi_target_mod,ib_srpt,ib_isert
rdma_cm               315392  5 rpcrdma,ib_srpt,ib_iser,ib_isert,rdma_ucm
ib_cm                 344064  2 rdma_cm,ib_srpt
ib_core              1101824  10 rdma_cm,rdma_rxe,rpcrdma,ib_srpt,iw_cm,ib_iser,ib_isert,rdma_ucm,ib_uverbs,ib_cm

$ ./check srp/001
srp/001 (Create and remove LUNs)                             [failed]
    runtime    ...  3.675s
    --- tests/srp/001.out	2021-10-13 01:18:50.846740093 -0400
    +++ /root/blktests/results/nodev/srp/001.out.bad	2021-10-14 03:24:18.593852208 -0400
    @@ -1,3 +1 @@
    -Configured SRP target driver
    -count_luns(): 3 <> 3
    -Passed
    +insmod: ERROR: could not insert module /lib/modules/5.15.0-rc5.fix+/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko: File exists
modprobe: FATAL: Module iscsi_target_mod is in use.

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/srp/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/srp/rc b/tests/srp/rc
index 586f007..f89948b 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -494,6 +494,7 @@ start_lio_srpt() {
 	if modinfo ib_srpt | grep -q '^parm:[[:blank:]]*rdma_cm_port:'; then
 		opts+=("rdma_cm_port=${srp_rdma_cm_port}")
 	fi
+	unload_module ib_srpt && \
 	insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt."* "${opts[@]}" || return $?
 	i=0
 	for r in "${vdev_path[@]}"; do
@@ -551,7 +552,7 @@ stop_lio_srpt() {
 	rmdir /sys/kernel/config/target/*/* >&/dev/null
 	rmdir /sys/kernel/config/target/* >&/dev/null
 
-	for m in ib_srpt iscsi_target_mod target_core_pscsi target_core_iblock \
+	for m in ib_srpt ib_isert iscsi_target_mod target_core_pscsi target_core_iblock \
 			 target_core_file target_core_stgt target_core_user \
 			 target_core_mod
 	do
-- 
2.21.3

