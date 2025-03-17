Return-Path: <linux-block+bounces-18526-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D802A65577
	for <lists+linux-block@lfdr.de>; Mon, 17 Mar 2025 16:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B83172F94
	for <lists+linux-block@lfdr.de>; Mon, 17 Mar 2025 15:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D68218E96;
	Mon, 17 Mar 2025 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tNQROqHb"
X-Original-To: linux-block@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C2A230BEB
	for <linux-block@vger.kernel.org>; Mon, 17 Mar 2025 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224942; cv=none; b=asNRRlUVb5T9te1Xz7fQzR2XC5+rR1wT5DlDonE+rk2nb9phG6wUdG3FD2b1FWbV7AE+OvEQMchjQxZvUAXI+DoCvcRvypJc/xx1+8TgqnmaeOaUUxFLfqc56fBvtACVsVuQvDcFnSYTGeXPhG1xwlLv/ybIile5u8Hsn6PALzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224942; c=relaxed/simple;
	bh=/3U2fSE64qzk1eoSDBneJHmrMk4WHhchS3rSZ3Yq7/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0aKQdRhZAS5iBUVm1KsJwg6RQFjJ1y8Nrr30mHkpUykH7xIPGG0ZFsvobTkRa2K7/8gKIL+bxSl98wRx4PbQmoKZMtchg1+fsmFVL7NV1YgHzWmoaz3zgpkpBhsO69Zjq+c9KtPeajDtYJDjWZQM8msDW5ZHDEBiWEEYd/v54w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tNQROqHb; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 17 Mar 2025 11:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742224936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QcIsuYBz+55ESZ1hBvmbeg1/Wn+/VrbfBkZhBx7J4SE=;
	b=tNQROqHbjmHa57fHutK+TRSjwAbvmLnIAbDMlykrWXCcjQ/5Sqg6N/vzCRC2+Mlh+gKdII
	XI3EaiWW3Rk3hVn444DPLVVjlSFm0d6xHWwLT7Gy9JhOWR1QVdwEU8Q9QrJmKO24bxdSJT
	VB29cFf1BH1p2Ali/DSBc5i5JzUB5W4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-bcachefs@vger.kernel.org, linux-block@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 13/14] block: Allow REQ_FUA|REQ_READ
Message-ID: <esal7jywq7ft5krza556nfz5arzq4og4hwqggxuto3myus6rju@24mee7zxctgh>
References: <5ymzmc3u3ar7p4do5xtrmlmddpzhkqse2gfharr3nrhvdexiiq@p3hszkhipbgr>
 <0712e91f-2342-41ef-baad-3f2348f47ed6@kernel.dk>
 <ycsdpbpm4jbyc6tbixj3ujricqg3pszpfpjltb25b3qxl47tti@b2oydmcmf2a6>
 <ad32deb6-daad-4aa8-8366-2013b08e394f@kernel.dk>
 <fy5lq7bxyr64f7oiypo343s57nujafjue2bcl72ovwszbzasxk@k6jhr6asqtmx>
 <Z9e6dFm_qtW29sVe@infradead.org>
 <fhhgjnhmk72vpruhgftwq3lzfmylbhn6cuajj6saikee2zuqjp@54yfyxu35yiz>
 <Z9guJ2VxvqAmm9o9@kbusch-mbp.dhcp.thefacebook.com>
 <ro2padvzarj6v2bsh6xlsz36qs67z6ubomsvaw77dw4elfqqu7@4acij7zk6g7z>
 <Z9g8eO4Ngvagw2XP@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9g8eO4Ngvagw2XP@kbusch-mbp.dhcp.thefacebook.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 17, 2025 at 09:15:04AM -0600, Keith Busch wrote:
> On Mon, Mar 17, 2025 at 10:49:55AM -0400, Kent Overstreet wrote:
> > But we do absolutely require checking for transient read errors, and we
> > will miss things and corrupt data unnecessarily without FUA reads that
> > bypass the controller cache.
> 
> Read FUA doesn't "bypass the controller cache". This is a "flush cache
> first, then read the result" operation. That description seems
> consistent for nvme, ata, and scsi.

Quoting from your previous email,

> 2) read the data and metadata, if any, from non-volatile medium.

That's pretty specific.
 
> You are only interested in the case where the read doesn't overlap with
> any dirty cache, so the "flush" part isn't a factor. Okay fine, but I'm
> still curious if you have actually seen a case where read data was
> corrupt in cache but correct with FUA?

No.

It's completely typical and expected to code defensively against errors
which we have not observed but know are possible.

Is bit corruption possible in the device cache? You betcha, it's
hardware.

Are we going to have to test for correct implementation of READ|FUA in
the future? Given all the devices that don't even get flushes right,
again yes.

Are we still going to go ahead and do it? Yes, and I'd even say it's a
prerequisite for complaining to manufacturers that don't get this right.

