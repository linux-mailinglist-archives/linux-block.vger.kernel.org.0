Return-Path: <linux-block+bounces-1760-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB6782B816
	for <lists+linux-block@lfdr.de>; Fri, 12 Jan 2024 00:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6153828B3D4
	for <lists+linux-block@lfdr.de>; Thu, 11 Jan 2024 23:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94CD59B6A;
	Thu, 11 Jan 2024 23:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0CI/qll"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31A8537FC;
	Thu, 11 Jan 2024 23:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B63C433F1;
	Thu, 11 Jan 2024 23:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705016246;
	bh=4bSQrMnZYifA1saWZcTH1YMYj7OMXSJTX6H9lMKiWn4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H0CI/qllVkBSSzyvoPhaFzIc62SuHe+lNZ8s5H82zd3u4vSlwkHoKPmm1x+AHH5Rr
	 215lPHx75hz1RSVQ/O3edaPH5C2oqTbMX8jelljJUtPuOyhjk6/6uO1K176zzO1kYJ
	 pSBLpvRS+DmGYJuk1v/0ligPKLUHnN3vN47bINxTJygajvGZ6+xcHj0h1lSlpfQS59
	 0bD/W85q0mhhR4Di+aa/NXuytWqfNK6y7FS+quWtVjtVqmLR4tyX/WOKsUd78zV9T9
	 7yudIT6kbUHXabDdNF1jbb2TJ68qpJZoffTSlmX78WIcqTLfwfD/R2uuyTojHQC568
	 vC/QVwXTHlZbg==
Message-ID: <ecf3adb2-596b-471b-8e35-b8f8124167f2@kernel.org>
Date: Fri, 12 Jan 2024 08:37:23 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: print symbolic error name instead of error code
Content-Language: en-US
To: Christian Heusel <christian@heusel.eu>, Jens Axboe <axboe@kernel.dk>,
 Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Christian Brauner <brauner@kernel.org>, Min Li <min15.li@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org
References: <20240111231521.1596838-1-christian@heusel.eu>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240111231521.1596838-1-christian@heusel.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/24 08:15, Christian Heusel wrote:
> Utilize the %pe print specifier to get the symbolic error name as a
> string (i.e "-ENOMEM") in the log message instead of the error code to
> increase its readablility.
> 
> This change was suggested in
> https://lore.kernel.org/all/92972476-0b1f-4d0a-9951-af3fc8bc6e65@suswa.mountain/
> 
> Signed-off-by: Christian Heusel <christian@heusel.eu>
> ---
>  block/partitions/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index f47ffcfdfcec..932df4db76f1 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -570,8 +570,8 @@ static bool blk_add_partition(struct gendisk *disk,
>  	part = add_partition(disk, p, from, size, state->parts[p].flags,
>  			     &state->parts[p].info);
>  	if (IS_ERR(part) && PTR_ERR(part) != -ENXIO) {
> -		printk(KERN_ERR " %s: p%d could not be added: %ld\n",
> -		       disk->disk_name, p, -PTR_ERR(part));
> +		printk(KERN_ERR " %s: p%d could not be added: %pe\n",
> +		       disk->disk_name, p, part);

pr_err() ?

>  		return true;
>  	}
>  

-- 
Damien Le Moal
Western Digital Research


