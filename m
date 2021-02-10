Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6063169CA
	for <lists+linux-block@lfdr.de>; Wed, 10 Feb 2021 16:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhBJPKW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 10 Feb 2021 10:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhBJPKT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 10:10:19 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09CFC06174A
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 07:09:38 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id n201so2175207iod.12
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 07:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L6P2NX/DTL8ff0P2HA6ZaoSj2C/OuBgNDFZ8rYrxH6A=;
        b=QWG5ruo31OnLIDF+acawcGjChk0qRnDtYH2wqsFwDv12NumjnqTJumluVd/cYLbgSe
         NRu1OopFvD2boZLmc5NZJEavgvNU7AuUl3cKYvkCzsqZ9Qr5tlnHWXtB/Dp72a7hQ4tk
         m7TlZuGNx5k/feyE1/DUcmBfAvS3oRPhCBSTQFTAGUrgXGt9EAtZvTFbdajm4jpceyu+
         QkPz+BVGRyprjwdrFoIcPNrKXXUttShZw8tmAtWml2qscrOI7lnCIM5CVf4dsiA1Qa7N
         vgLx/DwSrBibS7jzo5C+XlRdsZZsSSTm2g/0YZ1rvtRG5paYA++aBaj9zYvU5NQw+B+g
         iF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L6P2NX/DTL8ff0P2HA6ZaoSj2C/OuBgNDFZ8rYrxH6A=;
        b=NwhYi5VliEXtcS7ZJizsm8Y3+Gj+ZdJFBunZNJYQYA3B4pR6gI8cpr7mWRnVfUUz5F
         w+Ct5LLOq23EPtne8YSXw2g66uihd1T3QLn6uFbcpjNQxq/Tu3aUHnLCdDavg8Wkf/Xe
         Z52M7t2HiGJMQRvmG5x9XBKx24ahMjo6ykPRmU4W0OFXf5uFgNBpKzRdAQdgTUfjD0sM
         2Li3Db6hcnQi66VwipAUcGyAgP/cFGTDJQ2UYN/1L4RFcrxyr7xIfvq6atntevkZF8rq
         mpniO64CkU5aHawL68b0vXnoyXoXJQ5m4ggECwtZky28+/iGkotrSbkA+1bNCzh0S1oA
         OdTQ==
X-Gm-Message-State: AOAM530l73RXj1RGpyv+Ak/UzzFphRPiRwoaEN2pNFdZ98GR0UMHaTji
        homJoFN1usRZw9y6lT9kYZUrSA==
X-Google-Smtp-Source: ABdhPJxhrCo4d2ZxcT3su2gTAbH1vNyVsJVKZIANtOV0wGf+UDw1dFcCmwt5oapjDLUo0m65yk2c+g==
X-Received: by 2002:a05:6638:235:: with SMTP id f21mr3907067jaq.32.1612969778216;
        Wed, 10 Feb 2021 07:09:38 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d2sm1136062ilr.66.2021.02.10.07.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 07:09:37 -0800 (PST)
Subject: Re: [PATCH 07/20] bcache: add initial data structures for nvm pages
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Qiaowei Ren <qiaowei.ren@intel.com>
References: <20210210050742.31237-1-colyli@suse.de>
 <20210210050742.31237-8-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <76adf7d2-821b-c7a5-426e-4d3963d36455@kernel.dk>
Date:   Wed, 10 Feb 2021 08:09:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210050742.31237-8-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/9/21 10:07 PM, Coly Li wrote:
> +struct bch_nvm_pgalloc_recs {
> +union {
> +	struct {
> +		struct bch_nvm_pages_owner_head	*owner;
> +		struct bch_nvm_pgalloc_recs	*next;
> +		__u8				magic[16];
> +		__u8				owner_uuid[16];
> +		__u32				size;
> +		__u32				used;
> +		__u64				_pad[4];
> +		struct bch_pgalloc_rec		recs[];
> +	};
> +	__u8	pad[8192];
> +};
> +};

This doesn't look right in a user header, any user API should be 32-bit
and 64-bit agnostic.

> +struct bch_nvm_pages_owner_head {
> +	__u8			uuid[16];
> +	char			label[BCH_NVM_PAGES_LABEL_SIZE];
> +	/* Per-namespace own lists */
> +	struct bch_nvm_pgalloc_recs	*recs[BCH_NVM_PAGES_NAMESPACES_MAX];
> +};

Same here.

> +/* heads[0] is always for nvm_pages internal usage */
> +struct bch_owner_list_head {
> +union {
> +	struct {
> +		__u32				size;
> +		__u32				used;
> +		__u64				_pad[4];
> +		struct bch_nvm_pages_owner_head	heads[];
> +	};
> +	__u8	pad[8192];
> +};
> +};

And here.

> +#define BCH_MAX_OWNER_LIST				\
> +	((sizeof(struct bch_owner_list_head) -		\
> +	 offsetof(struct bch_owner_list_head, heads)) /	\
> +	 sizeof(struct bch_nvm_pages_owner_head))
> +
> +/* The on-media bit order is local CPU order */
> +struct bch_nvm_pages_sb {
> +	__u64			csum;
> +	__u64			ns_start;
> +	__u64			sb_offset;
> +	__u64			version;
> +	__u8			magic[16];
> +	__u8			uuid[16];
> +	__u32			page_size;
> +	__u32			total_namespaces_nr;
> +	__u32			this_namespace_nr;
> +	union {
> +		__u8		set_uuid[16];
> +		__u64		set_magic;
> +	};

This doesn't look like it packs right either.

> +
> +	__u64			flags;
> +	__u64			seq;
> +
> +	__u64			feature_compat;
> +	__u64			feature_incompat;
> +	__u64			feature_ro_compat;
> +
> +	/* For allocable nvm pages from buddy systems */
> +	__u64			pages_offset;
> +	__u64			pages_total;
> +
> +	__u64			pad[8];
> +
> +	/* Only on the first name space */
> +	struct bch_owner_list_head	*owner_list_head;

And here's another pointer...

-- 
Jens Axboe

