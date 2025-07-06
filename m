Return-Path: <linux-block+bounces-23738-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7564BAF99E0
	for <lists+linux-block@lfdr.de>; Fri,  4 Jul 2025 19:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154CA544169
	for <lists+linux-block@lfdr.de>; Fri,  4 Jul 2025 17:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315AD28A407;
	Fri,  4 Jul 2025 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="IEoZN18k"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31862D3EFC
	for <linux-block@vger.kernel.org>; Fri,  4 Jul 2025 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751650679; cv=none; b=hYd0wblVGrUjWbR2mHhKrhH4Rc7m+wRHfASw9jkZZK9MoCFr6B8qDXfRVdc7gtt+9xQHOHEnMm+OG9YLRPKV2me9p85Wf26Rm1OS9P7DL8VRPWw/bVOIt7VgGLzWPRZ1bm/UgckXrY4pMth6wHOpvhQ6xBZdmaVfiVx42kTfkRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751650679; c=relaxed/simple;
	bh=9EALfSFFBRNxRqRk7VUICyoOrPWaEk2Bqic5Nq+c1QU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z29L7htXc4J8SlFJjK2p8fTc1KC7NIu627gROzNpyxwKcQMEjG11x8PSsP6HLNjLpkBdBThO3gAN3OYEprNjZJ7uI761xlF+s+uBVVGw5y+CWX5+EOdbi8J2aPlAUn4lWPx9UfxDWSeJ2xnZj/P2PN7IOWwblaDva6NzD50jvhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=IEoZN18k; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e81cf6103a6so1069488276.3
        for <linux-block@vger.kernel.org>; Fri, 04 Jul 2025 10:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1751650676; x=1752255476; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lLUj9yr52QgRuAClbNBOdP/RkbfnWsisubBXRJYh1fQ=;
        b=IEoZN18kzQIDka8i89xchVuT9VJi5TSDgmA7iajf9iCpKJMdLU/FME99+PaRpUf1/4
         qc7CsT4GxkO/hGTtDdUPGGNKS4qpG2egKULafSUTVvPUcgooIJHIGchgA20rgyFEvLkW
         LMohtkvYAdOPNTRoUyxYxOQf/AXi633E4PfqiCHDa2rmOVZvim3U7Z6S2TVRp+WaynWO
         +/xsSdARGxzVyti2okmY0NBhy1z4jas5mxFbIBrw1kl5sCVK0TltKHA8KmltkZtac+zh
         VSnXvkt8hdoxeuv/ug7FSpRQL8lyVWNlLnZdqe/4E1DVTG2/EDfWYogE4aytjx/yt7mY
         fwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751650676; x=1752255476;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLUj9yr52QgRuAClbNBOdP/RkbfnWsisubBXRJYh1fQ=;
        b=YObMwb2aM5kkdGWUrTYTqYj3Zc7+owda7sRkCgU39d6dyeV0F/tXwlUDLoNdplRo56
         NT9ZhWND7Un/K/mx/iT0Vb7huTk+8wh1JUemaAQhCD9mxyk+FiD/l4bGWQoUjEbhHaj6
         9NGflBf9xg+7VMLoGSEkX7vmGHEA1Er/NocvUhvjZgkaXnD0XQVkox/RT2h2HUkTP8qu
         +EdPUuBkmoAqV3b/bHVQKMtdKrtikFxBZbWZbQfzPaojPKlnZYwTAUsya9QY0/IEgUGT
         KKmM8VUrhpgNwTF6kP2Y+eedJYcGA1HGhkkmV+Kq0LhArc0J1zwZnDIDFd970R5NnLl2
         D57Q==
X-Gm-Message-State: AOJu0YyWL3wqhSR1ylzpcL/wV5FMNfrDjlpLYofeKxLViirVBf/P9+lW
	dpXmXWut9Sjn2tJNywYugzYVxHJ23eS9HZMoxPXW3xADA/daGpx2gslqJzQwk+B+zqc=
X-Gm-Gg: ASbGncvo+VVV9lh16IzhrIJDTUDFMpbD/TILPZOzoX13YvaJxDEUu69Q0wjbaW5pdaS
	s1CE7Tt+cRSXPGAQN+B9Cwa0yJQuHtNrCCQhTOFD5QQTpRoIeMv7jtvCsDTFSkEbu9RXm+7/+TV
	CosgZjM+RL+yKSVaYoQ2ZhysXc1V/tsVrICN2HUjaaWUDZt/6vp8d+BUKBqQfRoJHS3qx0wzSQA
	ae+37Z/F1fLPYu0FSR8uT7FmKJpQzjJAzpA7vus1MZk5GS2enqMO+CxshCsBwWBYs9mbugW6H22
	zTxvlj8uJzPGWxlbwQyLvY4BCpEmTs/xQ1rZzcag7wMW2jLuwFXGSZEIwyU/Gbshwgx7Sq6rTDW
	fjg5I2b2mM2onotRQauS3Ow552nKfpz4=
X-Google-Smtp-Source: AGHT+IG/aHreLeb27PwZvmI50YVh3KULg7kve7WZz2i4AoC208Quitrbot6B7W1w0/7tBwFUvl1n9g==
X-Received: by 2002:a05:690c:b84:b0:70f:84c8:3105 with SMTP id 00721157ae682-71668d73139mr47948477b3.37.1751650675940;
        Fri, 04 Jul 2025 10:37:55 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:f030:281a:9e2c:722? ([2600:1700:6476:1430:f030:281a:9e2c:722])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7166599fc22sm4941937b3.28.2025.07.04.10.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:37:55 -0700 (PDT)
Message-ID: <9d9d7bbab5443bd1c3dfd7d81d9bc91debecf4ef.camel@dubeyko.com>
Subject: Re: [PATCH 4/4] hfs: enable uncached buffer io support
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, axboe@kernel.dk,
 aivazian.tigran@gmail.com, 	viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, linkinjeon@kernel.org, 	sj1557.seo@samsung.com,
 yuezhang.mo@sony.com, glaubitz@physik.fu-berlin.de, 	shaggy@kernel.org,
 konishi.ryusuke@gmail.com, 	almaz.alexandrovich@paragon-software.com,
 me@bobcopeland.com, 	willy@infradead.org, josef@toxicpanda.com,
 kovalev@altlinux.org, dave@stgolabs.net, 	mhocko@suse.com,
 chentaotao@didiglobal.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, linux-karma-devel@lists.sourceforge.net, 
	bpf@vger.kernel.org
Date: Fri, 04 Jul 2025 10:37:52 -0700
In-Reply-To: <20250626173023.2702554-5-frank.li@vivo.com>
References: <20250626173023.2702554-1-frank.li@vivo.com>
	 <20250626173023.2702554-5-frank.li@vivo.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
 fAMjjkInIPg7RLGs8FiwxfcpkILP0YbVWHiNAaQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-26 at 11:30 -0600, Yangtao Li wrote:
> Now cont_write_begin() support DONTCACHE mode, let's set
> FOP_DONTCACHE
> flag to enable uncached buffer io support for hfs.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> =C2=A0fs/hfs/inode.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 8409e4412366..a62f45e9745d 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -695,6 +695,7 @@ static const struct file_operations
> hfs_file_operations =3D {
> =C2=A0	.fsync		=3D hfs_file_fsync,
> =C2=A0	.open		=3D hfs_file_open,
> =C2=A0	.release	=3D hfs_file_release,
> +	.fop_flags	=3D FOP_DONTCACHE,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct inode_operations hfs_file_inode_operations =3D =
{

Frankly speaking, I am not convinced that HFS really need to support
this feature. It is old and pretty obsolete file system. The main use-
case is simply support the capability to mount HFS volume is created
under Mac OS X, for example, and to access the data there. Of course,
we can support this feature, but what is the point of this?

As far as I can see, the goal of RWF_DONTCACHE feature is:

"Common for both reads and writes with RWF_DONTCACHE is that they use
the page cache for IO. Reads work just like a normal buffered read
would, with the only exception being that the touched ranges will get
pruned after data has been copied. For writes, the ranges will get
writeback kicked off before the syscall returns, and then writeback
completion will prune the range."

So, who would like to see such efficiency in HFS? Do we really need to
support it in HFS? I think that it is not.

Thanks,
Slava. =20

