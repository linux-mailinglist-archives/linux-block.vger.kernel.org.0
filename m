Return-Path: <linux-block+bounces-20727-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA4FA9EBE2
	for <lists+linux-block@lfdr.de>; Mon, 28 Apr 2025 11:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E633BF273
	for <lists+linux-block@lfdr.de>; Mon, 28 Apr 2025 09:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6D32676D9;
	Mon, 28 Apr 2025 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hENInmxf"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA926739A
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745832191; cv=none; b=pddVC+Ge2DNMnmEiApXF5WoN7P8Q+litssuihGBy0KczvRSu2qf4F+LEr2Q5kPGnF2KI+ji28kbjWOes1xT639uXE7usapODTC51DtRRV75VJ8HxgmGXql+09rgFeNbAN8DY5z4mnY3tsdovWb12Rz1PpVmj1SNKWcvT6cbFjvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745832191; c=relaxed/simple;
	bh=ni7iG0pcXMyEswEF3ky/1g9WXEzkF5I/Qctnd5w9rjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLcsoxdoMDOyMeoJ5kJCdbwRu0a7QR6VKZ7EGUGQU70xzQBYqZYFsrKKFSTDQRj8hJzhkGUd67fzKGjp4fgXGuWeHFIAvFlPTkLfRmi0gPDCCj5DMZI3q4VoVnRZyQJgQQjBfdQ8KX3YTXaI7oqg8tK7EEr5zuL77N2+9O4MOPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hENInmxf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so39798585e9.3
        for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 02:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745832187; x=1746436987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VTBfMMopJTyWHQSabpmNdAk0IJVlLoaLPW901ABYfPA=;
        b=hENInmxfQ/8tCSI1OqLEGpiU9CREcJ1f47nRfuFHqJJNZpqk8vjF2dGSHvHPaWVZMW
         Ikd7bMVBJdfZLAyp9BjTiRkcx4/w12WPZmhfFABfPD+3ztJeSoqdiPnAkf6QFUcNWd+O
         VrvF21j7vughljylJbAdH3XBhNZYp8RZYBJu4jt+jqiKiQdiEgjpPKHwy6HWch9Mez9F
         n5R3NColYIASKVs4wfCL36ExoSvSlN8kmnqN5L4vHaKN/u2fOEFWzes45+GXG9FQPO65
         EUiUGeRk/cmxIC6wRt/dr3T8ZMq4FG7WIT1E8wg8rcfkbbNAXVgCM9u5PAaBlNaCrvf4
         x3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745832187; x=1746436987;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTBfMMopJTyWHQSabpmNdAk0IJVlLoaLPW901ABYfPA=;
        b=uSgeX/E5jN+Pfxg775B2t1u1rEDiFF13EP+oXd6awZd8uQshFjJ+pawvs3p16hRI2X
         ecjzvnbK8a4Sjn3RV50d2yUtvkPouSSZHrt7dt0wmc1AN9TgQ5vxNkR+Mn+dXpecK6oa
         iVtbXBOHwxG0MFbVLPEiNgLZhM1S13oX2POpIbaLq6YU8cap0Wvz46Ep0gB0x9xAvMcs
         s2bsc4O33rTKZK80nigIHTXuQHwcUrSCf+yufAiHV39i271bD+gjJTe3SK8ehq8SV6EL
         aHTiDtDnv51voSSXikXJE178sJN3DLM0ZoyDb7jhA9PuESKGYTLJRdXuNmbvXB2nyjJi
         a1Tg==
X-Gm-Message-State: AOJu0Yx7x0QfY5CD0KhV5UTQozKiT5Fox8xpl4yNX3X2HW9It7T06L6v
	yY2bYktl0oaYrp7Bw4UhRsrC981TYziV4nzM+Y39iWj7OHdHVJAF3lztI7lfWIc=
X-Gm-Gg: ASbGncsp3DfNTaZXAkprqRgtgSm4eV/d4nfaq94LITBBHrJVyLk9DUibxFwrZA+Gppg
	zCnhirceQ8Po/bLHgAOmfg0ZRJBr8uWeML0RRBTy+sUiG73QxNXVFo40JCHYqKKcITt/cBJZYF7
	ScbIllrd+JqK386hSvWzC1cPENMo30XA8FzOsmRaqss6K3TC30dGvEWgu39ME9OMwQ+vOltEMbu
	XfSCJCU9VZSQdv+Cz7+AAwB70wXfiUjCs+1FHD9wNMuqVcHJTp/rVBj6Zvb/WFhbLFDQsg8ArBo
	1kBUfPO47vbRRca5xS+pD6uRLWADccnuiZFl/P2LhQ0Ta9cr/0BGArik4gaW7hw9mZvB
X-Google-Smtp-Source: AGHT+IH37tTVSokimshgZW6lxGFvzF557LE6UTHnwllapDKuc5EV+Ab6vjHAVIVTRS0ttHZVKgcPlA==
X-Received: by 2002:a05:6000:22c2:b0:399:71d4:a9 with SMTP id ffacd0b85a97d-3a074f7f22amr8964485f8f.52.1745832187159;
        Mon, 28 Apr 2025 02:23:07 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25965b82sm7495040b3a.79.2025.04.28.02.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 02:23:06 -0700 (PDT)
Message-ID: <a90c9dcd-e0b0-40f7-8416-f30a3a6b26a0@suse.com>
Date: Mon, 28 Apr 2025 18:52:54 +0930
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] btrfs: use bdev_rw_virt in scrub_one_super
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-14-hch@lst.de>
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
In-Reply-To: <20250422142628.1553523-14-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/22 23:56, Christoph Hellwig 写道:
> Replace the code building a bio from a kernel direct map address and
> submitting it synchronously with the bdev_rw_virt helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

In fact I'm waiting for this helper to refactor how we do super block 
read/write, to get rid of any page cache usage of the block device.

Thanks,
Qu

> ---
>   fs/btrfs/scrub.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 2c5edcee9450..7bdb2bc0a212 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2770,17 +2770,11 @@ static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
>   			   struct page *page, u64 physical, u64 generation)
>   {
>   	struct btrfs_fs_info *fs_info = sctx->fs_info;
> -	struct bio_vec bvec;
> -	struct bio bio;
>   	struct btrfs_super_block *sb = page_address(page);
>   	int ret;
>   
> -	bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_READ);
> -	bio.bi_iter.bi_sector = physical >> SECTOR_SHIFT;
> -	__bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);
> -	ret = submit_bio_wait(&bio);
> -	bio_uninit(&bio);
> -
> +	ret = bdev_rw_virt(dev->bdev, physical >> SECTOR_SHIFT, sb,
> +			BTRFS_SUPER_INFO_SIZE, REQ_OP_READ);
>   	if (ret < 0)
>   		return ret;
>   	ret = btrfs_check_super_csum(fs_info, sb);

