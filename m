Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261CE62AFE9
	for <lists+linux-block@lfdr.de>; Wed, 16 Nov 2022 01:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiKPAMp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Nov 2022 19:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiKPAMn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Nov 2022 19:12:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F1D2A716
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2022 16:12:42 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFME4Jo020916;
        Wed, 16 Nov 2022 00:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=TfNZuRSK1rYDWpaEmMVhVZSMlQ8Ufn3t/rR4cl1Jzso=;
 b=ObOf2ox951EOPcH+r/r5ipq9fP8eNuO2PjT2CP8klD7wRF4fZdKwVelSyQd6rdA1Xn30
 2QBhQiIyyB7g9vDOycKAGED8/7df8TYLZt4wKrTOA/A+7zo5QTyJ0c2w3RoDLGoZxfVi
 XBCwUMRnPwSvqJJmqlnbuj1WLnPcKDQgBiZwDROkHlOf/WpS14KZjLB7oVGiWVkTwybA
 x7aGeZquHEPKw2LuodJy556UfjAgJORolMfzqrEFu2ASGut84shUIBUX1H9g3fGhoB35
 9gFtt0xh0KF91K3risvgldB+93Gc+jEF0S7teCTVizHL3WhmMPM0cqIMBHu16xEOUbz5 rA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8ykjmyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 00:12:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFNcc7X004768;
        Wed, 16 Nov 2022 00:12:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3k7dqf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 00:12:35 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AG0CZsq013984;
        Wed, 16 Nov 2022 00:12:35 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3k7dqee-1;
        Wed, 16 Nov 2022 00:12:35 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     alan.adamson@oracle.com, linux-nvme@lists.infradead.org,
        shinichiro.kawasaki@wdc.com
Subject: [PATCH] tests/nvme: Remove test output for passthrough error logging
Date:   Tue, 15 Nov 2022 16:12:34 -0800
Message-Id: <20221116001234.581003-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211150166
X-Proofpoint-GUID: -FSbXsoXg8FdkoJdlK8wof_DkiRueA6l
X-Proofpoint-ORIG-GUID: -FSbXsoXg8FdkoJdlK8wof_DkiRueA6l
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit d7ac8dca938c ("nvme: quiet user passthrough command errors")
disabled error logging for passthrough commands so the associated
error output in nvme/039.out should be removed.

When an error logging opt-in mechanism for passthrough commands is
provided, the error output can be added back.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 tests/nvme/039.out | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/nvme/039.out b/tests/nvme/039.out
index 162935eb1d7b..139070d22240 100644
--- a/tests/nvme/039.out
+++ b/tests/nvme/039.out
@@ -2,6 +2,4 @@ Running nvme/039
  Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR 
  Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR 
  Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR 
- Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR 
- Unknown(0x96), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR 
 Test complete
-- 
2.31.1

