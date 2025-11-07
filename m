Return-Path: <linux-block+bounces-29880-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4FBC3FC10
	for <lists+linux-block@lfdr.de>; Fri, 07 Nov 2025 12:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE95718822E2
	for <lists+linux-block@lfdr.de>; Fri,  7 Nov 2025 11:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39533308F1C;
	Fri,  7 Nov 2025 11:40:13 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47089225D6
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515613; cv=none; b=fnGB+sNvCAfU/Bqw8sKnO0CxjKzqIyiJAeT5KnEeCu6AlHu9JFyY03Xv50bv5eUroMiOHLOkvuQs89EjLxuoYnYX0Dulb+9KrBuzxDQm9gHyLXSlkmjsP2QUQaKACC87bx+Eo42Y1M/HHz56rZNkMfY7oP1zDwynu00ZC/bOD2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515613; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTOIZN7ulsJtszn1UF+EPitUcP7hMyuZ3tXyyZnt+wcPImnNz8OwN90V67z8WPCPyCgliM4CFoEJNRnvBNykKOFq6SKCU4bJhY6I0kIU1rkTDbqR3iowFe06q7T2KPuSJmW+tv9I3Xh3uDrs1qrX7PgH1BdvCI5X3vkSDDvNEA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 65978227AAF; Fri,  7 Nov 2025 12:40:06 +0100 (CET)
Date: Fri, 7 Nov 2025 12:40:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/3] block: improve blk_zone_wp_offset()
Message-ID: <20251107114005.GA29236@lst.de>
References: <20251107063844.151103-1-dlemoal@kernel.org> <20251107063844.151103-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107063844.151103-2-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


