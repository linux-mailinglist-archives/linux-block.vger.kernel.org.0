Return-Path: <linux-block+bounces-975-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1F480DE0D
	for <lists+linux-block@lfdr.de>; Mon, 11 Dec 2023 23:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F8A1C214C2
	for <lists+linux-block@lfdr.de>; Mon, 11 Dec 2023 22:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC8E5578F;
	Mon, 11 Dec 2023 22:15:24 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D619F
	for <linux-block@vger.kernel.org>; Mon, 11 Dec 2023 14:15:20 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-35d72b72ff7so20063165ab.0
        for <linux-block@vger.kernel.org>; Mon, 11 Dec 2023 14:15:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702332919; x=1702937719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+NbavSPkNYuuLKazhVu/hAbx07laMBmOoTQUM0p47w=;
        b=mgXJKiSmKJ1MJ8mUnuy5dg1uq58qUKlU0eVfFSiN379R0hSB3E9ArMQoPgG3uKTPPq
         VodfPMiCnAKLlRdbxWNFZXPhl7caQNRFlkeK2MsnFL1uiZRYfmEgTr+0jZkglkvWxK2c
         pEugUv3q8lyqwQb+iq7UlMyFwSp8u2UTWtyDWtQmpavsz3hWDOvAgcwVlAIzqjEXXbVg
         F9ZDzVjc+3/uRzUQzabJOraFdmn3NDj+jDHxEiCIBuOr12toMQHV1/Uiy63XpK4mHb3p
         UDkXR6mU3XSXb5kI9OLvRWBi81bWr70/0jQVzgP8ThqlPV+KNIKK1RXsoaRH+Vfzvdul
         sZ0Q==
X-Gm-Message-State: AOJu0Yz7UIkF8auPcCsPdKb8H7h6e4QtnywNXxhs/6Drz2qPhat1hGHp
	9DuVHy3+igw2A53qFgFaat5R
X-Google-Smtp-Source: AGHT+IHNeSpFqavSvNI7EouqNAWIqxS4EtGj5taHoZVkMX4FUv92lNAhynaV9F2HmvIyMA8Vl+7bmw==
X-Received: by 2002:a05:6e02:148c:b0:35c:9b2c:b9d1 with SMTP id n12-20020a056e02148c00b0035c9b2cb9d1mr5497877ilk.32.1702332919461;
        Mon, 11 Dec 2023 14:15:19 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id z10-20020a0cfeca000000b0067a788e258bsm3671868qvs.133.2023.12.11.14.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:15:19 -0800 (PST)
Date: Mon, 11 Dec 2023 17:15:18 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Hongyu Jin <hongyu.jin.cn@gmail.com>
Cc: agk@redhat.com, mpatocka@redhat.com, axboe@kernel.dk,
	ebiggers@kernel.org, zhiguo.niu@unisoc.com, ke.wang@unisoc.com,
	yibin.ding@unisoc.com, hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v3 5/5] dm-crypt: Fix lost ioprio when queuing write bios
Message-ID: <ZXeJ9jAKEQ31OXLP@redhat.com>
References: <df68c38e-3e38-eaf1-5c32-66e43d68cae3@ewheeler.net>
 <20231211090000.9578-1-hongyu.jin.cn@gmail.com>
 <20231211090000.9578-6-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211090000.9578-6-hongyu.jin.cn@gmail.com>

On Mon, Dec 11 2023 at  4:00P -0500,
Hongyu Jin <hongyu.jin.cn@gmail.com> wrote:

> From: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> The original submitting bio->bi_ioprio setting can be retained by
> struct dm_crypt_io::base_bio, we set the original bio's ioprio to
> the cloned bio for write.
> 
> Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
> ---
>  drivers/md/dm-crypt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 6de107aff331..b67fec865f00 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -1683,6 +1683,7 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
>  				 GFP_NOIO, &cc->bs);
>  	clone->bi_private = io;
>  	clone->bi_end_io = crypt_endio;
> +	clone->bi_ioprio = bio_prio(io->base_bio);

Weird use of bio_prio() wrapper given the assignment to
clone->bi_ioprio.  I'd prefer:
        clone->bi_ioprio = io->base_bio->bi_ioprio;

Some additional info to be mindful of:

This encryption bio has always been unique (ever since dm-crypt
stopped using the block layer's methods for cloning with 2007's commit
2f9941b6c55d7).

Prior to commit 2f9941b6c55d7, dm-crypt used to call __bio_clone() to
make sure not to miss cloning other capabilities -- and __bio_clone()
does exist again as of commit a0e8de798dd67 but it is private to bio.c
(in service to bio_alloc_clone, etc).

My point: because we aren't using traditional bio cloning (due to not
wanting to share the bio_vec) we also aren't transferring over the
cgroup (via bio_clone_blkg_association), etc.

That can be a secondary concern that you don't need to worry about
(but it is something Mikulas and I need to look at closer).

Mike

