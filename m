Return-Path: <linux-block+bounces-8314-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 278488FDDCF
	for <lists+linux-block@lfdr.de>; Thu,  6 Jun 2024 06:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BAB281D41
	for <lists+linux-block@lfdr.de>; Thu,  6 Jun 2024 04:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC6728DD5;
	Thu,  6 Jun 2024 04:41:26 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049418C08
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 04:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717648886; cv=none; b=eJkJUqLVvwbv9+ft2IJGf7qNIG9qW4mRbQG1yWzxmMzKT7puj1pXJ6PNJO5rlbwpZvCYUeq6oetsRlfwwSeagO/Zuaho8BA6VKyB2AcUDiCu+8q3x/BIvcT6MqW8YNXXQb+8iBuNhbUsoil8/8fuyc/89Krgnfz/vL/wLyLCjcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717648886; c=relaxed/simple;
	bh=H95/TRqOoSlHfqEpCV1WGM116xQQMVQkbLeyVFOfhjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/4iVWl/Y2BsGQ+ToUqnf46REkgXHxQCbILmOi2DIz2OIMthagUBGrRvfveu/Be7SsJiR4MoYDrdG342Jp64ZtsDCGgFMq8o38DagWwoZPvC/nqiU0GwMl1ZMa4Ui/s45NaA1lgywJ6DMZ3EKHPN1J3lovvNYCLSEwIgDsE0VLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 53CE668CFE; Thu,  6 Jun 2024 06:41:22 +0200 (CEST)
Date: Thu, 6 Jun 2024 06:41:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Benjamin Marzinski <bmarzins@redhat.com>
Subject: Re: [PATCH v4 1/3] block: Improve checks on zone resource limits
Message-ID: <20240606044122.GB8331@lst.de>
References: <20240605075144.153141-1-dlemoal@kernel.org> <20240605075144.153141-2-dlemoal@kernel.org> <ZmCfmlnoo7wjQLTg@ryzen.lan> <2e8b1334-61a1-4c1c-a4f7-9550e32e7be6@kernel.org> <ZmEPFn9tvZb95fgz@ryzen.lan> <11c62aed-0048-4420-8edc-a38df761bef2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11c62aed-0048-4420-8edc-a38df761bef2@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 06, 2024 at 11:12:08AM +0900, Damien Le Moal wrote:
> Maybe. But that would still not provide any guarantee: a buggy application not
> respecting the limits would be able to steal resources from the other namespace.
> 
> In any case, I think this is a discussion to have on the nvme list.

Yes, the per-controller limits in NVMe are a big mistake that was
already mentioned during ZNS standardization.  We don't really have
any good way to deal with it except strongly recommending users to
not use multiple ZNS namespaes per controller.


