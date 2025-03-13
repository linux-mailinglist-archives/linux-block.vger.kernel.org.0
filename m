Return-Path: <linux-block+bounces-18375-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCD4A5FBD5
	for <lists+linux-block@lfdr.de>; Thu, 13 Mar 2025 17:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53455169811
	for <lists+linux-block@lfdr.de>; Thu, 13 Mar 2025 16:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16AF126C03;
	Thu, 13 Mar 2025 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qig2UyyW"
X-Original-To: linux-block@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C05268FE4
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883627; cv=none; b=Hv08W7Hrxt0J9Kc9kjo7Xki1ODceROI9F2lARGqVVgIvaayC5VyDhfJ/0Hx1RAhZ5dA1r5Zl8K8K064oOi8YG50ruIE8tIrGl1QJ6fvtE/yvnAT7drBAVDzpUw+6veO/Wfas/sz+qw3/hrYX9KaHA2BGtRfURsfp9s5wA6uPxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883627; c=relaxed/simple;
	bh=X1Fn4Z22YxriXZ+XLXS3yric0pSIsewyNYqzNx7CY8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbVVzerxqCjXmxGktnD+v6Xpv8NBFzkubrYbfyDCp+PnxnxX+qkEfweW8n+ulL5weHXHiI3gr7Z8BC8RMIpmuGwG1EcwkQPZdlrkzuYmqJ+Awuqdrk6EjzJeDBo1atqwdR2my+LwE3GoNtAR9iMeAyYgiDew68czhNOfcxDpxec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qig2UyyW; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Mar 2025 12:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741883622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yYYxIVXRSwxyFIJhJvKACu1v5ak9j3w7POVOI2j0xpY=;
	b=qig2UyyWUSClfgJPkbnnSn4kxaK2MJtXBEFr4dLLqzCiRtpZG7z7bcYIWcYVqT1YekSUv4
	e+F6Ws8XfN5kclu+e4qoFmEeHvytisZOKChnh/wIHhxc4gaKs+ysqZlKEYOG4uD17Ilwd1
	b6DqBzVhKYEWnG33AykirVZJv2COweY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Heinz Mauelshagen <heinzm@redhat.com>, zkabelac@redhat.com, 
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <ahddmkk35cmhrh4c5i5474bgqxhwy4kbc6sfo6zem77o25riqe@ptksvxbczl3r>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com>
 <Z8W1q6OYKIgnfauA@infradead.org>
 <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com>
 <Z8XlvU0o3C5hAAaM@infradead.org>
 <8adb8df2-0c75-592d-bc3e-5609bb8de8d8@redhat.com>
 <Z8cE_4KSKHe5-J3e@infradead.org>
 <2pwjcvwkfasiwq5cum63ytgurs6wqzhlh6r25amofjz74ykybi@ru2qpz7ug6eb>
 <Z9GYGyjJcXLvtDfv@infradead.org>
 <e92833a3-c262-d7f5-9034-2a803e27dae7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e92833a3-c262-d7f5-9034-2a803e27dae7@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 13, 2025 at 05:21:36PM +0100, Mikulas Patocka wrote:
> > IS_SWAPFILE isn't going way, as can't allow other writers to it.
> > Also asides from the that the layouts are fairly complex.
> > 
> > The right way ahead for swap is to literally just treat it as a slightly
> > special case of direct I/o that is allowed to IS_SWAPFILE files.  We
> > can safely do writeback to file backed folios under memory pressure,
> > so we can also go through the normal file system path.
> 
> But that is prone to low-memory-deadlock because the filesystems allocate 
> buffer memory when they are mapping logical blocks to physical blocks. You 
> would need to have a mempool in the filesystems, so that they can make 
> forward progress even if there is no memory free - and that would 
> complicate them.

I can't speak for everone else, but bcachefs has those mempools.

