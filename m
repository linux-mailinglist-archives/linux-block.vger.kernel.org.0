Return-Path: <linux-block+bounces-7539-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED818CA01D
	for <lists+linux-block@lfdr.de>; Mon, 20 May 2024 17:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C337BB2164B
	for <lists+linux-block@lfdr.de>; Mon, 20 May 2024 15:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADD5524D4;
	Mon, 20 May 2024 15:50:56 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDC24C66;
	Mon, 20 May 2024 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220256; cv=none; b=n3FPH7WyVjxI6qFxund3Sc20KZAUn7hIwK/WELf2v5PPkI0Qvv2IGYhTAXjh+hdfw9rplnobFlfX4cALXukGLGX5bYauEhFl+fxq0HYk1uQRqdo3aXQ6ifYrzyLqpC2+DDneLVYzoBdLEgD+7Bb8vhZ8MVs2pDxzEwXVyfq1AsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220256; c=relaxed/simple;
	bh=jeid1BQlbkhG+oGn7mKvZgcQUeECcB1Yee8xBttrOY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaR+NUq8w+mOKO3e9j7VfrEl1SwqkynoWfJWDFS8WjPDrxKtVhd6AEIYHSK3WsyQ1GWi5eVdC2wqc1u2JTtxImgYeoo3t5z1YuQhBHm2zGa9v3KpYLtai7RkqVxBauBJeqPDDGja+f8ZWZ8a1KGrWNeE3wQE/qg07GP/Rcj0+DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0EA1068AFE; Mon, 20 May 2024 17:50:52 +0200 (CEST)
Date: Mon, 20 May 2024 17:50:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>,
	dm-devel@lists.linux.dev, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, regressions@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: dm: use queue_limits_set
Message-ID: <20240520155051.GB1327@lst.de>
References: <20240518022646.GA450709@mit.edu> <ZkmIpCRaZE0237OH@kernel.org> <ZkmRKPfPeX3c138f@kernel.org> <20240520150653.GA32461@lst.de> <ZktuojMrQWH9MQJO@kernel.org> <Zktwqu-N0E1miesx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zktwqu-N0E1miesx@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 20, 2024 at 11:47:54AM -0400, Mike Snitzer wrote:
> Maybe update blk_validate_limits() to ensure max_discard_sectors is a
> factor of discard_granularity?

That's probably a good idea.  I'm travelling currently so I'll probably
need a day to two to get to this, feel free to do it yourself if you
are faster.


