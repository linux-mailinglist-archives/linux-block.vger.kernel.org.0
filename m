Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5F8D1436C6
	for <lists+linux-block@lfdr.de>; Tue, 21 Jan 2020 06:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgAUFq0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Jan 2020 00:46:26 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48254 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUFq0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jan 2020 00:46:26 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00L5hPP7115698;
        Tue, 21 Jan 2020 05:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=hnj5yygl8cYjbyZ6FFoRETqhejtQqC1ViqWe7gP+9h8=;
 b=gcpbnat3hVcXfS+bN0SPTSfIILflFNoP/cb8gZhWPN7NA0MkcDSh/Ta8U5SbkfZT8EWu
 v+RiYrgQvJNZAgIq9r4NkNKYR0wp0ST89TOL2BuHNuvg16mKJtTHOpotBAi6ZgIxxiyM
 0pzSfTd9debb31jsdlavvQ0haYCZzAAAAxdmOeTc0TYAOXevErMO+eU6poC2Mix33OB+
 YFF8Pi1sBTNLIFuI8/2jO3AE0iwOIafKAAVuiNOy1s37qTV8GlDKFYddxfXZg1mQGrbV
 egkBxPjacGF4Duzqbwwrs/fpIEZSUeliBkSqvolT02Ey5yLuqOZIXOOdBWbbAeZ9O3xN 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xktnr2g4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 05:45:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00L5iV74122219;
        Tue, 21 Jan 2020 05:45:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2xnsj3vsjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 05:45:30 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00L5jPtc022123;
        Tue, 21 Jan 2020 05:45:26 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jan 2020 21:45:25 -0800
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, axboe@kernel.dk, tytso@mit.edu,
        adilger.kernel@dilger.ca, Chaitanya.Kulkarni@wdc.com,
        darrick.wong@oracle.com, ming.lei@redhat.com, osandov@fb.com,
        jthumshirn@suse.de, minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com
Subject: Re: [PATCH block v2 1/3] block: Add @flags argument to bdev_write_zeroes_sectors()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <157917805422.88675.6477661554332322975.stgit@localhost.localdomain>
        <157917815798.88675.11900718803129164489.stgit@localhost.localdomain>
Date:   Tue, 21 Jan 2020 00:45:21 -0500
In-Reply-To: <157917815798.88675.11900718803129164489.stgit@localhost.localdomain>
        (Kirill Tkhai's message of "Thu, 16 Jan 2020 15:35:58 +0300")
Message-ID: <yq18sm1icr2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=942
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001210050
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=996 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001210050
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Kirill,

> This is a preparation for next patch, which introduces a new flag
> BLKDEV_ZERO_ALLOCATE for calls, which need only allocation of blocks
> and don't need actual blocks zeroing.

Path of least resistance, I guess.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
