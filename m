Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F83A4500D
	for <lists+linux-block@lfdr.de>; Fri, 14 Jun 2019 01:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfFMXcY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 13 Jun 2019 19:32:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726265AbfFMXcY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 19:32:24 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DNC4fM061158;
        Thu, 13 Jun 2019 19:32:23 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t3xb2kmr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jun 2019 19:32:23 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5DNCwX7030472;
        Thu, 13 Jun 2019 23:32:22 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 2t1x6frja6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jun 2019 23:32:22 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5DNWKSD34931114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 23:32:20 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4177BE054;
        Thu, 13 Jun 2019 23:32:20 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C088ABE058;
        Thu, 13 Jun 2019 23:32:19 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.18.235.170])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jun 2019 23:32:19 +0000 (GMT)
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     linux-block@vger.kernel.org
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] block/cfq : Include check to avoid NULL Pointer
Date:   Thu, 13 Jun 2019 20:31:58 -0300
Message-Id: <20190613233159.26687-1-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=790 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130176
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I believe to have found a NULL pointer dereference on the code, but as
I am new to this code I would like the opinion of more experienced people.

I am not sure if it is the right procedure to send it here, since this file
is not on the tree since v4.20. But as it still affects many stable releases,
I think it's worth the try.

Please let me know if there is a better procedure on this.

Leonardo Bras (1):
  block/cfq : Include check to avoid NULL Pointer Dereferencing

 block/cfq-iosched.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.20.1

