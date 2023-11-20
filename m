Return-Path: <linux-block+bounces-294-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F7B7F152A
	for <lists+linux-block@lfdr.de>; Mon, 20 Nov 2023 15:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D142824C8
	for <lists+linux-block@lfdr.de>; Mon, 20 Nov 2023 14:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514BC1B28C;
	Mon, 20 Nov 2023 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CF0ScI1s"
X-Original-To: linux-block@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B3A10C0;
	Mon, 20 Nov 2023 06:03:43 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKDMaJR022494;
	Mon, 20 Nov 2023 14:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ayQvgFthRJNPJhY6OnvpeIv7utMhV9IsMNfSqwniqng=;
 b=CF0ScI1sI+S3fLP8hfsWERlOiURR+RTJDO5UbNXSKFbA3g3EdedndSYLIEsUQIotSkOx
 3FSDVAE1unxRTnKZqynF8gy0uCg80I8wJyev3AllvYrRp7F5zxsk2lfymPSdjEwvXHpG
 0KyQGFvvN9gotqziAKZ4z72+3jaxTxzBzdJ71bSq5tFUwb9kjMpkeuamtdV2wDxzWK+k
 lwimXGKMzzeWjyPFHxavg6lYM0XUNhuqAl5oZ3e99+npSqtWpxzrH1NgK/wpAAfbvjl1
 7CcFtYHdqxSg4WPxIY9efjedAUv9MTokc8l8awDFE9XMlpP8TZTDJny5va4kxtZYDyHs Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug89eh4t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Nov 2023 14:03:41 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AKDRSh9003048;
	Mon, 20 Nov 2023 14:03:40 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug89eh4s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Nov 2023 14:03:40 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKDPFo0010137;
	Mon, 20 Nov 2023 14:03:39 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8knhha7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Nov 2023 14:03:39 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AKE3cbK10224320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Nov 2023 14:03:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23B8E58063;
	Mon, 20 Nov 2023 14:03:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC76A58057;
	Mon, 20 Nov 2023 14:03:36 +0000 (GMT)
Received: from [9.179.19.4] (unknown [9.179.19.4])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Nov 2023 14:03:36 +0000 (GMT)
Message-ID: <ffdd12e0-22fa-d8b8-9862-c440d9cedf59@linux.ibm.com>
Date: Mon, 20 Nov 2023 15:03:36 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] s390/dasd: fix kernel panic with statistics
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
References: <20231025132437.1223363-1-sth@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20231025132437.1223363-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: slNPZYT41be9aMYSsNoPGjTNYh6FXW4M
X-Proofpoint-ORIG-GUID: 3o09iHnDC8TKI-a6AqaV_9jlfmpnBkM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_13,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=870 phishscore=0
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200097

Am 25.10.23 um 15:24 schrieb Stefan Haberland:
> Hi Jens,
>
> please apply the following patch for the upcomming merge window that
> fixes a kernel panic that can be triggered by using dasd statistics.
> Also there is a typo fix for a comment.
>
> Thanks.
>
> Jan Höppner (1):
>    s390/dasd: protect device queue against concurrent access
>
> Muhammad Muzammil (1):
>    s390/dasd: resolve spelling mistake
>
>   drivers/s390/block/dasd.c     | 24 +++++++++++++-----------
>   drivers/s390/block/dasd_int.h |  2 +-
>   2 files changed, 14 insertions(+), 12 deletions(-)
>

Hi Jens,

polite ping.

