Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8E56F4311
	for <lists+linux-block@lfdr.de>; Tue,  2 May 2023 13:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjEBLvu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 May 2023 07:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjEBLvs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 May 2023 07:51:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A697E11F
        for <linux-block@vger.kernel.org>; Tue,  2 May 2023 04:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683028265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kdZho8b0P96S/DuDI1xyFnU41Cvk0heUauLxuFmvVg0=;
        b=eslnCZOxn9i4zvt8htQONJui7EQDjN3EOBPUH+V1UMpPuxCJ0c8YdF8qSwFm++Qg0aSafh
        Ebz3nJ0eZipBjXI1Ga2hXma7ttUqMcGV+ETxBqjW2ZLiiWVzJOf4KYa5q9N6XQ6fINe5iH
        X26N3cqYwRejGwoE7zjBUuAyUmH90oQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-1eTQTzcXOPqDpEYy_kJThw-1; Tue, 02 May 2023 07:51:04 -0400
X-MC-Unique: 1eTQTzcXOPqDpEYy_kJThw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3ef3ca5b5afso49413401cf.0
        for <linux-block@vger.kernel.org>; Tue, 02 May 2023 04:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683028264; x=1685620264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdZho8b0P96S/DuDI1xyFnU41Cvk0heUauLxuFmvVg0=;
        b=MjBjo+cbFW84lOLjYt0f34H3afdo8LNeR9crU78OcImF+F4hZE+g1/wmQM9kDnq2FI
         1S7JvQeBF4x82suAkE5i2gH0A9CUziOjoO2vt9C35vZvqiVczxR0Kt4TtxjTd5OfyVmS
         mV1S/mH8OaS/tpGYkVWUeQrjMW1agswKF85vJPe6vVVM3cWvVYhefPbJXeFSQMGQL/Ui
         GP74xn3Pqy4qdv56aSZRYZFg1GptfxBVme+DCUV1VEsj7PNt0SxuJ7zSFZ7hg5ntt2nX
         sLDRJIvWyVyXFnx4o5JJQIB0w+e4HcoS1GMLzcj+Uv/zztgUQ2giQZaXnDNOp3tpEaBC
         zRbQ==
X-Gm-Message-State: AC+VfDyslfCz/xMwYjo92YuGwAbZc13PiDtQnN0Phc8B/nsr9uUD+R+X
        jSUJxIY9l2LKaPnvaTr5StNdoB+9R/kpsfD4Opl0Amhuw5iTVoC+1QHbDtjD1yPR9x5A3mgYoE2
        nVsvj+P1YSVS8p0gW7OiZ3co=
X-Received: by 2002:a05:622a:30f:b0:3ef:337b:4fcb with SMTP id q15-20020a05622a030f00b003ef337b4fcbmr28295418qtw.64.1683028264046;
        Tue, 02 May 2023 04:51:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Vrqw+pKj/0O/fsSqYR2NNR+qseAedVJ76NoenSc8LVgBigL4KUU+oPaikQc4zPyJmE8NtjQ==
X-Received: by 2002:a05:622a:30f:b0:3ef:337b:4fcb with SMTP id q15-20020a05622a030f00b003ef337b4fcbmr28295396qtw.64.1683028263837;
        Tue, 02 May 2023 04:51:03 -0700 (PDT)
Received: from ?IPV6:2601:883:c200:210:6ae9:ce2:24c9:b87b? ([2601:883:c200:210:6ae9:ce2:24c9:b87b])
        by smtp.gmail.com with ESMTPSA id fd9-20020a05622a4d0900b003d65e257f10sm6632958qtb.79.2023.05.02.04.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 04:51:02 -0700 (PDT)
Message-ID: <5f3ddda1-2c7d-811c-ffd5-5fc237def2eb@redhat.com>
Date:   Tue, 2 May 2023 07:51:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 09/20] gfs2: use __bio_add_page for adding single page
 to bio
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "axboe @ kernel . dk" <axboe@kernel.dk>
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        damien.lemoal@wdc.com, dm-devel@redhat.com, hare@suse.de,
        hch@lst.de, jfs-discussion@lists.sourceforge.net, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-raid@vger.kernel.org,
        ming.lei@redhat.com, shaggy@kernel.org, snitzer@kernel.org,
        song@kernel.org, willy@infradead.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20230502101934.24901-1-johannes.thumshirn@wdc.com>
 <20230502101934.24901-10-johannes.thumshirn@wdc.com>
Content-Language: en-US
From:   Bob Peterson <rpeterso@redhat.com>
In-Reply-To: <20230502101934.24901-10-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/2/23 6:19 AM, Johannes Thumshirn wrote:
> The GFS2 superblock reading code uses bio_add_page() to add a page to a
> newly created bio. bio_add_page() can fail, but the return value is never
> checked.
> 
> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
> 
> This brings us a step closer to marking bio_add_page() as __must_check.
> 
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/gfs2/ops_fstype.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index 9af9ddb61ca0..cd962985b058 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -254,7 +254,7 @@ static int gfs2_read_super(struct gfs2_sbd *sdp, sector_t sector, int silent)
>   
>   	bio = bio_alloc(sb->s_bdev, 1, REQ_OP_READ | REQ_META, GFP_NOFS);
>   	bio->bi_iter.bi_sector = sector * (sb->s_blocksize >> 9);
> -	bio_add_page(bio, page, PAGE_SIZE, 0);
> +	__bio_add_page(bio, page, PAGE_SIZE, 0);
>   
>   	bio->bi_end_io = end_bio_io_page;
>   	bio->bi_private = page;
Hi Johannes,

So...I see 6 different calls to bio_add_page() in gfs2.
Why change this particular bio_add_page() to __bio_add_page() and not 
the other five?

Regards,

Bob Peterson

