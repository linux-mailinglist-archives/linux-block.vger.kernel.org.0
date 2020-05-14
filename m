Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4561D40C1
	for <lists+linux-block@lfdr.de>; Fri, 15 May 2020 00:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgENWVB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 14 May 2020 18:21:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48854 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbgENWVB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 18:21:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EMDPaj188743;
        Thu, 14 May 2020 22:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=iXu1nAFus4sTDwZffcA0m9B08Spv91nPDCqcGwihypw=;
 b=q+V+vcDxWOfUqLFY4dRflM0pbKUmHivvaaYcOFJgK6eM/H88f0og65w03PyOdqT0w4A7
 x+cb4XGkw6UECz8elS+sx91a3LfmP7ojHfO8yhP6W+K0Yvrk+mrOE9FHH3gp6GW6Oac1
 vHKSu8muKTggqwjPVvpl6f5KIKrocK6cuhSFk/CPxnwSbylUifT3JPMiUZvaTP+vUb0C
 eOyNkX7KsboJg02cQU8sKdnNFtDAvWxlSc/qvCWn+dVoCWS24IFHNyRNvuEJRIjGasfv
 jSessfw/438JEhTx0nvOuxalbtue6LJhwGTi4xgHLi5827jYNeF/+WX7Pv+nXsWGYdLn aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 3100xwwetw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 May 2020 22:20:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EM8hOp067934;
        Thu, 14 May 2020 22:20:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 310vju293d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 May 2020 22:20:51 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04EMKo5H002141;
        Thu, 14 May 2020 22:20:50 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 May 2020 15:20:49 -0700
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] nvme: Fix io_opt limit setting
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200514055626.1111729-1-damien.lemoal@wdc.com>
Date:   Thu, 14 May 2020 18:20:47 -0400
In-Reply-To: <20200514055626.1111729-1-damien.lemoal@wdc.com> (Damien Le
        Moal's message of "Thu, 14 May 2020 14:56:26 +0900")
Message-ID: <yq1y2putayo.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=971 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140194
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140194
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Damien,

> Fix this by not setting the optimal IO size queue limit if the
> namespace does not report an optimal write size value.

I'm also OK with this approach.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
