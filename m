Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496AC711147
	for <lists+linux-block@lfdr.de>; Thu, 25 May 2023 18:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238968AbjEYQsu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 25 May 2023 12:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbjEYQsq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 12:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6388189
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685033278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dkhHTV4yWf72EQW+jJcHV7CXxI+jmEVf1Ed42wfSOPk=;
        b=G2RcMxRItEvX+dLZKY//E6c7p+J8Tck5yYyDlNietvP5qZ66WyOfNHbyx8BCcCnkPT5mDt
        ENa8HBvQ9U7WrC8KOZDFNmyLCg7fp5lxHC/tL4J6nPU6rmXpYAHD4CKy5MiEQFsKFatl1m
        L3B974XUKVFKmibX/gBB6tFL4OU8OD8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-_H3aVpDFMxisefMVmKRKjA-1; Thu, 25 May 2023 12:47:56 -0400
X-MC-Unique: _H3aVpDFMxisefMVmKRKjA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f60fb7b31fso3436775e9.2
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 09:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685033275; x=1687625275;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkhHTV4yWf72EQW+jJcHV7CXxI+jmEVf1Ed42wfSOPk=;
        b=WFKwLAO3QRPGwK3LFiNIXtRBNKfGNaZ7txslcN+7T9bRelboKXxY8Qsdz8KmXExPRV
         YHBn1ZM3Q1OVp2CYlfyRRZDxVi4k8SfDTZFVne6+qoNUa0+K3kU68CUZjpzXjUNo66PU
         aqiR8NAnv7E4ZDe3bDIIhrv43xZtjTuE/81ulKEZbcaffHkvwPWaZpflJMAurrNU5pFu
         HOMOcbkAgdtm5P6h+ZGXauWeF/261d3co08XbpSn/QnRypgd3hUdzZ/CmFkxkabIosE4
         TLBXKGUU1DbINpQakTGZIc44A5ADh60CHV8JTi0NYTOocHJIy2E0sMce8ta+INgpwtvX
         wOBw==
X-Gm-Message-State: AC+VfDzI/J0LXcpMB787S67Usg3JWnTyvLhz5AQO9EJFS1TpqZhLPiql
        ZTV9vgo/FPiTFuYGO72k5U9hDcNWLqrQXyWL30thQiNI6wgNJVnyjH24FEcnIxCwugb5GfGFAsh
        QSuqovD3FIykiBSI5nVOVe98=
X-Received: by 2002:a1c:4c0e:0:b0:3f6:d2f:27f7 with SMTP id z14-20020a1c4c0e000000b003f60d2f27f7mr2643839wmf.17.1685033275006;
        Thu, 25 May 2023 09:47:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5x7Zn1U8eTzuREMoFUdD9y0e8K096Z9etxMSRY6PlxSUFaWdbdc1yyGZ28KrofBVrR4sLjBw==
X-Received: by 2002:a1c:4c0e:0:b0:3f6:d2f:27f7 with SMTP id z14-20020a1c4c0e000000b003f60d2f27f7mr2643817wmf.17.1685033274602;
        Thu, 25 May 2023 09:47:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:600:4306:6a2b:57d5:2da1? (p200300cbc709060043066a2b57d52da1.dip0.t-ipconnect.de. [2003:cb:c709:600:4306:6a2b:57d5:2da1])
        by smtp.gmail.com with ESMTPSA id b5-20020a5d45c5000000b002fda1b12a0bsm2397513wrs.2.2023.05.25.09.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 09:47:53 -0700 (PDT)
Message-ID: <97970ae6-e912-912a-1755-8d7bbb1131d0@redhat.com>
Date:   Thu, 25 May 2023 18:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 1/3] mm: Don't pin ZERO_PAGE in pin_user_pages()
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230525155102.87353-1-dhowells@redhat.com>
 <20230525155102.87353-2-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230525155102.87353-2-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25.05.23 17:51, David Howells wrote:
> Make pin_user_pages*() leave the ZERO_PAGE unpinned if it extracts a
> pointer to it from the page tables and make unpin_user_page*()
> correspondingly ignore the ZERO_PAGE when unpinning.  We don't want to risk
> overrunning the zero page's refcount as we're only allowed ~2 million pins
> on it - something that userspace can conceivably trigger.
> 

As Linus raised, the ZERO_PAGE(0) checks should probably be 
is_zero_pfn(page_to_pfn(page)).

> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@infradead.org>
> cc: David Hildenbrand <david@redhat.com>
> cc: Andrew Morton <akpm@linux-foundation.org>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Jan Kara <jack@suse.cz>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Jason Gunthorpe <jgg@nvidia.com>
> cc: Logan Gunthorpe <logang@deltatee.com>
> cc: Hillf Danton <hdanton@sina.com>
> cc: Christian Brauner <brauner@kernel.org>
> cc: Linus Torvalds <torvalds@linux-foundation.org>
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-kernel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>   mm/gup.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index bbe416236593..d2662aa8cf01 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -51,7 +51,8 @@ static inline void sanity_check_pinned_pages(struct page **pages,
>   		struct page *page = *pages;
>   		struct folio *folio = page_folio(page);
>   
> -		if (!folio_test_anon(folio))
> +		if (page == ZERO_PAGE(0) ||
> +		    !folio_test_anon(folio))
>   			continue;
>   		if (!folio_test_large(folio) || folio_test_hugetlb(folio))
>   			VM_BUG_ON_PAGE(!PageAnonExclusive(&folio->page), page);
> @@ -131,6 +132,13 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>   	else if (flags & FOLL_PIN) {
>   		struct folio *folio;
>   
> +		/*
> +		 * Don't take a pin on the zero page - it's not going anywhere
> +		 * and it is used in a *lot* of places.
> +		 */
> +		if (page == ZERO_PAGE(0))
> +			return page_folio(ZERO_PAGE(0));

With the fixed check, this should be
	return page_folio(page);

I guess.

-- 
Thanks,

David / dhildenb

