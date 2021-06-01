Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB42D390972
	for <lists+linux-block@lfdr.de>; Tue, 25 May 2021 21:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhEYTLk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 May 2021 15:11:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50502 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhEYTLj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 15:11:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PJ6iYE179690;
        Tue, 25 May 2021 19:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XxKjRuV/tSojV4BWyIPFdJlClqCZDd0BAG6LsX8v840=;
 b=Qdpc30M2kM5PnL7MogpX9pNQ/4DHkdmHcemUPKWMBQljFRMe0HRKqzMFSgUtJuVMJ8EG
 WNk2UdzIZ3CjCMrMvIq2q8Syfgc4slZ3inzOd7/ttmyKKpH0F3NcAlJP+IWxNKpuIbEK
 QuCFsQi4nIqN1CjUILOk6dqf2HORMgtNojEEkhr6Nz7u/cLkUg3G/bkYbloteDNe8r6B
 UPsZJ3GZbzk0T4tstR1k8eiqI/E2zarFJagGUepHlqbEhF670l5PQsTf3te1P3AMhX+D
 CjJj6ddAlntQgRK3mElFxrMfJ47+OT52pRExteENEU5GSN2zLDpzauCnanQIBFNPw8B8 eQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 38q3q8xgg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 19:10:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PJ51ew098258;
        Tue, 25 May 2021 19:10:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3020.oracle.com with ESMTP id 38rehau06k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 19:10:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FR3nwcfMmXf8GBWX1qN7RmwmxgVUqQ+nznfT4k2STLQlCdkBksL1HBf6hWRbUxMWOrIPJlC6hagvfOjQO4dcbAGaCRMVi6CdB/HtE6QdjG6BqJdQLvzABAJ+vkZ/4xyKmOV2ORuJYUcl2TJFTb/pxa5KnwfPMh1puRfCEy7Ue0DnrtWjJi9sTqHcOh7/FjitPzaFsMpWFvtOGxnljCNoH9bRg9wWJiKgE3dwDZpjjV6+MgOMmDpaV++xTVRMRDHxkxuy4Y3inGnCTn5DPTAvJuL9QCVtCg4sqFKhvIQEg2ktUJfJRWG/dCpJzKhG10pWaiIeNa+Z7hHTozmdEcT5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxKjRuV/tSojV4BWyIPFdJlClqCZDd0BAG6LsX8v840=;
 b=KAaML6ZvmPNONDCYMR4BbvcuSebq8LZNXkDygzEtkcLDmqdC0j8KvR1TMhKqACiHh6xM1ccnjiCIG/RdTBz/DtAliV/ZioECkDaZzMotc0qSd7uUSpHhx9QSVUmO3apk7+sCryWnxTD0VAhWYMajYqqRM8Hgk4bm8Af+fU0IVt6j2z8zwbMyOZiCejdKJcOl0UUvxr/MS764MoQ4VGCTo7sc3gHBu1APR8BJrIEGHjY6V5FUdQLd1MObGKQmE4wZv3TPiRAN2rOFVv/W/9dnhCSKSguHas1aa+2oHLL3kjjyKJ6Wan/RLjPoqFIYBLgK/SfjIzJfbfHvNo65tCBa/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxKjRuV/tSojV4BWyIPFdJlClqCZDd0BAG6LsX8v840=;
 b=k51LVHDVcMOTqWfqVNuad/ecxLScO3DLMT4UaN1eX64l/Dr3pgJ7tByqFXX3AVdVmBKvOYVhFFNbgO71bbB/wp5jcQPdceidLVREeAHkHqHfPPz3KDw/PEm0aFFjORCQv/nSmgZcDx8AVo2RjWZ3rdkt9VbSyVzDY7FMb8D8gxE=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB3024.namprd10.prod.outlook.com (2603:10b6:805:d1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 25 May
 2021 19:10:02 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::168:1a9:228:46f3%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 19:10:02 +0000
Subject: Re: [PATCH v4 04/11] dm: Fix dm_accept_partial_bio()
To:     Damien Le Moal <damien.lemoal@wdc.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20210525022539.119661-1-damien.lemoal@wdc.com>
 <20210525022539.119661-5-damien.lemoal@wdc.com>
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <8d6ffa67-e21a-a47e-0ac2-a8c0a9403d5f@oracle.com>
Date:   Tue, 25 May 2021 14:10:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210525022539.119661-5-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.114.128.235]
X-ClientProxiedBy: SA9PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:806:21::9) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.28] (70.114.128.235) by SA9PR13CA0004.namprd13.prod.outlook.com (2603:10b6:806:21::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend Transport; Tue, 25 May 2021 19:10:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8936e9d-46fb-43a9-4a48-08d91fb0b2c0
X-MS-TrafficTypeDiagnostic: SN6PR10MB3024:
X-Microsoft-Antispam-PRVS: <SN6PR10MB3024A2CA37B53039D6DECA8DE6259@SN6PR10MB3024.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DmjVTrr5PWR3jYHNzZvm+sWSAn3WmyFvGG2P29iSFEw/xNa4qHUPalcWePau9fcQdxUWzq7uLNl5S27X3zlEqVzRZ+E0NXVxPCutXq3tQD0BMgFXE0padfYx88M2++YIASIwju/c2r0Z5oYwlSWPZ0BvMd/qdg6ExMTWrXhgD7FLfCmXlBjuFXvk2nc8c9UGboHvwWWXdujzoeN/L3VuQaRmSlEbO5YTignQUJ1Jm8tVE6iFk1/Wb6ZELVSizflHGumafxVhV/meWyUwjKAFIiAk1aK66oX+lX1/t/6ClTz3NzASMouH6bvGod/ccW9rEMMeDgsu0ZpO0gRTEjQn8SOuNz9PqJ0jfVQYJWSsOk4I3SQT+OmRV9tzo8nSa+9NcCUrsBQUfCc/8yCyYMnHmejiOmRFZHEhdphjYLQPKPxQS4iOErJtRZCmJyKCelvAJX0vUgU5AvvsDbNSMLQDOhxzNtR2g6CCNMAfuBZHlox7KrGZ/gpbF/5mrWR9i/2NkbcRYuNMgdzB66FEg+jf2Nbfx0lCvp2RSouAkK/a7IzAHY7F/M60SrnYfceqI/AMQ1ZY7GWZllx9zTxyizmdmMogeNTwnsWAm1N8eN92WXWbJbEUJic7o1Ps99zuLNPCTnv06akUnnpScIoBIR6sVqzHPZz37w+V0deVf0xzczamOqSIZvGd5B+6K9tHm7tX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(366004)(136003)(376002)(2616005)(66556008)(66476007)(110136005)(8936002)(26005)(2906002)(83380400001)(6486002)(31696002)(66946007)(31686004)(38100700002)(956004)(186003)(53546011)(86362001)(8676002)(36916002)(44832011)(478600001)(16526019)(16576012)(36756003)(316002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TXVpc3FkMTV6eVpKM3YxcmI5Y3RTbVE4NzIwYXBPb0Y5dytyMUY0aVNOK01D?=
 =?utf-8?B?bGNHemNheHdlY2hnb3BURmxwVnZqa2xDOFJ1S1V0UzJuTzFLK2NLRW9OYUFo?=
 =?utf-8?B?UTl1aURoQXZPdlptZGhCd0haOXlWbGdHL1RMUDNnTU1QMVJ1eHdzL3JGbExO?=
 =?utf-8?B?L3RUdUI1QVlEQWRnT0Q5OElqZHhXT0Z3TkFkOXBIaWRKNFYvakhLZG9xUTB3?=
 =?utf-8?B?RTFObzE2SUtJSGJkWGFabFZsZHJFVFNWT1kxQWpVbjM5ZWNMMndMS04wNnhC?=
 =?utf-8?B?bmhsRjA5S1J4MjY1aXdPY0NnYmRSR01td09kUFUwczhkdG9hbUFQM0ZQaElF?=
 =?utf-8?B?Q0R6eWdpZDdSeHdPRE5pNDZUY2tNcGdxR0xPOGcwWmx5TTQ5Y25KRTBSS2Fh?=
 =?utf-8?B?RVV6U2duaGowZnBxNGRoUFlRU0QrV01MSmZiZG5YYnNrZS9tRXFGeXFaV1ZT?=
 =?utf-8?B?TEltaHJGN2J2Nk93WmZLY0dLbUpTZGYwZHRuRVZJbE1uWFl2ckpUNEptRlkw?=
 =?utf-8?B?bVBuZmhxZXNIMWV6R2dQT1JNaVpvSVp1eHFxcTRxbi9WUnZ4Y01DTDJQUVd6?=
 =?utf-8?B?SW9BbmE1SGVCVmFINGl1emt4UWVEOWZzRmFwRTNreTFXdXoyM2dlL3Y2eCt1?=
 =?utf-8?B?RWRTSVBPdHNpWjNQTktmeEpPWm9qYmhrL1RKN2VtNHdDTGxhVkRreW00cWRE?=
 =?utf-8?B?MHBMUmFKaWNFeEJYMm9COWxzc3lSSnA4WWl6SUMzMHJoR1Qxa0J6YWpxT202?=
 =?utf-8?B?WmVTUi9xYlY2UklYVFg3aEZLTW1iY3lHMGRSbzlDaUl4b3NJT1hmQVNCZEM2?=
 =?utf-8?B?VGtIbWlMTHEvKzZnSjFURlN3NDg2eFFkdXBTeW9qWlBYeUlFVjFQTjU4SHh5?=
 =?utf-8?B?UENQcVMrSXpMRnRRQlV2QmFVY1hrdWljU3U2L3lLODZYODN3bmUzbWNnaVpW?=
 =?utf-8?B?VUkwWWhkZlhvalA0Sy9ielp5RENJMEg4T0F4Vy80K29CWGNnTlRiaHVGUVdm?=
 =?utf-8?B?QU93ZVU0WWRQYm0zTG1mN25JbHhNYktxWGo2M0d2bXpuL0ozdk10cTg2bDVD?=
 =?utf-8?B?RVhBcXZOam1DSlNhNW1lQVViY1VQMTEyc0NjRWowNG9FaXJhbkphczZDRXNE?=
 =?utf-8?B?TisyQ2hxTS8xV1dydGpaWmxvaHMvaElWdTJ1VkdxWWVGOWdrQ0dTbWpjSWxJ?=
 =?utf-8?B?eEN0dVZKUDdPU1cyN1JGN2ZXUDNIeU1UNmhMb21CNzVWMWNweVdpWGFzeDEv?=
 =?utf-8?B?a2JMN3AvOVlOMkFVQ1k3OGNybUh0RzErQS9wWmM4eHFyMC9HcHp3SDMvT0hi?=
 =?utf-8?B?MkM4bHFUcWJNeW9ITXMrMlNEcWxqWkFTK2JDSTVCcGRiN0dFdXFSd25PRU9t?=
 =?utf-8?B?ZmtGdjI4M3RhNXJMWFdrbDRJWXJkZ0ZWTjBKbkhyTlhhL2VzSDkzcGdkdlI4?=
 =?utf-8?B?d0R3NEtRenZBNVdQMjdHMDNXT2RndWU3NnVpbHh3bWk5K3NtSkpmUUh4M3hV?=
 =?utf-8?B?ejMvUldyZ3VOYUlQWVlwUTZiQVM4ZUJJdGpFZi9ELzFyNDd0Ry9lYnZwVE10?=
 =?utf-8?B?dzhuNk9KcnpyUnRHcU1kaDFxWUt0dVBkaE5RY1BmU05NY1habHJQblBFWVB2?=
 =?utf-8?B?cTlpWnNMODk5clRaZmU4SjhGWFZJVHZxbzVLSk1LUVVDblFEUnpIY21BSTJm?=
 =?utf-8?B?YS9JY2dhSytJMFZDZmJoR3lzc2IxYlJxOWJvSDZWMHVkb29tSEJqcFFKOCtM?=
 =?utf-8?Q?0M4+5rHmaD4zQGpUuLDr8tPW6NMY7W3rR8Z3bBq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8936e9d-46fb-43a9-4a48-08d91fb0b2c0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 19:10:02.3907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DL9Cv6Hj/UW2G9QPFb3iFUtl9+i+8APFGuozCR5FkJ66TcnSFKA2uR58ypCtk+/Dpv8VjiUv0Y3pj/kEVWcYQkj2bakKt8nEGiaLetVqjB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3024
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250117
X-Proofpoint-GUID: hYpaZiZ9CwcjPuJUY5yfKDt28uL8jfIq
X-Proofpoint-ORIG-GUID: hYpaZiZ9CwcjPuJUY5yfKDt28uL8jfIq
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250117
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/24/21 9:25 PM, Damien Le Moal wrote:
> Fix dm_accept_partial_bio() to actually check that zone management
> commands are not passed as explained in the function documentation
> comment. Also, since a zone append operation cannot be split, add
> REQ_OP_ZONE_APPEND as a forbidden command.
> 
> White lines are added around the group of BUG_ON() calls to make the
> code more legible.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/md/dm.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index ca2aedd8ee7d..a9211575bfed 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1237,8 +1237,9 @@ static int dm_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>   
>   /*
>    * A target may call dm_accept_partial_bio only from the map routine.  It is
> - * allowed for all bio types except REQ_PREFLUSH, REQ_OP_ZONE_RESET,
> - * REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH.
> + * allowed for all bio types except REQ_PREFLUSH, zone management operations
> + * (REQ_OP_ZONE_RESET, REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and
> + * REQ_OP_ZONE_FINISH) and zone append writes.
>    *
>    * dm_accept_partial_bio informs the dm that the target only wants to process
>    * additional n_sectors sectors of the bio and the rest of the data should be
> @@ -1268,9 +1269,13 @@ void dm_accept_partial_bio(struct bio *bio, unsigned n_sectors)
>   {
>   	struct dm_target_io *tio = container_of(bio, struct dm_target_io, clone);
>   	unsigned bi_size = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> +
>   	BUG_ON(bio->bi_opf & REQ_PREFLUSH);
> +	BUG_ON(op_is_zone_mgmt(bio_op(bio)));
> +	BUG_ON(bio_op(bio) == REQ_OP_ZONE_APPEND);
>   	BUG_ON(bi_size > *tio->len_ptr);
>   	BUG_ON(n_sectors > bi_size);
> +
>   	*tio->len_ptr -= bi_size - n_sectors;
>   	bio->bi_iter.bi_size = n_sectors << SECTOR_SHIFT;
>   }
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering
