Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E570F2C509E
	for <lists+linux-block@lfdr.de>; Thu, 26 Nov 2020 09:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgKZIgE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Nov 2020 03:36:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726392AbgKZIgE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 03:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606379763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gpEC5D0qOw9//L2As7ovMFYeDVD089fvAUww7rjLk5w=;
        b=geuk51MDoqT0NuJuWLxnbxWKex+s4LwU2BRALxp1Njb7CbTxRIsFetbtWTWavutTSHDlaQ
        CKC126DCbrxUIfQOoQVu52PTp2WuvW6UWMOTKDAvpKEWrUnF/e/mldmKDZexgRmwX3WTmc
        BtdWeJ6kNM/WQdRtqxXznazSHxTikWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-sLMyRioIMuCzZi04AmfOBw-1; Thu, 26 Nov 2020 03:36:00 -0500
X-MC-Unique: sLMyRioIMuCzZi04AmfOBw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 740041012E85;
        Thu, 26 Nov 2020 08:35:59 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76BC719C66;
        Thu, 26 Nov 2020 08:35:57 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@osandov.com, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
Subject: [PATCH V3 blktests 1/5] tests/srp/rc: update the ib_srpt module name
Date:   Thu, 26 Nov 2020 16:35:28 +0800
Message-Id: <20201126083532.27509-2-yi.zhang@redhat.com>
In-Reply-To: <20201126083532.27509-1-yi.zhang@redhat.com>
References: <20201126083532.27509-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the ib_srpt module insmod failure as the module in some distros are
end with .xz, like bellow on fedora:
/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko.xz

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/srp/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/srp/rc b/tests/srp/rc
index 7fc094b..1f665a2 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -465,7 +465,7 @@ configure_target_ports() {
 
 # Load LIO and configure the SRP target driver and LUNs.
 start_lio_srpt() {
-	local b d gid i ini_ids=() opts p target_ids=() vdev
+	local b d gid i ini_ids=() opts p target_ids=()
 
 	for gid in $(all_primary_gids); do
 		if [ "${gid#fe8}" != "$gid" ]; then
@@ -500,7 +500,7 @@ start_lio_srpt() {
 	if modinfo ib_srpt | grep -q '^parm:[[:blank:]]*rdma_cm_port:'; then
 		opts+=("rdma_cm_port=${srp_rdma_cm_port}")
 	fi
-	insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko" "${opts[@]}" || return $?
+	insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt."* "${opts[@]}" || return $?
 	i=0
 	for r in "${vdev_path[@]}"; do
 		if [ -b "$(readlink -f "$r")" ]; then
-- 
2.21.0

