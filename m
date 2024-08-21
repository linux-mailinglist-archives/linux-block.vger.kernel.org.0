Return-Path: <linux-block+bounces-10731-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F317395A21A
	for <lists+linux-block@lfdr.de>; Wed, 21 Aug 2024 17:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C803EB2530C
	for <lists+linux-block@lfdr.de>; Wed, 21 Aug 2024 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811AA1B3B13;
	Wed, 21 Aug 2024 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G40paiaX"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D52A364D6
	for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255505; cv=none; b=rKNzQN1ldgFZo56iJrYmTibq8d0VBdeep0Pp7TySbZ/Et2IHnpdm1tya1F+/XDwjGZhAmKSy1KNYJGdyE3vlUeG44GHwEoTw+M/XSyh/o8pjLi2Xg1N5QNnX+j0tpyXrsh4QJZxKgOw1nWWGdUpKyVNOFxzPgbEcYI8KVvvoNoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255505; c=relaxed/simple;
	bh=cfh3VaxFY12L6b9joBjAiMhKraXefyPDD9m7bT9Dn2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6y0tlgr7GYJ/gXnwWUhEXkPGDnzWrbn6aWLgYa9+OfuiY2FCL82ph/2gXu1cFVYTsSkWiWV+sYAkpp08XE6X8a5dWWiRe5HwV6ZeCScKARuLyXRaoiRluc9mLHsR2CvkPR15fesGKdX2iDXCkKln7JAFVPXO8ANTXfVq7I7nz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G40paiaX; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bf006f37daso1718218a12.1
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 08:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724255502; x=1724860302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cfh3VaxFY12L6b9joBjAiMhKraXefyPDD9m7bT9Dn2c=;
        b=G40paiaX4UWMZUwDMVjAbts3FUyXdWZdRSDEvqqLqhHtcvIpuIIUykA3X3FZjUlN7+
         D+qYRp1uT8jPDXzcOLVu4py+t9D9XX4SPfZnbD+INDrViaVJ2bNQsqsJKhuqkyz9tTPg
         hdmJi0v0Z5IUUM/tllDJkhQc2WDykOkdLyM3n+Myjv4onkFNI4FJCkBeb3WrEU4QEtPH
         fWKltE00kBLF12i3qdSbnNK6BiVINnrqAwnnW5u9fn8766vZvJ3qRdqScvGUa1xTVSpe
         OmdsacLLI3XpsV94F2+DM4YJ6KUqDeFUAwvhaukOH/uix++ZjvoBfz6LL0IUEcV53x48
         L8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724255502; x=1724860302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfh3VaxFY12L6b9joBjAiMhKraXefyPDD9m7bT9Dn2c=;
        b=WyKB0C+D8Kv+LxnVnzOAcCmHQw4KmZSfZewNyzmnwZ7BlQp9+WOW7kti4EEtR8+9EE
         7azorOlUD9B8RAybn54Qm9up/l92YHXsmsWcoBBrD2q3gGsVSVSplqoelC5kTNSGnJot
         P1aesQ9TB318JJZCy34LTNCLWdLHyG/Snj/gbX3nlykgrqeFcuMx7KdT2qaE1CM7Nxvl
         6J4ZC6SGhFXpwosQM/aGHsQAXtLGmd0htHfn8uX9foh/CYsKAiYqK5+kIJcddDWoTNwk
         ePKNbgcShjo9SXWi9qgBuTarA5nSObSMA0xdIZPK/SicyL9TPp1yS8Ffi9bOeOp3b5nL
         SX1g==
X-Forwarded-Encrypted: i=1; AJvYcCWfrju40AvRyOiAT8xm7oLCfXr+9QHICnt07CL89AWXLWUfGO1CvVAwdUH73fUIVT1CxOzSQOiyH9+N1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFn8GGFfLI1cZn0gAfKE63feaE9h1IRnCR3O97mW2cudBh2I8B
	zUK/qbHrJWrABN/ooeTR+ucmiY6dM8xTcUzE/Vu1hnzc6e+oUAz4iM9V1dkHqOU=
X-Google-Smtp-Source: AGHT+IHRKfOJRBIX00yACT9S6yJfNIRBD216Xy8o/dC87m9xqH+xwqjdfV16ljYKmJn/kNtjrDyw8w==
X-Received: by 2002:a05:6402:909:b0:5be:ecd9:c73e with SMTP id 4fb4d7f45d1cf-5bf2bfcb322mr101221a12.2.1724255501446;
        Wed, 21 Aug 2024 08:51:41 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbbe26fcsm8247046a12.5.2024.08.21.08.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 08:51:40 -0700 (PDT)
Date: Wed, 21 Aug 2024 17:51:39 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, hch@lst.de, axboe@kernel.dk, 
	longman@redhat.com, ming.lei@redhat.com, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, 
	houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com, 
	lilingfeng3@huawei.com
Subject: Re: [PATCH v2] blk-cgroup: don't clear stat in blkcg_reset_stats()
Message-ID: <migrlemuqjqff6y64o6ukfkuil6uwuarwvyg3xymfphnicznna@sy5dwhovytuz>
References: <20240821020756.786000-1-lilingfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u64mvz7adyyl3xft"
Content-Disposition: inline
In-Reply-To: <20240821020756.786000-1-lilingfeng@huaweicloud.com>


--u64mvz7adyyl3xft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Wed, Aug 21, 2024 at 10:07:56AM GMT, Li Lingfeng <lilingfeng@huaweicloud.com> wrote:
> The list of root cgroup can be used by both cgroup v1 and v2 while
> non-root cgroup can't since it must be removed before switch between
> cgroup v1 and v2.
> So it may has effect if the list of root used by cgroup v2 was corrupted
> after switching to cgroup v1, and switch back to cgroup v2 to use the
> corrupted list again.

> However, the root cgroup will not use the list any more after commit
> ef45fe470e1e("blk-cgroup: show global disk stats in root cgroup io.stat").

How come? Before that patch the root file was excluded with
CFTYPE_NOT_ON_ROOT. IOW how has that patch an effect on llist traversal?

(It doesn't matter, your patch doesn't restore memset anyway.)

This is the reasoning how I understand it:

| The removed function clears blkg.iostat structures that is only used on
| v2 whereas the function can only be called with v1 hierarchy attached.
| Zeroing effect could potentially be visible root blkcg "shared" between
| v1 and v2 but v2 actually synthesizes stats differently for root.

> Although this has no negative effect, it is not necessary. Remove the
> related code for cleanup. No function change.

I'm impressed by the amount of analysis you did to potentially remove
the unused function. If you feel like cleaning up more or sectioning,
see also [1] or [2] for inspiration.

Thanks,
Michal

[1] https://lore.kernel.org/all/20240625005906.106920-14-roman.gushchin@linux.dev/
[2] https://lore.kernel.org/all/20240628210317.272856-1-roman.gushchin@linux.dev/

--u64mvz7adyyl3xft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZsYNCAAKCRAt3Wney77B
STQRAP964BvPrWyhD3E2FATcSU9VzePaYOlzM2RkLQ1ceB9lVQEA6kUkdWtBIY0V
S39zAIVDUBJ2oJfcZCF3K0zwdtLkbA8=
=rh/X
-----END PGP SIGNATURE-----

--u64mvz7adyyl3xft--

