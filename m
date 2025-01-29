Return-Path: <linux-block+bounces-16696-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4EBA225A7
	for <lists+linux-block@lfdr.de>; Wed, 29 Jan 2025 22:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88DA57A1E8A
	for <lists+linux-block@lfdr.de>; Wed, 29 Jan 2025 21:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBED1E25EC;
	Wed, 29 Jan 2025 21:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q1meaguR"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBDA1E3796
	for <linux-block@vger.kernel.org>; Wed, 29 Jan 2025 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738186053; cv=none; b=brcHLUnGpf/wEyKJlf2UBIotcO5D8W4JcFKv0Gl84r+OkvJEzYr9n7QjOMIxd63uMCPaqC7/PgbSa5iWWZaFxjwd5M6pYzVsE2+mnZ2TGyzRbE6O8JkIJ4p33UYSllIani9ZkTmlebxsfo7K1fxavUXugUTJP51jYlBPYC872BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738186053; c=relaxed/simple;
	bh=NOeAsmdu+ehoyUG3XZhaAO1+WsXk2NPyfTIfuDm1vi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuTwTTDwC2xDHp1CCI5igIX50MOZOiawkzJH99YErkISV1q3jDNgrvAxh+ZLpF/kH/62OBby8PezZyQKybNrsEFSJJjs1JDTk8Ku//xQhq4HXaO0T9DFBo4kIhXJlgXIdTNNIlNjHLRw16Z7UDSFL/YuI5VQNuAT8gbzD7+CviY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q1meaguR; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so29891566b.3
        for <linux-block@vger.kernel.org>; Wed, 29 Jan 2025 13:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738186049; x=1738790849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BxlHwbfSGEjrkkVnaAj0TZ6ec/J3+GptfegL4fCvQFY=;
        b=Q1meaguRioGWxkL4YcOsh9U4jNgdPzQkY7543ETWK15oOY5tXo1S59Lu6tSS3YwNg+
         JYa5KqdO/tnVhexLzTrQ6Zxn+dojb9aN2f6pnZ0mPAX/td8OX/VNPzB28SzuYrzogefa
         I1FIFkVEvUQj9jPwkjgm8dCqxzCcanWjg85VICoMjavbh+VkKzv9xmy3IVzDnsDWZnMJ
         vTfsxlgDUu71vYpOcNwjaFHWgGI9OdNPdsXVupEClhPr8wnM8X6+NI1aPKBPHXqu7P/D
         nei6INQvac6y/keN8cSRuknyCSyV/Rbw4RvQBnu71obSGiK7UIIb/dYWoBNMt6KbS5KT
         VHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738186049; x=1738790849;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxlHwbfSGEjrkkVnaAj0TZ6ec/J3+GptfegL4fCvQFY=;
        b=RuksWguTdCCfVFAKBeTuMM7fOk82DKmSk0zc0Id0jQFWPOPmCctcqSp22pX0qz6HGR
         dgzb2bDZSYa7kQC43U3qUj9slYDU38rrsCc+BlEYxEQ6Z2JX3t+9lYcYPFDz1pr6F53s
         5SwrhcusolM3DiJlmo+Vi/ESecylXvFKF0jnnV4nl0wLmmWlCw7rRVODM2uzHLd8O2UK
         +hjGdV0RkF+iByGnLf1qIz2Pr95LleUunaxHErm8MUv8p0k+hD+SQ0gLCWOwd5MwbpQ2
         dYEsIFBcpIqSNvcxE795VOYHCbh3b8sUaQXrSIv7eZnEPKzrDGMnk63q2/0aTv2wYGwM
         JOTg==
X-Forwarded-Encrypted: i=1; AJvYcCU6iPdwjly5ScKDAhXyJDqSH1rpeOjlEq0x6NS5tIMBgQSlBsVsSd9Q+J+Yva/JSH90Z7r1z2/L/zXKGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZVIPLQk3gjBMMAzbEaAgxJ4lgmYiaXk8FTzE0r6IwqoWXp2Hi
	uZKCPGEVg49rvIZHVADHh1NFDE77azhQjD3SR1z0Pi1kKXKbO4ZhlzZrXkHPToQ=
X-Gm-Gg: ASbGncuDVPnawKAQUj1uAm5wue22kFkiLjkalbGnNb1Ua4RrYeGo03Q36mHhygMWJaU
	BI7PBmroG0uvWrbl6ngMvJD6WhWfkIAoBD/f35giXJDH5tLg6mp+xXFLGt00dWzArboximeJrP1
	0WgXyreAEL499pgAMPi/4UsIqQPlAxScBRUL7K26aasLjEtS3x6NVJZ8NUlw7ZzRvYmDkFudd+Y
	cF9Oz+yro5IJz6H108NkIKlqwrKnSViC3dGkMMnEz0ZQuzeO81W/xpULV+bvUx+lBtCE1gHAnhU
	aQQpP1KXPRHEWfU871/50VoQRaZGov/r2GZjrE2v2Yc=
X-Google-Smtp-Source: AGHT+IEpIWE2AAWpA2ZWCGob7gY0bijDoMnVMcEuI+RD3B3UsRx0bqmo4fQhG7Xj0B3HeC2e+ytIQA==
X-Received: by 2002:a17:907:1188:b0:ab6:d452:2315 with SMTP id a640c23a62f3a-ab6d45223e6mr300711766b.14.1738186049172;
        Wed, 29 Jan 2025 13:27:29 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de331efafsm445825ad.217.2025.01.29.13.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 13:27:28 -0800 (PST)
Message-ID: <1660f35a-3cee-4a67-a4fc-c26b7b2dbd24@suse.com>
Date: Thu, 30 Jan 2025 07:57:22 +1030
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/3] btrfs: add checksum offload
To: Kanchan Joshi <joshi.k@samsung.com>, josef@toxicpanda.com,
 dsterba@suse.com, clm@fb.com, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de
Cc: linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com
References: <20250129140207.22718-1-joshi.k@samsung.com>
 <CGME20250129141044epcas5p422461bd3630814884c91fc0f4207edde@epcas5p4.samsung.com>
 <20250129140207.22718-4-joshi.k@samsung.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20250129140207.22718-4-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/30 00:32, Kanchan Joshi 写道:
> Add new mount option 'datsum_offload'.
> 
> When passed
> - Data checksumming at the FS level is disabled.
> - Data checksumming at the device level is enabled. This is done by
> setting REQ_INTEGRITY_OFFLOAD flag for data I/O if the underlying device is
> capable.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>


Just as mentioned by Christoph, the change on csum tree is an on-disk 
format change, which requires extra incompat flags.
I believe that's fine because this is only a prototype.

But my concern is, this lack of csum tree has the following problems:

- Require all devices in the btrfs has the same capacity
   E.g. you can no longer add a devices without REQ_INTEGRITY_OFFLOAD
   capability.
   This can be a very big problem, especially if one just wants to
   migrate the fs to another device.

- Less versatile compared to nodatacsum flags/mount option
   For NODATACSUM flag it can be set on a per-inode basis, but the new
   no-datacsum flag is bound to hardware storage.

And finally my question on why to remove btrfs datacsum.

I understand the device's own checksum is super fast and efficient, but 
that doesn't mean different checksum at different layers are exclusive.

Yes, it cause some extra workload, but since it's handled by hardware 
there is no obvious penalty.

On the other hand, it is adding one extra layer of protection, upon the 
existing btrfs' checksum.

Thus if the end user is fully trusting the hardware's protection, then 
they can just use nodatasum mount option and call it a day.
The benefit you shown is really just the benefit from "nodatasum" 
behavior, and that's more or less expected due to the COW overhead.

So I really prefer to let the end user to choose what they want.

If they want to fully rely on the hardware's internal checksum, then 
configure the block device to do it, and create a btrfs with nodatasum.

If they want both btrfs and the hardware checksum, just do the usual way.

Thanks,
Qu

> ---
>   fs/btrfs/bio.c   | 12 ++++++++++++
>   fs/btrfs/fs.h    |  1 +
>   fs/btrfs/super.c |  9 +++++++++
>   3 files changed, 22 insertions(+)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 7ea6f0b43b95..811d89c64991 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -5,6 +5,7 @@
>    */
>   
>   #include <linux/bio.h>
> +#include <linux/blk-integrity.h>
>   #include "bio.h"
>   #include "ctree.h"
>   #include "volumes.h"
> @@ -424,6 +425,15 @@ static void btrfs_clone_write_end_io(struct bio *bio)
>   	bio_put(bio);
>   }
>   
> +static void btrfs_prep_csum_offload_hw(struct btrfs_device *dev, struct bio *bio)
> +{
> +	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
> +
> +	if (btrfs_test_opt(dev->fs_info, DATASUM_OFFLOAD) &&
> +	    bi && bi->offload_type != BLK_INTEGRITY_OFFLOAD_NONE)
> +		bio->bi_opf |= REQ_INTEGRITY_OFFLOAD;
> +}
> +
>   static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
>   {
>   	if (!dev || !dev->bdev ||
> @@ -435,6 +445,8 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
>   	}
>   
>   	bio_set_dev(bio, dev->bdev);
> +	if (!(bio->bi_opf & REQ_META))
> +		btrfs_prep_csum_offload_hw(dev, bio);
>   
>   	/*
>   	 * For zone append writing, bi_sector must point the beginning of the
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 79a1a3d6f04d..88e493967100 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -228,6 +228,7 @@ enum {
>   	BTRFS_MOUNT_NOSPACECACHE		= (1ULL << 30),
>   	BTRFS_MOUNT_IGNOREMETACSUMS		= (1ULL << 31),
>   	BTRFS_MOUNT_IGNORESUPERFLAGS		= (1ULL << 32),
> +	BTRFS_MOUNT_DATASUM_OFFLOAD		= (1ULL << 33),
>   };
>   
>   /*
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 7dfe5005129a..d0d5b35c2df9 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -121,6 +121,7 @@ enum {
>   	Opt_treelog,
>   	Opt_user_subvol_rm_allowed,
>   	Opt_norecovery,
> +	Opt_datasum_offload,
>   
>   	/* Rescue options */
>   	Opt_rescue,
> @@ -223,6 +224,7 @@ static const struct fs_parameter_spec btrfs_fs_parameters[] = {
>   	fsparam_string("compress-force", Opt_compress_force_type),
>   	fsparam_flag_no("datacow", Opt_datacow),
>   	fsparam_flag_no("datasum", Opt_datasum),
> +	fsparam_flag_no("datasum_offload", Opt_datasum_offload),
>   	fsparam_flag("degraded", Opt_degraded),
>   	fsparam_string("device", Opt_device),
>   	fsparam_flag_no("discard", Opt_discard),
> @@ -323,6 +325,10 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
>   		}
>   		break;
> +	case Opt_datasum_offload:
> +		btrfs_set_opt(ctx->mount_opt, NODATASUM);
> +		btrfs_set_opt(ctx->mount_opt, DATASUM_OFFLOAD);
> +		break;
>   	case Opt_datacow:
>   		if (result.negated) {
>   			btrfs_clear_opt(ctx->mount_opt, COMPRESS);
> @@ -1057,6 +1063,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
>   		seq_puts(seq, ",degraded");
>   	if (btrfs_test_opt(info, NODATASUM))
>   		seq_puts(seq, ",nodatasum");
> +	if (btrfs_test_opt(info, DATASUM_OFFLOAD))
> +		seq_puts(seq, ",datasum_offload");
>   	if (btrfs_test_opt(info, NODATACOW))
>   		seq_puts(seq, ",nodatacow");
>   	if (btrfs_test_opt(info, NOBARRIER))
> @@ -1434,6 +1442,7 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
>   	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
>   	btrfs_info_if_set(info, old, DEGRADED, "allowing degraded mounts");
>   	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
> +	btrfs_info_if_set(info, old, DATASUM_OFFLOAD, "setting datasum offload to the device");
>   	btrfs_info_if_set(info, old, SSD, "enabling ssd optimizations");
>   	btrfs_info_if_set(info, old, SSD_SPREAD, "using spread ssd allocation scheme");
>   	btrfs_info_if_set(info, old, NOBARRIER, "turning off barriers");


