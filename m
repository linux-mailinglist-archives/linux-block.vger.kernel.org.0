Return-Path: <linux-block+bounces-16904-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35720A27A1B
	for <lists+linux-block@lfdr.de>; Tue,  4 Feb 2025 19:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9181884BDE
	for <lists+linux-block@lfdr.de>; Tue,  4 Feb 2025 18:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE3A217F53;
	Tue,  4 Feb 2025 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLOf/bb1"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E1217707;
	Tue,  4 Feb 2025 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694212; cv=none; b=LQzRdS8xs6h7r0HLBNpIOqx2zgREaXMmuctAk2uUObje+Tes0GA+pQYAVzDmgiYpygJg+7YXo1Mh8Toaz6zLVWmJSfa1efj38L+OM6IdElJV/zN9upeMZHyAMT9BMmumqBgIscYZLaWGIJ5dmjBeGk8s9oo8w9+OH5yj+xeWWGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694212; c=relaxed/simple;
	bh=quUNLBlosc32+78MWTyF54MMroopCuPFrWDVXPPH3x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7gmomS5WHY4GjBDRUaXIaao/S3aZZwzSayigSGZHg9I6emrf/R02jXa9L2ky0G2oOLjaVA1LdwXBB02BG/prpNMD0eVw/xQPztAceFOlhugkvAaiXgRRRvY4wJqly3z3jXA2/QWdaaX+Er3/kcfo1XRzzt77D/GSIIUb/3rRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLOf/bb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CB3C4CEDF;
	Tue,  4 Feb 2025 18:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738694211;
	bh=quUNLBlosc32+78MWTyF54MMroopCuPFrWDVXPPH3x8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLOf/bb1CBB7uKxvYlajqdhCufhfMVu0ui/h+gkYO8eOX2WT/MhcI5kv4MHPP0qXA
	 e/sQXUpc76uZd8gean96KBEwTEvSsy6LXNgHe57LS0noBGaTJVgSi9ELmXegAkEnWk
	 bWt7FmYAke6oycVZl4LjG7TBOxxE32OYvpfpKSUM9xGgE/YlFbkkDvk+EvxGsKiPPL
	 njwMdajMUFgzZ8bXcDiJ+FidVCZAYW59am3JBsqUqkeFJJHrAgjwrz6BF1wNBZ7WJb
	 Mlllw2G88ktq4FjDfmwIBBfztSOeWIESqT+oEO/XhBhYVz6k8AT7EO9EuqD1+/6AUW
	 LT3TUOLJdsPAg==
Date: Tue, 4 Feb 2025 10:36:51 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 7/7] xfs: implement block-metadata based data checksums
Message-ID: <20250204183651.GA21791@frogsfrogsfrogs>
References: <20250203094322.1809766-1-hch@lst.de>
 <20250203094322.1809766-8-hch@lst.de>
 <20250203222031.GB134507@frogsfrogsfrogs>
 <20250204050025.GE28103@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250204050025.GE28103@lst.de>

On Tue, Feb 04, 2025 at 06:00:25AM +0100, Christoph Hellwig wrote:
> On Mon, Feb 03, 2025 at 02:20:31PM -0800, Darrick J. Wong wrote:
> > On Mon, Feb 03, 2025 at 10:43:11AM +0100, Christoph Hellwig wrote:
> > > This is a quick hack to demonstrate how data checksumming can be
> > > implemented when it can be stored in the out of line metadata for each
> > > logical block.  It builds on top of the previous PI infrastructure
> > > and instead of generating/verifying protection information it simply
> > > generates and verifies a crc32c checksum and stores it in the non-PI
> > 
> > PI can do crc32c now?  I thought it could only do that old crc16 from
> > like 15 years ago and crc64?
> 
> NVMe has a protection information format with a crc32c, but it's not
> supported by Linux yet.

Ah.  Missed that!

> > If we try to throw crc32c at a device,
> > won't it then reject the "incorrect" checksums?  Or is there some other
> > magic in here where it works and I'm just too out of date to know?
> 
> This patch implements XFS-level data checksums on devices that implement
> non-PI metadata, that is the device allows to store extra data with the
> LBA, but doesn't actually interpret and verify it іn any way.

Ohhhhh.  So the ondisk metadata /would/ need to capture the checksum
type and which inodes are participating.

> > The crc32c generation and validation looks decent though we're
> > definitely going to want an inode flag so that we're not stuck with
> > stable page writes.
> 
> Yeah, support the NOCOW flag, have a sb flag to enable the checksums,
> maybe even a field about what checksum to use, yodda, yodda.

Why do we need nocow?  Won't the block contents and the PI data get
written in an untorn fashion?

--D

