Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BAE4EE36E
	for <lists+linux-block@lfdr.de>; Thu, 31 Mar 2022 23:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241956AbiCaVsA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 31 Mar 2022 17:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237702AbiCaVr7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 17:47:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149371D915A
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 14:46:10 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VKVP6J032352;
        Thu, 31 Mar 2022 21:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=dwiDsf+zvdH7oRjbZrvdnL3TUrOGM2biKjLq4Z3n0to=;
 b=BTr75ZVpMNUo8Wvs2EsiTCTZf86INcUFhHvgjte+JtRd/khY6pYvVHpEBVLH3XdNbr8y
 TN+9tHjPTJSzYq67924uT1L9USiipsuYOEy+gBT5efdl8XmdDyfxCp5KjiuTXfoEgN1+
 5Dy13bXsqC7GaJo3C969yhZKrAcNuvQrciAg4BDUbXd+B/NOExVMKQtKHJfoX/Avi/VB
 7gZB1Vp4OXnpp1hXGY3Rskz/Fo2EDRjd2LrOg230gI/ZSNKwj8BemF5P70p3d8SuiZZN
 VrudY7Uo3mbRFNO5HGSqRsfPzEovuYhSGykfex/uqBx+otssHNbIfd8SACMCpdKoQSUH Aw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctwtsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 21:45:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VLfLtG013724;
        Thu, 31 Mar 2022 21:45:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95cux9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 21:45:58 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22VLjvTi025801;
        Thu, 31 Mar 2022 21:45:57 GMT
Received: from dhcp-10-65-129-122.vpn.oracle.com (dhcp-10-65-129-122.vpn.oracle.com [10.65.129.122])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95cuwy-1;
        Thu, 31 Mar 2022 21:45:57 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     alan.adamson@oracle.com, linux-nvme@lists.infradead.org,
        osandov@fb.com
Subject: Issues running nvme-tcp/rdma passthru blktests
Date:   Thu, 31 Mar 2022 14:45:25 -0700
Message-Id: <20220331214526.95529-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OY9R3DFYrKbNPG64zwoMNfwPmmh_fpkK
X-Proofpoint-GUID: OY9R3DFYrKbNPG64zwoMNfwPmmh_fpkK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When executing blktest nvme tests with tcp and rdma, and with 
CONFIG_NVME_TARGET_PASSTHRU enabled, tests nvme/034-037 did not
complete.

This was because the nvme/rc helper for setting up passthru targets
hardcoded trtype to "loop" which resulted in the nvme connect to
fail.

The following patch resolves this.

Alan

