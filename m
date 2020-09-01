Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC2125A00A
	for <lists+linux-block@lfdr.de>; Tue,  1 Sep 2020 22:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIAUdd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Sep 2020 16:33:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57288 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgIAUda (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 16:33:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081KV18G086254;
        Tue, 1 Sep 2020 20:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=EYQkGVRkaDWyew96BMF3jXmwIJZEd0ayKwQPrjp4fFc=;
 b=Ybi7dMm8G5J1WhdOD3SSOLQm/UL9SkuAwk/vQ1P19yoIw40UfJ8bSL3pa7dhhkNF4vBN
 bVSRMgh+9QhOAkseGuAoQSG+69CvTzzq+ehgShHgao1jcSNrj7Og1KCVojSOYaavIykK
 mPbvmtNAPlX6ZFioDiTuUDTXDIc2ViKwfH2ytllxeeNzcIaZhIjxLY2FK+Kc1FygdhQ0
 NFqZnn6CN3MaHXYAOeRoGx6e43JQ2LCJh/Mqa7YiRkVWEX5HVDZBxvol+sh/0rfmUeof
 PLsQfyMMUvbSUyruFZAMtYA+DtYjQxkl8hDlx6z1fxIcNWV5yEqUfrphDa9H1EMgfMLy Tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 337eym6pvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Sep 2020 20:33:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 081KThSC123309;
        Tue, 1 Sep 2020 20:33:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3380xx4u0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Sep 2020 20:33:27 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 081KXPuY003303;
        Tue, 1 Sep 2020 20:33:26 GMT
Received: from rsrivast-us.us.oracle.com (/10.211.44.96)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Sep 2020 13:33:25 -0700
From:   Ritika Srivastava <ritika.srivastava@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, ritika.srivastava@oracle.com
Subject: Return BLK_STS_NOTSUPP and blk_status_t from blk_cloned_rq_check_limits() 
Date:   Tue,  1 Sep 2020 13:17:29 -0700
Message-Id: <1598991451-9655-1-git-send-email-ritika.srivastava@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=950 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009010174
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9731 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=970 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010174
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

I applied the following patches on 5.10 branch and there are only line number changes.

[PATCH 1/2] block: Return blk_status_t instead of errno codes
[PATCH v4 2/2] block: better deal with the delayed not supported case in blk_cloned_rq_check_limits

I am resending the patches applied on top of 5.10 branch.

$ git log --oneline --decorate -n 5
5749f24 (HEAD, for-5.10/block) block: better deal with the delayed not supported case in blk_cloned_rq_check_limits
bb79f6e block: Return blk_status_t instead of errno codes
9493111 (origin/for-5.10/block) block: remove the unused q argument to part_in_flight and part_in_flight_rw
8eeee76 block: remove the disk argument to delete_partition
7f201bc block: cleanup __alloc_disk_node

Thanks,
Ritika
