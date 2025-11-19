Return-Path: <linux-block+bounces-30715-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A18C717A8
	for <lists+linux-block@lfdr.de>; Thu, 20 Nov 2025 00:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 925C64E2A74
	for <lists+linux-block@lfdr.de>; Wed, 19 Nov 2025 23:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DFA2E8DF3;
	Wed, 19 Nov 2025 23:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMyCXTEm"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718A02E1730
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 23:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763596748; cv=none; b=tglMDzWc/ztnMVEUu2TIs9FBTeCHFCLZ/28VyaHF8sK5p0joPFT0h6DOPrI2ktK0Qm4iVFyZM8x0b+As+8mHj4foesn/ehEH1lp+xeaFcKagPwf6mj1l8Ky/xuWR1DNbJef019rDSO80XavgCym17xEfgLgcvf2M174H9/aO+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763596748; c=relaxed/simple;
	bh=CHbGJo+gsN1mBKwtyyermcocCGGB6nJz9E/izE6AQ8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqS9MhQglQkKuYdg6JNr6463bV1H6KCCKw/cXsLMdHFAVHUHhALDIszLDEHfqNF71ppyVnQQWEXisuZrCpXr6uFdAV6MncnJwzk1uoLRM8HByq61AHFceXMu7O4JFFZ5DL1/T4RRQKRliLEPeb9IgRKnJJEtDXRBxVL7TMSij0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMyCXTEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6464C116B1;
	Wed, 19 Nov 2025 23:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763596748;
	bh=CHbGJo+gsN1mBKwtyyermcocCGGB6nJz9E/izE6AQ8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMyCXTEmJ46yBBzGk9e9w0eLK/AUO1PNvQdVnSrtbNGk5eoF0Rsb2MkUP7Y2S8YG6
	 97Z9fgnKuo8Kmy0Pt+R/4LRLE4aD1S6V7VtPUiBBcndG49NOIj/IOJV7JS5LWEM3vN
	 /fPes9vyE95fqu5drlOufwz3aJA+mVhIxkMb7OodOg7Z5qvw4WoR0sVCl1UyPvUnr0
	 h6G+NnIQjg7+htXLS/wt2wvLhcH9nW9gOhlv2N/X1mU1ygmnlKxdxP6WJ7zJpHjOal
	 onbjK5c1SaEF3LJo5xkDycWoiN5KLXpGsznXoCJFMaBZ+Ko3nCAmwMjsWx5Q9WNMSL
	 AvjTJI+Gjw6yQ==
Date: Wed, 19 Nov 2025 16:59:06 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCHv2 1/2] blktests: test direct io offsets
Message-ID: <aR5ZyoBaX-47tgNn@kbusch-mbp>
References: <20251119195449.2922332-1-kbusch@meta.com>
 <20251119195449.2922332-2-kbusch@meta.com>
 <ddda3d01-b95e-4798-b21d-a0c526b5b5a8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddda3d01-b95e-4798-b21d-a0c526b5b5a8@nvidia.com>

On Wed, Nov 19, 2025 at 11:48:47PM +0000, Chaitanya Kulkarni wrote:
> On 11/19/25 11:54, Keith Busch wrote:
> > +        ret = pwritev(test_fd, iov, vecs, 0);
> > +        if (ret < 0)
> > +		err(errno, "%s: failed to read buf", __func__);
> > +
> 
> 
> is pwritev correct above or it should be preadv () ?

Good eye, it should have been preadv. This part is currently unreachable
though, as it requires byte-aligned dma limits and the kernel doesn't
report such a value. But if this were to run, the test would have
falsely declared data corruption.

