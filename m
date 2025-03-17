Return-Path: <linux-block+bounces-18507-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DE4A64E5E
	for <lists+linux-block@lfdr.de>; Mon, 17 Mar 2025 13:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC213166B02
	for <lists+linux-block@lfdr.de>; Mon, 17 Mar 2025 12:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08266198A08;
	Mon, 17 Mar 2025 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WtWIDZH6"
X-Original-To: linux-block@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A6C235C15
	for <linux-block@vger.kernel.org>; Mon, 17 Mar 2025 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213761; cv=none; b=eiabrNJ5nx+xibunv9LghRSASLpLNVsbVpqlCbrc9H19p496ulE8Hfq8jslsRVXfX74CnomTlqjFLkiGkguwbBc282r4lXGt8mymA6bswwoSQ30ubDE3G7Tcr+TLS+Ar+oUVJ02EO8d+AurdhhlyANtmlmDGVuR3GBkErmlRydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213761; c=relaxed/simple;
	bh=FRN7UrN0XbZiFXMmo1/fuiOaUtBz90zOk5jrUMZN4yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1cy/J6CErQZsAoklx7fWIx0eeh7RKknV00MO6TI2kuc7vLdxQd3fIVtU6MlHGOzNVCKeU2Nci21S024No0KIJqD6aeUyE9IWscsXi+7gGhEQt0+76LZC3xCtjseo8qWKIJpOmwNEZV0nWFgclC5xqdfWhhV6XZ3y+rfTKu0OcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WtWIDZH6; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 17 Mar 2025 08:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742213756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRN7UrN0XbZiFXMmo1/fuiOaUtBz90zOk5jrUMZN4yA=;
	b=WtWIDZH6vSYOAGee3HaNkPgGUIIQE9zS2U63tJ76LpmOLde8uUX+u+kzn1jAo1AezGNfyh
	wfjXadT3kkDx+4+k44YJ5ctJTQUDooHqKqWk4zOz6XCUUz2FNWaxxk+5RNKYVv3Tznogc3
	6A9I3zyv+FNoyBLt3rwA263Y5Xjx2+0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-bcachefs@vger.kernel.org, 
	linux-block@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 13/14] block: Allow REQ_FUA|REQ_READ
Message-ID: <fhhgjnhmk72vpruhgftwq3lzfmylbhn6cuajj6saikee2zuqjp@54yfyxu35yiz>
References: <20250311201518.3573009-14-kent.overstreet@linux.dev>
 <9db17620-4b93-4c01-b7f8-ecab83b12d0f@kernel.dk>
 <abk74sbsvsuijqhohyenl2mecz6unmkhavkga55fxsld6m6ise@ncbz3xmjlymw>
 <510692e2-b83c-45bc-8d9d-08f7a172ffe6@kernel.dk>
 <5ymzmc3u3ar7p4do5xtrmlmddpzhkqse2gfharr3nrhvdexiiq@p3hszkhipbgr>
 <0712e91f-2342-41ef-baad-3f2348f47ed6@kernel.dk>
 <ycsdpbpm4jbyc6tbixj3ujricqg3pszpfpjltb25b3qxl47tti@b2oydmcmf2a6>
 <ad32deb6-daad-4aa8-8366-2013b08e394f@kernel.dk>
 <fy5lq7bxyr64f7oiypo343s57nujafjue2bcl72ovwszbzasxk@k6jhr6asqtmx>
 <Z9e6dFm_qtW29sVe@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9e6dFm_qtW29sVe@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Sun, Mar 16, 2025 at 11:00:20PM -0700, Christoph Hellwig wrote:
> On Sat, Mar 15, 2025 at 02:41:33PM -0400, Kent Overstreet wrote:
> > That's the sort of thing that process is supposed to avoid. To be clear,
> > you and Christoph are the two reasons I've had to harp on process in the
> > past - everyone else in the kernel has been fine.

...

> In this case you very clearly misunderstood how the FUA bit works on
> reads (and clearly documented that misunderstanding in the commit log).

FUA reads are clearly documented in the NVME spec.

As for the rest, I'm juts going to ignore the ranting.

