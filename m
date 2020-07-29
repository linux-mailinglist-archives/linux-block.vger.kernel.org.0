Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDD32327CD
	for <lists+linux-block@lfdr.de>; Thu, 30 Jul 2020 01:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgG2XDZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Jul 2020 19:03:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32988 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbgG2XDY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 19:03:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TN2wFJ169008;
        Wed, 29 Jul 2020 23:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=nfsXLq2NB1nyuGEg16keUAr8k6UXZIq8iy7477JC1mM=;
 b=neDHRkIFbCH9wOdESuHaoYDl6w6zA/fTPWHPrdoJPR73AsJIftZeexTji06QFvBpna9s
 /VmJLFMOc9kYwB6KnFd6L+3dp5qSeElz55OmR+gcP+lCGt/LSSdSJXgoZFRAYZAO0XDA
 sBbwhI0/dhXOUo6mrPHojMekqNxG9lJReupyv375pvrq8N3IfsMP/HgU0hnXkCrKdjG7
 860k80bXoJSTQtqxjO/8XtJyfAlkqkFoVMH7YGVdNchRFvGny9uEe9GmpxaM923WeA/n
 FwniPmqcn+9cdwThCZT1YU0jjEBg8mBWvmUzYgn6RGqpX5PUgqR8/3TDsO88t0OXbaR8 ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32hu1jgkcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 23:03:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TN2WBL139230;
        Wed, 29 Jul 2020 23:03:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 32hu5y8ae9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 23:03:21 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06TN3KDb030259;
        Wed, 29 Jul 2020 23:03:20 GMT
Received: from rsrivast-us.us.oracle.com (/10.211.44.96)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 16:03:18 -0700
From:   Ritika Srivastava <ritika.srivastava@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, ritika.srivastava@oracle.com
Subject: Return BLK_STS_NOTSUPP and blk_status_t from blk_cloned_rq_check_limits() 
Date:   Wed, 29 Jul 2020 15:47:56 -0700
Message-Id: <1596062878-4238-1-git-send-email-ritika.srivastava@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=920 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=1 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=924 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290155
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
These patches address the comments from previous v1 version
block: return BLK_STS_NOTSUPP if operation is not supported

Updates since v1:
- Document scenario and SCSI error encountered in a comment in blk_cloned_rq_check_limits().
- Add a patch to switch returning errno codes to blk_status_t in blk_cloned_rq_check_limits().

Please review the following patches.
[PATCH 1/2] block: Return blk_status_t instead of errno codes
[PATCH v2 2/2] block: return BLK_STS_NOTSUPP if operation is not supported

Thanks,
Ritika
