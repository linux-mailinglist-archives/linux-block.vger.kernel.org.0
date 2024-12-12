Return-Path: <linux-block+bounces-15259-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6859EDF62
	for <lists+linux-block@lfdr.de>; Thu, 12 Dec 2024 07:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A323B283762
	for <lists+linux-block@lfdr.de>; Thu, 12 Dec 2024 06:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F45A18A6AB;
	Thu, 12 Dec 2024 06:25:24 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0770176AB7
	for <linux-block@vger.kernel.org>; Thu, 12 Dec 2024 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733984724; cv=none; b=k/5ipLuU1ijBxDtIhJTKmFKXf7C+TkIRgJlfz3PzH/g7nGiR43jD6Js7lt0sP2+W1GIn9nn1g3ABNMtBBLZ9P5oB58ctccxCUHV2HH1GMki+rFeBn5CkHQu5ZnTgsWES2KVmRGewXOPtIEbtaBEq95DRLxtMVK0etGVC/cPw/MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733984724; c=relaxed/simple;
	bh=AmDmAQHwoRKWlysO8M4IQaBdyv54bRFnjPS+COBSjQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYDpY21oED0DGybL2vvABGYv80mg16ilCN0EJ32AUh39gs/styqohiUY0gSxQc0g202/aFpSDlhhn/tRYcn1hpbJ0ZZmfs9k8OUCH8fHMmrU2C2zGqRnfL29FH/+CjzrRdr6PFonnF9We0NgYNxYL9nA96ffd+O8CWcxFYiDcck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 766C468D07; Thu, 12 Dec 2024 07:25:19 +0100 (CET)
Date: Thu, 12 Dec 2024 07:25:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] block: Make bio_iov_bvec_set() accept pointer to const
 iov_iter
Message-ID: <20241212062519.GC5586@lst.de>
References: <20241202115727.2320401-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202115727.2320401-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 02, 2024 at 11:57:27AM +0000, John Garry wrote:
> Make bio_iov_bvec_set() accept a pointer to const iov_iter, which means
> that we can drop the undesirable casting to struct iov_iter pointer in
> blk_rq_map_user_bvec().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


