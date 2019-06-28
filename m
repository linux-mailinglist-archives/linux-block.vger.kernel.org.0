Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54F9F5A5DC
	for <lists+linux-block@lfdr.de>; Fri, 28 Jun 2019 22:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfF1UZr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 28 Jun 2019 16:25:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49476 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfF1UZr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 16:25:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SKNh8X105887;
        Fri, 28 Jun 2019 20:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=cuKdErStEbV911yNRiCd9yz0vcPar0KyqDRQ9fMwtm4=;
 b=ax+sGI5/8MWlXOtUGqi7fTAFyFLr4V7PAwIGdJcwzi2A+JH9u+HYM8sLSUGcrqk5jNPq
 vOXrk0A5gzgLFyIBI/1Q7tdxU3HZfBJKQ+amn5qJjjVWGgaivEwZWn+2rzES71JTcH2K
 8MDSoh7KSHA2Yz/siDbMgVQuzurml9Luc8JasDXgO6isZpm/Z5VnLrlqEqldoDogaHXY
 oUHbgiKSPOGGZbqZBWy2aAWx5HVC+ci0rWwvTVM3Ic4zBclxs2LxPwZ7nI0suBBPUo6e
 hv7++R5ctFy9sUmym2IK1/EPcxRMGmWsNjOvgracS62lKGwTze1CVLkKS/IultZx+lfw cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2t9c9q7ebk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 20:25:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SKNf7S122556;
        Fri, 28 Jun 2019 20:23:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t9ace0shp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 20:23:40 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5SKNd63001619;
        Fri, 28 Jun 2019 20:23:39 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Jun 2019 13:23:39 -0700
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/4] block, documentation: Document discard_zeroes_data, fua, max_discard_segments and write_zeroes_max_bytes
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190628200745.206110-1-bvanassche@acm.org>
        <20190628200745.206110-5-bvanassche@acm.org>
Date:   Fri, 28 Jun 2019 16:23:37 -0400
In-Reply-To: <20190628200745.206110-5-bvanassche@acm.org> (Bart Van Assche's
        message of "Fri, 28 Jun 2019 13:07:45 -0700")
Message-ID: <yq18stlh31y.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280233
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280233
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Bart,

Looks fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
