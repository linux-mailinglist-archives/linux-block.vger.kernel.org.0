Return-Path: <linux-block+bounces-2429-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3F683DB2D
	for <lists+linux-block@lfdr.de>; Fri, 26 Jan 2024 14:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72FD1F2649E
	for <lists+linux-block@lfdr.de>; Fri, 26 Jan 2024 13:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066CA1B94D;
	Fri, 26 Jan 2024 13:52:31 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2457D1B943;
	Fri, 26 Jan 2024 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277150; cv=none; b=N0PawXoUB8zodY0Emo2s9uUH70h6EQj8EDRf3kv/5RomubCzHc7bNOqeoZOgLGJU+zF6OG96LSKVmLZVUSCrR8NdDPp/4kv3F1gPfquaaX4dzD9u1Jx+zLaQifYRIkAhZTy/B+5cfKFJOJZXF3rwkB6ZwCwn7yFQawojlQmeHvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277150; c=relaxed/simple;
	bh=oEds4qWCVxolYDA+yZojD2fii414dNCAA09U6ZafQ+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLOZvM5dly0wac+B4URb6cH9/5ftUEQ6Dplefqumy8ZitcaQrkv+yUkAJW/gWF/CgdfNzz73zzvMeYCCcJa1SGCyVLpAKaGImZOfkhgY9EM+QvEHnZKESKe+YYEwt2CZtPYYoL9h9ZZMaeJBbi2LH8q1ce45xoAgtPUzQ/QpqNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E935B68C4E; Fri, 26 Jan 2024 14:52:24 +0100 (CET)
Date: Fri, 26 Jan 2024 14:52:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, tj@kernel.org, jiangshanlai@gmail.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH, RFC] block: set noio context in
 submit_bio_noacct_nocheck
Message-ID: <20240126135224.GA3368@lst.de>
References: <20240124093941.2259199-1-hch@lst.de> <be690355-03c6-42e2-a13f-b593ad1c0edd@kernel.dk> <20240125081050.GA21006@lst.de> <07de550c-2048-4b2f-8127-e20de352ffde@kernel.dk> <ZbKIN5tn4MqHzw6U@casper.infradead.org> <6c4a4cf3-c5ed-4236-a6b2-9d53e927f979@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c4a4cf3-c5ed-4236-a6b2-9d53e927f979@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 25, 2024 at 09:13:37AM -0700, Jens Axboe wrote:
> > Nono, you don't understand.  The plan is to remove GFP_NOIO
> > entirely.  Allocations should be done with GFP_KERNEL while under a
> > memalloc_noio_save().
> 
> I do understand, but thanks for the vote of confidence. Place the
> save/restore higher up, most likely actual IO submission isn't going to
> be the only (or even major) allocation potentially needed for the IO.

NOIO is defined as allocations that will not recurse into the I/O stack.
So for anything block based, entering the block layer is literally
the defined boundary where it should be used below.  So no, wrapping
every submit_bio into a context annotation doesn't make much sense.


