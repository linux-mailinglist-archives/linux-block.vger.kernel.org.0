Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFD12AEE14
	for <lists+linux-block@lfdr.de>; Wed, 11 Nov 2020 10:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgKKJt5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Nov 2020 04:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgKKJt4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 04:49:56 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F514C0613D1
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 01:49:56 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id b3so690110pls.11
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 01:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wy9KYNhp3gLXHxDS3wldI7ei9OvcjTNMDjVAtG+sk3I=;
        b=D40IYtVzVbalXaF6OaIasJDGe+NoAenJ4j1BxKnohUR/K3/6xIvRpl6RAq8xrrlZMN
         2mSJRl+OMm8AkbifuVOFugVGFxd9UQ1ONpFI/PauYwQ6xiWTPnuVYrQFP1FQCcZ6ZB3G
         V1KAoOU3OwU2eYMECd6mOD8bio1Nh0kZ/nn18MB6u08eJyuzTTmiSs4I1FMAVCfUxECz
         nmkXRQuU/5psF+coA45QnX8O+NF2sfjGPVIaN1/2NiqRd7xzeePgFwaaYYnnEF05VcAA
         6ZnbvRb+QCisguIaHTuV/8MDUtzgBVxN520Qlv8Z45o9dBy1YPkYx6LPIrb/3+bD+g9x
         p8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wy9KYNhp3gLXHxDS3wldI7ei9OvcjTNMDjVAtG+sk3I=;
        b=kMopU3aUiNwm1LGA21ik4jT0IlfCFqzXWk0QWVHrZlqcokbIw23e/0lIrZWpNgZyNB
         o3gRJp6H7SeotAOj+wch4DsNThjJyeHs6j3xNiPZwjRV1aAZL2Wb5K49wn/QPchLyMP1
         nWV8e9o6lWnhTGMGhtOjLCDZx/oE7qOxnLDnRXBhhpm5G4gjzPeVBbd8kO5HAh02UdBp
         350t4HfarAwclwNRmAfPnbdrpjaONpXoui2oKGp+v55U/GL+0H1xcJyIhRPx0I9upuaJ
         7zSnYsDrrVjdIz91w9l0UDzpW2/b0l2Efc/jFOSXn1tswFP0VBC812Cj+xM19S7jaZMt
         2qAA==
X-Gm-Message-State: AOAM532nUPYDQpniPc9vRnwjIZp2wbM4rWqnMhNHbkbBEkqQ/iodVkSs
        b4mPnMBMGKNEMJ2zV815vlX6BJamkWs8Mg==
X-Google-Smtp-Source: ABdhPJyqViOoiWT7aV5JXBTlH1xIMTKFRSp/aJCTu7kGf747y/N23xV9AXPxu8S7IXnFGVu8j9/xSQ==
X-Received: by 2002:a17:902:244:b029:d6:c451:8566 with SMTP id 62-20020a1709020244b02900d6c4518566mr20626958plc.46.1605088195763;
        Wed, 11 Nov 2020 01:49:55 -0800 (PST)
Received: from google.com (154.137.233.35.bc.googleusercontent.com. [35.233.137.154])
        by smtp.gmail.com with ESMTPSA id e17sm1972385pfl.216.2020.11.11.01.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 01:49:55 -0800 (PST)
Date:   Wed, 11 Nov 2020 09:49:51 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH] block/keyslot-manager: prevent crash when num_slots=1
Message-ID: <20201111094951.GB3907007@google.com>
References: <20201111021427.466349-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111021427.466349-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 10, 2020 at 06:14:27PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> If there is only one keyslot, then blk_ksm_init() computes
> slot_hashtable_size=1 and log_slot_ht_size=0.  This causes
> blk_ksm_find_keyslot() to crash later because it uses
> hash_ptr(key, log_slot_ht_size) to find the hash bucket containing the
> key, and hash_ptr() doesn't support the bits == 0 case.
> 
> Fix this by making the hash table always have at least 2 buckets.
> 
> Tested by running:
> 
>     kvm-xfstests -c ext4 -g encrypt -m inlinecrypt \
>                  -o blk-crypto-fallback.num_keyslots=1
> 
> Fixes: 1b2628397058 ("block: Keyslot Manager for Inline Encryption")
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  block/keyslot-manager.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
> index 35abcb1ec051d..0a5b2772324ad 100644
> --- a/block/keyslot-manager.c
> +++ b/block/keyslot-manager.c
> @@ -103,6 +103,13 @@ int blk_ksm_init(struct blk_keyslot_manager *ksm, unsigned int num_slots)
>  	spin_lock_init(&ksm->idle_slots_lock);
>  
>  	slot_hashtable_size = roundup_pow_of_two(num_slots);
> +
> +	/*
> +	 * hash_ptr() assumes bits != 0, so ensure the hash table has at least 2
> +	 * buckets.  This only makes a difference when there is only 1 keyslot.
> +	 */
> +	slot_hashtable_size = max(slot_hashtable_size, 2U);
> +
>  	ksm->log_slot_ht_size = ilog2(slot_hashtable_size);
>  	ksm->slot_hashtable = kvmalloc_array(slot_hashtable_size,
>  					     sizeof(ksm->slot_hashtable[0]),
> 
> base-commit: f8394f232b1eab649ce2df5c5f15b0e528c92091
> -- 
> 2.29.2
> 
Looks good to me. Please feel free to add
Reviewed-by: Satya Tangirala <satyat@google.com>
