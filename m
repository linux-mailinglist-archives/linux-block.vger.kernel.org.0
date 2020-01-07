Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96814131E01
	for <lists+linux-block@lfdr.de>; Tue,  7 Jan 2020 04:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgAGDdR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 6 Jan 2020 22:33:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57500 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbgAGDdQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jan 2020 22:33:16 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0073U8Dt044508;
        Tue, 7 Jan 2020 03:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=n3hOFxO756b5o0zbvtzmSTUCQEAHulQgbhS1INkyH2Y=;
 b=BL2c59YKlqagCI5G8PPSwaI3ahdwNQVZCQw8l9Qy0hk5S+Mm+ILSWLBVAvzLvY5qjv/f
 dPdlc2hZfQauXDlAHeYBRWPbGNFfwCsqgM3tae+nQFfneR5+KFic6LEDV0ULl9DDIz8z
 B8a+8aFh4kkcxD+/fNcAwTSB9uR7peCDdTmQGVWD3ujL6KPBJKsDm6irMyKnfEn8hMgg
 H0q2n8pHkEQQnSXMglv+UZXICy0hkVdcnp+KrSGFMt1CeTusWomANmCvYeHbvqv+7O+L
 7/mt3LqDv8zwlRbdnjMmEGyslco1Zdd0dNml7S3LE0HUlwL2pu5BAcwgLnmyGUUCVEPd Hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xakbqjqxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 03:33:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0073U4NP086406;
        Tue, 7 Jan 2020 03:33:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2xb47hhg1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 03:33:00 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0073WwDN031416;
        Tue, 7 Jan 2020 03:32:58 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jan 2020 19:32:58 -0800
To:     Balbir Singh <sblbir@amazon.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <axboe@kernel.dk>,
        <ssomesh@amazon.com>, <jejb@linux.ibm.com>, <hch@lst.de>,
        <mst@redhat.com>, <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [resend v1 1/5] block/genhd: Notify udev about capacity change
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200102075315.22652-1-sblbir@amazon.com>
        <20200102075315.22652-2-sblbir@amazon.com>
Date:   Mon, 06 Jan 2020 22:32:55 -0500
In-Reply-To: <20200102075315.22652-2-sblbir@amazon.com> (Balbir Singh's
        message of "Thu, 2 Jan 2020 07:53:11 +0000")
Message-ID: <yq1ftgs2b6g.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=906
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=969 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070026
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Balbir,

> Allow block/genhd to notify user space (via udev) about disk size
> changes using a new helper disk_set_capacity(), which is a wrapper on
> top of set_capacity(). disk_set_capacity() will only notify via udev
> if the current capacity or the target capacity is not zero.

I know set_capacity() is called all over the place making it a bit of a
pain to audit. Is that the reason you introduced a new function instead
of just emitting the event in set_capacity()?

-- 
Martin K. Petersen	Oracle Linux Engineering
