Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F65266347B
	for <lists+linux-block@lfdr.de>; Mon,  9 Jan 2023 23:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbjAIW5O (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 9 Jan 2023 17:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbjAIW5N (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 17:57:13 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA86E11809
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 14:57:10 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id cp9-20020a17090afb8900b00226a934e0e5so121676pjb.1
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 14:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mdo2/wDqCM6o38jdj1jQCw6QRnTv8QbOLw7MxYlHlrk=;
        b=16g0R6uNNKJzKpGNX1lPaagFx4n+ocJT15a6CdoHNRa3kXLdm6l+X8tfKfzip4O9jL
         Yx+m9c63FhJXRDdVtlpHrKcAbabIPQouM2gr+v0XMy5vTKHj4VsH3CPzwF1bUWbwotNw
         KN5ErzbzOn9FYZdNIAv81d6HVQGw3Eajg7Ab4eJ1Q9kXLwN5JNxyjSeGtLh5npdkpksS
         SwjDmHsj0OK8Rjo+CUmHIxDJKovAiZ66EMy2Bi6LW2PDGeoYVleAk0fUx4zyoA9jkJI6
         WIxcVTURovOsbweHx5PapLCSaZWH9/pzAywtrDuhZle66SzY1c7kNobHrQjZulVuFbQ9
         GeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdo2/wDqCM6o38jdj1jQCw6QRnTv8QbOLw7MxYlHlrk=;
        b=1AM4CjXIIsAIFwSpPyjSQskEGMtCPkGV2p8ZOwkDB3unMLMA01WwPGvV8azGjUxcqg
         /i5NEsZpHvRdx0rAV2rqi6thITurCaawAufj77CHzfF/UVHgIZk4ZBQPJFByZ1gvpj0o
         NjSsmeugSGYwlixzuZyyo/IsWP08ysR5Kx7fWsLFzO7ne0zsXaXIUsPIQFTDGF7aYTDa
         coV35zwfVaLXDfgAkwm1VqX69LqafNWUkwt6ZUtpmUp1lY6i8uJ1w7QLmau+WExhlVZ5
         RmG7I6VUKXwRhdtOkT0bBs8L4foFo6GXou8C4y9zYeq5snmg5A1RcESP738CgK6MgMah
         yaOA==
X-Gm-Message-State: AFqh2kpMcGmTFZtHUFIhke5/LQ5GtPJXTor54tOdOkLz0lmX0c/y2Pzt
        pFPbvdxbWWTTiR+XUePg+zZ0Mw==
X-Google-Smtp-Source: AMrXdXs87F2FmsDn6dLx5iqTdvODtWQXUv1Vh3rhPVK2TwOslYFMDwqA/V5nf4J9/gYFu2qn91zWXA==
X-Received: by 2002:a17:902:b611:b0:189:f277:3834 with SMTP id b17-20020a170902b61100b00189f2773834mr14677883pls.6.1673305030113;
        Mon, 09 Jan 2023 14:57:10 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b00177f4ef7970sm6681389plc.11.2023.01.09.14.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 14:57:09 -0800 (PST)
Message-ID: <bbd9cde3-7cbb-f3e4-a2a4-7b1b5ae392e0@kernel.dk>
Date:   Mon, 9 Jan 2023 15:57:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 7/7] iov_iter, block: Make bio structs pin pages rather
 than ref'ing if appropriate
To:     David Howells <dhowells@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <d0bb04e7-7e58-d494-0e39-6e98f3368a7b@kernel.dk>
 <20230109173513.htfqbkrtqm52pnye@quack3>
 <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk>
 <167305166150.1521586.10220949115402059720.stgit@warthog.procyon.org.uk>
 <2008444.1673300255@warthog.procyon.org.uk>
 <2084839.1673303046@warthog.procyon.org.uk>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2084839.1673303046@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/23 3:24?PM, David Howells wrote:
> Would you be okay with me flipping the logic of BIO_NO_PAGE_REF, so I end up
> with:
> 
> 	static void bio_release_page(struct bio *bio, struct page *page)
> 	{
> 		if (bio_flagged(bio, BIO_PAGE_PINNED))
> 			unpin_user_page(page);
> 		if (bio_flagged(bio, BIO_PAGE_REFFED))
> 			put_page(page);
> 	}
> 
> See attached patch.

I think it makes more sense to have NO_REF check, to be honest, as that
means the general path doesn't have to set that flag. But I don't feel
too strongly about that part.

> diff --git a/block/bio.c b/block/bio.c
> index 5f96fcae3f75..5b9f9fc62345 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -243,6 +243,11 @@ static void bio_free(struct bio *bio)
>   * Users of this function have their own bio allocation. Subsequently,
>   * they must remember to pair any call to bio_init() with bio_uninit()
>   * when IO has completed, or when the bio is released.
> + *
> + * We set the initial assumption that pages attached to the bio will be
> + * released with put_page() by setting BIO_PAGE_REFFED, but this should be set
> + * to BIO_PAGE_PINNED if the page should be unpinned instead; if the pages
> + * should not be put or unpinned, these flags should be cleared.
>   */
>  void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
>  	      unsigned short max_vecs, blk_opf_t opf)
> @@ -274,6 +279,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
>  #ifdef CONFIG_BLK_DEV_INTEGRITY
>  	bio->bi_integrity = NULL;
>  #endif
> +	bio_set_flag(bio, BIO_PAGE_REFFED);

This is first set to zero, then you set the flag. Why not just
initialize it like that to begin with?

> @@ -302,6 +308,8 @@ void bio_reset(struct bio *bio, struct block_device *bdev, blk_opf_t opf)
>  {
>  	bio_uninit(bio);
>  	memset(bio, 0, BIO_RESET_BYTES);
> +	bio_set_flag(bio, BIO_PAGE_REFFED);
> +	bio_clear_flag(bio, BIO_PAGE_PINNED);
>  	atomic_set(&bio->__bi_remaining, 1);
>  	bio->bi_bdev = bdev;
>  	if (bio->bi_bdev)

You just memset bi_flags here, surely we don't need to clear
BIO_PAGE_PINNED after that?

> @@ -814,6 +822,8 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
>  	bio_set_flag(bio, BIO_CLONED);
>  	bio->bi_ioprio = bio_src->bi_ioprio;
>  	bio->bi_iter = bio_src->bi_iter;
> +	bio_clear_flag(bio, BIO_PAGE_REFFED);
> +	bio_clear_flag(bio, BIO_PAGE_PINNED);

Maybe it would make sense to have a set/clear mask operation? Not
strictly required for this patch, but probably worth checking after the
fact.

> @@ -1273,12 +1295,20 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	 * result to ensure the bio's total size is correct. The remainder of
>  	 * the iov data will be picked up in the next bio iteration.
>  	 */
> -	size = iov_iter_get_pages(iter, pages,
> -				  UINT_MAX - bio->bi_iter.bi_size,
> -				  nr_pages, &offset, gup_flags);
> +	size = iov_iter_extract_pages(iter, &pages,
> +				      UINT_MAX - bio->bi_iter.bi_size,
> +				      nr_pages, gup_flags,
> +				      &offset, &cleanup_mode);
>  	if (unlikely(size <= 0))
>  		return size ? size : -EFAULT;
>  
> +	bio_clear_flag(bio, BIO_PAGE_REFFED);
> +	bio_clear_flag(bio, BIO_PAGE_PINNED);
> +	if (cleanup_mode & FOLL_GET)
> +		bio_set_flag(bio, BIO_PAGE_REFFED);
> +	if (cleanup_mode & FOLL_PIN)
> +		bio_set_flag(bio, BIO_PAGE_PINNED);
> +
>  	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);

The cleanup_mode pass-back isn't the prettiest thing in the world, and
that's a lot of arguments. Maybe it'd be slightly better if we just have
gup_flags be an output parameter too?

Also not great to first clear both flags, then set them with the two
added branches...

> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 22078a28d7cb..1c6f051f6ff2 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -482,7 +482,8 @@ void zero_fill_bio(struct bio *bio);
>  
>  static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
>  {
> -	if (!bio_flagged(bio, BIO_NO_PAGE_REF))
> +	if (bio_flagged(bio, BIO_PAGE_REFFED) ||
> +	    bio_flagged(bio, BIO_PAGE_PINNED))
>  		__bio_release_pages(bio, mark_dirty);
>  }

Same here on a mask check, but perhaps it ends up generating the same
code?

-- 
Jens Axboe

