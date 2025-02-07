Return-Path: <linux-block+bounces-17042-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D462FA2CE6B
	for <lists+linux-block@lfdr.de>; Fri,  7 Feb 2025 21:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B37169E9E
	for <lists+linux-block@lfdr.de>; Fri,  7 Feb 2025 20:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F58199FDE;
	Fri,  7 Feb 2025 20:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/bmfIA1"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF7A71747;
	Fri,  7 Feb 2025 20:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738961244; cv=none; b=FXW3zohPL4xWU3ba1vM7J8ELWxKDkynKANCx1a2+M9E/86d+vRBSMdD0nnmrfGlw1zljMtIV21auXCUeAWzFTV+avxvMOg+T0PuF73cMLRZFBtQ07FyDO9eftov0Gg+9JgVEdnWH2SO3zC25fHWiSZ9Mo4XzGpmDcvfkvxHa534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738961244; c=relaxed/simple;
	bh=6IkcpS44bKxjFCxlnMmWzweoPzSKVUkczEAPuMNT48U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEUq9m7lrRWNfSKDv0Dmguchs+AhroKvhyYBxPrSNus/ONEPuqXOPO6EFdWrN25dUdvsLqr/AjRLxE+r0ywswc75VCvq+wtN26bO55CQiLvKv3lcwJb/jeM5LyduK8YBMB3BB4pjYfREf8wEveo3U2gATcbf/ThMf1eTbJUyrM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/bmfIA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021FEC4CED1;
	Fri,  7 Feb 2025 20:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738961244;
	bh=6IkcpS44bKxjFCxlnMmWzweoPzSKVUkczEAPuMNT48U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i/bmfIA1tJwaavw67+pfkMDERWVbPeREkPvpWb9BY9d+BuL+KQq+hQCLZDHwm727L
	 Y2Gkjkoek5QssnR7N4kCphwjzBspYmpFbhh+1t1wsUQzbU7OcBbVzPZMld/j57aLhz
	 mwCdN9+dh7jdMEp4LNhEXC/sK+hOuKgmwDsJfBda2g/1BGhLwxdV/QQEvmqtiwnSBR
	 9F24b2QQJRVTaXXXnrqQzYeLdY7ULwvLh99kMFebnxKOwJEWIY8uNkSrg5/28FHJIS
	 GEaobAElAEQ729eXn0ZtInvKpJyuLlU4tx3eWmt/1WX7xObu42J2Q/UTJmRDgBKRhc
	 kf0JexV/8S1Ag==
Date: Fri, 7 Feb 2025 12:47:22 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hare@suse.de" <hare@suse.de>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH blktests v2 1/4] common: add and use min io for fio
Message-ID: <Z6ZxWhMZcypxe4B7@bombadil.infradead.org>
References: <20250204225729.422949-1-mcgrof@kernel.org>
 <20250204225729.422949-2-mcgrof@kernel.org>
 <rxgvw6zkrqqoyahgr54hcnbpi3dwgw6ataiy466rcmlmwmhrso@sdf55fwqxddk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rxgvw6zkrqqoyahgr54hcnbpi3dwgw6ataiy466rcmlmwmhrso@sdf55fwqxddk>

On Fri, Feb 07, 2025 at 11:26:17AM +0000, Shinichiro Kawasaki wrote:
> On Feb 04, 2025 / 14:57, Luis Chamberlain wrote:
> Spaces are used for indent in the hunk above. Let's use tabs instead.
> Same here, let's use tabs.

Fixed thanks.

 Luis

