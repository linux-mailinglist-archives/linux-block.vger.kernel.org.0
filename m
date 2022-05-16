Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5CD52947A
	for <lists+linux-block@lfdr.de>; Tue, 17 May 2022 01:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbiEPW7u (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 May 2022 18:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350127AbiEPW7m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 18:59:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41AC47579
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 15:58:18 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GKrC3q027282;
        Mon, 16 May 2022 22:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=qLmV2A/FfXX4Z1qISVXxXZ0NbRja0Rh9FDzBmYDHRqE=;
 b=DjnGMps7szT0QJJvZmEjPO25tHJR+o5D0qmWbMf7C93Lv+oolSRN7YpSej1wPc8Q6kt7
 lbbTbIdZ63H2HLAK007uB0g+EvxUls3FBi/yWwyAYLfQjlItL7osd450hnc/nIaKSUyW
 Kwu903xfs0CABK+Naiy1pj55uo6DOAVXSMQ3euDAZ6b9xsa/9tJU4eiNwP3+DpBWaD0d
 A366nLxj2xq72Rp+GYol4RKGttotB6M4ghe8wRWkp8IcKH/KUvSHF9YfEqMjrHJD+JnY
 Ks3L8cyIK3VXwlONaxDvVchwh3pJcmcn3GqM6As+v2OS7P7LAjn0Y8+DNJZuOUKlaCEW UQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2371vqfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 22:55:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24GMttQx013392;
        Mon, 16 May 2022 22:55:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v7xv2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 22:55:56 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 24GMtul3013443;
        Mon, 16 May 2022 22:55:56 GMT
Received: from dhcp-10-65-131-124.vpn.oracle.com (dhcp-10-65-131-124.vpn.oracle.com [10.65.131.124])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v7xuyu-1;
        Mon, 16 May 2022 22:55:56 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     alan.adamson@oracle.com, linux-nvme@lists.infradead.org,
        osandov@fb.com
Subject: blktests v4 tests/nvme: add tests for error logging
Date:   Mon, 16 May 2022 15:55:37 -0700
Message-Id: <20220516225539.81588-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9FuhQWjKqQtzvQ5hJWlQB6xZmC6SUEQV
X-Proofpoint-ORIG-GUID: 9FuhQWjKqQtzvQ5hJWlQB6xZmC6SUEQV
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

V2 - Update from suggestions from shinichiro.kawasaki@wdc.com
V3 - Add error injector helper functions to nvme/rc
V4 - Comments from shinichiro.kawasaki@wdc.com 

Alan Adamson (2):
  tests/nvme: add helper routine to use error injector
  tests/nvme: add tests for error logging

 tests/nvme/039     | 153 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |   7 +++
 tests/nvme/rc      |  44 +++++++++++++
 3 files changed, 204 insertions(+)
 create mode 100755 tests/nvme/039
 create mode 100644 tests/nvme/039.out

-- 
2.27.0

