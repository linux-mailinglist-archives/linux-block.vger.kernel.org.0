Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0ACC67A3EB
	for <lists+linux-block@lfdr.de>; Tue, 24 Jan 2023 21:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjAXUbN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Jan 2023 15:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjAXUbN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 15:31:13 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C025E618E;
        Tue, 24 Jan 2023 12:31:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8qvFo2VO7a5uP7WNJ8t/nnvvTYE3PusYjM40oWhCl5I9AvnqOZk6id6Z154hYKeGWb48sy7hcQWjtOPrrmOJExbmXgCn8BDbYb8tiNEFjNEd6Dt8JLBNSRjEcghyvI6OxywzL/xmJSe/sRfOI45ohVpHmW142YA05MQnUqS+9ewR6YcUbBO2gsw1ZFEDDccQ+6wdekd0tZXFRFKO0ExTV/npVoCrbDbY0vdO1rIWe5t1lWWvRAeoomkbriuRxvFhkaI3D8kG4bW9qGW1XNhuCtDdMjhkg/8/MUxXt4gUD+cHdMb0eKQZHKLyfFtboJGlwKknf91luiy1ezWYYMLpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEsO9jWKQ/Xx2n3ylmJJMK9le/H9/ZmRWJo08T6VYn0=;
 b=D+uB+SqodJbMfov6BKoEJchjOpdbD9B2bBW05L7r57khUZoJyhhylxFw+VvJxvZ/dTP8tAJkdVu4kyCjagU0jXR/aDjqNJMf3tATBoGydk2rm8+hWpIpbn1gj//8BjHmixp7XGfPXkLzHR/FTo1AdBqm3o2xlsbytZTx7sk5KrRwAhJpumnQRE6SS/oRabnJjYXCxxIGUldKhMGN+jp00WmTOyJQ/6Cs7s7QQDW7Ujbl3qfa2OYRfXZctVrUzjv8Ge5HsPyHz/lQSb8wyiqb0/i9/t1XiJ8BF2fUBbh5j7pGaU3u6yFJZns2Zaw5KgBj0bZu9d9AtviJ24gj2Ds+WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEsO9jWKQ/Xx2n3ylmJJMK9le/H9/ZmRWJo08T6VYn0=;
 b=FUaoYOZy/nVn81I2XN8M8j3PB6775QknY2zPABDlOM9KnnM7462gPXFSzhOtMiQdbbcKEWhBF3sNogtJmDKX3w/AnjpVH7JdtRmGL8I/pty4AmhlzL/hIVFSW8qBYL7XaMoEx7tUDHytQ2iFadLQwirbwtKX2GX3P0FrA8pnS7GzJkFkjx7LoXZ5TWaiX0UJRiQBa7P42OMJtAy3RuQzgqGocvZqdgfHAU9Q+GYgY4R6/TS/E14lDl4yRD8PY0qlRGLlJ84IKnAxWjqYFLbMCfywZkexavVKpNi6iLfKkqw2HtAWnaSkOp40lPWDcaZBKby8mOsiq9M8z825PN/+5A==
Received: from DM6PR08CA0028.namprd08.prod.outlook.com (2603:10b6:5:80::41) by
 CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Tue, 24 Jan 2023 20:31:09 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::9c) by DM6PR08CA0028.outlook.office365.com
 (2603:10b6:5:80::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 20:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.10 via Frontend Transport; Tue, 24 Jan 2023 20:31:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 11:50:17 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 24 Jan
 2023 11:50:17 -0800
Message-ID: <7390d21a-c5f5-8f21-9f3e-524252e73b46@nvidia.com>
Date:   Tue, 24 Jan 2023 11:50:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 6/8] block: Switch to pinning pages.
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
CC:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        "Jan Kara" <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Christoph Hellwig" <hch@lst.de>
References: <20230124170108.1070389-1-dhowells@redhat.com>
 <20230124170108.1070389-7-dhowells@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230124170108.1070389-7-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|CY5PR12MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: e1868385-6799-4026-d9bd-08dafe49ed76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1potaqWGwwIo0/juUumNqjiefgl2uA94JT6FIrlNBAHeUwbkjAGS5B1gpQ/o/8XGHuZmb/3/PN+0bwbuEIlQgqkK+Ckf717jn79CwCyswZ+OQL69LyoEg7+qdJuOB+dIMgwGQn7gsf/O+lDTqPkkV7Ny41sXMrrNrGWSv0ShwJtkO8TGq+R7ZP+o+eF8/e4zBrxnpFovZvZedtwf41P2Dkmnik/XGaK/ho/qv/S1AodM8GxOwIpevMqwqJpNxH5Ygp6rRzoKG365A9SJqrHD6jMbXCiFnXoXjZRXLxdwDArcA+LkMQJi4PxRf5wDodwkP9tPKroysutOT3lx6lgVKFJVLRK9iPKtlh4sd5KAomdO4kH1R09lx6zhOCWs1/A+Qjq/fnRn3c5LqePmWdY66qXf/WPj7CzN89+QjRnQZa1PuZcAX8x3a3txDpGwOgVdwExHNgdLk4h5LHWmtDS9u3HCthh5npc7EPBTSyAGlXkubIeNqZHyRKSmuOZAIQukRU90yWPIzmhhKJkMXK1GEg5tUaelFAV/+k237MIkLOZ0A0xlbK/plEPjZNsw7b9UlzLCH3Mb2e2vBvfRlgm/YdKXiYH9q4Zj7m0vC6x0WK+NjwEtEYbjHrrLiRHo2qYV+Ywk3sImgsiwpUFJjoMDXon7U3vf3t4McI8OCa6/8q+gDBNcF+WDGB0JmvWuMjPfdZAstY7oztFetwzfY0rSoRfh49CusByVumAJdGHxro=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199018)(40470700004)(36840700001)(46966006)(36756003)(5660300002)(7636003)(82740400003)(2906002)(7416002)(356005)(2616005)(8936002)(41300700001)(83380400001)(82310400005)(36860700001)(31696002)(4326008)(8676002)(110136005)(31686004)(86362001)(478600001)(40460700003)(16526019)(70206006)(40480700001)(316002)(70586007)(186003)(53546011)(16576012)(26005)(54906003)(336012)(426003)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 20:31:09.4840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1868385-6799-4026-d9bd-08dafe49ed76
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6549
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/24/23 09:01, David Howells wrote:
> Add BIO_PAGE_PINNED to indicate that the pages in a bio are pinned
> (FOLL_PIN) and that the pin will need removing.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Jan Kara <jack@suse.cz>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Logan Gunthorpe <logang@deltatee.com>
> cc: linux-block@vger.kernel.org
> ---
> 
> Notes:
>      ver #9)
>       - Only consider pinning in bio_set_cleanup_mode().  Ref'ing pages in
>         struct bio is going away.
>       - page_put_unpin() is removed; call unpin_user_page() and put_page()
>         directly.
>       - Use bio_release_page() in __bio_release_pages().
>       - BIO_PAGE_PINNED and BIO_PAGE_REFFED can't both be set, so use if-else
>         when testing both of them.
>      
>      ver #8)
>       - Move the infrastructure to clean up pinned pages to this patch [hch].
>       - Put BIO_PAGE_PINNED before BIO_PAGE_REFFED as the latter should
>         probably be removed at some point.  FOLL_PIN can then be renumbered
>         first.
> 
>   block/bio.c               |  6 +++---
>   block/blk.h               | 21 +++++++++++++++++++++
>   include/linux/bio.h       |  3 ++-
>   include/linux/blk_types.h |  1 +
>   4 files changed, 27 insertions(+), 4 deletions(-)

Neatly avoiding any use of FOLL_PIN or FOLL_GET, good. :)

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/block/bio.c b/block/bio.c
> index 851c23641a0d..fc45aaa97696 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1176,7 +1176,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
>   	bio_for_each_segment_all(bvec, bio, iter_all) {
>   		if (mark_dirty && !PageCompound(bvec->bv_page))
>   			set_page_dirty_lock(bvec->bv_page);
> -		put_page(bvec->bv_page);
> +		bio_release_page(bio, bvec->bv_page);
>   	}
>   }
>   EXPORT_SYMBOL_GPL(__bio_release_pages);
> @@ -1496,8 +1496,8 @@ void bio_set_pages_dirty(struct bio *bio)
>    * the BIO and re-dirty the pages in process context.
>    *
>    * It is expected that bio_check_pages_dirty() will wholly own the BIO from
> - * here on.  It will run one put_page() against each page and will run one
> - * bio_put() against the BIO.
> + * here on.  It will unpin each page and will run one bio_put() against the
> + * BIO.
>    */
>   
>   static void bio_dirty_fn(struct work_struct *work);
> diff --git a/block/blk.h b/block/blk.h
> index 4c3b3325219a..32b252903f9a 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -425,6 +425,27 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
>   		struct page *page, unsigned int len, unsigned int offset,
>   		unsigned int max_sectors, bool *same_page);
>   
> +/*
> + * Set the cleanup mode for a bio from an iterator and the extraction flags.
> + */
> +static inline void bio_set_cleanup_mode(struct bio *bio, struct iov_iter *iter)
> +{
> +	if (iov_iter_extract_will_pin(iter))
> +		bio_set_flag(bio, BIO_PAGE_PINNED);
> +}
> +
> +/*
> + * Clean up a page appropriately, where the page may be pinned, may have a
> + * ref taken on it or neither.
> + */
> +static inline void bio_release_page(struct bio *bio, struct page *page)
> +{
> +	if (bio_flagged(bio, BIO_PAGE_PINNED))
> +		unpin_user_page(page);
> +	else if (bio_flagged(bio, BIO_PAGE_REFFED))
> +		put_page(page);
> +}
> +
>   struct request_queue *blk_alloc_queue(int node_id);
>   
>   int disk_scan_partitions(struct gendisk *disk, fmode_t mode, void *owner);
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 805957c99147..b2c09997d79c 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -484,7 +484,8 @@ void zero_fill_bio(struct bio *bio);
>   
>   static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
>   {
> -	if (bio_flagged(bio, BIO_PAGE_REFFED))
> +	if (bio_flagged(bio, BIO_PAGE_REFFED) ||
> +	    bio_flagged(bio, BIO_PAGE_PINNED))
>   		__bio_release_pages(bio, mark_dirty);
>   }
>   
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 7daa261f4f98..a0e339ff3d09 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -318,6 +318,7 @@ struct bio {
>    * bio flags
>    */
>   enum {
> +	BIO_PAGE_PINNED,	/* Unpin pages in bio_release_pages() */
>   	BIO_PAGE_REFFED,	/* put pages in bio_release_pages() */
>   	BIO_CLONED,		/* doesn't own data */
>   	BIO_BOUNCED,		/* bio is a bounce bio */
> 

