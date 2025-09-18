Return-Path: <linux-block+bounces-25538-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F82B220B0
	for <lists+linux-block@lfdr.de>; Tue, 12 Aug 2025 10:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DA65060F5
	for <lists+linux-block@lfdr.de>; Tue, 12 Aug 2025 08:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F8B2E1C50;
	Tue, 12 Aug 2025 08:22:46 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7272D6E4B;
	Tue, 12 Aug 2025 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986966; cv=none; b=aRum+Yu15z0ZoKtIWF3sHSZss/oL+REceDtglaK5hW4guSK+yIxE4wKfcVHk4LjJ7jBV9b9gigtwuHcdRe5GAmAW5DYBC/SQtZAJXRQ6NUyetYNlidRERbW/rk1PwKsn3HbR7NiPc2zsVNpR6xI3KfwEINtJRiNz3xR9QirPPy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986966; c=relaxed/simple;
	bh=pHkJKOmxQBWE2EUo/59MlBK5m+slLnMfansOEEvvQtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLiVbfnuv8glmY0uUas1NKhSH13NdHqhIEXV+dVChbxOZ9WAmRqVrhJod+bFgyTRphjP3MiHWU83A6/8B6B0hoguwKuoH1fizzutXiGdCeHmaRq+tEwYMnahqjsxVQET7UjKNMOWDvd0Rzq6cmVncuPHYEY8Q6AQbQ1Kq2HDAXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B1B2868AA6; Tue, 12 Aug 2025 10:22:40 +0200 (CEST)
Date: Tue, 12 Aug 2025 10:22:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, brauner@kernel.org,
	josef@toxicpanda.com, jack@suse.cz, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [RFC PATCH 2/5] fs: add the interface to query user write
 streams
Message-ID: <20250812082240.GB22212@lst.de>
References: <20250729145135.12463-1-joshi.k@samsung.com> <CGME20250729145335epcas5p462315e4dae631a1d940b6c3b2b611659@epcas5p4.samsung.com> <20250729145135.12463-3-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729145135.12463-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 29, 2025 at 08:21:32PM +0530, Kanchan Joshi wrote:
> Add new fcntl F_GET_MAX_WRITE_STREAMS.
> This returns the numbers of streams that are available for userspace.
> 
> And for that, use ->user_write_streams() callback when the involved
> filesystem provides it.
> In absence of such callback, use 'max_write_streams' queue limit of the
> underlying block device.

As mentioned in patch 1, I think we'd rather dispath the whole fcntl
to the file system, and then use generic helpers, which will give
more control of the details to the file system.


