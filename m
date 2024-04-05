Return-Path: <linux-block+bounces-5827-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494F0899FF4
	for <lists+linux-block@lfdr.de>; Fri,  5 Apr 2024 16:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB33AB227AE
	for <lists+linux-block@lfdr.de>; Fri,  5 Apr 2024 14:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F4916F284;
	Fri,  5 Apr 2024 14:39:03 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AD516F294
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327943; cv=none; b=uVytUB4Ev+VHc8YA/EneWhahiQ6FpKsM2HN0ej8G2Acy3PZnJkGLSBXeYD23gStdffRXzp+MuhchipujF6pyAE6bp6MtOScbDwjshpE9Kj0Wp+ag73W9KmmDZrlgCHUvtFpQfjwc1X8E0Er2frJz6teF2YZFt7fNLB6le0YoTC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327943; c=relaxed/simple;
	bh=zSC74fdTVL+TnGicAI3I2T4/Wu4/cc5FSKRfE6EGvgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWeV3Eb/hQDcPaBzQl5T+kXf6GwujAsRiUh1RSdjxi+Kw22DiQhEdmYXGJyuqUToP4Z1Ioq9NaYurb4inLxRwwxOR1EpfOL73SunxcOGoZZh7kw4431rpqUkAkepqd9NwLXiCQkDGwr3SrUP/yjr8h4cIK82WxRPJ+Aj7Ohk3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70A8468D07; Fri,  5 Apr 2024 16:38:56 +0200 (CEST)
Date: Fri, 5 Apr 2024 16:38:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: work around sparse in queue_limits_commit_update
Message-ID: <20240405143856.GA6008@lst.de>
References: <20240405085018.243260-1-hch@lst.de> <65a7c6b1-ad4e-4b27-b8b1-44d94a66bf7a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65a7c6b1-ad4e-4b27-b8b1-44d94a66bf7a@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 05, 2024 at 01:31:10PM +0100, John Garry wrote:
> Anyway, changing the code, below, for sparse when it seems somewhat 
> broken/unreliable may not be the best approach.

Ok, let's skip this and I'll report a bug to the sparse maintainers
(unless you want to do that, in which case I'll happily leave it to
you).

