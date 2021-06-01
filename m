Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB9E39096E
	for <lists+linux-block@lfdr.de>; Tue, 25 May 2021 21:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhEYTKp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 May 2021 15:10:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45488 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhEYTKp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 15:10:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PJ6g1H132958;
        Tue, 25 May 2021 19:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wNK9h4wyFtSiHANHSsfzQngok7zo7qtN+8MIAJ4nfOI=;
 b=kGOe0tV1DyDY1S+EKc9Wh4B3mTqhjRie5DRsHwfK3I70tQecwQlxbe3zJDr99AkmExpC
 oHm7NVCgOTC0TO/Ado158pfAZpUH1DivAjLGFwFWknB3RqEiPl0JaMvqqNr2cNgAK7t5
 hDOfH5+iGYZI9qZWTSkkZItF04Z3R1Xe4pZPAESg+OzIuDLIuyF5SkxZW5k17Kr+w0HF
 dDSwX1bbfwg+WZBaCMg9rZshUb2IJPGYWawkf03j6dECVPcs7+2F94dyKBRoSDTHGxOh
 HuJuMz9vTuKje22aetDAFIA8afB6/MmEEtk6+5lvWCBd4YJtuYpWN7vTyqtd7Wes5yCz hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38ptkp702b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 19:09:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PJ50xu098219;
        Tue, 25 May 2021 19:09:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3020.oracle.com with ESMTP id 38rehatxe7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 19:09:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emjiSLpj4Zd5jwOBVCaLod6dleNeADL0vAM82Apls0JqaxRBPLAtlh5wk7CbAj/342Y7S+96TlrxHGVmHGJRfyEEAmQCmMznbJ0aXg1jDsyXc7mwv+jJJEy+VlMvaFdiQTn+4jhz/Voqn3Fu1ke9yMvkJIAZ7/fuFpMBTl84X5XHAV21PSDrIK2Z5fqS+gXFNZd8LwYTM2Q5Qyzk7Id0wpI+2juDDocKxJlZJxuKTYdPdytnyacH1KMfU7xismYzpzxirWJeuS2mrygkqGMO9ghcUwF8w9mwqYr/gGrE8omuNpLNCg8JFEynixnv8bcKw93051ziZJcTbAbMD2TDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNK9h4wyFtSiHANHSsfzQngok7zo7qtN+8MIAJ4nfOI=;
 b=h8+QumrBi6yw+StqK/A70MS2hmgG5iSqKJjfr71VU7KBPGQQneEID3XVW4a54Ald/OinChXd28i8KkN7nAwNM1ewUTUAfH4y14Hut83k2yQBiXd8sey4mXa9RMQ3fmg6pzvrdFr9Md3KaFow3NzIrG9FMW5ETZoAnPQ0XACQxm0T1jW5OfOi9O/1H+57I+5aGDXCaA4nx6ClHQPyoGmpWEKEEiFpRgqRsvHdn/ZPOU8b2akZH1U9b7ZtSioSSmutxXwfhpFdh9wOleQQw/na9KARpkqIHShcOQCGk7rRr3i5wuesUY25BJAgIhK+eDsgCiwpmVCB9aINS+K1VEGwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNK9h4wyFtSiHANHSsfzQngok7zo7qtN+8MIAJ4nfOI=;
 b=HHAAuKjYyoV/fN7WuAQUKR8iWeE3SJcCbJQaaXdXXI7J7n/UcgQtmrtyUhoKkWPfdfJz2JIjVUx6oem8+76vSCvcWUa6UxyFkjHcNnia0F3wd3SbwbhiDaZ7WcT4Hl6w+736Nj7PBCtX5UitEVz2ii6MctckWMIIchfPNH1Yd2Y=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB2720.namprd10.prod.outlook.com (2603:10b6:805:3f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 19:09:06 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 19:09:06 +0000
Subject: Re: [PATCH v4 01/11] block: improve handling of all zones reset
 operation
To:     Damien Le Moal <damien.lemoal@wdc.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
 <20210525022539.119661-2-damien.lemoal@wdc.com>
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <6d6ad853-8616-7016-34fd-36972abcdae5@oracle.com>
Date:   Tue, 25 May 2021 14:09:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210525022539.119661-2-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.114.128.235]
X-ClientProxiedBy: SA9PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:806:21::22) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.28] (70.114.128.235) by SA9PR13CA0017.namprd13.prod.outlook.com (2603:10b6:806:21::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Tue, 25 May 2021 19:09:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7aa9043-d924-4070-886f-08d91fb0914d
X-MS-TrafficTypeDiagnostic: SN6PR10MB2720:
X-Microsoft-Antispam-PRVS: <SN6PR10MB27207875A48C1A1331B48ED9E6259@SN6PR10MB2720.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ZXVEDMcvSXp91BTxo20NYVMx5FN3mzf0jvEEuC+6/3NgjCfCKKeMi4Dh1NxdvKNT6Q8+1uMYfg+hfLy7BkEHxB8NevM3/JFXszkII25LxcD3pY9LtQkMyIBYTrOT5RKXdCYnuU4urcxIO4uDKK/WDz4qiePu0KeEbSY/Kebp47WHk1BFV9DwndAtqQvwWo4XDd+lyj84RvN8JShqrQQrv4uwGMZK7pCVf0fcBct1Hm5H4RUjpOFZ/JpUIeCntPZaaK/sfBLBXnhqUS8BQIht5xP3ay3HeWTrMSToALOXvxrfJDyOEXhURChdIYjhsTaiG3De6QinSD3JTXeRofbZJmuHkKJ2Lg03yf3qpemrIcEHnCRHiRp9VTXYhNN2RzCxaTYQTxwzp0HNbSU71c0uMNzgwR+AtYEvVROV17ujhqI5/KHkzGXKjUSfR+uyeKNR+yr27lbELaqx6D8mEmeM7vCOlDSi7lTGVLwZ3i+9Q/1H0P/Pw7a6ZTkch1dxPe1+ycH428zbY84vI2ZaNtjzTRAKE+CUztGFRq5R2Gs7oCwMKoW5oF9wGAIIduOMvN/AOjzlal59C5JoEvPKlB7W0rfCny9XUTE71L7U1XdbHJWTF6w1WsCvjpknq1sOkI+QeF99Xn9gg5HOECWijC7OJxlUdUq+WV3r5piEWBTpGHfwrVYOToGFv0EJmcZuas5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(366004)(376002)(396003)(2906002)(26005)(478600001)(44832011)(53546011)(110136005)(186003)(86362001)(16526019)(8676002)(8936002)(31696002)(38100700002)(5660300002)(66946007)(36756003)(16576012)(316002)(66556008)(2616005)(36916002)(31686004)(66476007)(83380400001)(6486002)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UkR2VDI4ZjFIK1ZOOEV3aURYV2p4VzhjYnZJZUlsaUllYzArYzlGK3lNTkov?=
 =?utf-8?B?b05HS3pPM3NFZDdsMUZjcUJVa2xjQjdOZW9qRVd0L0E4WWp4N1hMUGIvVzU2?=
 =?utf-8?B?Z0pyOGwwQzBWT29BcUR1S2c2ekVCMW5RUXZ5elMyNy9YNFVyaXpCSVk1dHpo?=
 =?utf-8?B?UEN2NStBa1pQd3R6L3BqMU5ZVmQra0FHRktwU05mK3FvbndBN3JxT3Y3eHBZ?=
 =?utf-8?B?TzBBSFVhaktYcEZwSThzSTA3ZU14Qk9HVHc3c3hDelRRd1VxaVVwYzBvYm12?=
 =?utf-8?B?SmxtSHFVSGhmb1FBSGRWanhEK3VvNjZwWmtTVlZodDFJSHpBeEpIS0czT1ps?=
 =?utf-8?B?cE5oYjFKUmRLajR4VDU0L2RubXllVXhscFZRZTJWYzlJdyt1MmZyYWFuVlZY?=
 =?utf-8?B?UFM4UE9pZ2JScG9PTGF6eE9sU2dZNW5vY2NNVDZxQTBaY2JlQkVqRGFlUFpR?=
 =?utf-8?B?VXY0NHRrcVhPdUN2Q2hOUC91cXk1MzdpYzdTdkY0N0R6NWExR2dMajdQc2tT?=
 =?utf-8?B?alFqSXQ1VW5BcW5ac2Y1eitnbWlkSUtsNXVJald2ZDFTb3VtUEMyR0NIUmZ6?=
 =?utf-8?B?VnA2OGdJU1h5RWk0eTRxTmNyZkova0ZhNGlsWWplazFISmtaT2kwOTUzQUxB?=
 =?utf-8?B?eHZWQjJZUHZOR05CNlZHbjJuQ2Foa2xZU0d5RG5ieXVVNC93dlRQMFZNQ0J1?=
 =?utf-8?B?RWg2ZVNsZ000cTkwa0tQR2VUVjRpaFNVMTFKekw4RW80cFoyYTQ4Ui9zeUhZ?=
 =?utf-8?B?R0JmalFNbjR0cWRCeDJITXpJa2UwRXVQRUJ3amd3N0ZOZHdpTlh6emhUTkww?=
 =?utf-8?B?aklYeWNDclIyTmtYT1dLLy8rTU9XM05TNzdrbUhJeWZRTzBMcHNwRmc3SlFN?=
 =?utf-8?B?QU9XaG9Da1hRRHNCbC8zc0NNaWc1Ym1HOTJaQlB6Q2hWRERObUhOdGY0VWY3?=
 =?utf-8?B?ZkcyQUQ0dW5saUhLenZGRnJQRmpzR2YxRDZmVEhBMjB3aFN5N2kyNkhZZk05?=
 =?utf-8?B?TlNYakVkdGdkYXljN05hSVZWd2paV2szQVlEZWF1Z3p2Vm9TMzdRMGZRQTJR?=
 =?utf-8?B?VU0veFNQZXpSWlJKQmpGRFIxM0h5K085QkxVa0hGWjErNWpQam15dUhwak5L?=
 =?utf-8?B?YnpZemgvWFNuRVZRSStKRjNFOXF4T1NZaDAycmlwVFI2U0l5RGxjWkRBeEs4?=
 =?utf-8?B?THlWbEYxSVd3cE54ODN1eElLaG5kSU44UlpVL3BGcjhiNkJIc0w3SHlVcnl2?=
 =?utf-8?B?aVlYZFZ5MHBqRExUQXVHcDYzSVlRb2xKZWduRm5YYjFla3BCMHNNUk00cTJU?=
 =?utf-8?B?ZFZtTFFRMUNwUFR4aUNEL21WbXpNWnZEZnd5T0w5NGQzQnlHM2ZCOVRPdEh0?=
 =?utf-8?B?dXJrL2liQ3ZaajJtTWt6Y0dybWMxL2liUnZGSFVML3JZMVgvelc2aW4zZDdl?=
 =?utf-8?B?cFdUL05uVHdibGJzakdJeEgzY2s5TjB4aEpMVkoxYVQ5RGUvUXE3ZjVDUmJo?=
 =?utf-8?B?RWY3N05Ga0cramo4dHBaSU9MdEdwaTZJL3RDQzVIaXUwcUgxWWdIVmd6TERN?=
 =?utf-8?B?dGJieFg3clpiT1hUVVJwQTh2RXZlalg4ZU5Nd0pTZHA2MFRERk9DUlNvdzFw?=
 =?utf-8?B?Q3h2VXZsZjFHRXNScC9OZytBdXJYVkQ1Wjk5bUQxdElYNVZtdXNrc0VuYmNI?=
 =?utf-8?B?VzUvMkF4NFhFcnpQdllCUzNiYm5jQUMrRVVvcFpvWlhvbC9KSEpIakFicFp6?=
 =?utf-8?Q?PVzsUXmBHzk0VNZX7JJPWHfDBGZ2THoUwDKNFLg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7aa9043-d924-4070-886f-08d91fb0914d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 19:09:06.3137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quPmv4ys8bbbxHs8kR5i6MzZdF0p5fjPVSwWDBHUA80fRtXLFt2lpx7FGX7yvrXf0HDOExhfpsw/srubBegJ/sYKDBxnoywyI4DbbUcYLu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2720
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250117
X-Proofpoint-GUID: w-We-7ca3UZOeJfqMkl4aDMURk6w-ygD
X-Proofpoint-ORIG-GUID: w-We-7ca3UZOeJfqMkl4aDMURk6w-ygD
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250117
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/24/21 9:25 PM, Damien Le Moal wrote:
> SCSI, ZNS and null_blk zoned devices support resetting all zones using
> a single command (REQ_OP_ZONE_RESET_ALL), as indicated using the device
> request queue flag QUEUE_FLAG_ZONE_RESETALL. This flag is not set for
> device mapper targets creating zoned devices. In this case, a user
> request for resetting all zones of a device is processed in
> blkdev_zone_mgmt() by issuing a REQ_OP_ZONE_RESET operation for each
> zone of the device. This leads to different behaviors of the
> BLKRESETZONE ioctl() depending on the target device support for the
> reset all operation. E.g.
> 
> blkzone reset /dev/sdX
> 
> will reset all zones of a SCSI device using a single command that will
> ignore conventional, read-only or offline zones.
> 
> But a dm-linear device including conventional, read-only or offline
> zones cannot be reset in the same manner as some of the single zone
> reset operations issued by blkdev_zone_mgmt() will fail. E.g.:
> 
> blkzone reset /dev/dm-Y
> blkzone: /dev/dm-0: BLKRESETZONE ioctl failed: Remote I/O error
> 
> To simplify applications and tools development, unify the behavior of
> the all-zone reset operation by modifying blkdev_zone_mgmt() to not
> issue a zone reset operation for conventional, read-only and offline
> zones, thus mimicking what an actual reset-all device command does on a
> device supporting REQ_OP_ZONE_RESET_ALL. This emulation is done using
> the new function blkdev_zone_reset_all_emulated(). The zones needing a
> reset are identified using a bitmap that is initialized using a zone
> report. Since empty zones do not need a reset, also ignore these zones.
> The function blkdev_zone_reset_all() is introduced for block devices
> natively supporting reset all operations. blkdev_zone_mgmt() is modified
> to call either function to execute an all zone reset request.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> [hch: split into multiple functions]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-zoned.c | 119 +++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 92 insertions(+), 27 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 250cb76ee615..f47f688b6ea6 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -161,18 +161,89 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
>   }
>   EXPORT_SYMBOL_GPL(blkdev_report_zones);
>   
> -static inline bool blkdev_allow_reset_all_zones(struct block_device *bdev,
> -						sector_t sector,
> -						sector_t nr_sectors)
> +static inline unsigned long *blk_alloc_zone_bitmap(int node,
> +						   unsigned int nr_zones)
>   {
> -	if (!blk_queue_zone_resetall(bdev_get_queue(bdev)))
> -		return false;
> +	return kcalloc_node(BITS_TO_LONGS(nr_zones), sizeof(unsigned long),
> +			    GFP_NOIO, node);
> +}
>   
> +static int blk_zone_need_reset_cb(struct blk_zone *zone, unsigned int idx,
> +				  void *data)
> +{
>   	/*
> -	 * REQ_OP_ZONE_RESET_ALL can be executed only if the number of sectors
> -	 * of the applicable zone range is the entire disk.
> +	 * For an all-zones reset, ignore conventional, empty, read-only
> +	 * and offline zones.
>   	 */
> -	return !sector && nr_sectors == get_capacity(bdev->bd_disk);
> +	switch (zone->cond) {
> +	case BLK_ZONE_COND_NOT_WP:
> +	case BLK_ZONE_COND_EMPTY:
> +	case BLK_ZONE_COND_READONLY:
> +	case BLK_ZONE_COND_OFFLINE:
> +		return 0;
> +	default:
> +		set_bit(idx, (unsigned long *)data);
> +		return 0;
> +	}
> +}
> +
> +static int blkdev_zone_reset_all_emulated(struct block_device *bdev,
> +					  gfp_t gfp_mask)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +	sector_t capacity = get_capacity(bdev->bd_disk);
> +	sector_t zone_sectors = blk_queue_zone_sectors(q);
> +	unsigned long *need_reset;
> +	struct bio *bio = NULL;
> +	sector_t sector =  0;
> +	int ret;
> +
> +	need_reset = blk_alloc_zone_bitmap(q->node, q->nr_zones);
> +	if (!need_reset)
> +		return -ENOMEM;
> +
> +	ret = bdev->bd_disk->fops->report_zones(bdev->bd_disk, 0,
> +				q->nr_zones, blk_zone_need_reset_cb,
> +				need_reset);
> +	if (ret < 0)
> +		goto out_free_need_reset;
> +
> +	ret = 0;
> +	while (sector < capacity) {
> +		if (!test_bit(blk_queue_zone_no(q, sector), need_reset)) {
> +			sector += zone_sectors;
> +			continue;
> +		}
> +
> +		bio = blk_next_bio(bio, 0, gfp_mask);
> +		bio_set_dev(bio, bdev);
> +		bio->bi_opf = REQ_OP_ZONE_RESET | REQ_SYNC;
> +		bio->bi_iter.bi_sector = sector;
> +		sector += zone_sectors;
> +
> +		/* This may take a while, so be nice to others */
> +		cond_resched();
> +	}
> +
> +	if (bio) {
> +		ret = submit_bio_wait(bio);
> +		bio_put(bio);
> +	}
> +
> +out_free_need_reset:
> +	kfree(need_reset);
> +	return ret;
> +}
> +
> +static int blkdev_zone_reset_all(struct block_device *bdev, gfp_t gfp_mask)
> +{
> +	struct bio bio;
> +
> +	bio_init(&bio, NULL, 0);
> +	bio_set_dev(&bio, bdev);
> +	bio.bi_opf = REQ_OP_ZONE_RESET_ALL | REQ_SYNC;
> +
> +	return submit_bio_wait(&bio);
>   }
>   
>   /**
> @@ -200,7 +271,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
>   	sector_t capacity = get_capacity(bdev->bd_disk);
>   	sector_t end_sector = sector + nr_sectors;
>   	struct bio *bio = NULL;
> -	int ret;
> +	int ret = 0;
>   
>   	if (!blk_queue_is_zoned(q))
>   		return -EOPNOTSUPP;
> @@ -222,20 +293,21 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
>   	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
>   		return -EINVAL;
>   
> +	/*
> +	 * In the case of a zone reset operation over all zones,
> +	 * REQ_OP_ZONE_RESET_ALL can be used with devices supporting this
> +	 * command. For other devices, we emulate this command behavior by
> +	 * identifying the zones needing a reset.
> +	 */
> +	if (op == REQ_OP_ZONE_RESET && sector == 0 && nr_sectors == capacity) {
> +		if (!blk_queue_zone_resetall(q))
> +			return blkdev_zone_reset_all_emulated(bdev, gfp_mask);
> +		return blkdev_zone_reset_all(bdev, gfp_mask);
> +	}
> +
>   	while (sector < end_sector) {
>   		bio = blk_next_bio(bio, 0, gfp_mask);
>   		bio_set_dev(bio, bdev);
> -
> -		/*
> -		 * Special case for the zone reset operation that reset all
> -		 * zones, this is useful for applications like mkfs.
> -		 */
> -		if (op == REQ_OP_ZONE_RESET &&
> -		    blkdev_allow_reset_all_zones(bdev, sector, nr_sectors)) {
> -			bio->bi_opf = REQ_OP_ZONE_RESET_ALL | REQ_SYNC;
> -			break;
> -		}
> -
>   		bio->bi_opf = op | REQ_SYNC;
>   		bio->bi_iter.bi_sector = sector;
>   		sector += zone_sectors;
> @@ -396,13 +468,6 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>   	return ret;
>   }
>   
> -static inline unsigned long *blk_alloc_zone_bitmap(int node,
> -						   unsigned int nr_zones)
> -{
> -	return kcalloc_node(BITS_TO_LONGS(nr_zones), sizeof(unsigned long),
> -			    GFP_NOIO, node);
> -}
> -
>   void blk_queue_free_zone_bitmaps(struct request_queue *q)
>   {
>   	kfree(q->conv_zones_bitmap);
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering
