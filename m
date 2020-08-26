Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B77252CAC
	for <lists+linux-block@lfdr.de>; Wed, 26 Aug 2020 13:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgHZLoX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 26 Aug 2020 07:44:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52040 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbgHZLdC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 07:33:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QBTLiO052364;
        Wed, 26 Aug 2020 11:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=HveVLL7EXNCp5m3T5mLVFK08+ceAw2VPDTsyqsD7P2s=;
 b=HuojoWxGluHfAXI1B81euQ1eaen2dTMGgvEHBNQsKv5jq1o1+edR8Hr7ZOV4S5Rqa/7u
 BAiLFIbTnH6NaZU9IfXEaOYY9Pe9T++Qnpatg/JZyn9Nou9kSiQmtm/SKauOfqH1lWRM
 2+wXl9ADVFYIWRQKPnAa3ZJFmgJqKusuTZ1jZfZG4zo3YKunSPK6zjRkWQFz9tFZaGWL
 isPpOX2rKf7LYKufcU7l1WyptJpRkE8Xz7NpPRhWEf2gDw2xaUh0eYoWpGbI6UTtOADL
 Uqojm1HSf3cwKXI0YOj8D0ik9L8QTCBJ1pZlymOCcOsLfSrZRUIFI7iR7CKxlqEMOaOl WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 333w6txbnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 11:32:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QBUiqp138701;
        Wed, 26 Aug 2020 11:32:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 333ru00q01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 11:32:53 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07QBWp2f021625;
        Wed, 26 Aug 2020 11:32:51 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Aug 2020 04:32:50 -0700
Date:   Wed, 26 Aug 2020 14:32:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] rnbd: Fix an error code in process_rdma()
Message-ID: <20200826113242.GC393664@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008260093
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The error code is uninitialized on this error path.

Fixes: 735d77d4fd28 ("rnbd: remove rnbd_dev_submit_io")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/block/rnbd/rnbd-srv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 0fb94843a495..5b69bc56b225 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -149,6 +149,7 @@ static int process_rdma(struct rtrs_srv *sess,
 	bio = rnbd_bio_map_kern(data, sess_dev->rnbd_dev->ibd_bio_set, datalen, GFP_KERNEL);
 	if (IS_ERR(bio)) {
 		rnbd_srv_err(sess_dev, "Failed to generate bio, err: %ld\n", PTR_ERR(bio));
+		err = PTR_ERR(bio);
 		goto sess_dev_put;
 	}
 
-- 
2.28.0

