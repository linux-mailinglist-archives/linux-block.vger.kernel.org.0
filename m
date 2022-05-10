Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE1452218C
	for <lists+linux-block@lfdr.de>; Tue, 10 May 2022 18:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343686AbiEJQrt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 10 May 2022 12:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347653AbiEJQrf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 May 2022 12:47:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2352AE24A
        for <linux-block@vger.kernel.org>; Tue, 10 May 2022 09:43:27 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AEtbkj023549;
        Tue, 10 May 2022 16:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=2uTEi4STk77JpNa2hrHaFpY1pFIodvOdfvC38BkZjMI=;
 b=rIvDlq0Lo9+7FukcI2kiwP1h3Wb5TNa+iZyq9Pa2P7Y3peq9Byfah7tUP1O7hPr6PEG1
 opuyvBCFc8cyznY9FeXl34AWAU/0xI4qY1HujI970wAPzoTnAeF0FGYRslqy5zbyCl+s
 9D+UA+vJRdtuy/MKVfdfzPC9hSipthGH63OvspjnghLI+UWxSCbW0y79pux0I7POUSC8
 /dGEJmvvsvbhVazT7ni3GNsLXsjXHoyYuqQnI7jEB/qTuW6wero9Md2KTN6ONDylC5Km
 CEsDOqCkRVJMJXbJpYve+ykPSQbdWw3iCYAiGT/Jk3bJJpYr0xqZDuDlFYSyZ6lPS/51 /w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcsqdsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 16:43:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24AGPdEZ036816;
        Tue, 10 May 2022 16:43:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf738ska-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 16:43:18 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24AGhHnT030233;
        Tue, 10 May 2022 16:43:18 GMT
Received: from dhcp-10-39-195-127.vpn.oracle.com (dhcp-10-39-195-127.vpn.oracle.com [10.39.195.127])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf738sj7-2;
        Tue, 10 May 2022 16:43:17 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     alan.adamson@oracle.com, linux-nvme@lists.infradead.org,
        osandov@fb.com
Subject: [PATCH v2 blktests] tests/nvme: add tests for error logging
Date:   Tue, 10 May 2022 12:43:04 -0400
Message-Id: <20220510164304.86178-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220510164304.86178-1-alan.adamson@oracle.com>
References: <20220510164304.86178-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xvDe-y5S_5whGjQC2shD2YY2z1OkiXMd
X-Proofpoint-ORIG-GUID: xvDe-y5S_5whGjQC2shD2YY2z1OkiXMd
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

These test verify the functionality delivered by the follow:
	commit bd83fe6f2cd2 ("nvme: add verbose error logging")

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 tests/nvme/039     | 185 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |   7 ++
 2 files changed, 192 insertions(+)
 create mode 100755 tests/nvme/039
 create mode 100644 tests/nvme/039.out

diff --git a/tests/nvme/039 b/tests/nvme/039
new file mode 100755
index 000000000000..e6d45a6e3fe5
--- /dev/null
+++ b/tests/nvme/039
@@ -0,0 +1,185 @@
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
+declare -A NS_DEV_FAULT_INJECT_SAVE
+declare -A CTRL_DEV_FAULT_INJECT_SAVE
+
+save_err_inject_attr()
+{
+	local a
+
+	for a in /sys/kernel/debug/"${ns_dev}"/fault_inject/*; do
+		NS_DEV_FAULT_INJECT_SAVE[${a}]=$(<"${a}")
+	done
+	for a in /sys/kernel/debug/"${ctrl_dev}"/fault_inject/*; do
+		CTRL_DEV_FAULT_INJECT_SAVE[${a}]=$(<"${a}")
+	done
+}
+
+restore_err_inject_attr()
+{
+	local a
+
+	for a in /sys/kernel/debug/"${ns_dev}"/fault_inject/*; do
+		echo "${NS_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
+	done
+	for a in /sys/kernel/debug/"${ctrl_dev}"/fault_inject/*; do
+		echo "${CTRL_DEV_FAULT_INJECT_SAVE[${a}]}" > "${a}"
+	done
+}
+
+set_verbose_prob_retry()
+{
+	echo 0 > /sys/kernel/debug/"$1"/fault_inject/verbose
+	echo 100 > /sys/kernel/debug/"$1"/fault_inject/probability
+	echo 1 > /sys/kernel/debug/"$1"/fault_inject/dont_retry
+}
+
+set_status_time()
+{
+	echo "$1" > /sys/kernel/debug/"$3"/fault_inject/status
+	echo "$2" > /sys/kernel/debug/"$3"/fault_inject/times
+}
+
+inject_unrec_read_err()
+{
+	# Inject a 'Unrecovered Read Error' error on a READ
+	set_status_time 0x281 1 "$1"
+
+	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
+	    2> /dev/null 1>&2 
+
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
+inject_invalid_read_err()
+{
+	# Inject a valid invalid error status (0x375) on a READ
+	set_status_time 0x375 1 "$1"
+
+	dd if=/dev/"$1" of=/dev/null bs=512 count=1 iflag=direct \
+	    2> /dev/null 1>&2
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
+inject_write_fault()
+{
+	# Inject a 'Write Fault' error on a WRITE
+	set_status_time 0x280 1 "$1"
+
+	dd if=/dev/zero of=/dev/"$1" bs=512 count=1 oflag=direct \
+	    2> /dev/null 1>&2
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
+inject_id_admin()
+{
+	# Inject a valid (Identify) Admin command
+	set_status_time 0x286 1000 "$1"
+
+	nvme admin-passthru /dev/"$1" --opcode=0x06 --data-len=4096 \
+	    --cdw10=1 -r 2> /dev/null 1>&2
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
+inject_invalid_cmd()
+{
+	# Inject an invalid command (0x96)
+	set_status_time 0x1 1 "$1"
+
+	nvme admin-passthru /dev/"$1" --opcode=0x96 --data-len=4096 \
+	    --cdw10=1 -r 2> /dev/null 1>&2
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
+	save_err_inject_attr
+
+	set_verbose_prob_retry "${ns_dev}"
+
+	inject_unrec_read_err "${ns_dev}"
+	inject_invalid_read_err "${ns_dev}"
+	inject_write_fault "${ns_dev}"
+
+	set_verbose_prob_retry "${ctrl_dev}"
+
+	inject_id_admin "${ctrl_dev}"
+	inject_invalid_cmd "${ctrl_dev}"
+
+	restore_err_inject_attr
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

