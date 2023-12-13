Return-Path: <linux-block+bounces-972-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9D480DBC1
	for <lists+linux-block@lfdr.de>; Mon, 11 Dec 2023 21:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0A56B20EFF
	for <lists+linux-block@lfdr.de>; Mon, 11 Dec 2023 20:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46235380E;
	Mon, 11 Dec 2023 20:39:32 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
X-Greylist: delayed 417 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 12:39:30 PST
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4E7DC
	for <linux-block@vger.kernel.org>; Mon, 11 Dec 2023 12:39:30 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 0176A84;
	Mon, 11 Dec 2023 12:32:33 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id aau8RBsaKR5o; Mon, 11 Dec 2023 12:32:28 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 85AE345;
	Mon, 11 Dec 2023 12:32:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 85AE345
Date: Mon, 11 Dec 2023 12:32:28 -0800 (PST)
From: Eric Wheeler <dm-devel@lists.ewheeler.net>
To: Hongyu Jin <hongyu.jin.cn@gmail.com>
cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, axboe@kernel.dk, 
    ebiggers@kernel.org, zhiguo.niu@unisoc.com, ke.wang@unisoc.com, 
    yibin.ding@unisoc.com, hongyu.jin@unisoc.com, linux-kernel@vger.kernel.org, 
    dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Subject: Re: [PATCH v3 5/5] dm-crypt: Fix lost ioprio when queuing write
 bios
In-Reply-To: <20231211090000.9578-6-hongyu.jin.cn@gmail.com>
Message-ID: <3ea8a22-47f2-ec2a-36d2-ca656db971@ewheeler.net>
References: <df68c38e-3e38-eaf1-5c32-66e43d68cae3@ewheeler.net> <20231211090000.9578-1-hongyu.jin.cn@gmail.com> <20231211090000.9578-6-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 11 Dec 2023, Hongyu Jin wrote:
> From: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> The original submitting bio->bi_ioprio setting can be retained by
> struct dm_crypt_io::base_bio, we set the original bio's ioprio to
> the cloned bio for write.
> 
> Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>

Thanks, 

Reviewed-by: Eric Wheeler <dm-crypt@linux.ewheeler.net>

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
>  
>  	remaining_size = size;
>  
> -- 
> 2.34.1
> 
> 
> 

