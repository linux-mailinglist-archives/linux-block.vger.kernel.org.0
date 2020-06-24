Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D692072DB
	for <lists+linux-block@lfdr.de>; Wed, 24 Jun 2020 14:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389730AbgFXMIA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 Jun 2020 08:08:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43640 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388522AbgFXMIA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 08:08:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05OC2Zx8124084;
        Wed, 24 Jun 2020 12:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=BEbvcmGfM5tz2pa3NoCamUu/o77G2mzvTOG95lKNFD4=;
 b=XJvwdkq4nfBjtLpVXFp4BmfLKu+qVfAoVvTsmFTeGJWKXViXcJRVVgwM7vC8AVVuND+4
 zUehiZxcCUbm4WNpy9NsUCweQFZuir/BjezVHYZp8PiSKpMaXkVry0IS/cJPHBgNlMsZ
 6rFsvsr6SNlMLH+97eoHQhPfGEruMeLkTI2m6EmYm4zPau1tSTmhcqFCCi3esHC45ULa
 wDW0bLv8wEP0Bp2fFRxrnMp0HU8L5B/OunaR3Xh7AkGtwnUAVbSRr2VlWfcfwcRl55Dg
 HEBTVjEtCT0kfg+5IxfjigPhEskJqAq9jcp9+htojA8RU3DOMP8p/rd5W6aonerpCWfg DA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31uut5jf39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 12:07:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05OC49V8076680;
        Wed, 24 Jun 2020 12:07:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31uur677pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 12:07:38 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05OC7Xlk020706;
        Wed, 24 Jun 2020 12:07:33 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jun 2020 12:07:33 +0000
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] block: release bip in a right way in error path
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v9jg1xcq.fsf@ca-mkp.ca.oracle.com>
References: <20200624102139.5048-1-cgxu519@mykernel.net>
Date:   Wed, 24 Jun 2020 08:07:31 -0400
In-Reply-To: <20200624102139.5048-1-cgxu519@mykernel.net> (Chengguang Xu's
        message of "Wed, 24 Jun 2020 18:21:39 +0800")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 spamscore=0 adultscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=885 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9661 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=1
 phishscore=0 impostorscore=0 cotscore=-2147483648 priorityscore=1501
 mlxscore=0 mlxlogscore=903 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006240088
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Chengguang,

> Release bip using kfree() in error path when that was allocated
> by kmalloc().

Looks good to me.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
