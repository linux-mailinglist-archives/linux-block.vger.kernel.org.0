Return-Path: <linux-block+bounces-2049-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A9C833056
	for <lists+linux-block@lfdr.de>; Fri, 19 Jan 2024 22:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E261C20323
	for <lists+linux-block@lfdr.de>; Fri, 19 Jan 2024 21:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689A01E4BE;
	Fri, 19 Jan 2024 21:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IinR596w"
X-Original-To: linux-block@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7CE1DFCB
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705700053; cv=none; b=L4QXiB2GyiBKfX5BoUN3wBhAhKihkRJT/6zrDUP1Pm6WdskoyPKchighy+VjFEayeuwWo57OqYHP/MqpRn95kBIJxnzzcQu4FlHIFItD9kSScVKkOjoUZHmUOzh9SnCRl1IcvCDXPEVG0rKZYUdcHQlxPBr1AEEQ0MROFwkK5SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705700053; c=relaxed/simple;
	bh=Yh+o/gnGQFjtcs5YDaAfbW/99ZkPz0o4v0F0fI5Tmlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNsXzg7okcm2yMat35gtPDPmKTef7wt2GSl21asbzBdZT3W7Qj5Q51bEWwiQqAIJnheRa8qzQ5pslY0qHmiEXjmVBWHWigrUbo3K02Dp0cwYfbu7j05IcvXIoiXWMiaH7a4OErj640up3THXK5ik+S8Ekmpw4xTvnOWGmIsdG/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IinR596w; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Jan 2024 16:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705700048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iu6wa/rK4pWrBKLxOWNu0O90Wa8WyeV3+r+u3h8jh4k=;
	b=IinR596wBybdI8NlUso85eN36G5vxLDEN+nkOaSfk4qtH3lYVBNeHWFqDfJ060ngmZLmC2
	1LS3qYu9ZxicNGWxq7KD4toKh81g09CHcN22PHP0eVr91BbL0mJX0qhIfPBUA0/OvlU7Gh
	IE9FY0LhRnaAdoYHCHbWdBalam2ATsA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: Mia Kanashi <chad@redpilled.dev>, linux-bcachefs@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>
Subject: Re: [BUG] I/O timeouts and system freezes on Kingston A2000 NVME
 with BCACHEFS
Message-ID: <ijsmgkglg2eiy6fswgjj7utrtlq7weiih2afx2cssaaz2pjwem@wonvjbulvgsw>
References: <54fcc150f287216593b19271f443bf13@redpilled.dev>
 <c8f441c2-d662-43fc-9e8e-fc847428dbaa@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8f441c2-d662-43fc-9e8e-fc847428dbaa@kernel.dk>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 19, 2024 at 02:22:04PM -0700, Jens Axboe wrote:
> On 1/19/24 5:25 AM, Mia Kanashi wrote:
> > This issue was originally reported here: https://github.com/koverstreet/bcachefs/issues/628
> > 
> > Transferring large amounts of files to the bcachefs from the btrfs
> > causes I/O timeouts and freezes the whole system. This doesn't seem to
> > be related to the btrfs, but rather to the heavy I/O on the drive, as
> > it happens without btrfs being mounted. Transferring the files to the
> > HDD, and then from it to the bcachefs on the NVME sometimes doesn't
> > make the problem occur. The problem only happens on the bcachefs, not
> > on btrfs or ext4. It doesn't happen on the HDD, I can't test with
> > other NVME drives sadly. The behaviour when it is frozen is like this:
> > all drive accesses can't process, when not cached in ram, so every app
> > that is loaded in the ram, continues to function, but at the moment it
> > tries to access the drive it freezes, until the drive is reset and
> > those abort status messages appear in the dmesg, after that system is
> > unfrozen for a moment, if you keep copying the files then the problem
> > reoccurs once again.
> > 
> > This drive is known to have problems with the power management in the
> > past:
> > https://wiki.archlinux.org/title/Solid_state_drive/NVMe#Troubleshooting
> > But those problems where since fixed with kernel workarounds /
> > firmware updates. This issue is may be related, perhaps bcachefs does
> > something different from the other filesystems, and workarounds don't
> > apply, which causes the bug to occur only on it. It may be a problem
> > in the nvme subsystem, or just some edge case in the bcachefs too, who
> > knows. I tried to disable ASPM and setting latency to 0 like was
> > suggested, it didn't fix the problem, so I don't know. If this is
> > indeed related to that specific drive it would be hard to reproduce.
> 
> From a quick look, looks like a broken drive/firmware. It is suspicious
> that all failed IO is 256 blocks. You could try and limit the transfer
> size and see if that helps:
> 
> # echo 64 > /sys/block/nvme0n1/queue/max_sectors_kb
> 
> Or maybe the transfer size is just a red herring, who knows. The error
> code seems wonky:

Does nvme have a blacklist/quirks mechanism, if that ends up resolving
it?

