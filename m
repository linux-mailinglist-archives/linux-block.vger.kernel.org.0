Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEAE526699
	for <lists+linux-block@lfdr.de>; Fri, 13 May 2022 17:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345493AbiEMPxR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 13 May 2022 11:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382144AbiEMPxP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 May 2022 11:53:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD9B20D24D
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 08:53:14 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DFdC7O005769;
        Fri, 13 May 2022 15:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=+wn5OkM5Ai+3Pwa2ZmApyaSDNLntVr1QkElfVJ9EUuE=;
 b=KR0O2tvyB7lDBqxYj09Bd/cTUL8lOUhE2dGIoy/qRP7ddrthGsnEqo71D1ysgLqHO+3q
 PmlYBwnPa/iQOykVTZKmFb0KAT5DrATkT5kbEFBWlAI4HiSOJAVa6ZK6pCxRytaP545u
 MDV0EFg+fUKVAYtJwJLdaQWab4vbv9TjAzkW3+pLDmauh8FPxB1bHHUiIIMBWSg2yoKO
 tB2Px3+lIQH2XWXf57Zms+cK+GhBfVn1/BoLbcrx4+44qpR7gAFh6DGok+GqvsDaiUip
 6ZQTfPYl16StMNOfowh6N00MLj/ePykXO29mjbHk/xjKiiJ7CD7G0qI/PzBbzcJkKZwL ag== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhatr09d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 15:53:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24DFjZHc012200;
        Fri, 13 May 2022 15:53:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf76626h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 15:53:07 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24DFr1xS034295;
        Fri, 13 May 2022 15:53:07 GMT
Received: from dhcp-10-159-226-103.vpn.oracle.com (dhcp-10-159-226-103.vpn.oracle.com [10.159.226.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf766243-3;
        Fri, 13 May 2022 15:53:07 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     alan.adamson@oracle.com, linux-nvme@lists.infradead.org,
        osandov@fb.com
Subject: [PATCH v3 blktests 2/2] tests/nvme: add tests for error logging
Date:   Fri, 13 May 2022 08:52:52 -0700
Message-Id: <20220513155252.14332-3-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220513155252.14332-1-alan.adamson@oracle.com>
References: <20220513155252.14332-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o64VwStvWTXNi9ilZa1VG9iHxGbQC7ue
X-Proofpoint-ORIG-GUID: o64VwStvWTXNi9ilZa1VG9iHxGbQC7ue
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
run with or without NVME_VERBOSE_ERRORS configured.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 tests/nvme/039     | 152 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |   7 +++
 2 files changed, 159 insertions(+)
 create mode 100755 tests/nvme/039
 create mode 100644 tests/nvme/039.out

diff --git a/tests/nvme/039 b/tests/nvme/039
new file mode 100755
index 000000000000..dd216cbb2ef0
--- /dev/null
+++ b/tests/nvme/039
@@ -0,0 +1,152 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Oracle and/or its affiliates
+#
+# Test nvme error logging by injecting errors. Kernel must have FAULT_INJECTION
+# and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can be
+# run with or without NVME_VERBOSE_ERRORS configured.
+#
+# Test for commit bd83fe6f2cd2 ("nvme: add verbose error logging").
+
+. tests/nvme/rc
+DESCRIPTION="test error logging"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_kernel_option FAULT_INJECTION && \
+	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
+}
+
+inject_unrec_read_read()
+{
+	# Inject a 'Unrecovered Read Error' (0x281) status error on a READ
+	_nvme_enable_err_inject "$1" 0 100 1 0x281 1
+
+	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
+	    2> /dev/null 1>&2
+
+	_nvme_clear_err_inject "$1"
+	if ${nvme_verbose_errors}; then
+		dmesg -t | tail -2 | grep "Unrecovered Read Error (" | \
+		    sed 's/nvme.*://g'
+	else
+		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
+		    sed 's/I\/O Error/Unrecovered Read Error/g' | \
+		    sed 's/nvme.*://g'
+	fi
+}
+
+inject_invalid_status_read()
+{
+	# Inject an invalid status (0x375) on a READ
+	_nvme_enable_err_inject "$1" 0 100 1 0x375 1
+
+	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
+	    2> /dev/null 1>&2
+
+	_nvme_clear_err_inject "$1"
+
+	if ${nvme_verbose_errors}; then
+		dmesg -t | tail -2 | grep "Unknown (" | \
+		    sed 's/nvme.*://g'
+	else
+		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
+		    sed 's/I\/O Error/Unknown/g' | \
+		    sed 's/nvme.*://g'
+	fi
+}
+
+inject_write_fault_write()
+{
+	# Inject a 'Write Fault' 0x280 status error on a WRITE
+	_nvme_enable_err_inject "$1" 0 100 1 0x280 1
+
+	dd if=/dev/zero of=/dev/"$1" bs=512 count=1 oflag=direct \
+	    2> /dev/null 1>&2
+
+	_nvme_clear_err_inject "$1"
+
+	if ${nvme_verbose_errors}; then
+		dmesg -t | tail -2 | grep "Write Fault (" | \
+		    sed 's/nvme.*://g'
+	else
+		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Write/g' | \
+		    sed 's/I\/O Error/Write Fault/g' | \
+		    sed 's/nvme.*://g'
+	fi
+}
+
+inject_access_denied_identify()
+{
+	# Inject a 'Access Denied' (0x286) status error on an
+	# Identify admin command
+	_nvme_enable_err_inject "$1" 0 100 1 0x286 1
+
+	nvme admin-passthru /dev/"$1" --opcode=0x06 --data-len=4096 \
+	    --cdw10=1 -r 2> /dev/null 1>&2
+
+	_nvme_clear_err_inject "$1"
+
+	if ${nvme_verbose_errors}; then
+		dmesg -t | tail -1 | grep "Access Denied (" | \
+		    sed 's/nvme.*://g'
+	else
+		dmesg -t | tail -1 | grep "Admin Cmd(" | \
+		    sed 's/Admin Cmd/Identify/g' | \
+		    sed 's/I\/O Error/Access Denied/g' | \
+		    sed 's/nvme.*://g'
+	fi
+}
+
+inject_invalid_cmd_admin()
+{
+	# Inject a 'Invalid Command Opcode' (0x1) on an invalid command (0x96)
+	 _nvme_enable_err_inject "$1" 0 100 1 0x1 1
+
+	nvme admin-passthru /dev/"$1" --opcode=0x96 --data-len=4096 \
+	    --cdw10=1 -r 2> /dev/null 1>&2
+
+	_nvme_clear_err_inject "$1"
+
+	if ${nvme_verbose_errors}; then
+		dmesg -t | tail -1 | grep "Invalid Command Opcode (" | \
+		    sed 's/nvme.*://g'
+	else
+		dmesg -t | tail -1 | grep "Admin Cmd(" | \
+		    sed 's/Admin Cmd/Unknown/g' | \
+		    sed 's/I\/O Error/Invalid Command Opcode/g' | \
+		    sed 's/nvme.*://g'
+	fi
+}
+
+test_device() {
+	local nvme_verbose_errors
+	local ns_dev
+	local ctrl_dev
+
+	echo "Running ${TEST_NAME}"
+
+	if _have_kernel_option NVME_VERBOSE_ERRORS; then
+		nvme_verbose_errors=true
+	else
+		unset SKIP_REASON
+		nvme_verbose_errors=false
+	fi
+
+	ns_dev=${TEST_DEV##*/}
+	ctrl_dev=${ns_dev%n*}
+
+	_nvme_err_inject_setup "${ns_dev}" "${ctrl_dev}"
+
+	inject_unrec_read_read "${ns_dev}"
+	inject_invalid_status_read "${ns_dev}"
+	inject_write_fault_write "${ns_dev}"
+
+	inject_access_denied_identify "${ctrl_dev}"
+	inject_invalid_cmd_admin "${ctrl_dev}"
+
+	_nvme_err_inject_cleanup "${ns_dev}" "${ctrl_dev}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/039.out b/tests/nvme/039.out
new file mode 100644
index 000000000000..162935eb1d7b
--- /dev/null
+++ b/tests/nvme/039.out
@@ -0,0 +1,7 @@
+Running nvme/039
+ Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR 
+ Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR 
+ Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR 
+ Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR 
+ Unknown(0x96), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR 
+Test complete
-- 
2.27.0

