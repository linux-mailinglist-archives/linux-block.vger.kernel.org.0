Return-Path: <linux-block+bounces-6620-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE30B8B44B0
	for <lists+linux-block@lfdr.de>; Sat, 27 Apr 2024 09:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C91282F97
	for <lists+linux-block@lfdr.de>; Sat, 27 Apr 2024 07:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DAB41A89;
	Sat, 27 Apr 2024 07:03:37 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E64540856;
	Sat, 27 Apr 2024 07:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714201417; cv=none; b=StU1eLaiVHo+lp0Q5x3uGnzy11ziyMdKfOrz9WgcwiusRZ0GrVibPzsElCxdtA0gxkNlmlj1sT4yWFnzIjfQhcMptEHtGv57JZBscKC2VSDzrEEkp/6/2UrK4NqbulANHpYMO9FmZg5oU1Dg3pYUv1HxNxGUHY0qlLKQTfn2R3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714201417; c=relaxed/simple;
	bh=mi5s0Hd6W16kfDDMYCEY/0UEj/RRHXj9GNaBZSqJ7nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeX8P2HKnnLybVr2Rm1j8vRcHHU3ccwOa37xTzQYfrd3hnN8PD7cjhjRys4c4xPEdT3Ga6hgFoc39QL8Vt/pYurZcxOFznhwxgEB5HOlIi+GzJdLiBHBe5laGdIasI642daqs3gu8X+f4mw6aCx9hdMCF0+UZP3rm0UY1ziyqsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A4E81227AA8; Sat, 27 Apr 2024 09:03:31 +0200 (CEST)
Date: Sat, 27 Apr 2024 09:03:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, kbusch@kernel.org,
	hch@lst.de, brauner@kernel.org, asml.silence@gmail.com,
	dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 02/10] block: copy bip_max_vcnt vecs instead of
 bip_vcnt during clone
Message-ID: <20240427070331.GB3873@lst.de>
References: <20240425183943.6319-1-joshi.k@samsung.com> <CGME20240425184653epcas5p28de1473090e0141ae74f8b0a6eb921a7@epcas5p2.samsung.com> <20240425183943.6319-3-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425183943.6319-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 26, 2024 at 12:09:35AM +0530, Kanchan Joshi wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> If bio_integrity_copy_user is used to process the meta buffer, bip_max_vcnt
> is one greater than bip_vcnt. In this case bip_max_vcnt vecs needs to be
> copied to cloned bip.

Can you explain this a bit more?  The clone should only allocate what
is actually used, so this leaves be a bit confused.


