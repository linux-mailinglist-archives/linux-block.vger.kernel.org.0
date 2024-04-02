Return-Path: <linux-block+bounces-5513-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC4B8948B9
	for <lists+linux-block@lfdr.de>; Tue,  2 Apr 2024 03:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E710D283238
	for <lists+linux-block@lfdr.de>; Tue,  2 Apr 2024 01:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFD18F6D;
	Tue,  2 Apr 2024 01:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="U1GwS7k7"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F15DD529
	for <linux-block@vger.kernel.org>; Tue,  2 Apr 2024 01:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712021209; cv=none; b=kMKQu9pm3v7j9O/JPkUSpLCnlS2y7FJDSpzk79sE9UbV28qxcsrcOnVF2nmYRMLK0DzrFCpjKGUX1GOyULFzQRORlgoJdqPWwS5PFXsJ1LxswRLvKFQsNM6PSDEBKVL/BWBnWz/WxjtpmSdVcRQly7Gd8VbE2tRhwMvOVZ5qW7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712021209; c=relaxed/simple;
	bh=r81tVplr/mXsa6cwAdC5W16sL6mZ3+LlluvNMb7GzWw=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=KMBFCuX3ZDgM+bsFfrd4jWIUm4GSzXB+suvHPha4t55QronjwhyyLhG2zHZ48bRl5wX7m+NX++KiKgV9FAgGbvQB1Wu7wop7eQe4f4LTLBqkseo31hiNySSEvajsHZbFKQ8rxZQxB4boW2Gp24TIcen95f7aI5TVpIADz5vebbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=U1GwS7k7; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6152be7c58bso34347b3.0
        for <linux-block@vger.kernel.org>; Mon, 01 Apr 2024 18:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712021205; x=1712626005; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YvU3eDeGNif8WZjhEP3jhv+aJxwb2qUvZEErn5YlURc=;
        b=U1GwS7k7R+XTZDYYhT4yW6nOBibRGNZ1dV8n1pvCC0efv8tqTNXyDG18Xz+3tgUYnx
         lke3nDhDp9vjCqBKuy6UNdbOLYr4TcBthAnQaQJ1ynk7rWhVaWaSfjcn3vsv85EXviEj
         ZFL4QeN1nW1qWpb5Iwgd00zNcFEXsvgKicYVBmH2+z9NcoyhXG1e+MsRr3Zqv7d0teyy
         K126Vi73T0gH6l1PpJpTsIky0akqZ0CJ5Z/J/3YLJ3ALyE4Xh1uU+82wrhIs7iY6h0Bm
         ViANu6YBzvlIoAUFmrB7p8q6GXE/BCeSjjeLqaTDhAcVFP8MF5ghoazQD58FBkPn+5oS
         1Nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712021205; x=1712626005;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YvU3eDeGNif8WZjhEP3jhv+aJxwb2qUvZEErn5YlURc=;
        b=EqJsi6iVcoOxn2Qv4eb8UzopWkp+/GmCEYumzQmyQvi2Ay2sDeGylsF2oo0IypG0nf
         QD7aYJsdJXe1V5/38eIrcl/WoCSOe7x2FyimxM/UA/cwf/Vnnmw/XmGI1W35MZaY8c1c
         pjZyYCpHXqORhUk8y1pF/I2XWkXjF6OJ847CEageNKTSEpE/E9gYq+L1hKcn465cQUxs
         A0HFhXYnKpp793W6qDZi0JDbxVxNIJE52Dk103InUMRQ1JUwCy9yK0a+N8AhofWJEdRu
         EPznEu26o3Ji0vJ0/WSLTnu7ofPGfRvCfzGi/Vhg6MMOUG0KRFBOyjhk9rC9zr4grfoq
         rxXg==
X-Forwarded-Encrypted: i=1; AJvYcCVN5Gh75mlBngXR/+U5sRVOVVfip9ULdF2EYoRBUJAtArVFqWpaOKevu0S0rc79+usObbkpzreTvYVIfG8AxEzSrU+E/goCi7gsJiE=
X-Gm-Message-State: AOJu0YyOI89/kw9C1p18M7NAitfub9FJp/8jI5RdAb9gUsllzaiywUrG
	nCFp88XRK1rwG8s6nfXNVRlbzmp5asuayHhL+zwzRpGLIkfJS5PKWun+jvJIFQ==
X-Google-Smtp-Source: AGHT+IHcwelFOZJua7sBX5BklkyXs7C7ZndzRUSAmvczI0RmFqF9qben7QrlRY0K6vcuZ7H7X473Hw==
X-Received: by 2002:a0d:d78c:0:b0:611:2a5b:8543 with SMTP id z134-20020a0dd78c000000b006112a5b8543mr10278060ywd.23.1712021205494;
        Mon, 01 Apr 2024 18:26:45 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id i19-20020ae9ee13000000b0078a280c92c6sm3861806qkg.134.2024.04.01.18.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 18:26:45 -0700 (PDT)
Date: Mon, 01 Apr 2024 21:26:44 -0400
Message-ID: <a811e4dda817d7a01f39b14ffa16a484@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, eparis@redhat.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>, Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH v16 14/20] ipe: add support for dm-verity as a trust  provider
References: <1711657047-10526-15-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1711657047-10526-15-git-send-email-wufan@linux.microsoft.com>

On Mar 28, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> Allows author of IPE policy to indicate trust for a singular dm-verity
> volume, identified by roothash, through "dmverity_roothash" and all
> signed dm-verity volumes, through "dmverity_signature".
> 
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ---
> v2:
>   + No Changes
> 
> v3:
>   + No changes
> 
> v4:
>   + No changes
> 
> v5:
>   + No changes
> 
> v6:
>   + Fix an improper cleanup that can result in
>     a leak
> 
> v7:
>   + Squash patch 08/12, 10/12 to [11/16]
> 
> v8:
>   + Undo squash of 08/12, 10/12 - separating drivers/md/ from security/
>     & block/
>   + Use common-audit function for dmverity_signature.
>   + Change implementation for storing the dm-verity digest to use the
>     newly introduced dm_verity_digest structure introduced in patch
>     14/20.
> 
> v9:
>   + Adapt to the new parser
> 
> v10:
>   + Select the Kconfig when all dependencies are enabled
> 
> v11:
>   + No changes
> 
> v12:
>   + Refactor to use struct digest_info* instead of void*
>   + Correct audit format
> 
> v13:
>   + Remove the CONFIG_IPE_PROP_DM_VERITY dependency inside the parser
>     to make the policy grammar independent of the kernel config.
> 
> v14:
>   + No changes
> 
> v15:
>   + Fix one grammar issue in KCONFIG
>   + Switch to use security_bdev_setintegrity() hook
> 
> v16:
>   + Refactor for enum integrity type
> ---
>  security/ipe/Kconfig         |  18 ++++++
>  security/ipe/Makefile        |   1 +
>  security/ipe/audit.c         |  29 ++++++++-
>  security/ipe/digest.c        | 120 +++++++++++++++++++++++++++++++++++
>  security/ipe/digest.h        |  26 ++++++++
>  security/ipe/eval.c          |  91 +++++++++++++++++++++++++-
>  security/ipe/eval.h          |  10 +++
>  security/ipe/hooks.c         |  72 +++++++++++++++++++++
>  security/ipe/hooks.h         |   8 +++
>  security/ipe/ipe.c           |  15 +++++
>  security/ipe/ipe.h           |   4 ++
>  security/ipe/policy.h        |   3 +
>  security/ipe/policy_parser.c |  24 ++++++-
>  13 files changed, 417 insertions(+), 4 deletions(-)
>  create mode 100644 security/ipe/digest.c
>  create mode 100644 security/ipe/digest.h

...

> diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
> index 6bcc7908ed13..f95986a87d51 100644
> --- a/security/ipe/hooks.c
> +++ b/security/ipe/hooks.c
> @@ -187,3 +191,71 @@ void ipe_unpack_initramfs(void)
>  {
>  	ipe_sb(current->fs->root.mnt->mnt_sb)->initramfs = true;
>  }
> +
> +#ifdef CONFIG_IPE_PROP_DM_VERITY
> +/**
> + * ipe_bdev_free_security - free IPE's LSM blob of block_devices.
> + * @bdev: Supplies a pointer to a block_device that contains the structure
> + *	  to free.
> + */
> +void ipe_bdev_free_security(struct block_device *bdev)
> +{
> +	struct ipe_bdev *blob = ipe_bdev(bdev);
> +
> +	ipe_digest_free(blob->root_hash);
> +}
> +
> +/**
> + * ipe_bdev_setintegrity - save integrity data from a bdev to IPE's LSM blob.
> + * @bdev: Supplies a pointer to a block_device that contains the LSM blob.
> + * @type: Supplies the integrity type.
> + * @value: Supplies the value to store.
> + * @size: The size of @value.
> + */
> +int ipe_bdev_setintegrity(struct block_device *bdev, enum lsm_integrity_type type,
> +			  const void *value, size_t size)
> +{
> +	struct ipe_bdev *blob = ipe_bdev(bdev);
> +
> +	if (type == LSM_INT_DMVERITY_ROOTHASH) {
> +		if (!value) {
> +			ipe_digest_free(blob->root_hash);
> +			blob->root_hash = NULL;
> +
> +			return 0;
> +		}
> +
> +		const struct dm_verity_digest *digest = value;
> +		struct digest_info *info = NULL;

General kernel coding conventions put variable declarations at the top
of the scope; in other words, move the '!value' if-statement below
this.

> +		info = kzalloc(sizeof(*info), GFP_KERNEL);
> +		if (!info)
> +			return -ENOMEM;
> +
> +		info->digest_len = digest->digest_len;
> +
> +		info->digest = kmemdup(digest->digest, info->digest_len,
> +				       GFP_KERNEL);
> +		if (!info->digest)
> +			goto err;

It's always a good practice to not do any work you might not need to
do in case of error:

  info->digest = kmemdup(...);
  if (!info->digest)
    goto dmv_roothash_err;
  info->digest_len = digest->digest_len;

> +		info->alg = kstrdup(digest->alg, GFP_KERNEL);
> +		if (!info->alg)
> +			goto err;
> +
> +		blob->root_hash = info;
> +
> +		return 0;
> +err:

You might want to consider naming this 'dmv_roothash_err' to help
indicate that it is a jump label specifically for use within the
DMVERITY_ROOTHASH block.

> +		ipe_digest_free(info);
> +
> +		return -ENOMEM;
> +	} else if (type == LSM_INT_DMVERITY_SIG) {
> +		blob->dm_verity_signed = size > 0 && value;
> +
> +		return 0;
> +	}

Woule it be worth returning -EINVAL if some other lsm_integrity_type
value was used here?

  if (ROOTHASH) {
    ...
  } else if (SIG) {
    ...
  } else
    return -EINVAL;

> +	return 0;
> +}
> +#endif /* CONFIG_IPE_PROP_DM_VERITY */

--
paul-moore.com

