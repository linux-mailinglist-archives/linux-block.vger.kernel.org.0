Return-Path: <linux-block+bounces-27578-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF9CB86DD2
	for <lists+linux-block@lfdr.de>; Thu, 18 Sep 2025 22:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98881582769
	for <lists+linux-block@lfdr.de>; Thu, 18 Sep 2025 20:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA54631AF00;
	Thu, 18 Sep 2025 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHpsgiUs"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29532ECE83;
	Thu, 18 Sep 2025 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226382; cv=none; b=G4J7wVdojqpFzj7iOkDx52dyCiG7hk5N1M2+SlqJ8ebPWjwM2Ym4BVBREQon+jQcD1+fW6cKZe5A9uCxRjV3wZkPFkljId7D+amESLMUximLoxYwiCGzPMSh8RpdDUh3sHx8rZytHnscbO+u6uGol5TVtsmX+yNYrrxjAV8q/cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226382; c=relaxed/simple;
	bh=QO2Mttnm2wWhFv2FWDR+qK8iRxiLvdzjC3ZIPIlYNms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noacPYx2fSjTKGUWhf/Sg1MDnesP48bN9JipdJeToWZ5bYA+8lNI0BZ8/cOPaSc5yAwvIjHbdP+5vuFNnLYeVFDnZjY9rP6fwAQyXgUbZq2ksDGnR/3rPkKwKjzIQ/JoniDmuIvNyPpOD71++U/h47k6jX1n6gPiZD32m7Nvlr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHpsgiUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF13C4CEE7;
	Thu, 18 Sep 2025 20:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758226382;
	bh=QO2Mttnm2wWhFv2FWDR+qK8iRxiLvdzjC3ZIPIlYNms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VHpsgiUsCADJtHjuEJqUQLyoExSRq9imnkfleN053G2b6Fi8wiqsQW2T7Bvr3SHWo
	 q+4KL2LIr3kQf9BNf8XiwBIm20E26td0IGqjwVexxwxUK2MdnFQz1Ty5e0MJN5L61a
	 PtTY3HYjAnU7cUpQxqZupo0zIrBv9nQip0FtGaNw2S4S6uWMrTkTyedLjbZ7KUMN+S
	 fMKZ1WszQomkU5LGUzgN15SEjT3hrDvcRT65nMw8/yqefxnCWJkeF4B2dI5KM3d0V8
	 QokNnsZ4TI+gNYv8wy5IEmSxdM7fqsoAwdWzyk/2myKoGHVMtOmGCC+Do/4UISjGCF
	 u2Np3Upa8b7tQ==
Date: Thu, 18 Sep 2025 14:13:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: dm-devel@lists.linux.dev, snitzer@kernel.org,
	linux-block@vger.kernel.org, mpatocka@redhat.com,
	ebiggers@google.com
Subject: Re: [RFC PATCH] dm-crypt: allow unaligned bio_vecs for direct io
Message-ID: <aMxnzIavwnJmdAz1@kbusch-mbp>
References: <20250918161642.2867886-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918161642.2867886-1-kbusch@meta.com>

On Thu, Sep 18, 2025 at 09:16:42AM -0700, Keith Busch wrote:
> +		bio_advance_iter_single(ctx->bio_in, &ctx->iter_in, len);
> +		bytes -= len;
> +	} while (bytes);
> +
> +	sg_mark_end(sg_in);
> +	sg_in = dmreq->sg_in[0];

Err, there should be an '&' in there, "&dmreq->sg_in[0];"

By the way, I only tested plain64 for the ivmode. That appears to work
fine, but I am aware this will not be successful with elephant, lmk, or
tcw. So just an RFC for now to see if it's worth pursuing.

